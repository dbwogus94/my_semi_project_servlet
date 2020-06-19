<%@page import="join.dto.JoinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
/*layout*/
header{width:100%;height: 50px;
    margin-top: 1%; background: #000;}

header>h1{float:left; font-size: 30px; font-weight: bold; color:#fff;
   text-align: left; margin-top: 0.3%;}
#logo>img{float:left; width:100px; height:50px; padding-left:5px;}

#content{
	height: 370px;
	text-align: center;
}
#btn{
	border: 1px solid #000;
	background: none;
	margin-top:10px;
	height:30px;
}
#nowPW{
	height:30px;
	border: none;
	border-bottom: 2px solid #000;
	text-align: center;
}
#ChangePW{
	margin: 10px 0;
	height:30px;
	border: none;
	border-bottom: 2px solid #000;
	text-align: center;
	}
#ConfirmPW{
	margin: 10px 0;
	height:30px;
	border: none;
	border-bottom: 2px solid #000;
	text-align: center;
	
	}
	
footer{
   width: 100%;
   height: 40px;
   background-color: #000;
   color: #f2f2f2;
   text-align: center;
   padding-top: 10px;
}
  
</style>
<meta charset="UTF-8">
<% JoinDto joinDto = (JoinDto)request.getAttribute("JoinDto"); %>
<script type="text/javascript" src="resource/jquery-3.4.1.js"></script>
<script type="text/javascript">
	var chk1 = false;
	var chk2 = false;
 
	window.onload = function() {
		
		$("#nowPW").keyup(function() {
			var pw = document.getElementById("nowPW");
			console.log(pw.value);
		});
			
		$("#ChangePW").keyup(function() {			
			var ChangePW = document.getElementById("ChangePW"); 
			console.log(ChangePW.value);
		});
		
		$("#ConfirmPW").keyup(function() {			
			var ConfirmPW = document.getElementById("ConfirmPW");
			console.log(ConfirmPW.value);
		});
		
	}
	function pwConfirm() {
		var pw = document.getElementById("nowPW");
		var ChangePW = document.getElementById("ChangePW"); 
		var ConfirmPW = document.getElementById("ConfirmPW");
		
		if(ChangePW.value == ConfirmPW.value){
			var chk2 = true;
		}
		
		if(pw.value==<%=joinDto.getJoinPw()%>){
			var chk1 = true;
		}
		if(!(ChangePW.value == pw.value)){
			var chk3 = true;
		}
		
		if(chk1&&chk2&&chk3){
			alert("비밀번호 변경 할꺼냐?");
		}else{
			
			if(!chk1){
				alert("현재 비밀번호를 확인하세요");
				return false;
			}else if(!chk2){
				alert("새 비밀번호를 확인하세요");
				return false;
			}else if(!chk3){
				alert("현재 비밀번호와 다른 비밀번호를 입력해주세요");
				return false;
			}else{
				return true;
			}
		}
	}

</script>

<title>Insert title here</title>
</head>
<body>
<header>
   <div id="logo"><img src="images/logo_white.png" /></div>
   <h1>운토티</h1>
  
</header>
	<form action="join.do" method="post" onsubmit="return pwConfirm();">
	<input type="hidden" name="command" value="PasswordChangeRes">
	<input type="hidden" name="id" value="<%= joinDto.getId()%>">
	<div id="content">	
	<h1><%=joinDto.getId()%>님 비밀번호 변경</h1>
	<fieldset>
	<legend>NOW</legend>
	<input type="text" id="nowPW" placeholder="비밀번호 작성">
	</fieldset>
	<br>
	<fieldset>
	<legend>AFTER</legend>
	<input type="text" id="ChangePW" name="ChangePW" placeholder="비밀번호 작성">
	<br>
	<input type="text" id="ConfirmPW" placeholder="비밀번호 작성">
	<br>
	<input type="submit" id="btn" value="변경하기">
	</fieldset>
	</div>
	</form>
 <footer>@ 2020 all copyrights reserved by 운토티</footer>
</body>
</html>