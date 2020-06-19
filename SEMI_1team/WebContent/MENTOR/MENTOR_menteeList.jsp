<%@page import="member.profile.dto.ProfileDto"%>
<%@page import="member.board.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="All.statics.join.LoginProfile.dto.LoginProfileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script> 
<link href="resource/css/ADMIN_css/ADMIN_SearchMentorDetail.css" rel="stylesheet" >
<script type="text/javascript">
function myFunction(x) {
    x.classList.toggle("change");
    $("#nav").toggle(800);
}
</script>
<title>MENTOR 상세</title>

</head>
<%
	LoginProfileDto mentorDto = (LoginProfileDto)session.getAttribute("mentorDto");
	if(mentorDto == null || !(mentorDto.getJoinRole().equals("멘토"))){
		pageContext.forward("Main.jsp");
	}
	List<ProfileDto> menteeList = (List<ProfileDto>)request.getAttribute("menteeList");
%>
<body>
	
	<header>
		<div id="logo"> 
			<img src="images/logo_white.png" onclick="location.href='join.do?command=mentorMain'"/>
		</div>
		<h1 onclick="location.href='join.do?command=mentorMain'">운토티</h1>
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
	<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=mentorDto.getMemberName() %> 님이 관리하는 멘티리스트</h3>
	<br>
	<hr>
	<div id="mentor_pro">
		<div id="img_pro">
			<img alt="" src="images/mentor.png">
		</div>
		<div id="li_pro">
			<ul>
				<li><%=mentorDto.getMemberOneIntro() %></li>
				<li><%=mentorDto.getJoinEmail() %></li>
				<li><%=mentorDto.getMemberPhone() %></li>
				<li><%=mentorDto.getMemberAddr() %></li>
			</ul>
		</div>
	</div>
	<br>
	<br>
	<hr>

	<div class="mentee_board">
		<% 
			if(menteeList.size() == 0){
		%>
		
		<%
			} else {
				for(ProfileDto profileDto : menteeList){
		%>
					<fieldset>
						<legend style="text-align: center;"><b><%=profileDto.getMemberName() %></b>님 </legend>
						<legend style="text-align: left;"><b>&nbsp;</b> </legend>
						<img id="mentee_img"alt="" src="images/mentor.png">
						<br>
						<br>
						<input type="button" value="상세보기" onclick="location.href='profile.do?command=getMenteeChart&id=<%=profileDto.getId() %>'"/>
					</fieldset>
		<% 
				}
			}
		%>
	</div>


	<footer>@ 2020 all copyrights reserved by 운토티</footer>
</body>
</html>