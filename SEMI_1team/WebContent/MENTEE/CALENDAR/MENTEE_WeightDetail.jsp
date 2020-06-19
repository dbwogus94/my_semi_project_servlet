<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mentee_weightDetail</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="JS/MENTEE_WeightDetail.js"></script>
<link href="CSS/MENTEE_WeightDetail.css" rel="stylesheet"
	type="text/css" />
</head>
<body>
<%
		//MENTEE_Main.js 에서 받아옴
		double weight = Double.parseDouble(request.getParameter("weight"));
		String date = request.getParameter("date");
		String id = request.getParameter("id");
		
		System.out.println("id : " + id);
%>

	<div class="container">
		<p class="title">체중기록</p>
		<div id="weightBox">
			<input type="text" placeholder="<%=weight%>" id="deleteWeight" /> <p id="kg">kg</p>
		</div>
		<div id="btn_group">
			<input type="button" value="삭제" class="btn" id="delBtn" onclick="deleteWeight(<%=weight %>, <%=date %>,'<%=id %>')">
			<input type="button" value="닫기" class="btn" id="closeBtn" onclick="window.close();">
		</div>
	</div>


</body>
</html>