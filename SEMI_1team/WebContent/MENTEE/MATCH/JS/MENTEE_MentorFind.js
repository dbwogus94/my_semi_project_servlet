/*-- 슬라이드 이미지 라이브러리 --*/
$(document).ready(function() {
   $('.bxslider').bxSlider({
      auto : true, //자동 애니메이션
      speed : 300, //애니메이션 속도
      pause : 5000, //애니메이션 유지시간 (1초:1000)
      mode : 'horizontal', //슬라이드 모션 (fade, horizontal, vertical)
      autoControls : false, //시작 중지 버튼 보여짐
      pager : false, //페이지 표시 보여짐
      captions : true, //이미지 위에 텍스트 넣을 수 있음
      adaptiveHeight: true,
   });
   
   
});
   
         /*-- 검색기능 --*/
function search() {
   var name = $("#searchInput").val();
  
   /*
   $.ajax({
      url: "match.do?command=searchMentor",
      dataType: "json",
      data: {
         name : name
      },
      success:function(data){
         $.each(data, function (idx, obj) {
            alert(obj);
            //ajax로 받긴 받았는데 어떻게 뿌려줘야 할지...^^ 후..
         });
      }
   });
   */
}
 
$(function() {
   var availableModels = []; 
   // retrieve JSon from external url and load the data inside an array :
   $.getJSON("match.do?command=searchMentor", function(data) {
         $.each(data, function(key, val) {
            $.each(val, function(key2, val2) {
               var name = val.memberName;
                  console.log(name);
                  availableModels.push(name);
         });
         });
         console.log(data);
   });
      
   $("#searchBox").autocomplete({
      source: availableModels,
      open: function(event, ui) {
           $(this).autocomplete("widget").css({
               "width": 375,
               "height": 35,
               "font-size":20
           });
       }
   });
   
   //enter 
   $('#searchBox').bind("keydown", function (kp) {
      var tag = $('#searchBox').val().trim();
     
       if(tag.length > 0){
            if(kp.keyCode  == 13){ 
               $.each(availableModels, function(i,e) {
                  var name = availableModels[i];
                  if(name == tag){ 
                     location.href="match.do?command=searchMentorPro&name="+name;
                  }
               });      
              
            }
         }
    });
   
   //click
   $("#searchBnt").click(function() {
      var tag = $('#searchBox').val().trim();
      
       $.each(availableModels, function(i,e) {
           var name = availableModels[i];
           if(name == tag){
              location.href="match.do?command=searchMentorPro&name="+name;
           }
        });   
  });
   
});
