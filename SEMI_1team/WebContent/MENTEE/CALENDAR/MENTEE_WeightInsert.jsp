<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="CSS/MENTEE_WeightInsert.css" rel="stylesheet"
   type="text/css" />
<script type="text/javascript" src="../../resource/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="JS/MENTEE_WeightInsert.js"></script>
</head>
<%
   String id = request.getParameter("id");   
%>
<body>
   <div class="container">
   <p>오늘의 체중</p>
      <div class="dropdown">
         <select id="selectYear" class="dropdown-select">
            
         </select>
      </div>
      <div class="dropdown">
         <select id="selectMonth" class="dropdown-select">
            
         </select>
      </div>
      <div class="dropdown">
         <select id="selectDay" class="dropdown-select">
            
         </select>
      </div>


      <div>
         <input type="number" placeholder="체중을 입력해주세요." id="inputWeight" /><span> kg</span>
      </div>

      <div id="btn_group">
         <!-- MENTEE_WeightInsert.js -->
         <input type="button" id="updateBtn" value="입력" onclick="insertWeight('<%=id %>');">
      </div>
   </div>
</body>
</html>