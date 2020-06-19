//현재 날짜 가져오는 함수
var year = new Date().getFullYear();
var month = new Date().getMonth() + 1;
var date = new Date().getDate();

$(function() {
   
   selectYear = $("#selectYear");
   selectYear1 = $("#selectYear option");

   for (var i = 1990; i < 2050; i++) {
      $('<option>').val(i).text(i).appendTo(selectYear);
   }
   selectYear.val(year);
   

    selectMonth = $("#selectMonth");
    optionsM = [ "1", "2", "3", "4", "5", "6",
         "7", "8", "9", "10", "11", "12" ];

   for (var i = 0; i < optionsM.length; i++) {
      $('<option>').val(optionsM[i]).text(optionsM[i]).appendTo(selectMonth);
   }
   selectMonth.val(optionsM[month - 1]);

   selectDate = $("#selectDay");
   optionDay = [];
   var lastDay = (new Date($("#selectYear option:selected").text(),$("#selectMonth option:selected").text(),0)).getDate();
   for(var i=1; i<=lastDay; i++){
      optionDay.push(i);
   }
   
   for (var i = 0; i < optionDay.length; i++) {
      $('<option>').val(optionDay[i]).text(optionDay[i]).appendTo(selectDate);
   }
   selectDate.val(date);
   
   $("#selectMonth").change(function () {
      $("select[id='selectDay'] option").remove();
      var options = [];
      var lastDay = (new Date($("#selectYear option:selected").text(),$("#selectMonth option:selected").text(),0)).getDate();
      for(var i=1; i<=lastDay; i++){
         options.push(i);
      }
   
      for (var i = 0; i < options.length; i++) {
         $('<option>').val(options[i]).text(options[i]).appendTo(selectDate);
      }
      selectDate.val(date);
   });
    
   console.log(new Date("'"+selectYear.val()+"-"+selectMonth.val()+"-"+selectDate.val()+"'").getDay());

});
/*-----------------selectDate---------------------------*/

/*
 * 
 * 
 */

   var insertWeight = function(id) {
      var week = ['일','월','화','수','목','금','토'];
      var weight = $("#inputWeight").val();
      var month = (optionsM.indexOf(selectMonth.val())+1) < 10 ? "0" + (optionsM.indexOf(selectMonth.val())+1) : (optionsM.indexOf(selectMonth.val())+1);
      var day = selectDate.val() < 10 ? "0" + selectDate.val() : selectDate.val(); 
      var dayOfWeek = week[new Date("'"+selectYear.val()+"-"+month+"-"+day+"'").getDay()];
      
      location.href="../../total.do?command=insertWeight&weight="+weight+"&date="+selectYear.val()+month+day +"&id=" +id+
      "&dayOfWeek="+dayOfWeek;
      opener.window.location.reload();
      window.close();
   }
/*-----------------insertWeight---------------------------*/


