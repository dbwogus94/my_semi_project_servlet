
<%@page import="All.statics.join.menuFood.dto.menuFoodDto"%>
<%@page import="All.statics.Util"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.mentee.dayMenu.biz.DayMenuBizImpl"%>
<%@page import="member.mentee.dayMenu.biz.DayMenuBiz"%>
<%@page import="java.util.List"%>
<%@page import="member.mentee.dayMenu.dto.DayMenuDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mentee_menuDetail</title>
<link href="CSS/MENTEE_MenuDetail.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
   src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="JS/MENTEE_MenuDetail.js?ver1"></script>
</head>
<body>
   <!-- MENTEE_Main.js 에서 팝업창 열어주면서 가져온 데이터들 -->
   <%
      String menuDate = request.getParameter("menu");
      DayMenuBiz menuBiz = new DayMenuBizImpl();
      String id = "MENTEE01";
      List<menuFoodDto> selectMorning = menuBiz.selectMorning(menuDate);
      List<menuFoodDto> selectLunch = menuBiz.selectLunch(menuDate);
      List<menuFoodDto> selectEven = menuBiz.selectEven(menuDate);
      List<menuFoodDto> selectSnack = menuBiz.selectSnack(menuDate);
      
      
   %>
   <div class="container">
      <p id="title">식단기록</p>
      <p class="time">아침</p>
      <div class="tagDiv" id="tag-area1">
         <%
            for (menuFoodDto list : selectMorning) {
         %>
         <span class="tag" id="morning"><%=list.getFoodName()%></span><br/>

         <%
            }
         %>
      </div>
      <p class="time">점심</p>
      <div class="tagDiv" id="tag-area2">
         <%
            for (menuFoodDto list : selectLunch) {
         %>
         <span class="tag" id="snack"><%=list.getFoodName()%></span><br/>

         <%
            }
         %>
      </div>
      <p class="time">저녁</p>
      <div class="tagDiv" id="tag-area3">
         <%
            for (menuFoodDto list : selectEven) {
         %>
         <span class="tag" id="even"><%=list.getFoodName()%></span><br/>

         <%
            }
         %>
      </div>
      <p class="time">간식</p>
      <div class="tagDiv" id="tag-area4">
         <%
            for (menuFoodDto list : selectSnack) {
         %>
         <span class="tag" id="snack"><%=list.getFoodName()%></span><br/>
         <%
            }
         %>
      </div>

      <div id="btn_group">
         <input type="button" class="btn" id="delBtn" value="삭제" onclick="location.href='../../dayMenu.do?command=deleteMenu&menuDate=<%=menuDate %>'"/>
         <input type="button" class="btn" id="closeBtn" value="닫기" onclick="window.close();" />
      </div>
   </div>

</body>

</html>