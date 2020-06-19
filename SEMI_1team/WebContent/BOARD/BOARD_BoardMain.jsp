<%@page import="member.board.biz.BoardBizlmpl"%>
<%@page import="member.board.biz.BoardBiz"%>
<%@page import="member.board.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%response.setContentType("text/html; charset=UTF-8");%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<link rel="stylesheet" href="css/Board_Main.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
function myFunction(x) {
	x.classList.toggle("change");
	$("#nav").toggle(800);
}



</script>
<style type="text/css">
.pageBar{
	text-align: center;
}
</style>
</head>
<%
	List<BoardDto> list = (List<BoardDto>)request.getAttribute("boardlist");
	int cPage = (int)request.getAttribute("cPage");
	int numPerPage = (int)request.getAttribute("numPerPage");
	String pageBar = (String)request.getAttribute("pageBar");
	BoardBiz boardBiz = new BoardBizlmpl();
	String loginId = (String)request.getAttribute("loginId");
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
<hr><br><h3>자유게시판</h3><br><hr>

<form action="board.do" method="post">
<input type = "hidden" name = "command" value = "boardSearch"/>
<div id="container">
    <div id="search1">
    	<select name = "category">
    		<option value="0">---선택---</option>
    		<option value="id">아이디</option>
    		<option value="name">이름</option>
    		<option value="addr">제목</option>
    	</select>
    	<input type="text" name = "search2" placeholder="검색할 내용을 입력하고 엔터키를 눌러주세요" onkeypress = "if(event.keyCode == 13) {submit();}">
    </div>
    <div id="button">
    
    <input type="button" class="button" value="게시글관리" onclick="location.href='board.do?command=BoardManage'">
    <input type="button" class="button" value="글쓰기" onclick="location.href='board.do?command=BoardWriteform'">
    </div>
</form>
    <ul class="board">
<%
		if(list.size() == 0){
%>
		<li>
			<a href = "#">------------작성된 내용이 없습니다.------------</a>
		</li>
<%
		} else {
			for(BoardDto dto : list){
%>
		<li>
           <a href="board.do?command=BoardDetail&board_Group=<%=dto.getBoard_Group()%>&boardNo=<%=dto.getBoard_Category_No()%>">
                 <div id="writer"><%=dto.getId() %></div>
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
    <div id = "pageBar">
		<%=pageBar %>	
	</div>
</div>
<footer>@ 2020 all copyrights reserved by 운토티</footer>
</body>
</html>