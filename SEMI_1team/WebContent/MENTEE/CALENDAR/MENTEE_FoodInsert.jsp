<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");
   response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../../resource/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="CSS/MENTEE_FoodInsert.css" >
<script type="text/javascript" src="JS/MENTEE_FoodInsert.js"></script>
</head>
<body>
   <form name="foodForm" method="post">
      <input type="hidden" name="command" value="foodInsert">
      <div id="container">
         <span id="food">음식 입력</span>
         <div class="inputTxt" id="inputBox">
            <input type="text" class="inputTxt" name="foodName" id="name" placeholder="음식 이름" required="required"><br/>
            <input type="number" class="inputTxt" name="foodGram" id="gram" placeholder="그램" required="required"><br/>
            <input type="number" class="inputTxt" name="foodCar" id="car" placeholder="탄수화물" required="required"><br/>
            <input type="number" class="inputTxt" name="foodPro" id="pro" placeholder="단백질" required="required"><br/>
            <input type="number" class="inputTxt" name="foodFat" id="fat" placeholder="지방" required="required"><br/>
            <input type="number" class="inputTxt" name="foodCalorie" id="calorie" placeholder="칼로리" required="required"><br/>
         </div>
         <div>
            <input type="button" class="bnt" id="ok" value="입력">
            <input type="button" class="bnt" id="cancle" value="취소" onclick="location.href='MENTEE_DayMenuInsert.jsp'">
         </div>
      </div>
   </form>
</body>
</html>