<%@page import="member.board.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/exinfo.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
function myFunction(x) {
	x.classList.toggle("change");
	$("#nav").toggle(800);
}

function exerciseCategory(Category) {
	var total1="command=exerciseCategory&Category="+Category;
	//$("div").children("ul").children("li").toggle(800);
	$.ajax({
		url:"exercise.do?"+total1,
		dataType:"json",
		success:function(msg){
			if($("#"+decodeURIComponent(msg.Category)).children("li").children("a").length > 0){
			} else {
				$("#"+decodeURIComponent(msg.Category)).append(
				'<li><a onclick="exerciseOne('+"'"+ decodeURIComponent(msg.ExerciseName0) + "'"+')">'+decodeURIComponent(msg.ExerciseName0)+'</a></li>',
				'<li><a onclick="exerciseOne('+"'"+ decodeURIComponent(msg.ExerciseName1) + "'"+')">'+decodeURIComponent(msg.ExerciseName1)+'</a></li>',
				'<li><a onclick="exerciseOne('+"'"+ decodeURIComponent(msg.ExerciseName2) + "'"+')">'+decodeURIComponent(msg.ExerciseName2)+'</a></li>',
				'<li><a onclick="exerciseOne('+"'"+ decodeURIComponent(msg.ExerciseName3) + "'"+')">'+decodeURIComponent(msg.ExerciseName3)+'</a></li>',
				'<li><a onclick="exerciseOne('+"'"+ decodeURIComponent(msg.ExerciseName4) + "'"+')">'+decodeURIComponent(msg.ExerciseName4)+'</a></li>',
				'<li><a onclick="exerciseOne('+"'"+ decodeURIComponent(msg.ExerciseName5) + "'"+')">'+decodeURIComponent(msg.ExerciseName5)+'</a></li>'
				);
			}
			$('#'+decodeURIComponent(msg.Category)).show(800);
			$('#move').show();
		},
		error:function(){
			alert("통신 실패!");
		}
	});
	

}

function exerciseOne(exerciseName) {
	var total2="command=exerciseContent&exerciseName="+exerciseName;
	$.ajax({
		url:"exercise.do?"+total2,
		dataType:"json",
		success:function(msg){
			console.log(msg);
			$("#name").html(
					decodeURIComponent(msg.exerciseName) + "의 운동 방법"
			);
			$("#content").html(
					decodeURIComponent(msg.exerciseContent)
			);
			$("#URL").attr('src',decodeURIComponent(msg.exerciseUrl))
			//$("#URL").setAttribute('src',decodeURIComponent(msg.exerciseUrl))
		},
		error:function(){
			alert("통신 실패!");
		}
	});
	
}

$(document).ready(function() {
	 $("nav>ul>li").click(function(){
	        //e.preventDefault();
	        $(this).siblings().removeClass("on");
	        $(this).toggleClass("on");
	    });

});

 
	
 </script>
   <style type="text/css">
  nav>ul>li>ul{display: none;}
nav>ul>li.on>ul{display: block;}
  
  
  
  </style>
 
</head>
<%
	List<BoardDto> exerciseCategoryList = (List<BoardDto>)request.getAttribute("exerciseCategoryList");
%>
<body>

<header>
	<div id="logo"><img src="images/gym.png"  onclick = "location.href='join.do?command=menteeMain'"/></div>
	<h1 onclick = "location.href='join.do?command=menteeMain'">운토티</h1>
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
</header><br><hr>

<section>
<nav>
	<ul>
<%
	for(BoardDto boardDto : exerciseCategoryList){
%>

		<li id="on"><a onclick="exerciseCategory('<%=boardDto.getBoard_Exercise_Category()%>')"><%=boardDto.getBoard_Exercise_Category()%></a>
			<ul>
				<li id="<%=boardDto.getBoard_Exercise_Category()%>"></li>
			</ul>
		</li>

<%
	}
%>
	</ul>
</nav>

<div id="container">
	<div id="move"><br><br><br>
	<h4 id = "name"></h4>
	<h5 id = "content"></h5>
	<h5 id = "url"></h5>
	<div id="vid">
		<iframe id = "URL" width="60%" height="500px" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>      
	</div>									
</div>	
		
</div>
		
</section>
<footer>@ 2020 all copyrights reserved by 운토티</footer>
</body>
</html>