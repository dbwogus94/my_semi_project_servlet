$(function() {
    /*---------------Date choose---------------*/
   //현재 날짜 가져오는 함수
   var year = new Date().getFullYear();
   var month = new Date().getMonth() + 1;
   var date = new Date().getDate();
   
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

   
   /*---------------JSON -> ARRAY---------------*/
   var availableModels = [];
    
   // retrieve JSon from external url and load the data inside an array :
   $.getJSON("../../dayMenu.do?command=dayMenuAjax", function( data ) {
   var items = [];
      $.each(data, function( key, val ) {
         availableModels.push(val);
      });
   });
   
   /*------------------searchBox------------------*/
    $("#searchInput").autocomplete({
       //입력시 서버쪽에서 실행될 스크립트
       source: availableModels,
       //두자 이상이 입력될 때 서버로 요청 검색된 데이터의 양이 너무 많아지는 것을 방지
        minLength: 2,
        //서버에서 응답이 오면 화면에 리스트를 보여주기 전에 실행 ui는 서버로 부터 보내온 데이터
        response: function(event, ui) {
            console.log(ui);
        },
        //검색된 리스트에서 항목을 선택하면 실행
        select: function(event, ui) {
            console.log("Selected:" + ui.item.value);
        },
        //한글 리스트에서 선택시 리스트가 사라지는 오류 방지
        focus: function(event, ui) {
            return false;
        },
    });

    $("#searchInput").autocomplete({
       //입력시 서버쪽에서 실행될 스크립트
       source: availableModels,
       open: function(event, ui) {
             $(this).autocomplete("widget").css({
                 "width": 280
             });
         }
    });
    
    //var tagArea = '.tag-area';
    var backSpace;
    var close = '<input type="button" class="close" id="x" value="X">';
    //var close = '<span class="close"> x</span>';

    //div 생성
   $('#breakfast').append('<ul id="breakfastTag" class="tag-box"></ul>');
   $('#breakfast').append('</div>');

   $('#lunch').append('<ul id="lunchTag" class="tag-box"></ul>');
      $('#lunch').append('</div>');

      $('#dinner').append('<ul id="dinnerTag" class="tag-box"></ul>');
   $('#dinner').append('</div>');
   
   $('#snack').append('<ul id="snackTag"  class="tag-box"></ul>');
   $('#snack').append('</div>');

   
   //tag li 생성 method
   var insertMeal = function() {
      var tag = "<span>"+$('.input_tag').val().trim()+"</span>";
      
      if($("select[id='selectMeal'] option:selected").text() == "아침"){ 
          $("#breakfastTag").append('<li class="tags">'+tag+close+'</li>');
          $('#breakfastTag').css('display','block');
        } else if($("select[id='selectMeal'] option:selected").text() == "점심"){ 
           $("#lunchTag").append('<li class="tags">'+tag+close+'</li>');
           $('#lunchTag').css('display','block');
        } else if($("select[id='selectMeal'] option:selected").text() == "저녁"){ 
           $("#dinnerTag").append('<li class="tags">'+tag+close+'</li>');
           $('#dinnerTag').css('display','block');
       }else if($("select[id='selectMeal'] option:selected").text() == "간식"){ 
          $("#snackTag").append('<li class="tags">'+tag+close+'</li>');
          $('#snackTag').css('display','block');
       }
   }
   
   //modal popup
   var modal = function() {
      
      $("#gram").css('display','inherit');
      $("#gram").css('background-color','white');
      $("body").css('background-color','#696969');
      $("#searchInput").css('background-color','#696969');
      $("select").css('background-color','#696969');
      $(".bnt").css('background-color','#696969');
       
       
      $("#gramBnt").click(function() {
         if($("#insertGram").val().length > 0){
            $("body").css('background-color','white');
            $("#searchInput").css('background-color','white');
            $("select").css('background-color','white');
            $(".bnt").css('background-color','white');
            $("#gram").css('display','none');
                
            insertMeal();
            dayMenuAjax();
                
            $("#searchInput").val('');
            $("#insertGram").val('');
         } else{
            $("body").css('background-color','white');
            $("#searchInput").css('background-color','white');
            $("select").css('background-color','white');
            $(".bnt").css('background-color','white');
            $("#gram").css('display','none');
            $("#searchInput").val('');
            $("#insertGram").val('');
         }
          
      });
        
      $("#cancle").click(function() {
         $("body").css('background-color','white');
         $("#searchInput").css('background-color','white');
         $("select").css('background-color','white');
         $(".bnt").css('background-color','white');
         $("#gram").css('display','none');
         $("#searchInput").val('');
         $("#insertGram").val('');
         $("#searchInput").val('');
           $("#insertGram").val('');
      });
       
   }
   
   //ajax를 사용하여 음식 입력시 DB에 저장
   var dayMenuAjax = function(){
      var id = $("#id").val();
      var tag = $('.input_tag').val();
      var selectedYear = selectYear.val();
      var selectedMonth = selectMonth.val() < 10 ? "0" + selectMonth.val() : selectMonth.val()
      var selectedDate = selectDate.val() < 10? "0" + selectDate.val() : selectDate.val();
      var selectMeal = $('#selectMeal').val();
      var gram = $("#insertGram").val();
      
      $.ajax({
         type:"post",
         url:"../../dayMenu.do?command=dayMenuInsert",
         data: "foodName="+tag+"&menuDate="+selectedYear+selectedMonth+selectedDate+
         "&meal="+selectMeal+"&gram="+gram+"&id="+id
         
       });
   }
   
   var deleteAjax = function(tag){
         var id = $("#id").val();
         var tag = tag;
         var selectedYear = selectYear.val();
         var selectedMonth = selectMonth.val() < 10 ? "0" + selectMonth.val() : selectMonth.val()
         var selectedDate = selectDate.val() < 10? "0" + selectDate.val() : selectDate.val();
         var selectMeal = $('#selectMeal').val();
         
         $.ajax({
            type:"post",
            url:"../../dayMenu.do?command=oneMenuDelete",
            data: "foodName="+tag+"&menuDate="+selectedYear+selectedMonth+selectedDate+
            "&meal="+selectMeal+"&id="+id
            
          });
      }
   
    // Taging (enter)
    $('.input_tag').bind("keydown", function (kp) {
       var tag = $('.input_tag').val().trim();
         $(".tags").removeClass("danger");
         
         if(tag.length > 0){
             backSpace = 0;
            if(kp.keyCode  == 13){    
               $.each(availableModels, function(i,e) {
                  var food = availableModels[i];
                  if(food == $("#searchInput").val()){
                     modal();
                  }
               });      
              
            }
         }   
          else {if(kp.keyCode == 8 ){
             $(".new-tag").prev().addClass("danger");
          }
       }
    });
    
   
    
    /*Taging (click)*/
    $(".img_searchIcon").click(function() {
        $.each(availableModels, function(i,e) {
            var food = availableModels[i];
            if(food == $("#searchInput").val()){
               modal();
            }
         });   
   });
    
    //Delete tag
    $(".tag-box").on("click", ".close", function()  {
       var tag = $(this).siblings().text();
       deleteAjax(tag);
       $(this).parent().remove();
    });
    $(".tag-box").click(function(){
        $('.input-tag').focus();
    });
      
    // sorting
   $( ".tag-box" ).sortable({
     items: "li:not(.new-tag)",
     containment: "parent",
     scrollSpeed: 100
    });
  
    $( ".tag-box" ).disableSelection();

    //새로운 음식 입력
    $("#gramBnt").click(function() {
      alert("음식이 캘린더에 입력되었습니다.");
   });
    
    

});

