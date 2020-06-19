<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운동플랜</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style type="text/css">
.container {
	width: 100%;
}

.dropdown {
  display: inline-block;
  position: relative;
  overflow: hidden;
  height: 28px;
  width: 150px;
  background: #f2f2f2;
  border: 1px solid;
  border-color: white #f7f7f7 whitesmoke;
  border-radius: 3px;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.08);
}

.selectPlan {
	display: inline-block;
    width: 10%;
    border: 1px solid gray;
    background-color: black;
    color: white;
}

h4 {
	font-size: 20px;
	text-align: center;
}

ul {
    text-align: center;
    /* border: none; */
    padding: 0px;
    margin: 20px auto;
}

.selectPlan .close{
	display: inline-block;
  	right: 4px;
  	bottom: 3px;
  	visibility: hidden;
}

.drop .selectPlan:hover .close{
  visibility: visible;
}

.close:hover {
  color: rgba(0,0,0,.5);
  cursor: pointer;
}

.exercisePlan {
    margin-left: 12%;
}

.selectExer {
	width: 100%;
    height: 30px;
    margin-bottom: 10px;
    background: black;
    color: white;
    border: none;
    border-bottom: 1px solid white;
}

.selectCount {
	width: 100%;
    height: 30px;
    margin-bottom: 10px;
    background: black;
    color: white;
    border: none;
    border-bottom: 1px solid white;
}

li {
	display: inline-block;
	list-style-type: none;
	width: 13%;
}

.drop {
    float: left;
    width: 100%;
    height: 700px;
    border-right: 1px solid gray;
    /* text-align: center; */
}

div#mon {
    border-left: 1px solid gray;
}

.drop > div {
	margin: 10px;
    width: 80%;
    background-color: black;
    color: white;
}

.dropdown-select {
    width: 150px;
    height: 35px;
    border: none;
    border-bottom: 2px solid black;
    margin-right: 5px;
}

.date {
    padding: 20px 30%;
}

</style>
<script type="text/javascript">
//현재 날짜 가져오는 함수
var year = new Date().getFullYear();
var month = new Date().getMonth() + 1;
var date = new Date().getDate();

//onload
//var 안 붙이면 함수 밖에서 쓸 수 있는 '전역변수'
$(function() {	
	 selectYear = $("#selectYear");
	 selectYear1 = $("#selectYear option");

	for (var i = 1990; i < 2050; i++) {
		$('<option>').val(i).text(i).appendTo(selectYear);
	}
	selectYear.val(year);


	 selectMonth = $("#selectMonth");
	 optionsM = [ "January", "February", "March", "April", "May", "June",
			"July", "August", "September", "October", "November", "December" ];

	for (var i = 0; i < optionsM.length; i++) {
		$('<option>').val(optionsM[i]).text(optionsM[i]).appendTo(selectMonth);
	}
	selectMonth.val(optionsM[month - 1]);


	 selectDate = $("#selectDay");
	 options = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
			"12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22",
			"23", "24", "25", "26", "27", "28", "29", "30", "31" ];
	for (var i = 0; i < options.length; i++) {
		$('<option>').val(options[i]).text(options[i]).appendTo(selectDate);
	}
	selectDate.val(date);
	

});
/*-----------------selectDate---------------------------*/
    // 드래그 대상 
    function onDragStart(event) {
        
     	// dataTransfer.setData("name", value)
        event.dataTransfer.setData("select", event.target.id); 
        event.dataTransfer.effectAllowed = "copy";
        
        clone = event.target.cloneNode(true);
        cloneId = event.target.getAttribute("select");
        clone.className += ' ' + 'selected';
       
    }

    // 드롭 대상 (드롭위치지정) : 기본적으로 데이터와 요소는 다른 요소에 드롭될 수 없기 때문에 기본동작을 방지(prevent)한다.
    function onDragOver(event) {
    	event.dataTransfer.dropEffect = "copy"; 
        event.preventDefault();
    }

    // 드롭
    function onDrop(event) {
    	var i = 0;
    	event.dataTransfer.dropEffect = "copy";
        event.preventDefault();        
        //선택된 요소 복제(자식요소까지)해서 drop 영역에 drop해줄거야 
        var data = event.dataTransfer.getData("select");
        var clone = document.getElementById(data).cloneNode(true);
       
        //옮겨진 애는 못 옮기게 하자 draggable="false"
        //그대신 x표 만들어야 되나 아..
        clone.setAttribute("draggable", "false");
        clone.setAttribute("id", "select" + i);
        i++;
        event.target.closest(".drop").append(clone);        
        
    }

    /*
    $(document).ready( function() {
  	  $("h4").on("click", ".close", function() {
  	    $(this).parents("div").fadeOut(100);
  	  });
  	});
    */
    $(document).ready(function() {
    	/*
	    $(".close").click(function () {
	    	alert('눌렀음');
	    	$(this).parents("div").fadeOut(100);
		});
    	*/
	    
	  
    });
    
    //동적으로 생성된 요소에 이벤트 적용하기
    $(document).on("click", ".close" ,function(){
    	alert('눌렀음');
    	//closest() : 셀렉터로 잡히는 상위 요소 중 가장 근접한 하나 반환해줌
    	$(this).closest("div").fadeOut(100);
    });
  
    //데이터 넘어오나
    function insert() {
		$("")
	}
    
</script>

</head>
<body>

	<div class="container">	
		<h4>기간</h4>
		<div class="date">
			<select id="selectYear" class="dropdown-select">					
			</select><span class="spanDate">년</span> 
			<select id="selectMonth" class="dropdown-select">				
			</select><span class="spanDate">월</span> 
			<select id="selectDay" class="dropdown-select">				
			</select><span class="spanDate">주</span> 
		</div>
	</div>
 <!-- 가슴, 다리, 팔, 등, 어깨, 복근, 전신 카테고리 -->
	<div class="exercisePlan">
		<div class="selectPlan" id="select1" draggable="true" ondragstart="onDragStart(event)">
			<h4>가슴<span class="close">&times;</span></h4>
			<select class="selectExer">
				<option>스쿼트</option>
				<option>레그레이즈</option>
			</select>
			<select class="selectCount">
				<option>10회</option>
				<option>15회</option>
				<option>20회</option>
			</select>
		</div>
		
		<div class="selectPlan" id="select2" draggable="true" ondragstart="onDragStart(event)">
			<h4>다리<span class="close">&times;</span></h4>
			<select class="selectExer">
				<option>스쿼트</option>
				<option>레그레이즈</option>
			</select>
			<select class="selectCount">
				<option>10회</option>
				<option>15회</option>
				<option>20회</option>
			</select>
		</div>
		
		<div class="selectPlan" id="select3" draggable="true" ondragstart="onDragStart(event)">
			<h4>팔<span class="close">&times;</span></h4>
			<select class="selectExer">
				<option>스쿼트</option>
				<option>레그레이즈</option>
			</select>
			<select class="selectCount">
				<option>10회</option>
				<option>15회</option>
				<option>20회</option>
			</select>
		</div>
		
		<div class="selectPlan" id="select4" draggable="true" ondragstart="onDragStart(event)">
			<h4>등<span class="close">&times;</span></h4>
			<select class="selectExer">
				<option>스쿼트</option>
				<option>레그레이즈</option>
			</select>
			<select class="selectCount">
				<option>10회</option>
				<option>15회</option>
				<option>20회</option>
			</select>
		</div>
		
		<div class="selectPlan" id="select5" draggable="true" ondragstart="onDragStart(event)">
			<h4>어깨<span class="close">&times;</span></h4>
			<select class="selectExer">
				<option>스쿼트</option>
				<option>레그레이즈</option>
			</select>
			<select class="selectCount">
				<option>10회</option>
				<option>15회</option>
				<option>20회</option>
			</select>
		</div>
		
		<div class="selectPlan" id="select6" draggable="true" ondragstart="onDragStart(event)">
			<h4>복근<span class="close">&times;</span></h4>
			<select class="selectExer">
				<option>스쿼트</option>
				<option>레그레이즈</option>
			</select>
			<select class="selectCount">
				<option>10회</option>
				<option>15회</option>
				<option>20회</option>
			</select>
		</div>
		
		<div class="selectPlan" id="select7" draggable="true" ondragstart="onDragStart(event)">
			<h4>전신<span class="close">&times;</span></h4>
			<select class="selectExer">
				<option>스쿼트</option>
				<option>레그레이즈</option>
			</select>
			<select class="selectCount">
				<option>10회</option>
				<option>15회</option>
				<option>20회</option>
			</select>
		</div>
		<div class="selectPlan" id="select8" draggable="true" ondragstart="onDragStart(event)">
			<h4>유산소<span class="close">&times;</span></h4>
			<select class="selectExer">
				<option>스쿼트</option>
				<option>레그레이즈</option>
			</select>
			<select class="selectCount">
				<option>10회</option>
				<option>15회</option>
				<option>20회</option>
			</select>
		</div>	
	</div>
		
<!-- 계획창 -->
<form>
		<ul>
			<li>
				<p>월</p>
				<div class="drop" id="mon" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
			</li>
			<li>
				<p>화</p>
				<div class="drop" id="tue" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
			</li>
			<li>
				<p>수</p>
				<div class="drop" id="wen" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
			</li>
			<li>
				<p>목</p>
				<div class="drop" id="thu" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
			</li>
			<li>
				<p>금</p>
				<div class="drop" id="fri" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
			</li>
			<li>
				<p>토</p>
				<div class="drop" id="sat" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
			</li>
			<li>
				<p>일</p>
				<div class="drop" id="sun" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
			</li>
		</ul>
		
		<div>
			<input type="submit">
		</div>
		</form>
</body>
</html>