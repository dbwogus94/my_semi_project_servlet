<%@page import="member.mentee.exercise.total.dto.TotalDto"%>
<%@page import="All.statics.join.LoginProfile.dto.LoginProfileDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="member.mentee.exercise.plan.dto.PlanDto"%>
<%@page import="java.util.List"%>
<%@page import="member.mentee.exercise.plan.biz.PlanBizImpl"%>
<%@page import="member.mentee.exercise.plan.biz.PlanBiz"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mentee_ExerciseDetaile</title>
<link href="MENTEE/CALENDAR/CSS/MENTEE_ExerciseDetail.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="MENTEE/CALENDAR/JS/MENTEE_ExerciseDetail.js"></script>
</head>
<%
   LoginProfileDto menteeDto = (LoginProfileDto)session.getAttribute("menteeDto");
%>
<%
   //프로필 영역
   String name = menteeDto.getMemberName();
   //plan영역
   List<PlanDto> planList = (List<PlanDto>) request.getAttribute("planList");
   //날짜
   String date = "";
   //총 운동시간
   TotalDto selectTimeCal = (TotalDto) request.getAttribute("selectTimeCal");
%>
<body>

   <div class="container">
      <div id="profile">
         <img alt="" src="">
         <p><%=name %> 님의 운동기록</p>
      </div>
      
 
<%
      int i = 0;
      for(PlanDto dto : planList){
    	  date = dto.getPlanDate();
%>
      <form>
         <div class="plan-container">
            <div class="plan-box" id="plan-box<%=i %>">
               <div class="plan" id="plan<%=i %>">
                  <p class="category" id="category<%=i %>"><%=dto.getPlanCategory()%></p>
                  <p class="exercise-name" id="exercise<%=i %>"><%=dto.getExerciseName()%></p>
                  <p class="count" id="count<%=i %>">
<%
               if(dto.getPlanCategory().equals("유산소")){
%>
                  <%=dto.getPlanTime()%>
<%                  
               }
%>               
               <%=dto.getPlanCount()%>
               
                  </p>
               </div>
            </div>
         </div>
         
<%
         i++;
      }
   
      if(planList.size() != 0){

%>
      <div id="time">
         <p>총 운동시간 : <span id="sumTime"> <%=selectTimeCal.getTotalTime() %>분</span></p>
      </div>
     <div id="btn_group">
			<input type="button" value="삭제" class="btn" id="delBtn" onclick="delPlan('<%=date %>');">
			<input type="button" value="닫기" class="btn" id="closeBtn" onclick="window.close();">
		</div>
      </form>
   </div>
<%
      }
%>   
<script type="text/javascript">



</script>
</body>   
</html>