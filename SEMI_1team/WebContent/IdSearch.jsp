<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
</head>
<body>
	<h1>아이디찾기</h1>
	<form action="join.do" method="post">
				<input type="hidden" name="command" value="IdSearchRes" /> 
				<span
					class="join_span"> <input type="email" class="input_text"
					name="email" placeholder="이메일작성" id="email" required="required"/>
				</span> 
				<br /> 
				<input type="submit" value="아이디 찾기">
	</form>

</body>
</html>