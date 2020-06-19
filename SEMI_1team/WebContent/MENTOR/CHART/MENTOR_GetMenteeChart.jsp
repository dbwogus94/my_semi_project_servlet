<%@page import="All.statics.join.LoginProfile.dto.LoginProfileDto"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.mentee.exercise.total.dto.TotalDto"%>
<%@page import="member.mentee.exercise.total.biz.TotalBizImpl"%>
<%@page import="member.mentee.exercise.total.biz.TotalBiz"%>
<%@page import="java.util.Calendar"%>
<%@page import="member.mentee.dayMenu.biz.DayMenuBizImpl"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="member.mentee.dayMenu.biz.DayMenuBiz"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘티차트</title>
<link href="MENTOR/CHART/CSS/MENTOR_GetMenteeChart.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">
 function myFunction(x) {
     x.classList.toggle("change");
     $("#nav").toggle(800);
   }
 </script>

</head>
<%
	LoginProfileDto mentorDto = (LoginProfileDto)session.getAttribute("mentorDto");
%>
	<header>
		<div id="logo">
			<img src="images/logo_white.png"/>
		</div>
		<h1>운토티</h1>
		<div class="main_container" onclick="myFunction(this)">
			<div class="bar1"></div>
			<div class="bar2"></div>
			<div class="bar3"></div>
		</div>
	   <div id="nav">
			<ul>
				<li><a href="../../profile.do?command=">수익 관리</a></li>
				<li><a href="../../match.do?command=mentor_menteeList&mentorID=<%=mentorDto.getId()%>">멘티관리</a></li>
				<li><a href="../../board.do?command=boardMain">자유게시판</a></li>
				<li><a href="" onclick="chatPopup()">채팅</a></li>
		   </ul>
		</div>
	
	</header><br>

<hr><br><h3>MENTEE CHART</h3>

<br><hr>
<br>
<body>
<div class="board">
<%
   //로그인 id
   String MentorId = mentorDto.getId();
   //매칭된 멘티 아이디
   String id = (String)request.getAttribute("id");
   //프로필(이름)
   String name = (String)request.getAttribute("memberName");

   //1.총 섭취 칼로리 (차트) : #calorieChart
   JSONArray getCalorieChartView = (JSONArray)request.getAttribute("getCalorieChartView");
   //2.오늘 섭취 칼로리
   double getTodayCal = (double)request.getAttribute("getTodayCal");
   //3.내 기초 대사량
   double getBasal = (double)request.getAttribute("getBasal");
   //4.총 체중 (차트) : #weightChart
   JSONArray getWeightChartView = (JSONArray)request.getAttribute("getWeightChartView");
   //5.오늘 체중
   double getTodayWeight = (double)request.getAttribute("getTodayWeight");
   //6.내 bmi 지수
   double getBmi = (double)request.getAttribute("getBmi");
   //7.내 영양소 비율 (차트) : #myNutriChart 
   JSONArray getNutrientChartView = (JSONArray)request.getAttribute("getNutrientChartView");
   //8.총 운동 소모 칼로리 (차트) : #exerciseChart
   JSONArray getExerciseChartView = (JSONArray)request.getAttribute("getExerciseChartView");
   //9. 오늘 운동 소모 칼로리, 시간
   double getCalorie = (double)request.getAttribute("getCalorie");
   String getTime = (String)request.getAttribute("getTime");
   
 //bmi
   double bmi = Math.round(getBmi*100)/100.0;
   String bmiRes = "";
   if(bmi < 18.5){
	   bmiRes = "저체중";
   } else if (18.5 < bmi && bmi < 23){
	   bmiRes = "정상 체중";
   } else if (23 < bmi && bmi < 25){
	   bmiRes = "과체중";
   } else {
	   bmiRes = "비만";
   }
%>
   <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
   <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
   
   
   <div class="container">
      <p id="profile-name"><%=name %><span> 님</span></p>
      <!-- 차트 범위 (1, 3, 6 개월) -->
      <input type="button" id="btn" value="1개월" onclick="viewMonth(1)">
      <input type="button" id="btn" value="3개월" onclick="viewMonth(3)">
      <input type="button" id="btn" value="6개월" onclick="viewMonth(6)">
   	  <!-- 운동플랜 -->
   	  <input type="button" id="btn" value="운동플랜" onclick="location.href='MENTEE/CALENDAR/MENTEE_ExercisePlan.jsp'">
   </div>
 <div class="container">
      <div id="calorie">
         <fieldset class="mini-box">
         <legend>기초대사량</legend>
     <span><%=getTodayCal %> kcal</span>
         
            <br><hr><br>
            <p><%=name %>님의 기초대사량 <br/> 
             <%=getBasal %> kcal</p>
         </fieldset>
         <fieldset class="chart-container">
            <legend>칼로리 관리 추세</legend><br>
            <canvas id="calorieChart"></canvas>
         </fieldset>
      </div>
      
      <div id="weight">
         <fieldset class="mini-box">
         	<legend>체중</legend>
            <span><%=getTodayWeight %> Kg</span>
            <div class=""></div>
            <br><hr><br>
            <p><%=name %>님의 BMI 지수  <br>
            <%=Math.round(getBmi*100)/100.0 %> <%=bmiRes %></p>          
            <div></div>
         </fieldset>
         <fieldset class="chart-container">
            <legend>체중 그래프</legend><br>
            <canvas id="weightChart"></canvas>
         </fieldset>
      </div>
      
      <div id="nutrient">
         <fieldset class="chart-container_max">
            <legend>영양소</legend><br>
            <canvas id="standardNutriChart"></canvas>
            <canvas id="myNutriChart"></canvas>
         </fieldset>
      </div>
      
   
      <div id="exercise">
         <fieldset class="mini-box">
         	<legend>운동</legend>
            <span><%=getCalorie %> kcal</span>
            <br><br><hr><br>
            <p><%=getTime %> 분</p>
         </fieldset>
         <fieldset class="chart-container">
            <legend>운동 소모 칼로리</legend><br>
            <canvas id="exerciseChart"></canvas>
         </fieldset>
      </div>
      
   </div>
<script type="text/javascript">
/*차트에 들어갈 데이터*/
$(function() {
   /*--1. 총 섭취 칼로리 차트 : #calorieChart--*/
   calChartLabels = [];
   calChartData = [];
   
   $(document).ready(function() {
      $.each(<%=getCalorieChartView %>, function(idx, obj) {
         calChartLabels.push(obj.date);
         calChartData.push(obj.calorie);
      });
      createCalChart();
   });
   
   calLineChartData = {
      labels : calChartLabels,
      datasets : [ {
         label : "칼로리",
         backgroundColor : 'rgba(255, 126, 103, 0.4)',   
         borderColor : [ 'rgba(0, 0, 0, 1)',      
                  'rgba(116, 116, 116, 1)', 'rgba(255, 206, 86, 1)',
                  'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
                  'rgba(255, 159, 64, 1)' ],
         borderWidth : 2,   
         data : calChartData
      }]
   }

   /*--4. 총 체중 차트 : #weightChart--*/
   weightChartLabels = [];
   weightChartData = [];
   
   $(document).ready(function () {
      $.each(<%=getWeightChartView %>, function(idx, obj) {
         weightChartLabels.push(obj.date);
         weightChartData.push(obj.weight);   
      });
         createWeightChart();
   });
   
   weightlineChartData = {
      labels : weightChartLabels,
      datasets : [ {
         label : "체중",
         defaultFontSize : 50,
         backgroundColor : 'rgba(255, 126, 103, 0.4)',
         borderColor : [ 'rgba(0, 0, 0, 1)',
                  'rgba(0, 0, 0, 1)', 'rgba(255, 206, 86, 1)',
                  'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
                  'rgba(255, 159, 64, 1)' ],
         borderWidth : 2,
         data : weightChartData
      }]
   };

   /*--7-1. 표준 영양소 차트 : #standardNutriChart--*/
   $(document).ready(function () {
      createNutriChart();
   });
      
   /*--7-2. 내 영양소 비율 차트 : #myNutriChart  --*/
   nutrientChartLabels = ['탄수화물', '단백질', '지방'];
   nutrientChartData = [];
      
   $(document).ready(function () {
      $.each(<%=getNutrientChartView %>, function(idx, obj) {
         nutrientChartData.push(obj.car);
         nutrientChartData.push(obj.pro);
         nutrientChartData.push(obj.fat);
      });
         createMyNutriChart();
   });
      
      
   /*--8.총 운동 소모 칼로리 차트 : #exerciseChart  --*/
   exerChartLabels = [];
   exerChartData = [];
         
   $(document).ready(function () {
      $.each(<%=getExerciseChartView %>, function(idx, obj) {
         exerChartLabels.push(obj.date);
         exerChartData.push(obj.exercise);   
      });
         createExerChart();
   });
      
   exerLineChartData = {
         labels : exerChartLabels,
         datasets : [ {
            label : "운동 소모 칼로리",
            backgroundColor : 'rgba(255, 126, 103, 0.4)',
            borderColor : [ 'rgba(0, 0, 0, 1)',
                     'rgba(0, 0, 0, 1)', 'rgba(255, 206, 86, 1)',
                     'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
                     'rgba(255, 159, 64, 1)' ],
            borderWidth : 2,
            data : exerChartData
         }]
      }

});

/* creatChart 함수 */
/*--1. 총 섭취 칼로리 차트 : #calorieChart--*/
function createCalChart() {
   var ctx = document.getElementById('calorieChart').getContext('2d');
   var myChart = new Chart(ctx, {
      type : 'line',   // 차트 형식은 라인
      data : calLineChartData,
      options : {
         responsive: false,
         scales : {
            yAxes : [ {
               ticks : {
                  // 그래프 증가 텀
                  stepSize : 200
               }
            } ]
         }
      }
   });
}
/*--4. 총 체중 차트 : #weightChart--*/
function createWeightChart() {
   var ctx = document.getElementById('weightChart').getContext('2d');
   var myChart = new Chart(ctx, {
      type : 'line',
      data : weightlineChartData,
      options : {
         responsive: false,
         scales : {
            yAxes : [ {
               ticks : {
                  stepSize : 0.5
               }
            } ]
         }
      }
   });
}
/*--7-1. 표준 영양소 차트 : #standardNutriChart--*/
function createNutriChart() {
   var ctx = document.getElementById('standardNutriChart').getContext('2d');
   var myChart = new Chart(ctx,{
         type : 'doughnut',
         data : {
            labels : [ '탄수화물', '단백질', '지방' ],
            datasets : [ {
               label : '표준 영양소 비율',
               data : [ 50, 30, 20 ],
               backgroundColor : [ 'rgba(192, 192, 192, 1)',
                           'rgba(116, 116, 116, 1)',
                           'rgba(0, 0, 0, 1)' ]
            
               } ]
            },
            options : {
               responsive: false,
               scales : {
                  xAxes : [ {
                     gridLines : {
                        display : false
                     },
                     ticks : {
                        display : false
                     }
                  } ],
                  yAxes : [ {
                     gridLines : {
                        display : false
                     },
                     ticks : {
                        display : false
                     }
                  } ]
               },
               elements : {
                  center : {   // 도넛차트 센터 텍스트 : 내 기초대사량
                     text : <%=getBasal %> + ' Kcal',
                     color : '#000',
                     fontStyle : 'Arial',
                     sidePadding : 20
                  }
               }
            }
      });
}
/*--7-2. 내 영양소 비율 차트 : #myNutriChart  --*/
function createMyNutriChart() {
   var ctx = document.getElementById('myNutriChart').getContext('2d');
   var myChart = new Chart(ctx,{
         type : 'doughnut',
         data : {
            labels : nutrientChartLabels,
            datasets : [ {
               label : '내 영양소 비율',
               data : nutrientChartData,
               backgroundColor : [ 'rgba(192, 192, 192, 1)',
                        'rgba(116, 116, 116, 1)',
                        'rgba(0, 0, 0, 1)' ],
               borderColor: '#000'
               } ]
            },
            options : {
               responsive: false,
               scales : {
                  xAxes : [ {
                     gridLines : {
                        display : false
                     },
                     ticks : {
                        display : false
                     }
                  } ],
                  yAxes : [ {
                     gridLines : {
                        display : false
                     },
                     ticks : {
                        display : false
                     }
                  } ]
               },
               elements : {
                  center : {   // 도넛차트 센터 텍스트 : 오늘 총 섭취 칼로리
                     text : <%=getTodayCal %> + ' kcal', 
                     color : '#000',
                     fontStyle : 'Arial',
                     sidePadding : 20
                  }
               }
            }
         });
}
/*--8.총 운동 소모 칼로리 차트 : #exerciseChart  --*/
function createExerChart() {
   var ctx = document.getElementById('exerciseChart').getContext('2d');
   var myChart = new Chart(ctx, {
      type : 'line',
      data : exerLineChartData,
      options : {
         responsive: false,
         scales : {
            yAxes : [ {
               ticks : {
                  stepSize : 200
               }
            } ]
         }
      }
   });
}
</script>

<!-- 1, 3, 6개월 범위에 따라 차트 다시 그려주자  -->
<script type="text/javascript">
function viewMonth(month) {
   $.ajax({
      type: 'post',
      url: 'profile.do',
      data: 'command=getMenteeChartM&month=' + month +'&id=' +'<%=id%>',
      dataType: 'json',
      async:false,
      success:function(data){
         alert('통신성공');
         
         //1. 총 섭취 칼로리 그래프
         $(function () {
            //라벨 배열 다 pop하자!
            for(var i = calChartLabels.length; i > 0; i--){
               calChartLabels.pop();
            }
            for(var i = calChartData.length; i > 0; i--){
               calChartData.pop();
            }
            for(var i = weightChartLabels.length; i > 0; i--){
               weightChartLabels.pop();
            }
            for(var i = weightChartData.length; i > 0; i--){
               weightChartData.pop();
            }
            for(var i = exerChartLabels.length; i > 0; i--){
               exerChartLabels.pop();
            }
            for(var i = exerChartData.length; i > 0; i--){
               exerChartData.pop();
            }
            
            
            $.each(data, function(idx, obj) {
               $.each(obj, function (idx1, obj1) {
                  $.each(obj1, function (idx2, obj2) {
                     console.log(JSON.stringify(obj2.calDate));
                     
                     if(obj2.calDate !== undefined){
                        calChartLabels.push(obj2.calDate);
                        calChartData.push(obj2.calorie);
                     }
                     
                     if(obj2.weightDate !== undefined){
                        weightChartLabels.push(obj2.weightDate);
                        weightChartData.push(obj2.weight);
                     }
                     
                     if(obj2.exerDate !== undefined){
                        exerChartLabels.push(obj2.exerDate);
                        exerChartData.push(obj2.exercise);
                     } 
                     
                  });
               });
            });
               createCalChart();
               createWeightChart();
               createExerChart();
         });
         
      },
      error:function(msg){
         alert('통신실패');
         console.log(msg);
      }
      
      
   });
}
</script>

<!-- 차트 가운데 텍스트 삽입해주는 플러그인 -->
<script type="text/javascript">
/* doughnut 차트 가운데에 text 넣어주는 플러그인 */
Chart.pluginService.register({
   beforeDraw: function (chart) {
      if (chart.config.options.elements.center) {
    // Get ctx from string
    var ctx = chart.chart.ctx;
    
         // Get options from the center object in options
    var centerConfig = chart.config.options.elements.center;
     var fontStyle = centerConfig.fontStyle || 'Arial';
         var txt = centerConfig.text;
    var color = centerConfig.color || '#000';
    var sidePadding = centerConfig.sidePadding || 20;
    var sidePaddingCalculated = (sidePadding/100) * (chart.innerRadius * 2)
    // Start with a base font of 30px
    ctx.font = "30px " + fontStyle;
    
         // Get the width of the string and also the width of the element
         // minus 10 to give it 5px side padding
    var stringWidth = ctx.measureText(txt).width;
    var elementWidth = (chart.innerRadius * 2) - sidePaddingCalculated;

    // Find out how much the font can grow in width.
    var widthRatio = elementWidth / stringWidth;
    var newFontSize = Math.floor(30 * widthRatio);
    var elementHeight = (chart.innerRadius * 2);

    // Pick a new font size so it will not be larger than the height of
   // label.
    var fontSizeToUse = Math.min(newFontSize, elementHeight);

   // Set font settings to draw it correctly.
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    var centerX = ((chart.chartArea.left + chart.chartArea.right) / 2);
    var centerY = ((chart.chartArea.top + chart.chartArea.bottom) / 2);
    ctx.font = fontSizeToUse+"px " + fontStyle;
    ctx.fillStyle = color;
    
    // Draw text in center
    ctx.fillText(txt, centerX, centerY);
      }
   }
});
</script>
  </div> 
  
  <footer>@ 2020 all copyrights reserved by 운토티</footer>
</body>
</html>