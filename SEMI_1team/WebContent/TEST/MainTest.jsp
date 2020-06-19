<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="MainTest.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	var year = new Date().getFullYear();
	var month = new Date().getMonth() + 1;
	var isTwoMonth = month < 10 ? "0" + month : month;
	var date = new Date().getDate();

	$(function () {
		$("h1").text(year + "/" + isTwoMonth);
		
		//첫째날
		var dayOfWeek = new Date(year, month-1, 1);
		//
		var lastDay = new Date(year, month, 0);
		
		var day = new Array(42);
		
		//공백
		var j;
		for(var i = 0; i < dayOfWeek; i++){
			day[i] = "";
			j = i;
		}
		
		for(var i = 0; i <= lastDay; i++){
			day[j + 1] = i + 1;
		}
		
	});
	

	
</script>

  <div class="calendar">
    <header class="mainHead">
      <h1>February 2014</h1>
    </header>

    <!-- days -->
    <ul class="start">
      <li class="days">Mon</li>
      <li class="days">Tue</li>
      <li class="days">Wed</li>
      <li class="days">Thu</li>
      <li class="days">Fri</li>
      <li class="days">Sat</li>
      <li class="days">Sun</li>
    </ul>

    <!-- row 27-2 -->
    <ul class="start">
      <li class="column light">27</li>
      <li class="column light"><i class="work"></i>28</li>
      <li class="column light">29</li>
      <li class="column light">30</li>
      <li class="column light">31</li>
      <li class="column weekend">1</li>
      <li class="column weekend">2</li>
    </ul>

    <!-- row 3-9 -->
    <ul class="start">
      <li class="column">3</li>
      <li class="column">4</li>
      <li class="column">5</li>
      <li class="column">6</li>
      <li class="column"><i class="event"></i>7</li>
      <li class="column weekend">8</li>
      <li class="column weekend">9</li>
    </ul>

    <!-- row 10-16 -->
    <ul class="start">
      <li class="column">10</li>
      <li class="column">11</li>
      <li class="column"><i class="meeting"></i>12</li>
      <li class="column">13</li>
      <li class="column">14</li>
      <li class="column weekend">15</li>
      <li class="column weekend">16</li>
    </ul>

    <!-- row 17-23 -->
    <ul class="start">
      <li class="column">17</li>
      <li class="column">18</li>
      <li class="column">19</li>
      <li class="column">20</li>
      <li class="column">21</li>
      <li class="column weekend">22</li>
      <li class="column weekend">23</li>
    </ul>

    <!-- row 24-2 -->
    <ul class="start">
      <li class="column">24</li>
      <li class="column">25</li>
      <li class="column">26</li>
      <li class="column">27</li>
      <li class="column"><i class="work"></i>28</li>
      <li class="column light weekend">1</li>
      <li class="column light weekend">2</li>
    </ul>

    <!-- row 3-9 -->
    <ul class="start">
      <li class="column light">3</li>
      <li class="column light">4</li>
      <li class="column light">5</li>
      <li class="column light">6</li>
      <li class="column light">7</li>
      <li class="column light weekend">8</li>
      <li class="column light weekend">9</li>
    </ul>
  </div>


</body>
</html>