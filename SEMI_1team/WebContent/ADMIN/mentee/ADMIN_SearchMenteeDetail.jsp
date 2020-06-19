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

<link href="resource/css/ADMIN_css/ADMIN_SearchMenteeDetail.css" rel="stylesheet" >
<script type="text/javascript">
	
</script>
<title>MENTEE 상세</title>

</head>
<%
	LoginProfileDto memberMenteeDto = (LoginProfileDto)request.getAttribute("memberMenteeDto");
	List<BoardDto> boardList = (List<BoardDto>)request.getAttribute("boardList");
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
	<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=memberMenteeDto.getMemberName() %> 님 상세정보</h3>
	<br>
	<hr>
	<div id="mentor_pro">
		<div id="img_pro">
			<img alt="" src="images/mentor.png">
		</div>
		<div id="li_pro">
			<ul>
				<li><%=memberMenteeDto.getMemberOneIntro() %></li>
				<li><%=memberMenteeDto.getJoinEmail() %></li>
				<li><%=memberMenteeDto.getMemberPhone() %></li>
				<li><%=memberMenteeDto.getMemberAddr() %></li>
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
				<legend>지출내역</legend>
					<ul>
						<li>금액 : <%=tradeDto.getTradePrice() %></li>
						<li>은행명 : <%=tradeDto.getTradeBankname() %> </li>
						<li>계좌번호 : <%=tradeDto.getTradeBanknum() %></li>
						<li>출금자명 : <%=tradeDto.getTradeName() %></li>
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
					<a href = "#">------작성된 내용이 없습니다.------</a>
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