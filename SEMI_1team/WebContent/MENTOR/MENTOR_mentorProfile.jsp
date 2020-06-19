<%@page import="All.statics.join.LoginProfile.dto.LoginProfileDto"%>
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
	
	/* 태그에 사용된 버튼 8개 */
	.tag_button{
		margin: 7px;
		width: 21%;
		height: 20px;
		font-size: 10px;
		font-weight: bold; 
		color: white;
		background-color: #9ACD32;
		cursor: pointer;
		display: inline-block;
		border: none;
		border-radius: 10px;
	}
	
	textarea{
		margin:0px;	
		width: 96%; height: 100px;
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
	var cnt = 1;
	function getBtnVal(butValue) {
		//alert(butValue);
		var id = document.getElementById("text_input_but");
		
		$(".tag_button")
		var Butarr = $(".tag_button");
		
		for(var i = 0; i<Butarr.length; i++){
			if(Butarr.eq(i).val() === butValue){
				if(cnt===4){
				break;	
					
				}else{
				Butarr.eq(i).attr("disabled","disabled");
				Butarr.eq(i).css("background","gray");
				}
			}
		}
		if(cnt%4===0){
			$(".tag_button").attr("disabled","disabled");
			alert("태그는 최대 4개까지만 선택할 수 있습니다.");
		}else{
			if(id.value.length>0){
				id.value += ", "+butValue
				cnt++;
			}else {
				id.value = butValue
			}
		}
		
			
	}
	function Address() {
		window.open("../profile.do?command=Address","","width=500px,height=500px");
		
	}
	function cancel01(){
		var reset = document.getElementById("text_input_but");
		reset.value = "";
		cnt = 1;
		$(".tag_button").removeAttr("disabled");
		$(".tag_button").css("background","#9ACD32");
	}
	window.onload = function() {
		
		$("#passwordChange").click(function() {
			location.href="../join.do?command=main";
		});
		
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
	function confirmRes() {
		if(document.getElementById("text_input_but").value == ""){
			alert("태그를 클릭해주세요.");
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
	</script>

<title>Insert title here</title>
</head>
<%
	//JoinDto joinDto = (JoinDto)session.getAttribute("joinDto");
	LoginProfileDto mentorDto = (LoginProfileDto)session.getAttribute("mentorDto");
		if(mentorDto == null){
			pageContext.forward("../Main.jsp");
	}
	
	int nowYear = Calendar.getInstance().get(Calendar.YEAR);
	
	int year = Integer.parseInt(mentorDto.getMemberBirth().substring(0,4));
	int month = Integer.parseInt(mentorDto.getMemberBirth().substring(4,6));
	int date = Integer.parseInt(mentorDto.getMemberBirth().substring(6,8));
	String id = mentorDto.getId();
	String idSub1 = id.substring(0,id.length()/2);
	String idSub2 = id.substring(id.length()/2,id.length());
	System.out.println(id);
	System.out.println(idSub1);
	System.out.println(idSub2);
	System.out.println(year+"/"+month+"/"+date);	
	String phone1 = mentorDto.getMemberPhone().substring(4,8);
	String phone2 = mentorDto.getMemberPhone().substring(9,13);
	String imageSrc = mentorDto.getMemberContent();
	System.out.println(phone1+"/"+phone2);
	System.out.println(imageSrc);
%>

<body>
	
<fieldset id = "fieldset">
	<legend style="text-align: center;">멘토 프로필 입력</legend>
    <div id="Main_container">
    	<form action="../profile.do" method="post" onsubmit="return confirmRes()">
    		<input type="hidden" name="command" value="memberMentorUpdate"/>
    		<input type="hidden" name="memberRole" value="멘토"/>
			<input type="button" value="프로필사진추가" onclick="imageres('<%=idSub1%>','<%=idSub2%>')">
			<input type="text" name="id" value="<%=id%>">
			<img alt="" src="<%=imageSrc%>">
			<br/>
				
				
				<h4>이름</h4>
				<input type="text" name="memberName" value="<%=mentorDto.getMemberName() %>" class="imput_text" required="required"/>
				
				<br/>
				<br/>
				
				<h4>생년월일</h4>  <!-- 서블릿으로 넘겨서 yyyy/dd/mm을 합쳐서 memberBirth에 사용 -->
				<div class="group">				
					<select name="year" class="select_3" required="required">
						<option selected="selected"> --년도--</option> 
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
					<select name="date" class="select_3"required="required">
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
					<input type="number" class="text_2" name="memberHeight" value="<%=mentorDto.getMemberHeight() %>" placeholder="cm" required="required"/>
					<input type="number" class="text_2" name="memberWeight" value="<%=mentorDto.getMemberWeight() %>" placeholder="kg" required="required"/>
				</div>
				
				<br/>
				<br/>
				
				<h4>주소</h4>
				<input type="text" name="memberAddr" id="AddressID" class="imput_text" onclick="Address();" value="<%=mentorDto.getMemberAddr() %>" readonly="readonly"/>
				
				<br/>
				<br/>
				
				<h4>이메일</h4>
				<input type="text" name="" value="<%=mentorDto.getJoinEmail() %>" class="imput_text" readonly="readonly"/>
				
				<br/>
				<br/>
				
				<h4>전화번호</h4>  <!-- memberPhone는 서블릿에 배열로 넘겨서 합친다. -->
				<div class="group">		
					<input type="text" class="text_3" id="phone1" name="memberPhone1" value="010" readonly="readonly"/>
					<input type="number" class="text_3" id="phone2" name="memberPhone2" value="<%=phone1%>"/>
					<input type="number" class="text_3" id="phone3" name="memberPhone3" value="<%=phone2%>"/>
					<input type="button" value="중복확인" onclick="PhoneChk();">
				</div>
				
				<br/>
				<br/>
				<br/>
				
				<h4>태그(최대 4개 선택가능)</h4>
				<div class="group">
					<input type="button"  value="#다이어트"  class="tag_button" onclick="getBtnVal(this.value);"/> <input type="button"  value="#증량"  class="tag_button" onclick="getBtnVal(this.value);"/> <input type="button"  value="#건강"  class="tag_button" onclick="getBtnVal(this.value);"/> <input type="button"  value="#몸매관리"  class="tag_button" onclick="getBtnVal(this.value);"/> 						
					<input type="button"  value="#홈트전문"  class="tag_button" onclick="getBtnVal(this.value);"/> <input type="button"  value="#체력증진"  class="tag_button" onclick="getBtnVal(this.value);"/> <input type="button"  value="#야나두운동"  class="tag_button" onclick="getBtnVal(this.value);"/> 	<input type="button"  value="#독소제거"  class="tag_button" onclick="getBtnVal(this.value);"/>
				</div>
				<input type="text" name="memberCareer" id="text_input_but" class="imput_text" placeholder="ex) #다이어트,#체중감량" readonly="readonly"/>
				<input type="button" value="reset" id="reset" onclick="cancel01();">
				<br/>
				<br/>
				
				<h4>한 줄 소개 하기</h4>
				<input type="text" name="memberOneIntro" value="<%=mentorDto.getMemberOneIntro() %>" class="imput_text" required="required"/>
		
				<br/>
				
				<div class="group">
					<input type="submit" value="수정하기" class="submit_button"/>
					<input type="button" value="비빌번호 변경" class="submit_button" onclick="window.open('../join.do?command=passwordChange&id=<%=mentorDto.getId() %>','','width=500px,height=530px')" id="passwordChange">
					<input type="button" value="탈퇴" class="submit_button" onclick="location.href='../join.do?command=leave&id=<%=mentorDto.getId()%>'"/>
				</div>
				
		</form>
	</div>
</fieldset>
</body>
</html>