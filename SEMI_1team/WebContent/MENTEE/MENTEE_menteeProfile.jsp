<%@page import="All.statics.join.LoginProfile.dto.LoginProfileDto"%>
<%@page import="All.statics.Util"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
header{width:100%;height: 60px; background: #000;}
a{text-decoration: none; color: #000; outline:0;}
ol,ul{list-style: none;}
header>h1{float:left; font-size: 30px; font-weight: bold; color:#fff;
   text-align: left; margin:0;}
#logo>img{float:left; width:100px; height:50px; padding-left:5px;}
#untoti{color: #fff;}
.container {
  display: inline-block;
  cursor: pointer;
  float: right;
  padding:7px 20px;
}

.bar1, .bar2, .bar3 {
  width: 35px;
  height: 5px;
  background-color: #fff;
  margin: 6px 0px;
  transition: 0.4s;
  border-radius: 2px;
}

.change .bar1 {
  -webkit-transform: rotate(-45deg) translate(-9px, 6px);
  transform: rotate(-45deg) translate(-9px, 6px);
}

.change .bar2 {opacity: 0;}

.change .bar3 {
  -webkit-transform: rotate(45deg) translate(-8px, -8px);
  transform: rotate(45deg) translate(-8px, -8px);
}
	#nav{
 width:100%; 
 height: 300px;
 background: rgba(255,255,255,.9);
 position: absolute;
 top:60px;
 right:0;
 z-index: 999;
 display: none;
 } 
#nav ul{
	display:block;
	width:100%;
	}
#nav ul li {
	float: left;
	width:15%;
	height:44px;
	margin:2% 5%;
	font-size: 20px;
	text-align: center;
	border-bottom: 2px solid #000;
	}
#nav ul li:hover{
	border-bottom: 2px solid #ff7e67;
} 
#nav ul li a{color: #000;}
	body{padding: 0px; margin: 0px; position:relative; background:#f5f6f7;}
	#fieldset{
		border: 1px solid;
		margin:1%;
		width:95%;
		height: 98%;
		border-radius: 10px ;
		background-color: white;	
		
	}
	#Main_container{
		position: relative;
		width:33%;
		left: 33%; 
		height: 95%;
		text-align: center;
		
	}
	img{
		width: 200px; height: 200px;
    	object-fit: cover;
    	object-position: top;
    	border-radius: 50%;
	}
	h4{text-align: left; line-height: 0%;}
	option{padding:5px 0;}
	/* 한줄짜리 텍스트 */
	.imput_text{width: 98%; height: 25px;}
	.Address_text{width: 98%; height: 25px;}
	/* 년/월/일  */
	.select_3{
		margin-right:-3px; margin-left:-2px;
		width: 33.5%;
		height: 30px;
	}
	/* div */
	.group{
		text-align: left;
		margin: 5px;
	}
	/* 키/몸무게 */
	.text_2{
		margin-right:-3px; margin-left:-2px;
		width: 49.5%;
		height: 25px;
	}
	/* 전화번호 */
	.text_3{
		margin-right:-3px; margin-left:-2px;
		width: 32.6%;
		height: 25px;
	}
	/* 하단 버튼 */
	.submit_button{
		margin: 1%;
		width: 30.5%;
		font-size:18px;
		color:white;
		background-color: gray;
		cursor: pointer;
		display: inline-block;
		border: none;
		border-radius: 7px;
	}
	
</style>
<script type="text/javascript" src="../resource/jquery-3.4.1.js"></script>
<script type="text/javascript">
	var chk1 = false;
	function getBtnVal(butValue) {
		//alert(butValue);
		var text = document.getElementById("text_input_but").value 
		text += butValue;
	}
	function Address() {
		window.open("../profile.do?command=Address","","width=500px,height=500px");
		
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
	function PhoneChk() {
		var phone1 = document.getElementById("phone1");
		var phone2 = document.getElementById("phone2");
		var phone3 = document.getElementById("phone3");
		var phone4 = phone1.value+"-"+phone2.value+"-"+phone3.value;
		console.log(phone4);
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
window.onload = function() {
		
		$("#passwordChange").click(function() {
			location.href="../join.do?command=main";
		});
		
	}
	function confirmRes() {
		var addr = document.getElementById("AddressID").value;
		
		if(addr==""){
			alert("주소입력하시오");
			return false;
		}else{
			return true;
		}
		
	}
	function imageres(idSub1,idSub2) {
		window.open("../profile.do?command=image&idSub1="+idSub1+"&idSub2="+idSub2,"","width:500px, height:500px;");
		console.log(idSub1);
		console.log(idSub2);
	}

	function myFunction(x) {
		x.classList.toggle("change");
		$("#nav").toggle(800);
	}

</script>

<title>Insert title here</title>
</head>
<%
	LoginProfileDto menteeDto = (LoginProfileDto)session.getAttribute("menteeDto");
	if(menteeDto == null){
		pageContext.forward("../Main.jsp");
	}
	int year = Integer.parseInt(menteeDto.getMemberBirth().substring(0,4));
	int month = Integer.parseInt(menteeDto.getMemberBirth().substring(4,6));
	int date = Integer.parseInt(menteeDto.getMemberBirth().substring(6,8));
	System.out.println(year+"/"+month+"/"+date);	
	String phone1 = menteeDto.getMemberPhone().substring(4,8);
	String phone2 = menteeDto.getMemberPhone().substring(9,13);
	String imageSrc = menteeDto.getMemberContent();
	System.out.println(imageSrc);
	
	int nowYear = Calendar.getInstance().get(Calendar.YEAR);
	System.out.println(phone1+"/"+phone2);
	
	String id = menteeDto.getId();
	String idSub1 = id.substring(0, id.length()/2);
	String idSub2 = id.substring(id.length()/2, id.length());
	System.out.println(idSub1);
	System.out.println(idSub2);
%>

<body>

<header>
	<div id="logo"><img src="../images/logo_white.png" onclick = "location.href='../join.do?command=menteeMain'"/></div>
	<h1 onclick = "location.href='../join.do?command=menteeMain'">운토티</h1>
	<div class="container" onclick="myFunction(this)">
  		<div class="bar1"></div>
  		<div class="bar2"></div>
 		 <div class="bar3"></div>
	</div>
	<div id="nav">
		<ul>
     		<li><a href="../profile.do?command=menteeProfile">프로필 수정</a></li>
     		<li><a href="../plan.do?command=planMain">운동캘린더</a></li>
     		<li><a href="../profile.do?command=getChart">차트</a></li>
     		<li><a href="../exercise.do?command=exerciseMain">운동정보</a></li>
      		<li><a href="../match.do?command=getMatchView">멘토찾기</a></li>
      		<li><a href="">헬스장 찾기</a></li>
     		<li><a href="../board.do?command=boardMain">자유게시판</a></li>
      		<li><a href="../join.do?command=chat_mentee">채팅</a></li>
   		</ul>
	</div>
</header><br>

<fieldset id = "fieldset">
	<legend style="text-align: center;">멘티 프로필 입력</legend>
    <div id="Main_container">
    	<form action="../profile.do" method="post">
    		<input type="hidden" name="command" value="memberMenteeUpdate" onsubmit="return confirmRes();"/>
    		<img id="upload" alt="dd" src="../images/upload.png" onclick="imageres('<%=idSub1%>','<%=idSub2%>')"></legend>
    		<input type="hidden" name="memberRole" value="멘티"/>
    		<input type="hidden" name="id" value="<%=id%>">
			<img alt="" src="<%=imageSrc%>">
			<br/>
				
				<h4>이름</h4>
				<input type="text" name="memberName" value="<%=menteeDto.getMemberName() %>" class="imput_text" required="required"/>
				
				<br/>
				<br/>
				
				<h4>생년월일</h4> <!-- 서블릿으로 넘겨서 yyyy/dd/mm을 합쳐서 memberBirth에 사용 -->
				<div class="group">				
					<select name="year" class="select_3" required="required">
						<option> --년도--</option> 
						<% for(int i = 1960; i<nowYear; i++){
						%>	
						 <option value=<%=i %> <%=(year==i)?"selected":"" %>><%=i %></option>
						<%
						}
						%>
					</select>
					<select name="month" class="select_3" required="required">
						<option>--월--</option>
						<% for(int i = 1; i<=12; i++){
						%>	
						 <option value=<%=i %> <%=(month==i)?"selected":"" %>><%=i %></option>
						<%
						}
						%>
					</select>
					<select name="date" class="select_3" required="required">
						<option>--일--</option>
						<% for(int i = 1; i<=31; i++){
						%>	
						 <option value=<%=i %> <%=(date==i)?"selected":"" %>><%=i %></option>
						<%
						}
						%>
					</select>
				</div>
				
				<br/>
				<br/>
				
				<h4>키/몸무게</h4>
				<div class="group">
					<input type="number" class="text_2" name="memberHeight" value="<%=menteeDto.getMemberHeight() %>" placeholder="cm" required="required"/>
					<input type="number" class="text_2" name="memberWeight" value="<%=menteeDto.getMemberWeight() %>" placeholder="kg" required="required"/>
				</div>
				
				<br/>
				
				<h4>주소</h4>
				<input type="text" name="memberAddr" id="AddressID" class="Address_text" onclick="Address();" value="<%=menteeDto.getMemberAddr() %>" readonly="readonly"/>
				
				<br/>
				<br/>
				
				<h4>이메일</h4>
				<input type="text" name="joinEmail" value="<%=menteeDto.getJoinEmail() %>" class="imput_text" readonly="readonly"/>
				
				<br/>
				<br/>
				
				<h4>전화번호</h4>
				<div class="group">	<!-- memberPhone은 배열로 받아서 합친다. -->	
					<input type="text" class="text_3" id="phone1" name="memberPhone1" value="010" readonly="readonly"/>
					<input type="number" class="text_3" id="phone2" value="<%=phone1 %>" name="memberPhone2" required="required"/>
					<input type="number" class="text_3" id="phone3" value="<%=phone2 %>" name="memberPhone3" required="required"/>
					<input type="button" value="중복확인" onclick="PhoneChk();">
				</div>
				
				<br/>
				<br/>
				
				<h4>한 줄 소개 하기</h4>
				<input type="text" name="memberOneIntro" value="<%=menteeDto.getMemberOneIntro() %>" class="imput_text" required="required"/>
				
				<br/>
				<br/>
				
				<h4>성별</h4>
				<div class="group">
					<input type="checkbox" name="memberGender" value="F" <%=("F".equals(menteeDto.getMemberGender())?"checked":"") %> onclick="checkboxChk(this);"/>여성
					<input type="checkbox" name="memberGender" value="M" <%=("M".equals(menteeDto.getMemberGender())?"checked":"") %> onclick="checkboxChk(this);"/>남성
				</div>
				
				<br/>
				
				<h4>활동량</h4>
				<div class="group">
					<input type="checkbox" name="memberActivity" value="1" <%=("1".equals(menteeDto.getMemberActivity()+"")?"checked":"") %> onclick="ActivityChk(this);"/>거의없음(회사원)
					<input type="checkbox" name="memberActivity" value="2" <%=("2".equals(menteeDto.getMemberActivity()+"")?"checked":"") %> onclick="ActivityChk(this);"/>적음
					<input type="checkbox" name="memberActivity" value="3" <%=("3".equals(menteeDto.getMemberActivity()+"")?"checked":"") %> onclick="ActivityChk(this);"/>평균정도
					<input type="checkbox" name="memberActivity" value="4" <%=("4".equals(menteeDto.getMemberActivity()+"")?"checked":"") %> onclick="ActivityChk(this);"/>활동적임
				</div>
				
				<br/>
				
				<div class="group">
					<input type="submit" value="수정하기" class="submit_button"/>
					<input type="button" value="비빌번호 변경" class="submit_button" onclick="window.open('../join.do?command=passwordChange&id=<%=menteeDto.getId() %>','','width=500px,height=500px')" id="passwordChange"/>
					<input type="button" value="탈퇴" class="submit_button" onclick="location.href='../join.do?command=leave&id=<%=menteeDto.getId()%>'"/>
				</div>
		</form>
	</div>
</fieldset>
</body>
</html>