<%@page import="All.statics.join.LoginProfile.dto.LoginProfileDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.mentee.exercise.plan.dto.PlanDto"%>
<%@page import="member.mentee.exercise.plan.biz.PlanBizImpl"%>
<%@page import="member.mentee.exercise.plan.biz.PlanBiz"%>
<%@page import="member.mentee.dayMenu.biz.DayMenuBizImpl"%>
<%@page import="member.mentee.dayMenu.dto.DayMenuDto"%>
<%@page import="member.mentee.dayMenu.dao.DayMenuDaoImpl"%>
<%@page import="member.mentee.dayMenu.biz.DayMenuBiz"%>
<%@page import="java.util.List"%>
<%@page import="All.statics.Util"%>
<%@page import="member.mentee.exercise.total.biz.TotalBizImpl"%>
<%@page import="member.mentee.exercise.total.biz.TotalBiz"%>
<%@page import="member.mentee.exercise.total.dto.TotalDto"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mentee_main</title>
<script src="https://kit.fontawesome.com/599e2aa924.js" crossorigin="anonymous"></script>
<link href="CSS/MENTEE_Main.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="JS/MENTEE_Main.js?ver=1"></script>
<script type="text/javascript">
 function myFunction(x) {
     x.classList.toggle("change");
     $("#nav").toggle(800);
   }

 function chatPopup(){
	var url = '../../join.do?command=chat_mentee';
		window.open(url, "", "width=400px, height=500px");
 }


</script>
</head>
<%
	LoginProfileDto menteeDto = (LoginProfileDto)session.getAttribute("menteeDto");
%>
<body>

<header>
   <div id="logo"><img src="../../images/logo_white.png" /></div>
   <h1>운토티</h1>
   <div class="container" onclick="myFunction(this)">
        <div class="bar1"></div>
        <div class="bar2"></div>
        <div class="bar3"></div>
   </div>
   <div id="nav">
		<ul>
	      <li><a href="../../profile.do?command=menteeProfile">프로필 수정</a></li>
	      <li><a href="../../plan.do?command=planMain">운동캘린더</a></li>
	      <li><a href="../../profile.do?command=getChart">차트</a></li>
	      <li><a href="../../exercise.do?command=exerciseMain">운동정보</a></li>
	      <li><a href="../../match.do?command=getMatchView">멘토찾기</a></li>
	      <li><a href="../../map.html">헬스장 찾기</a></li>
	      <li><a href="../../board.do?command=boardMain">자유게시판</a></li>
	      <li><a href="" onclick="chatPopup();">채팅</a></li>
   		</ul>
	</div>
</header>
<br>
<hr><br><h3>MENTEE MAIN</h3>

<br><hr>
<br><h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=menteeDto.getMemberName() %> 님 PROFILE</h3><br><hr>
<div id="mentee_pro">
<div id="img_pro">
<img alt="" src="../<%=menteeDto.getMemberContent()%>">
<button onclick = "location.href='../../profile.do?command=menteeProfile'" class="edit_profile">프로필수정</button>
</div>
<div id="li_pro">
      <ul>
         <li><%=menteeDto.getMemberOneIntro() %></li>
         <li><%=menteeDto.getJoinEmail() %></li>
         <li><%=menteeDto.getMemberPhone() %></li>
         <li><%=menteeDto.getMemberAddr() %></li>
      </ul>
</div>   
</div>
<br><br><hr>

   <%
      Calendar cal = Calendar.getInstance();
      int year = cal.get(Calendar.YEAR);
      int month = cal.get(Calendar.MONTH) + 1;

      String paramYear = request.getParameter("year");
      String paramMonth = request.getParameter("month");

      if (paramYear != null) {
         year = Integer.parseInt(paramYear);
      }

      if (paramMonth != null) {
         month = Integer.parseInt(paramMonth);
      }

      if (month > 12) {
         month = 1;
         year++;
      }

      if (month < 1) {
         month = 12;
         year--;
      }

      //1. 현재년도, 현재월, 1일로 달력 설정
      cal.set(year, month - 1, 1);

      //2. 1일의 요일
      //3. 현재 월의 마지막 일
      int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
      int endDate = cal.getActualMaximum(Calendar.DATE);

      int cnt = cal.get(Calendar.DAY_OF_WEEK);
      int week = 7 - ((dayOfWeek - 1 + endDate) % 7) % 7;

      //달력에 체중-식사-운동 기록확인
      TotalBiz totalBiz = new TotalBizImpl();
      DayMenuBiz menuBiz = new DayMenuBizImpl();
      PlanBiz planBiz = new PlanBizImpl();
      
      String yyyyMM = year + Util.isTwo(month +"");
      String id = menteeDto.getId();
      
      List<TotalDto> totalList = totalBiz.getCalViewList(id, yyyyMM);
      List<DayMenuDto> menuList = menuBiz.getCalViewList(id, yyyyMM);
      List<PlanDto> planList = planBiz.getCalViewList(id, yyyyMM);
      
      // 오늘날짜 yyyyMM
      String date = year + "" + (month < 10 ? "0" + month : month);
   %>

   <div class="board">
   
      <div class="menteeCal">
         <div id="calenderBoard">
            <table id="calendar">
               <caption>
                  <a href="MENTEE_Main.jsp?year=<%=year%>&month=<%=month - 1%>">
                     <i class="fas fa-chevron-left"></i></a>
                  <b><span class="date"><%=year%>년</span>
                  <span class="date"><%=month%>월</span></b>
                  <a href="MENTEE_Main.jsp?year=<%=year%>&month=<%=month + 1%>">
                  <i class="fas fa-chevron-right"></i></a></b>
               </caption>
      
               <tr>
                  <th>일</th>
                  <th>월</th>
                  <th>화</th>
                  <th>수</th>
                  <th>목</th>
                  <th>금</th>
                  <th>토</th>
               </tr>
         
               <tr>
         
<%
         for(int i = 0; i < dayOfWeek-1; i++){
            out.print("<td>&nbsp;</td>");
         }
         for(int i = 1; i <= endDate; i++){
%>
            <td>
               <a><%=i %></a>
               <div id="btn_group">
<%
               for(TotalDto dto : totalList){
                  if(dto.getTotalDate().substring(6, 8).equals(Util.isTwo(i +""))){            
%>
                        <input type="button" id="weightBtn" onclick="popupWeight(<%=dto.getTotalWeight() %>, <%=date + Util.isTwo(i+"") %>)">                     
<%         
                  }
               }            

               for(DayMenuDto dto : menuList){
                  if(dto.getMenuDate().substring(6, 8).equals(Util.isTwo(i +""))){   
%>
                        <input type="button" value="" id="menuBtn" onclick="popupMenu(<%=dto.getMenuDate() %>)">
<%         
                     break;
                  }
               }            

               for(PlanDto dto : planList){
                  if(dto.getPlanDate().substring(6, 8).equals(Util.isTwo(i +""))){                        
%>
                        <input type="button" value="" id="planBtn" onclick="popupPlan(<%=dto.getPlanDate() %>)">
<%         
                     break;
                  }
               }            
%>
               
               </div>
            </td>
<%      
      
            if(cnt % 7 == 0){
%>
            </tr>
            <tr>
<%
            }
            cnt++;
         }
         
         cal.set(year, month-1, endDate);
         for(int i = 0; i < 7-(cal.get(Calendar.DAY_OF_WEEK)); i++){
            out.print("<td>&nbsp;</td>");
         }
%>
            </table>
            <div id="insert_btn_group">
               <input type="button" value="체중기록" id="weightInsertBtn" onclick="popupInsertWeight('<%=id%>')">
               <input type="button" value="식단기록" id="menuInsertBtn" onclick="popupInsertDayMenu('<%=id%>')">
               <input type="button" value="운동기록" id="planInsertBtn" onclick="popupInsertPlan();">
            </div>
         </div>
         <div id="mentor">
            <div><span>최멘티</span>님의 멘토</div>
            <hr id="mentorHr">
            <div>
               <img  id="mentorImage" src="ICON/mentorKim.png">
            
               <button id="planbtn" onclick="location.href='MENTEE_ExercisePlan.jsp'">운동플랜</button>
               <button id="coach">자세코칭</button>
            </div>
        <br>
            <br>
         </div>
      </div>
   </div>
   
     
   <footer>@ 2020 all copyrights reserved by 운토티</footer>
</body>
</html>