<%@page import="join.dto.JoinDto"%>
<%@page import="java.util.Calendar"%>
<%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
header{width:100%;height: 60px;
    background: #000;}

header>h1{float:left; font-size: 30px; font-weight: bold; color:#fff;
   text-align: left; margin-top: 0.3%;}
#logo>img{float:left; width:100px; height:50px; padding-left:5px;}
h3{
   padding:0 20px;
}



hr{ 
   border: 1px solid #ddd;
     border-radius: 2px; 
     margin: 0 20px;
 
  }

	body{padding: 0px; margin: 0px; position:relative; background:#f5f6f7;}
	#fieldset{
		border: 2px solid #000;
		margin:3% auto;
		width:60%;
		height: auto;
		background-color: white;	
		padding: 3%;
		
	}
	#fieldset button{
	background: none;
	border: none;
	}
	#upload{
	border-radius: none;
	width: 30px; height: 30px;
	position: relative;
	left: -60px;
	top:-20px;
	}
	#Main_container{
		position: relative;
		width:60%;
		margin:auto;
		height: 95%;
		text-align: center;
		
	}
	#profile{
		width: 200px; height: 200px;
    	object-fit: cover;
    	object-position: top;
    	border-radius: 50%;
    	margin:15px;
	}
	h4{text-align: left; line-height: 0%;}
	option{padding:5px 0;}
	/* 한줄짜리 텍스트 */
	.input_text{
	width: 97%; height: 25px;
	border:none;
	border-bottom: 2px solid #000;
	margin: auto;
	}
	.Address_text{
	width: 98%; height: 25px;
	border:none;
	border-bottom: 2px solid #000;
	margin: auto;
	}
	/* 년/월/일  */
	.select_3{
		width: 32%;
		height: 30px;
		border:none;
	border-bottom: 2px solid #000;
	margin: auto;
	}
	/* div */
	.group{
		text-align: left;
		margin: 5px;
		font-size: 15px;
	}
	/* 키/몸무게 */
	.text_2{
		
		width: 49%;
		height: 25px;
		border:none;
	border-bottom: 2px solid #000;
	margin: auto;
	}
	/* 전화번호 */
	.text_3{
		
		width: 25%;
		height: 25px;
		border:none;
	border-bottom: 2px solid #000;
	}
	#chk_btn{
		border:1px solid #000;
		width: 20%;
		height: 25px;
		background: none; 
	}
	#chk_btn:hover{
	border:1px solid #ff7e67;
	}
	/* 하단 버튼 */
	.submit_button{
		
		width: 31%;
		font-size:15px;
		color:white;
		background-color: #000;
		cursor: pointer;
		display: inline-block;
		border:1px solid #000;
	}
		.submit_button:hover{
		background: #ff7e67;
		}
footer{
   width: 100%;
   height: 60px;
   background-color: #000;
   color: #f2f2f2;
   text-align: center;
   padding-top: 10px;
}	
/*****모바일**********************/
@media screen and (max-width:767px) {
#Main_container{
		position: relative;
		width:90%;
		margin:auto;
		height: 95%;
		text-align: center;
		
	}

	#fieldset{
		border: 2px solid #000;
		margin:3% auto;
		width:80%;
		height: auto;
		background-color: white;	
		padding: 3%;
		
	}
}
/*태블릿 크기 768~1023*/
@media screen and (min-width:768px) and (max-width:1023px) {

#Main_container{
		position: relative;
		width:80%;
		margin:auto;
		height: 95%;
		text-align: center;
		
	}

}
</style>
<script type="text/javascript" src="../resource/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	var chk2 = false;
	var chk2_1 = false;
	var chk2_2 = false;
	var chk2_3 = false;
	var chk4 = false;
	var chk6 = false;
	var chk8 = false;
	var chk9 = false;
	
	
	
	function getBtnVal(butValue) {
		//alert(butValue);
		var text = document.getElementById("text_input_but").value 
		text += butValue;
	}
	function Address() {
		window.open("../profile.do?command=Address","","width=500px,height=500px");
	}
	function PhoneChk() {
		var phone1 = document.getElementById("phone1");
		var phone2 = document.getElementById("phone2");
		var phone3 = document.getElementById("phone3");
		var phone4 = phone1.value+"-"+phone2.value+"-"+phone3.value;
		if(phone2.value.length!==4){
			alert("올바른 앞자리 번호를 입력해주세요.");
			phone2.focus();
		}
		else if(phone3.value.length!=4){
			alert("올바른 뒷자리 번호를 입력해주세요.");
			phone3.focus();
		}else{
			$.ajax({
				url:"../profile.do",
				type:"post",
				async:true,
				data:{
					command:"PhoneNumberCheck",
					PhoneNumber: phone4
				},
				dataType:"text",
				success: function(msg) {
					if(msg == "fail"){
						alert("핸드폰 번호가 중복됩니다.");
					}else if(msg == "ok"){
						alert("사용가능한 핸드폰 번호 입니다.");
						chk6 = true;
					}
				},
				error: function() {
					alert("통신 실패");
				}
			});
		}
		console.log(phone4);
		
	}
		window.onload=function() {
			
		
		
		if($(".activity").eq(0).checked==false&&$(".activity").eq(1).checked==false&&$(".activity").eq(2).checked==false&&$(".activity").eq(3).checked==false){
			//alert("활동량을 선택해 주세요");
		}else{
			chk9 = true;
		}
	}
	
	function YearChk(year) {
		var yearSelect = year;
		if(yearSelect.value=="" || yearSelect.value=="--년도--"){
			alert("년도를 선택해주세요.");
		}else{
			console.log("년도 입력 완료");
			console.log(yearSelect.value);
			chk2_1 = true;
		}
		
	}
	function MonthChk(month) {
		var monthSelect = month;
		if(monthSelect.value =="" || monthSelect.value =="--월--"){
			alert("월을 선택해주세요");
		}else{
			console.log("월 선택 완료");
			console.log(monthSelect.value);
			chk2_2 = true;
		}
	}
	function DayChk(day) {
		var daySelect = day;
		if(daySelect.value == "" || daySelect.value == "--일--"){
			alert("일을 선택해주세요.");
		}else{
			console.log("일 선택 완료");
			console.log(daySelect.value);
			chk2_3 = true;
		}
		
	}
	function checkboxChk(chk) {
		  var gender = document.getElementsByName("memberGender");

	        for(var i=0; i<gender.length; i++){

	            if(gender[i] != chk){
	            	gender[i].checked = false;
	            }
	        }
	}
	function ActivityChk(chk) {
		 var act = document.getElementsByName("memberActivity");
		 
		 for(var i=0; i<act.length; i++){

	            if(act[i] != chk){
	            	act[i].checked = false;
	            }
	        }
	}
	function confirmSubmit() {
		var gender = document.getElementsByName("memberGender");
		var Activity = document.getElementsByName("memberActivity");
		for(var i = 0; i<gender.length; i++){
			if(gender[i].checked==true){
			console.log(gender[i].value);
			chk8 = true;
			}else if(Activity[i].checked == true){
				console.log(Activity[i].value);
				chk9 = true;
			}
		}
		if(chk2_1&&chk2_2&&chk2_3){
			chk2=true;
		}else{
			alert("생년월일을 확인하세요.");
		}
		if(!(document.getElementById("AddressID").value=="")){
			chk4 = true;
		}
	
		if(chk2 && chk4 && chk6 && chk8 && chk9){
		var con = confirm("작성한 내용  으로 confirm 하시겠습니까?")
		if(con){
			return true;
		}else{
			return false;
		}
	}else if(!chk2){
		alert("생년원일을 확인하세요.");
		return false;
	}else if(!chk4){
		alert("주소를 확인하세요.");
		return false;
	}else if(!chk6){
		alert("전화번호를 확인하세요.");
		return false;
	}else if(!chk8){
		alert("성별을 체크하세요.");
		return false;
	}else if(!chk9){
		alert("활동량을 체크하세요.");
		return false;
	}
		return false;
	}
	function image(id) {
		window.open("../profile.do?command=image&id="+id,"","width:300px,height:300px");
		
	}

</script>

<title>Insert title here</title>
</head>
<%
	JoinDto joinDto = (JoinDto)session.getAttribute("joinDto");
		if(joinDto == null){
			pageContext.forward("../Main.jsp");
	}
	
	int nowYear = Calendar.getInstance().get(Calendar.YEAR);
%>

<body>
<header>
   <div id="logo"><img src="../images/logo_white.png" /></div>
   <h1>운토티</h1>
  
</header>	
<br>
<hr><h3>MENTEE 프로필 작성</h3><hr>
<fieldset id = "fieldset">
	<legend style="text-align: center;"><img id="profile" alt="" src="../images/카카오.png">
	<img id="upload" alt="" src="../images/upload.png" onclick="image(<%=joinDto.getId()%>);"></legend>
    <div id="Main_container">
    	<form action="../profile.do" method="post" onsubmit="return confirmSubmit();">
    		<input type="hidden" name="command" value="memberMenteeInsertRes"/>
    		<input type="hidden" name="memberRole" value="멘티"/>
    		
			<br/>
				
				<h4>이름</h4>
				<input type="text" name="memberName" id="name" class="input_text" required="required"/>
				
				<br/>
				<br/>
				
				<h4>생년월일</h4> <!-- 서블릿으로 넘겨서 yyyy/dd/mm을 합쳐서 memberBirth에 사용 -->
				<div class="group">				
					<select name="year" class="select_3" onchange="YearChk(this);" required="required">
						<option selected="selected" id="yearchk"> --년도--</option> 
						<% for(int i = 1960; i<nowYear; i++){
						%>	
						 <option value=<%=i %>><%=i %></option>
						<%
						}
						%>
					</select>
					<select name="month" class="select_3" id="monthchk" onchange="MonthChk(this);" required="required" >
						<option>--월--</option>
						<% for(int i = 1; i<=12; i++){
						%>	
						 <option value=<%=i %>><%=i %></option>
						<%
						}
						%>
					</select>
					<select name="date" class="select_3"  id="daychk" onchange="DayChk(this);" required="required">
						<option>--일--</option>
						<% for(int i = 1; i<=31; i++){
						%>	
						 <option value=<%=i %>><%=i %></option>
						<%
						}
						%>
					</select>
				</div>
				
				<br/>
				<br/>
				
				<h4>키/몸무게</h4>
				<div class="group">
					<input type="number" class="text_2" name="memberHeight" placeholder="cm" required="required"/>
					<input type="number" class="text_2" name="memberWeight" placeholder="kg" required="required"/>
				</div>
				
				<br/>
				
				<h4>주소</h4>
				<input type="text" name="memberAddr" id="AddressID" class="Address_text" onclick="Address();"readonly="readonly"/>
				
				<br/>
				<br/>
				
				<h4>이메일</h4>
				<input type="text" name="" value="<%=joinDto.getJoinEmail() %>" id="email" class="input_text" />
				
				<br/>
				<br/>
				
				<h4>전화번호</h4>
				<div class="group">	<!-- memberPhone은 배열로 받아서 합친다. -->
					
					<input type="text" class="text_3" name="memberPhone" value="010" id="phone1" readonly="readonly"/>
					<input type="number" class="text_3" id="phone2" name="memberPhone" required="required"/>
					<input type="number" class="text_3" id="phone3" name="memberPhone" required="required"/>
					<input type="button" value="중복확인" id="chk_btn" onclick="PhoneChk();">
				</div>
				
				<br/>
				<br/>
				
				<h4>한 줄 소개 하기</h4>
				<input type="text" name="memberOneIntro" class="input_text" required="required"/>
				
				<br/>
				<br/>
				
				<h4>성별</h4>
				<div class="group">
					<input type="checkbox" class="gender" name="memberGender" onclick="checkboxChk(this);" value="F"  id="Femail"/>여성
					<input type="checkbox" class="gender" name="memberGender" onclick="checkboxChk(this);" value="M" id="mail"/>남성
				</div>
				
				<br/>
				
				<h4>활동량</h4>
				<div class="group">
					<input type="checkbox" class="activity" name="memberActivity" onclick="ActivityChk(this);" value="1" />거의없음(회사원)
					<input type="checkbox" class="activity" name="memberActivity" onclick="ActivityChk(this);" value="2" />적음
					<input type="checkbox" class="activity" name="memberActivity" onclick="ActivityChk(this);" value="3" />평균
					<input type="checkbox" class="activity" name="memberActivity" onclick="ActivityChk(this);" value="4" />활동적
				</div>
				
				<br/>
				
				<div class="group">
					<input type="submit" value="저장" class="submit_button"/>
					<input type="hidden" id="chkValue" value="ss">
				</div>
		</form>
	</div>
</fieldset>
<footer>@ 2020 all copyrights reserved by 운토티</footer>
</body>
</html>