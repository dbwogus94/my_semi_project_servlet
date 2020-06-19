<%@page import="All.statics.join.LoginProfile.dto.LoginProfileDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="member.mentee.exercise.plan.dto.PlanDto"%>
<%@page import="java.util.List"%>
<%@page import="member.mentee.exercise.plan.biz.PlanBizImpl"%>
<%@page import="member.mentee.exercise.plan.biz.PlanBiz"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운동플랜</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="MENTEE/CALENDAR/CSS/MENTEE_ExerciseInsert.css" rel="stylesheet">
</head>
<%
   LoginProfileDto menteeDto = (LoginProfileDto)session.getAttribute("menteeDto");
%>
<%
   //프로필 영역
   String name = menteeDto.getMemberName();
   int year = (int)request.getAttribute("year");
   int month = (int)request.getAttribute("month");
   int date = (int)request.getAttribute("date");
   
   //plan영역
   List<PlanDto> planList = (List<PlanDto>) request.getAttribute("planList");
 //plan영역
   List<PlanDto> planCList = (List<PlanDto>) request.getAttribute("planCList");
%>
<body>
<script type="text/javascript">
 year = <%=year %>;
 month = <%=month %>;
 date = <%=date %>;
   $(function() {
      /*---------------Date choose---------------*/
      //현재 날짜 가져오는 함수
      var year = <%=year %>;
      var month = <%=month %>;
      var date = <%=date %>;

      selectYear = $("#selectYear");
      selectYear1 = $("#selectYear option");

      for (var i = 1990; i < 2050; i++) {
         $('<option>').val(i).text(i).appendTo(selectYear);
      }
      selectYear.val(year);

      selectMonth = $("#selectMonth");
      optionsM = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
            "12" ];

      for (var i = 0; i < optionsM.length; i++) {
         $('<option>').val(optionsM[i]).text(optionsM[i]).appendTo(
               selectMonth);
      }
      selectMonth.val(optionsM[month - 1]);

      selectDate = $("#selectDay");
      optionDay = [];
      var lastDay = (new Date($("#selectYear option:selected").text(), $(
            "#selectMonth option:selected").text(), 0)).getDate();
      for (var i = 1; i <= lastDay; i++) {
         optionDay.push(i);
      }

      for (var i = 0; i < optionDay.length; i++) {
         $('<option>').val(optionDay[i]).text(optionDay[i]).appendTo(
               selectDate);
      }
      selectDate.val(date);

      $("#selectMonth").change(
            function() {
               $("select[id='selectDay'] option").remove();
               var options = [];
               var lastDay = (new Date($("#selectYear option:selected")
                     .text(), $("#selectMonth option:selected").text(),
                     0)).getDate();
               for (var i = 1; i <= lastDay; i++) {
                  options.push(i);
               }

               for (var i = 0; i < options.length; i++) {
                  $('<option>').val(options[i]).text(options[i])
                        .appendTo(selectDate);
               }
               selectDate.val(date);
            });
   });
   
   $(document).on('change', '.dropdown-select', function () {
	  /*-- 선택된 날짜 --*/
	  yy = $('#selectYear').val();
	  mm = $('#selectMonth').val() < 10 ? '0' + $('#selectMonth').val() : $('#selectMonth').val();
	  dd = $('#selectDay').val() < 10 ? '0' + $('#selectDay').val() : $('#selectDay').val();
	   
      var selectDate = new Date(yy, mm-1, dd); 
      var dayOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
      var planDayofweek = dayOfWeek[selectDate.getDay()];            //선택된 날짜 요일
      location.href = 'plan.do?command=getSelectPlan&year='+yy +'&month=' +mm+'&date='+dd;
   });
   
   /*-- 체크박스 값 가져오는 함수 --*/
   $(document).on('click', '#insertBtn', function() {
	  /*-- 선택된 날짜 --*/
	  yy = $('#selectYear').val();
	  mm = $('#selectMonth').val() < 10 ? '0' + $('#selectMonth').val() : $('#selectMonth').val();
	  dd = $('#selectDay').val() < 10 ? '0' + $('#selectDay').val() : $('#selectDay').val();
	  //유산소 운동 시간
	  var aerobicTime = 0;
	  //유산소 이름
	  var aerobicName = "";
      $('.allChk').each(function () {
         if($(this).is(':checked')){
            //선택된 체크박스 id
            var id = $(this).attr('id');
            //선택된 애들 변수i
            var i = id.split('chk');
            //선택된 카테고리, 이름, 횟수 가져오기
            var category = $('#category'+ i[1]).text();
            var exerciseName = $('#exercise'+i[1]).text();
            var count = $.trim($('#count' +i[1]).text());
           
            if(category === '유산소'){
            	aerobicTime = aerobicTime + count;
            	aerobicName = exerciseName;
            }
            
            $.ajax({
                url: 'plan.do',
                data: {
               	command: 'insertPlanC',
                   year : yy,
                   month : mm,
                   date : dd,
                   category : category,
                   exerciseName : exerciseName,
                   count : count
                }
                ,
                success: function (data) {
                   alert('통신성공');
                }
             });
         }
         
      });
      
      //total 테이블에 총 운동 시간 insert
      var insertTime = $('#insertTime').val();
      $.ajax({
    	 url: 'total.do',
    	 data: {
    		 command : 'insertTotalTime',
    		 aerobicTime : aerobicTime,
    		 aerobicName : aerobicName,
    		 insertTime : insertTime,
    		 year : yy,
             month : mm,
             date : dd
    	 },
    	 success: function (data) {
             alert('total 통신성공');
             opener.window.location.reload();
             window.close();
          }
      });
      
      
   });

</script>
   <div class="container">
      <div id="profile">
         <img alt="" src="">
         <p><%=name %> 님의 <%=year %>년 <%=month %>월 <%=date %>일 <span>운동플랜</span></p>
      </div>
      
       <div id="date">
            <div class="selectTime">
               <select id="selectYear" class="dropdown-select"></select>
               <select id="selectMonth" class="dropdown-select"></select>
               <select id="selectDay" class="dropdown-select"></select>
            </div>
		</div>
<%
	int i = 0;
	if(planCList.size() != 0){
%>
	      <div id="noPlan">이미 등록된 기록이 있습니다.</div>
<%		  
	 }
	else if(planList.size() == 0){
%>
      <div id="noPlan">계획된 운동이 없습니다.</div>
<%
      } else {

      for(PlanDto dto : planList){
%>
      <form>
         <div class="plan-container">
            <div class="plan-box" id="plan-box<%=i %>">
               <div class="plan" id="plan<%=i %>">
                  <p class="category" id="category<%=i %>"><%=dto.getPlanCategory()%></p>
                  <p class="exercise-name" id="exercise<%=i %>"><%=dto.getExerciseName()%></p>
                  <p class="count" id="count<%=i %>">
<%
               if(dto.getPlanCategory().equals("유산소")){
%>
                  <%=dto.getPlanTime()%>
<%                  
               }
%>               
               <%=dto.getPlanCount()%>
               
                  </p>
               </div>
               <input class="allChk" id="chk<%=i %>" type="checkbox">완료했습니다.
            </div>
         </div>
         
<%
         i++;
      }
   
      if(planList.size() != 0){

%>
		<br>
      <div id="time">
         <p>총 운동시간 <input type="text" id="insertTime"> 분 </p>
         
      </div>
      <input type="button" value="입        력" id="insertBtn">
      </form>
   </div>
<%
      }
      }
%>   
<script type="text/javascript">



</script>
</body>   
</html>