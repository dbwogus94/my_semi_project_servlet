<%@page import="join.biz.JoinBizImpl"%>
<%@page import="join.biz.JoinBiz"%>
<%@page import="join.dto.JoinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="resource/jquery-3.4.1.js"></script>
<script type="text/javascript">
	var idChk = false;
	var emailChk = false;
	
	function PwSearch() {
		var id = document.getElementById("id");
		var email = document.getElementById("email");
		if(id.value==""){
			alert("id를 작성해주세요.");
		}else if(email.value==""){
			alert("email을 작성해주세요.");
		}else{
			 $.ajax({
					url:"join.do",
					type:"post",
					async: true,
					data:{
						command:"PwSearchId",
						id: id.value,
						email: email.value
					},
					dataType:"text",
					success: function(msg){
						if(msg === "ok"){
							alert("정보확인완료");
							idChk = true;
							document.getElementById( 'InfoFirm' ).setAttribute('style','display: none')
							document.getElementById( 'PwSubmit' ).setAttribute('style','display: ')
						} else if(msg === "fail"){
							alert("id,email을 확인 해주세요.");
							idChk = false;
						}
					},
					error: function(){
						alert("통신 실패");
					}
	        	 });
			}
		}
	function PwPopup() {
		window.close();
		var Pwid = document.getElementById("id").value;
		var Pwemail = document.getElementById("email").value;
		window.open("join.do?command=PwSearchRes&id="+Pwid+"&email="+Pwemail,"","height=300px, weight=300px");
		
	}
</script>

<title>Insert title here</title>
</head>
<body>
	<h1>비밀번호 찾기</h1>
	<form action="join.do?command=PwSearchRes" method="post" onsubmit="PwPopup();">
				<input type="hidden" name="command" value="IdSearchRes" /> 
				<span
					class="join_span"> <input type="text" class="input_text"
					name="id" placeholder="id 작성" id="id" required="required"
					 />
				</span>
				<span
					class="join_span"> <input type="email" class="input_text"
					name="email" placeholder="이메일작성" id="email" required="required"/>
				</span> 
				<span>
					<input type="button" value="정보확인" id="InfoFirm" onclick="PwSearch();">
				</span>
				<br /> 
				<input type="submit" value="비밀번호 찾기" id="PwSubmit" style="display: none;">
	</form>

</body>
</html>