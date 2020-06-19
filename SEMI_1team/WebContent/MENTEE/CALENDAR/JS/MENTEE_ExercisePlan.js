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
var selectDiv;
var category;
var selectExer;
var selectCount;
var selectTime;
var dayOfWeek;
function onDragStart(event) {
    
   // dataTransfer.setData("name", value)
   event.dataTransfer.setData("select", event.target.id); 
   event.dataTransfer.effectAllowed = "copy";
   
   clone = event.target.cloneNode(true);
   cloneId = event.target.getAttribute("select");
   clone.className += ' ' + 'selected';
   
   selectDiv = event.target.id;
   category = $("#"+selectDiv).children('h4').text();
   selectExer = $("#"+selectDiv).children('.selectExer').find("option:selected").val();
   selectCount = $("#"+selectDiv).children('.selectCount').find("option:selected").val();
   selectTime = $("#"+selectDiv).children('.selectTime').find("option:selected").val();
   console.log(category);
   console.log(selectExer);
   console.log(selectDiv);
   
}

// 드롭 대상 (드롭위치지정) : 기본적으로 데이터와 요소는 다른 요소에 드롭될 수 없기 때문에 기본동작을 방지(prevent)한다.
function onDragOver(event) {
   event.dataTransfer.dropEffect = "copy"; 
    event.preventDefault();
   
}

// 드롭
var i = 0;

function onDrop(event) {

   event.dataTransfer.dropEffect = "copy";
   event.preventDefault();        
   //선택된 요소 복제(자식요소까지)해서 drop 영역에 drop해줄거야 
   var data = event.dataTransfer.getData("select");
   var clone = document.getElementById(data).cloneNode(true);
   //clone에 select값 가져오기
   $(clone).children('.selectExer').val(selectExer).prop("selected", true);
   $(clone).children('.selectCount').val(selectCount).prop("selected", true);
   $(clone).children('.selectTime').val(selectTime).prop("selected", true);
   
   //clone select 값 변경 불가
   $(clone).children('.selectExer').attr("disabled", true);
   $(clone).children('.selectCount').attr("disabled", true);
   $(clone).children('.selectTime').attr("disabled", true);

    //옮겨진 애는 못 옮기게 하자 draggable="false"
   //그대신 x표 만들어야 되나 아..
   clone.setAttribute("draggable", "false");
   clone.setAttribute("id", "select" + i);
   i++;
   event.target.closest(".drop").append(clone);        
   
   dayOfWeek = event.target.id;

   console.log(category);
   console.log(dayOfWeek);
   
   $.ajax({
      type:"post",
      url:"../../plan.do?command=planInsert",
      data: "planCategory="+category+"&exerciseName="+selectExer+
      "&planCount="+selectCount+"&planTime="+selectTime+
      "&dayOfWeek="+dayOfWeek,
   });
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
   //closest() : 셀렉터로 잡히는 상위 요소 중 가장 근접한 하나 반환해줌
   $(this).closest("div").css('display','none');
   
   $.ajax({
      type:"post",
      url:"../../plan.do?command=planDelete",
      data: "planCategory="+category+"&exerciseName="+selectExer+
      "&planCount="+selectCount+"&planTime="+selectTime+
      "&dayOfWeek="+dayOfWeek,
   });
});
  
function myFunction(x) {
    x.classList.toggle("change");
    document.getElementById("myDropdown").classList.toggle("show");
}


window.onclick = function(event) {
   if (!event.target.matches('.menu_icon')) {
   var dropdowns = document.getElementsByClassName("dropdown-content");
   var i;
      for (i = 0; i < dropdowns.length; i++) {
         var openDropdown = dropdowns[i];
         if (openDropdown.classList.contains('show')) {
            openDropdown.classList.remove('show');
         }
       }
   }
}