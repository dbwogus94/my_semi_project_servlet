<%@page import="member.trade.dto.TradeDto"%>
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

<link href="resource/css/ADMIN_css/ADMIN_SearchMentorDetail.css" rel="stylesheet" >
<script type="text/javascript">
	
</script>
<title>MENTOR 상세</title>

</head>
<%
	LoginProfileDto memberMentorDto = (LoginProfileDto)request.getAttribute("memberMentorDto");
	List<BoardDto> boardList = (List<BoardDto>)request.getAttribute("boardList");
	List<ProfileDto> menteeList = (List<ProfileDto>)request.getAttribute("menteeList");
	List<TradeDto> tradeList = (List<TradeDto>)request.getAttribute("tradeList");
%>
<body>
	
	<header>
		<div id="logo"> 
			<img src="images/logo_white.png" onclick="location.href='join.do?command=adminMain'"/>
		</div>
		<h1>운토티</h1>
		<div class="container" onclick="myFunction(this)">
			<div class="bar1"></div>
			<div class="bar2"></div>
			<div class="bar3"></div>
		</div>
	</header>
	<br>
	<hr>
	<br>
	<h3>MENTOR MAIN</h3>
	<br>
	<hr>
	<br>
	<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=memberMentorDto.getMemberName() %> 님 상세정보</h3>
	<br>
	<hr>
	<div id="mentor_pro">
		<div id="img_pro">
			<img alt="" src="images/mentor.png">
		</div>
		<div id="li_pro">
			<ul>
				<li><%=memberMentorDto.getMemberOneIntro() %></li>
				<li><%=memberMentorDto.getJoinEmail() %></li>
				<li><%=memberMentorDto.getMemberPhone() %></li>
				<li><%=memberMentorDto.getMemberAddr() %></li>
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
						<input type="button" value="상세보기" onclick="location.href='profile.do?command=admin_MemberSearchDetail&id=<%=profileDto.getId() %>&memberRole=<%=profileDto.getMemberRole() %>'"/>
					</fieldset>
		<% 
				}
			}
		%>
		
	</div>

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
		}	
%>
	</div>

	<div class="board">
		<input type="checkbox" value=""/>전체선택
		<input type="button" id="btn"value="선택삭제"/>
		<ul>
		<%
			if(boardList.size() == 0){
		%>
				<li>
					------작성된 내용이 없습니다.------
				</li>
		<%
			} else {
				for(BoardDto dto : boardList){
		%>
			  <li>
		            <a href="board.do?command=BoardDetail&board_Group=<%=dto.getBoard_Group()%>&boardNo=<%=dto.getBoard_Category_No()%>">
		           		<input type="checkbox" name="" value=""/>
			    		<hr/>
		           		<div id="writer"><%=dto.getId() %></div>
						<div id="date"><%=dto.getBoard_Regdate() %></div>
		 			    <div id="img"><img src="images/cat.png" alt=""></div>
						<div id="title"><%=dto.getBoard_Title() %></div>
		               	<div id="content"><%=dto.getBoard_Content() %></div>
		           	</a>
		      </li>
		<%
					}
				}
		%>
		</ul>
	</div>

	<footer>@ 2020 all copyrights reserved by 운도티</footer>
</body>
</html>