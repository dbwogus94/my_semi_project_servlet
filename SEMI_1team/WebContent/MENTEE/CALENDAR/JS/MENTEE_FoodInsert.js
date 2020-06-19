
$(function() {
   var availableModels = [];
       
   // retrieve JSon from external url and load the data inside an array :
   $.getJSON("../../food.do?command=foodAjax", function(data) {
      $.each(data, function(key, val) {
         availableModels.push(val);
      });
   });
   
   $("#ok").click(function() {
      var cnt = 0;  
       var foodForm = document.foodForm;
      
      $.each(availableModels, function(i,e) {
         var food = availableModels[i];
         
           if(food == $("#name").val()){
              cnt++;
           }
       });  
      
      if(cnt > 0){
         alert("이미 있는 음식입니다.\n검색을 통해 음식을 입력해주세요.");
          location.href="MENTEE_DayMenuInsert.jsp";
      } else{
         foodForm.action="../../food.do";
         foodForm.submit();
      }
      
   });
   
   console.log(availableModels);
});