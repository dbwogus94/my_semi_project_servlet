<%@page import="member.board.biz.BoardBizlmpl"%>
<%@page import="member.board.biz.BoardBiz"%>
<%@page import="member.board.dto.BoardDto"%>
<%@page import="java.util.List"%>

<%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글관리</title>
<link rel="stylesheet" href="css/boardmuldel.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
function myFunction(x) {
	x.classList.toggle("change");
	$("#nav").toggle(800);
}

function search() {
	var searchtext = document.getElementsByName("search1")[0].value;
	var total = "board.do?command=muldelSearch&searchtext="+searchtext;
	
	location.href = total;
}

function allchk(bool) {
	$(function() {
		$("input[name=chk]").each(function() {
			$(this).prop("checked", bool);
		});
	
		$("input[name=chk]").click(function() {
			if($("input[name=chk]").length == $("input[name=chk]:checked").length){
				$("input[name=all]").prop("checked", true);
			} else {
				$("input[name=all]").prop("checked", false);
			}
		});	
	});
}
</script>
<style type="text/css">
.pageBar{
	text-align: center;
}
</style>
</head>
<%
	List<BoardDto> list = (List<BoardDto>)request.getAttribute("boardList");
	String pageBar = (String)request.getAttribute("pageBar");
	String loginId = (String)request.getAttribute("loginId");
	BoardBiz boardBiz = new BoardBizlmpl();
	String checkres = boardBiz.check_Id_board(loginId);
	String href = "";
	if(checkres.equals("멘티")){
		href = "MENTEE/CALENDAR/MENTEE_Main.jsp";
	} else if(checkres.equals("멘토")){
		href = "MENTOR/MAIN/MENTOR_Main.jsp";
	}
%>
<body>
<header>
<%
	if(checkres.equals("멘티")){
%>
		<div id="logo"><img src="images/logo_white.png" onclick = "location.href='<%=href %>'"/></div>
		<h1 onclick = "location.href='<%=href %>'">운토티</h1>

	<div class="container" onclick="myFunction(this)">
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
<%
	} else if(checkres.equals("멘토")){
%>
	<div id="logo"><img src="images/logo_white.png" onclick="location.href='join.do?command=mentorMain'"/></div>
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
<%
	}
%>
</header><br>
<hr><br><h3>게시글 관리</h3><br><hr>
<div id="search1"><input type="text" name="search1" placeholder="검색할 제목을 입력하세요" onkeypress = "if(event.keyCode == 13) {search();}"/></div>
<div id="wrap">
    <div id="search2"><input type="checkbox" name="all" value="전체 선택" onclick="allchk(this.checked);"/></div>
    <div id="button"><input type="submit" value="선택 삭제" /></div>
    <div id = "pageBar">
		<%=pageBar %>	
	</div>
</div>

<form action = "board.do" method = "post" >
<input type = "hidden" name = "command" value = "muldelBoard"/>

<div id="container"> 
    <ul class="board">
<%
		if(list.size() == 0){
%>
		<li>
			<a href = "#">------------작성한 게시글이 없습니다.------------</a>
		</li>
<%
		} else {
			for(BoardDto dto : list){
%>
		<li>
           <a href="board.do?command=BoardDetail&board_Group=<%=dto.getBoard_Group()%>&boardNo=<%=dto.getBoard_Category_No()%>">
                 <input type = "checkbox" name = "chk" value = "<%=dto.getBoard_Group()%>"/>
				 <div id="date"><%=dto.getBoard_Regdate() %></div>
 				 <div id="img"><img src="images/conimg.jpg" alt=""></div>
				 <div id="title"><%=dto.getBoard_Title() %></div>
            </a>
        </li>
<%
			}
		}
%>
    </ul>
</div>
</form>
<footer>@ 2020 all copyrights reserved by 운토티</footer>
</body>
</html>