<%@page import="member.board.biz.BoardBizlmpl"%>
<%@page import="member.board.biz.BoardBiz"%>
<%@page import="member.board.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
    
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글수정</title>
<link rel="stylesheet" href="css/boardupdate.css">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
<script type="text/javascript">
function myFunction(x) {
	x.classList.toggle("change");
	$("#nav").toggle(800);
}

function boardupdate(boardno,groupno) {
	var title = document.getElementById("title").value;
	var content = document.getElementById('summernote').value;
	var total="board.do?command=boardUpdateres&title="+title+"&content="+content+"&boardno="+boardno+"&groupno="+groupno;
	
	location.href = total;
}

$(document).ready(function() {
    $('#summernote').summernote({
          height: 300,
          disableDragAndDrop: true,
          toolbar: [
              ['style', ['style']],
              ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
              ['fontface', ['fontname']],
              ['textsize', ['fontsize']],
              ['color', ['color']],
              ['alignment', ['ul', 'ol', 'paragraph', 'lineheight']],
              ['height', ['height']],
              ['table', ['table']],
              ['insert', ['link','picture']],
              ['Misc',['undo','redo']]
          ],
    });
 });
</script>
</head>
<%
	BoardDto boardDto = (BoardDto)request.getAttribute("boardDto");
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
<div id="board">
	<div id="content">
	<div id="cdetail">
			
		 
  <input type="text" id="title" name="title" placeholder="<%=boardDto.getBoard_Title()%>"/>
		<br>
		<div id="cdetail">
			<span><img src="images/mentee2.jpg"></span>
			<span><%=boardDto.getBoard_Member_Name()%></span>
			
		</div><br><br><hr>
		<div class="cdetail2">
		<div class="conimg"><img alt="" src="images/conimg.jpg"></div>
		<div id="ctext">
		<textarea rows="100" cols="100" id="summernote" placeholder="<%=boardDto.getBoard_Content()%>"></textarea>
		</div>
		<div id="btn2">
			<input type="button" value="수정하기" id="cbtn" onclick="boardupdate('<%=boardDto.getBoard_Category_No()%>','<%=boardDto.getBoard_Group()%>');"/> 
			<input type="button" value="취소" id="cbtn" onclick = "location.href='board.do?command=BoardDetail&boardNo=<%=boardDto.getBoard_Category_No()%>&board_Group=<%=boardDto.getBoard_Group()%>'">
		</div>
	</div>
</div>	
</div>
</div>
</body>
</html>