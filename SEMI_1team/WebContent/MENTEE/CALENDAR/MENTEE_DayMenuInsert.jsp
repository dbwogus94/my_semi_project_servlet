<%@page import="member.mentee.food.dto.FoodDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");
   response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://kit.fontawesome.com/599e2aa924.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="CSS/MENTEE_DayMenuInsert.css" >
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<%
   String id = request.getParameter("id");   
%>
<body>
   <input type="hidden" id="id" value="<%=id%>">   
   <div class="container">
      <div id="date">
         <div class="selectTime">
            <select id="selectYear" class="dropdown-select"></select>
            <select id="selectMonth" class="dropdown-select"></select>
            <select id="selectDay" class="dropdown-select"></select>
            <select id="selectMeal">
               <option selected="selected">아침</option>
               <option>점심</option>
               <option>저녁</option>
               <option>간식</option>
            </select>
         </div>
      </div>
      <div class="dropdown">
         <input type="button" class="img_searchIcon">
         <input type="text" class="input_tag" placeholder="Search.." id="searchInput">
      </div>
      <div class="meal" id="meal">
         <div id="spanbreakfast">
            <span class="spanMeal" >아침</span>
         </div>
         <div class="meal" id="breakfast"></div>
         <div id="spanlunch">
            <span class="spanMeal">점심</span>
         </div>
         <div class="meal" id="lunch"></div>
         <div id="spandinner"> 
            <span class="spanMeal">저녁</span>
         </div>
         <div class="meal" id="dinner"></div>
         <div id="spansnack">
            <span class="spanMeal" >간식</span>
         </div>
         <div class="meal" id="snack"></div>
      </div>
      <div id="noFood">
         <span>해당 음식이 존재하지 않습니다. </br>
         직접 입력하세요</span>
      </div>
      <div id="bnt">       
         <input id="ok" class="bnt" type="button" value="입              력" onclick="location.href='MENTEE_Main.jsp'">
         <input id="apply" class="bnt" type="button" value="새로운 음식 추가" onclick="location.href='MENTEE_FoodInsert.jsp'">
      </div>
   </div>
   <script type="text/javascript" src="JS/MENTEE_DayMenuInsert.js"></script>
   <div id="gram">
      <span id="inputGram">섭취량 입력</span>
      <input id="insertGram" type="number"><span id="g">g</span> <br>
      <input id="gramBnt" type="button" value="입         력">
      <input id="cancle" type="button" value="취         소">
   </div>
</body>
</html>