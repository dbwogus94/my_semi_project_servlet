<%@page import="member.trade.dto.TradeDto"%>
<%@page import="member.board.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="All.statics.join.LoginProfile.dto.LoginProfileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="resource/css/ADMIN_css/ADMIN_SearchMenteeDetail.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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
	if(mentorDto == null){
		pageContext.forward("Main.jsp");
	}
	
	List<TradeDto> tradeList = (List<TradeDto>)request.getAttribute("tradeList");
	int cPage = (int)request.getAttribute("cPage");
	int numPerPage = (int)request.getAttribute("numPerPage");
	String pageBar = (String)request.getAttribute("pageBar");
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
	<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=mentorDto.getMemberName() %> 님 수익내역</h3>
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

	<div class="data_board">
<%
		if(tradeList.size() == 0){
%>
		<span>
			<b>============수익 내역이 없습니다.=============</b>
		</span>
<%			
		} else {
			for(TradeDto tradeDto : tradeList){	
%>			
			<fieldset>
				<legend>수익내역</legend>
					<ul>
						<li>금액 : <%=tradeDto.getTradePrice() %></li>
						<li>은행명 : <%=tradeDto.getTradeBankname() %> </li>
						<li>계좌번호 : <%=tradeDto.getTradeBanknum() %></li>
						<li>입금자명 : <%=tradeDto.getTradeName() %></li>
					</ul>	
			</fieldset>
<%		
			}
%>
		<div id = "pageBar">
			<%=pageBar %>	
		</div>
<%

		}	
%>
		
	</div>
	

	<footer>@ 2020 all copyrights reserved by 운도티</footer>
</body>
</html>