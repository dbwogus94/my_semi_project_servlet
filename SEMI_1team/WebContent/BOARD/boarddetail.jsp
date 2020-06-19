<%@page import="member.board.dto.reviewDto"%>
<%@page import="All.statics.join.LoginProfile.dto.LoginProfileDto"%>
<%@page import="member.board.dto.AnswerBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="member.board.biz.BoardBizlmpl"%>
<%@page import="member.board.biz.BoardBiz"%>
<%@page import="member.board.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<% request.setCharacterEncoding("UTF-8");%>
<% response.setContentType("text/html; charset=UTF-8");%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/boarddetail.css">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
<script type="text/javascript">
window.onscroll = function(ev) {
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
        
    }
};
function myFunction(x) {
	x.classList.toggle("change");
    $("#nav").toggle(800);
}

function reviewWrite(boardno,group) {
	// 게시글에 댓글
	
	var review = document.getElementsByName("reviewtext")[0].value;
	var boardno = boardno;
	var group = group;
	var total = "board.do?command=ReviewWriteres&boardno="+boardno+"&content="+review+"&group="+group;
	
	location.href = total;
}

function reviewUpdate(click, reviewno, groupno, boardno) {
	// 댓글 수정
	
	var review = $(click).prev().val();
	var reviewno = reviewno;
	var total = "board.do?command=ReviewUpdate&boardContent="+review+"&reviewno="+reviewno+"&boardno="+boardno+"&groupno="+groupno;
	
	location.href = total;
}

function reviewAndreview(click,boardno,reviewgroup,reviewgroupno,reviewtab) {
	// 댓글에 댓글 작성
	var review = $(click).prev().val();
	var total = "board.do?command=ReviewAndReview&reviewgroup="+reviewgroup+"&reviewgroupno="+reviewgroupno+"&boardContent="+review+"&reviewtab="+reviewtab+"&boardno="+boardno;
	
	location.href = total;
}

function reviewtoggle(loginid,reviewid,count,group,groupno) {
	// 댓글 클릭시 해당 댓글에 달린 댓글을 비동기로 불러옴
	
	var count = count;
	var group = group;
	var groupno = groupno;
	var boardno = document.getElementsByName("boardno")[0].value;
	var total = "command=reviewtoggle&board_Group="+group+"&board_Group_No="+groupno+"&boardNo="+boardno+"&count="+count;
	$.ajax({
		url:"board.do?"+total,
		dataType:"json",
		success:function(data){
			var ChildCount = $("#reviewAndreview"+decodeURIComponent(data.count)).children();
			var Content = decodeURIComponent(data.reviewList);
			var count = decodeURIComponent(data.count);
			

			
			if(ChildCount.length == 0){
				$.each(data.reviewList, function(index, reviewList) {
					var reviewarea = document.getElementById('reviewAndreview'+count);
					var reviewtext = document.createElement('div');
					
					reviewtext.classList.add('comment_body'); // 클래스이름
					
					var name = document.createTextNode(reviewList.board_Member_Name);
					var content = document.createTextNode(reviewList.board_Content);
					
					var p = document.createElement('span');
					p.setAttribute("style","font-weight: bold;");
					p.appendChild(name);
					reviewtext.appendChild(p);
					// 작성자 이름
					
					reviewtext.appendChild(content);
					// 작성 내용
					
					
					
					var input1 = document.createElement('input');
					var input2 = document.createElement('input');
					var input3 = document.createElement('input');
					var input4 = document.createElement('input');
					var input5 = document.createElement('input');
					var input6 = document.createElement('input');
					var input7 = document.createElement('input');
					var input8 = document.createElement('input');
					var input9 = document.createElement('input');
					var input10 = document.createElement('input');
					var input11 = document.createElement('input');
					var input12 = document.createElement('input');
					var input13 = document.createElement('input');
					
					input1.setAttribute("type","hidden");
					input1.setAttribute("name","board_Group");
					input1.setAttribute("value",reviewList.board_Group);
					
					input2.setAttribute("type","hidden");
					input2.setAttribute("name","board_Group_No");
					input2.setAttribute("value",reviewList.board_Group_No);
					
					input3.setAttribute("type","hidden");
					input3.setAttribute("name","board_Tab");
					input3.setAttribute("value",reviewList.board_Tab);
					
					input4.setAttribute("type","hidden");
					input4.setAttribute("name","board_Member_Name");
					input4.setAttribute("value",reviewList.board_Member_Name);
					
					input5.setAttribute("type","button");
					input5.setAttribute("name","reviewinsert2");
					input5.setAttribute("id","cbtn");
					input5.setAttribute("value","댓글");
					input5.setAttribute("onclick","toggleshow(this);");
					
					input6.setAttribute("type","text");
					input6.setAttribute("name","reviewcontent2");
					input6.setAttribute("placeholder","댓글 작성 해주세요");
					input6.setAttribute("style","display: none;");
					
					input7.setAttribute("type","button");
					input7.setAttribute("name","reviewdone2");
					input7.setAttribute("id","cbtn");
					input7.setAttribute("value","작성");
					input7.setAttribute("style","display: none;");
					input7.setAttribute("onclick","reviewAndreview2(this,'"+boardno+"','"+reviewList.board_Member_Name+"','"+reviewList.board_Group+"','"+reviewList.board_Group_No+"','"+reviewList.board_Tab+"');");
					
					input8.setAttribute("type","button");
					input8.setAttribute("name","reviewexit2");
					input8.setAttribute("id","cbtn");
					input8.setAttribute("value","취소");
					input8.setAttribute("style","display: none;");
					input8.setAttribute("onclick","togglehide(this)");
				
					input9.setAttribute("type","button");
					input9.setAttribute("name","reviewupdate2");
					input9.setAttribute("id","cbtn");
					input9.setAttribute("value","수정");
					input9.setAttribute("onclick","toggleshow(this)");
					
					input10.setAttribute("type","text");
					input10.setAttribute("name","reviewupdate2");
					input10.setAttribute("placeholder","수정 내용을 작성 해주세요");
					input10.setAttribute("style","display: none;");
					
					input11.setAttribute("type","button");
					input11.setAttribute("name","reviewupdatedone2");
					input11.setAttribute("value","작성완료");
					input11.setAttribute("id","cbtn");
					input11.setAttribute("style","display: none;");
					input11.setAttribute("onclick","reviewUpdate2(this,'"+boardno+"','"+group+"','"+reviewList.board_Member_Name+"','"+reviewList.board_Content+"','"+reviewList.board_Category_No+"');");
					
					input12.setAttribute("type","button");
					input12.setAttribute("name","reviewupdateexit2");
					input12.setAttribute("value","취소완료");
					input12.setAttribute("id","cbtn");
					input12.setAttribute("style","display: none;");
					input12.setAttribute("onclick","togglehide(this);");
					
					input13.setAttribute("type","button");
					input13.setAttribute("name","reviewdelete2");
					input13.setAttribute("id","cbtn");
					input13.setAttribute("value","삭제");
					input13.setAttribute("onclick","location.href='board.do?command=ReviewDelete&reviewno="+reviewList.board_Category_No+"&boardno="+boardno+"&groupno="+group+"'");
					
					
					reviewtext.classList.add('help');
					reviewtext.appendChild(input1);
					reviewtext.appendChild(input2);
					reviewtext.appendChild(input3);
					reviewtext.appendChild(input4);
					
					
					if(loginid === reviewid) {
						reviewtext.appendChild(input9);
						reviewtext.appendChild(input10);
						reviewtext.appendChild(input11);
						reviewtext.appendChild(input12);
						reviewtext.appendChild(input13);
					}
					reviewtext.appendChild(input5);
					reviewtext.appendChild(input6);
					reviewtext.appendChild(input7);
					reviewtext.appendChild(input8);
					
					reviewarea.appendChild(reviewtext);
					
				});
			}
		},
		error:function(){
			alert("통신 실패!");
		}
	});
	var toggle = document.getElementById('reviewAndreview'+count);
	if(toggle.style.display == 'none'){
		toggle.style.display = 'block';
	} else {
		toggle.style.display = 'none';
	}	
}

function toggleshow(click) {
	// 버튼 클릭시 보임
	
	$(click).next().show();
	$(click).next().next().show();
	$(click).next().next().next().show();
}

function togglehide(click) {
	// 취소 눌렀을때 안보임
	
	$(click).hide();
	$(click).prev().hide();
	$(click).prev().prev().hide();
}

function reviewUpdate2(click,boardno,group,name,content,reviewno) {
	// 댓글의 댓글 수정
	
	var checkname = "@" + name;
	var review;
	
	if(content.indexOf(checkname) != -1){
		review = "@" + name + " " + $(click).prev().val();
	} else {
		review = $(click).prev().val();
	}

	var total = "board.do?command=ReviewUpdate&boardContent="+review+"&reviewno="+reviewno+"&boardno="+boardno+"&groupno="+group;
	
	location.href = total;
}

function reviewAndreview2(click,boardno,name,reviewgroup,reviewgroupno,reviewtab) {
	// 댓글의 댓글에 댓글 작성
	// 그룹, 그룹번호, 작성 내용, 탭 번호

	var review = "@" + name + " " + $(click).prev().val();
	var reviewgroup = reviewgroup;
	var reviewgroupno = reviewgroupno;
	var reviewtab = reviewtab;
	var total = "board.do?command=ReviewAndReview&reviewgroup="+reviewgroup+"&reviewgroupno="+reviewgroupno+"&boardContent="+review+"&reviewtab="+reviewtab+"&boardno="+boardno;
	
	location.href = total;
}

$(function() {
	// 댓글 10개넘었을때 더보기 버튼
	
	$(".reviewtoggle").slice(0,10).show();
	$("#load").click(function(e) {
		e.preventDefault();
		$(".reviewtoggle:hidden").slice(0,10).show();
		if($(".reviewtoggle:hidden").length == 0){
			//alert("불러올 댓글이 없습니다.");		// 안 숨기고 알려만 주기
			$("#load").hide();				// 숨기기
		}
	});
});
</script>
</head>
<%
	String loginId = (String)request.getAttribute("loginId");
	List<AnswerBoardDto> boardList = (List<AnswerBoardDto>)request.getAttribute("boardList");
	BoardDto boardDto = (BoardDto)request.getAttribute("boardDto");
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

<script>
$(document).ready(function() {
	// 섬머노트로 글 불러오기 위해 사용
	
	$('#ctext').summernote({disableDragAndDrop: true });
	 $('#ctext').summernote('disable');
	var content = '<%=boardDto.getBoard_Content()%>';
	$('#ctext').summernote('editor.pasteHTML', content);
	
	
});
</script>
<hr id="board_title2"><br><h3 id="board_title">상세 게시판</h3><br><hr id="board_title2">
<div id="board">
	<div id="content">
	<input type = "hidden" name = "boardno" value = "<%=boardDto.getBoard_Category_No() %>"/>
		<h2 class="title"><%=boardDto.getBoard_Title() %></h2><br>
		<div id="cdetail">
			<span><img src="images/mentee2.jpg"></span>
			<span><%=boardDto.getBoard_Member_Name() %></span>
			<span><%=boardDto.getBoard_Regdate() %></span>
			<div id="btn2">
<%
			if(boardDto.getId().equals(loginId)){
%>
				<input type="button" id="cbtn1" value="수정" onclick = "location.href='board.do?command=boardUpdate&boardNo=<%=boardDto.getBoard_Category_No()%>'"/>
				<input type="button" id="cbtn1" value="삭제" onclick = "location.href='board.do?command=BoardDelete&groupNo=<%=boardDto.getBoard_Group()%>'"/>
<%
			} else {
%>
				<input type="button" value="수정" style = "display: none;"/>
				<input type="button" value="삭제" style = "display: none;"/>
<%
			}
%>
			</div>
		</div><br><br><hr>
		<div class="cdetail2">
		<div class="conimg"><img alt="" src="images/conimg.jpg"></div>
		<div id="ctext"></div>
	</div>

	<h2 class="comment">댓글<span>(<%=boardList.size() %>)</span></h2>
	<input type="text" name = "reviewtext" placeholder="댓글 작성 해주세요"/>
	<input type="button" id="cbtn1" value="댓글작성하기" onclick="reviewWrite('<%=boardDto.getBoard_Category_No() %>','<%=boardDto.getBoard_Group()%>');"/>
	
<%
	int search = boardBiz.select_Search_End_No();
	int count = 0;
	for(AnswerBoardDto answerboardDto : boardList){
		if(answerboardDto.getBoard_Tab() == 0){
			
			
%>
		<div id = "comment" class = "reviewtoggle" style = "display: none;" >
		<img alt="" src="images/mentee.png">
		<div id="commentUp">


			<div id="commenter"><%=answerboardDto.getBoard_Member_Name() %></div>
			<div id="btn">
				<input type = "hidden" name = "reviewtab" value = "<%=answerboardDto.getBoard_Tab()%>"/>
				<input type = "hidden" name = "reviewno" value = "<%=answerboardDto.getBoard_Category_No()%>"/>
			</div>
			</div>
				<div id="commentDown">
				
<%
		
			if(loginId.equals(answerboardDto.getId())){
%>
				<input type = "button" value="삭제" id="cbtn" name = "reviewdelete1" onclick="location.href='board.do?command=ReviewDelete&reviewno=<%=answerboardDto.getBoard_Category_No()%>&boardno=<%=boardDto.getBoard_Category_No()%>&groupno=<%=answerboardDto.getBoard_Group()%>'"/>       
				<input type = "button" value="수정하기" id="cbtn" name = "reviewupdate1" onclick="toggleshow(this);"/>
				<input type = "text" name = "reviewupdate1" placeholder="수정 내용을 작성 해주세요" style = "display: none;"/>
				<input type = "button" value = "수정" id="cbtn" name = "reviewupdatedone1" style = "display: none;" onclick="reviewUpdate(this,'<%=answerboardDto.getBoard_Category_No()%>','<%=answerboardDto.getBoard_Group()%>','<%=boardDto.getBoard_Category_No()%>');" />
				<input type = "button" value = "취소"  id="cbtn" name = "reviewupdateexit1" style = "display: none;" onclick = "togglehide(this);"/>
				<input type = "button" value="댓글달기" id="cbtn" name = "reviewinsert1" onclick = "toggleshow(this);"/>
				<input type = "text" name = "reviewcontent1" placeholder="댓글 작성 해주세요" style = "display: none;"/>
				<input type = "button" value = "작성" id="cbtn" name = "reviewdone1" style = "display: none;" onclick = "reviewAndreview(this,'<%=boardDto.getBoard_Category_No() %>','<%=answerboardDto.getBoard_Group() %>','<%=answerboardDto.getBoard_Group_No() %>','<%=answerboardDto.getBoard_Tab()%>');" />
				<input type = "button" value = "취소" id="cbtn" name = "reviewexit1" style = "display: none;" onclick = "togglehide(this);"/>
				
<%
			} else {
%>
				<input type = "button" value="삭제" id="cbtn" name = "reviewdelete1" style = "display: none;"/>
				<input type = "button" value="수정하기" id="cbtn" name = "reviewupdate1" style = "display: none;"/>
				<input type = "text" name = "reviewupdate1" style = "display: none;"/>
				<input type = "button" value = "수정" id="cbtn" name = "reviewupdatedone1" style = "display: none;"/>
				<input type = "button" value = "취소" id="cbtn" name = "reviewupdateexit1" style = "display: none;"/>
				<input type = "button" value="댓글달기" id="cbtn" name = "reviewinsert1" onclick = "toggleshow(this);"/>
				<input type = "text" name = "reviewcontent1" placeholder="댓글 작성 해주세요" style = "display: none;"/>
				<input type = "button" value = "작성" id="cbtn" name = "reviewdone1" style = "display: none;" onclick = "reviewAndreview(this,'<%=boardDto.getBoard_Category_No() %>','<%=answerboardDto.getBoard_Group() %>','<%=answerboardDto.getBoard_Group_No() %>','<%=answerboardDto.getBoard_Tab()%>');" />
				<input type = "button" value = "취소" id="cbtn" name = "reviewexit1" style = "display: none;" onclick = "togglehide(this);"/>
				
<%
			}                                                        
%>

			<br><br>
			<hr>

		
		<div id="com"><%=answerboardDto.getBoard_Content()%></div>
		<br><br><br>
	
		</div>

		<div id="rebox">
		
		<p id="reply">
		<%
		if(search == answerboardDto.getBoard_Group_No()){
			List<reviewDto> List = boardBiz.selectList_Search_End_board(answerboardDto.getBoard_Group_No());
			if(List.size() > 0){
%>
			<a onclick = "reviewtoggle('<%=loginId %>','<%=answerboardDto.getId() %>','<%=count%>','<%=answerboardDto.getBoard_Group()%>','<%=answerboardDto.getBoard_Group_No()%>');">
				답글 : <%=List.size()%> 개 
			</a>
<%			
			}
		} else {
			int EndCount = boardBiz.selectEndCount(answerboardDto.getBoard_Group(), answerboardDto.getBoard_Group_No());
			List<reviewDto> List = boardBiz.select_reviewAndreview_board(answerboardDto.getBoard_Group(), answerboardDto.getBoard_Group_No(), EndCount);
			if(List.size() > 0){
%>
			<a onclick = "reviewtoggle('<%=loginId %>','<%=answerboardDto.getId() %>','<%=count%>','<%=answerboardDto.getBoard_Group()%>','<%=answerboardDto.getBoard_Group_No()%>');">
				답글 : <%=List.size()%> 개
			</a>
<%	
			}
		}
%></p>
<div id = "reviewAndreview<%=count%>" style="display: none;"></div>

		
		
		
		
		</div>		</div>
		<br/>
		<br><br><br>
<%
		count++;
		}
	}
%>
		
		<a href="#" id = "load">더 보기</a>
		
		
</div>
<footer>@ 2020 all copyrights reserved by 운토티</footer>
</div>
</body>
</html>