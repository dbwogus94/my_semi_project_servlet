<%@page import="All.statics.join.LoginProfile.dto.LoginProfileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="MENTOR/MAIN/MENTOR_Main.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>     
<script type="text/javascript">
	function myFunction(x) {
	    x.classList.toggle("change");
	    $("#nav").toggle(800);
	}
	
	function chatPopup(){
		var url = 'join.do?command=chat_mentor';
			window.open(url, "", "width=400px, height=500px");
	 }
	
</script>
</head>
<%
	LoginProfileDto mentorDto = (LoginProfileDto)session.getAttribute("mentorDto");
	if(mentorDto == null || !(mentorDto.getJoinRole().equals("멘토"))){
		pageContext.forward("Main.jsp");
	}
	int countMentee = (int)request.getAttribute("countMentee");
%>
<body>
	<header>
		<div id="logo">
			<img src="images/logo_white.png" />
		</div>
		<h1>운토티</h1>
		<div class="container" onclick="myFunction(this)">
			<div class="bar1"></div>
			<div class="bar2"></div>
			<div class="bar3"></div>
		</div>
	   <div id="nav">
			<ul>
				<li><a href="profile.do?command=mentor_profit">수익 관리</a></li>
				<li><a href="profile.do?command=mentor_menteeList">멘티관리</a></li>
				<li><a href="board.do?command=boardMain">자유게시판</a></li>
				<li><a href="" onclick="chatPopup()">채팅</a></li>
		   </ul>
		</div>
	
	</header>
	<br>
	<hr>
	<br>
	<h3>MENTOR MAIN</h3>
	<br>
	<hr>
	<br>
	<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;김멘토 님 PROFILE</h3>
	<br>
	<hr>
	<div id="mentor_pro">
		<div id="img_pro">
			<img alt="" src="images/mentor.png">
			<button onclick="location.href='profile.do?command=mentorProfile'" class="edit_profile">
				 프로필수정
			</button>
		</div>
		<div id="li_pro">
			<ul>
				<li><%=mentorDto.getMemberOneIntro()%></li>
				<li><%=mentorDto.getJoinEmail() %></li>
				<li><%=mentorDto.getMemberPhone() %></li>
				<li><%=mentorDto.getMemberAddr()%></li>
			</ul>
		</div>
	</div>
	<br>
	<br>
	<hr>

	<div id="mentor_detail">
		<fieldset>
			<legend>수익</legend>
			<ul>
				<li id="1st"><span id="total"><%=mentorDto.getMemberCoin() %></span>원</li>
				<li><span id="2ndtotal"><%=mentorDto.getMemberCoin() %></span>을 출금할 수 있습니다.</li>
				<li><button onclick="location.href='profile.do?command=mentor_profit'">상세보기</button></li>
			</ul>
		</fieldset>

		<fieldset>
			<legend>관리 중인 멘티</legend>
			<ul>
				<li id="1st"><span id="total"><%=countMentee %></span>명</li>
				<li><span id="2ndtotal"><%=countMentee %>명</span>의 멘티를 관리 중입니다.</li>
				<li><button onclick="location.href='profile.do?command=mentor_menteeList'">상세보기</button></li>
			</ul>
		</fieldset>
	</div>


	<footer>@ 2020 all copyrights reserved by 운토티</footer>

</body>
</html>