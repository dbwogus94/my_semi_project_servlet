<%@page import="member.match.dto.MatchDto"%>
<%@page import="All.statics.join.LoginProfile.dto.LoginProfileDto"%>
<%@page import="member.profile.biz.ProfileBiz"%>
<%@page import="member.profile.biz.ProfileBizImpl"%>
<%@page import="member.profile.dto.ProfileDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="MENTEE/MATCH/CSS/MENTEE_MentorFind.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
function myFunction(x) {
	x.classList.toggle("change");
	$("#nav").toggle(800);
}
</script>
</head>
<%
   	LoginProfileDto menteeDto = (LoginProfileDto)session.getAttribute("menteeDto");
%>
<body>
<%
   //멘토 프로필 리스트    
   List<LoginProfileDto> mentorList = (List<LoginProfileDto>) request.getAttribute("mentorList");
   
	//멘토 유뮤
	boolean getMyMentor = (boolean)request.getAttribute("getMyMentor");
	System.out.println(getMyMentor);
   
   //현재 로그인된 아이디(멘티)
   //String id = request.getParameter("id");
   String id = menteeDto.getId();
   ProfileBiz profileBiz = new ProfileBizImpl();
   ProfileDto getMenteeProfile = profileBiz.getProfile(id);
   
   //MENTEE/MATCH/IMG/img01.jpg
   //MENTEE/MATCH/IMG/img02.jpg
%>
<header>
   <div id="logo"><img src="images/logo_white.png" onclick = "location.href='join.do?command=menteeMain'"/></div>
   <h1 onclick = "location.href='join.do?command=menteeMain'">운토티</h1>
   <div class="main_container" onclick="myFunction(this)">
        <div class="bar1"></div>
        <div class="bar2"></div>
        <div class="bar3"></div>
   </div>
   <div id="nav">
		<ul>
     		<li><a href="profile.do?command=menteeProfile">프로필 수정</a></li>
     		<li><a href="plan.do?command=planMain">운동캘린더</a></li>
     		<li><a href="profile.do?command=getChart">차트</a></li>
     		<li><a href="exercise.do?command=exerciseMain">운동정보</a></li>
      		<li><a href="match.do?command=getMatchView">멘토찾기</a></li>
      		<li><a href="">헬스장 찾기</a></li>
     		<li><a href="board.do?command=boardMain">자유게시판</a></li>
      		<li><a href="join.do?command=chat_mentee">채팅</a></li>
   		</ul>
	</div>
</header><br>
   <div class="container">
      <div class="slider-box">
         <ul class="bxslider">
            <li><div id="img01" class="slideImg"></div></li>
            <li><div id="img02" class="slideImg"></div></li>
            <li><div id="img03" class="slideImg"></div></li>
         </ul>
      </div>

      <!-- 검색 영역 -->
      <div class="serch-box">
         <p class="search">
            <span class="mentor">멘토</span>를 찾아보세요
         </p>
         <div class="search">
            <input type="button" class="search" id="searchBnt">
            <input type="text" class="search" id="searchBox" placeholder="Search..">
         </div>
      </div>
 <script type="text/javascript" src="MENTEE/MATCH/JS/MENTEE_MentorFind.js"></script>
      <!-- 프로필 영역 -->
      <div class="pofile-box">
<%
   for (LoginProfileDto dto : mentorList) {
%>
           <div id="mentor_pro">
               <div id="img_pro">
                  <img alt="" src="MENTEE/MATCH/IMG/mentorKim.png"> 
               </div>
               <div id="li_pro">
                  <h1>
                     <%=dto.getMemberName()%><span>님 (<%=(int)dto.getMemberScore() %>)</span>
                  </h1>
                  <ul>
                     <li><%=dto.getMemberOneIntro()%></li>
                     <li><%=dto.getJoinEmail() %></li>
                     <li><%=dto.getMemberPhone()%></li>
                     <li><%=dto.getMemberAddr()%></li>
                  </ul>       
                  <input id="matchBtn" type="button" value="멘토링 신청" onclick="payment('<%=dto.getId() %>')">
               </div>
         </div>
<%
   }
%>

<%
		if(getMyMentor == false){
%>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#matchBtn").attr('disabled', true);
			$("#matchBtn").attr('value', '멘토 존재');
			$("#matchBtn").css('background-color', 'black');
			$("#matchBtn").css('color', 'white');
		});
	</script>			
<%		
		}
%>      
      </div>
   </div>
 
   <footer>@ 2020 all copyrights reserved by 운토티</footer>
  
   <script type="text/javascript">
   function payment(id) {
         var tel = <%=getMenteeProfile.getMemberPhone()%>;   //구매자 전화번호 필수항목
         var MenteeId = '<%=id %>';
         var MentorId = id;   //onclick할 때 받아온 해당 프로필의 멘토id
         
         var IMP = window.IMP;
         IMP.init('imp81779230');
         
         IMP.request_pay({
             pay_method : 'card',
             name : '운토티:운동플래닝서비스',
             amount : 2000,
             buyer_tel : tel
         }, function(rsp) {
             if ( rsp.success ) {
                var msg = '결제가 완료되었습니다.';
                alert(msg);
                
             
                //결제 성공했으면 서블릿에서 DB에 저장해주자
                jQuery.ajax({
                   url: "trade.do?command=payment", 
                   type: 'POST',
                   data: {
                      MenteeId : MenteeId,
                      imp_uid : rsp.imp_uid,
                      MentorId : id
                   }
                   
                }).done(function(data) {
                   window.location.reload();
                });
             
             } else {
                 var msg = '결제에 실패하였습니다. 다시 시도해주세요.';
                 msg += '에러내용 : ' + rsp.error_msg;
                 //msg += rsp.error;
                 alert(msg);
             }
         });
         
   }
   </script>
  
</body>
</html>