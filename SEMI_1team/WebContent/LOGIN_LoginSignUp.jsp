<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
  
  <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<link rel="stylesheet" href="resource/css/LOGIN_css/LOGIN_LoginSignUp.css">
<script type="text/javascript" src="resource/jquery-3.4.1.js"></script>
<script type="text/javascript">
	var chk1 = false; 
	var chk2 = false;
	var chk3 = false; 
	var chk4 = false;
	var chk5 = false;
		 
	// 멘토 멘티 체크
	function oneCheckbox(obj) {
		var chk = document.getElementsByName("joinRole");
		for(var i=0; i<chk.length; i++){
            if(chk[i] != obj){
            	chk[i].checked = false;
            }
		}
		if(chk[0].checked || chk[1].checked){
			chk4 = true;
    		console.log("확인"+chk4);
    	}
	} 
	
	window.onload = function(){
		
		// 아이디 유효성 검사
		$(".input_text").eq(0).keyup(function(){
			var idChecked = /^[0-9a-zA-Z]/;
			var id = document.getElementsByClassName("input_text")[0]; 
			var res = document.getElementsByClassName("check_res")[0]; 
		
			if(id.value){  // id가 작성되어 있다면 
				if(!(idChecked.test(id.value))){  // 정규표현식으로 영어 숫자 검사
					chk1 = false;
					res.style.display="block";
					res.style.color = "red";
					res.textContent = "아이디는 영어+숫자를 사용해 주세요";
					return false;
				
				} else if((id.value.length < 5) || (id.value.length > 15)){ // 길이 검사 
					res.style.display="block";
					res.style.color = "red";
					res.textContent = "아이디는 5 ~ 15자리 사이로 만들어주세요";
					chk1 = false;
					return false;
				
				} else {  		// DB에서 아이디 중복검사 
					$.ajax({
						url:"join.do", 
						type:"post",
						async: true,
						data:{
							command:"idCheck",
							id:id.value
						},
						dataType:"text",
						success: function(value){
							if(value === "fail"){
								chk1 = false;
								res.style.display="block";
								res.style.color = "red";
								res.textContent="이미 존재하는 아이디 입니다.";
							} else if(value === "ok") {
								chk1 = true;  				// id 최종적으로 사용가능하면 true
								res.style.display="block";
								res.style.color="blue"
								res.textContent="사용가능한 아이디 입니다.";
							}
						},
						error: function(){
							alert("통신 실패");
						}
					});
				} 
			} else {
				//alert("아이디를 입력 하세요.");
				res.textContent = "아이디는 필수입니다.";
				res.style.display="block";
				chk1 = false;
				return false;
			}
		});
	
		// 이메일 텍스트에 값이 추가되었다면 >>> true로
		$(".input_text").eq(1).keyup(function(){
			var email = document.getElementsByClassName("input_text")[1];
			if(email.value){
				chk2 = true;
			}
		});
		
		$(".input_text").eq(3).keyup(function(){
			var pw = document.getElementsByClassName("input_text")[2];
			var pwChk = document.getElementsByClassName("input_text")[3];
			var res = document.getElementsByClassName("check_res")[3];
			
			if(pw.value == pwChk.value){
				chk3 = true;
				res.style.display="block";
				res.style.color = "blue";
				res.textContent="비빌번호가 일치합니다."
			} else {
				chk3 = false;
				res.style.display="block";
				res.style.color = "red";
				res.textContent="비빌번호가 일치하지 않습니다."
			}
		});
	} //window.onload 바디  끝
	
	// 이메일 인증 팝업
	function emailChkConfirm() {
		window.open("join.do?command=emailChk","","width=500px,height=500px");
		chk2 = true;
	}
	
	// 약관동의
	function consent(obj){
		if(obj){
			chk5 = true;
		} else {
			chk5 = false;	
		}
	}
	
	
	// 서브밋 유효성 검사
	function  confirmSubmit() {
		if(chk1 && chk2 && chk3 && chk4 && chk5){
			var con = confirm("작성내용으로 회원가입 하시겠습니까?")
			if(con){
				return true;
			} else {
				return false;
			}
		} else if(!chk1) {
			alert("아이디를 확인하세요");
			return false;
		} else if(!chk2) {
			alert("이메일을 확인하세요")
			return false;
		} else if(!chk3) {
			alert("비밀번호를 확인하세요");
			return false;
		} else if(!chk4){
			alert("멘토 또는 멘티를 체크하세요");
			return false;
		} else if(!chk5){
			alert("약관에 동의하세요");
			return false;
		}
		return false;
	}

	
	//카카오 회워가입 페이지
	function kakaoSignUp() {
		location.href="join.do?command=kakaoSingUp";		
	}
	// 구글 회원가입 페이지
	function googleSignUp() {
		location.href="join.do?command=googleSingUp";
	}
	
	 function myFunction(x) {
		  x.classList.toggle("change");
	}

	 
	 
	
</script>
<title>회원가입 팝업</title>
</head>
<body>

<header>
	<div id="logo"><img src="images/logo_white.png" onclick="location.href='join.do?command=main'"/></div>
	<h1 id="untoti">운토티</h1>
	<div class="container" onclick="myFunction(this)">
  		<div class="bar1"></div>
  		<div class="bar2"></div>
 		 <div class="bar3"></div>
	</div>
</header>


	<div id="main_container">
		<div id="join_container">
			<h1>회원가입</h1>
			
			<button onclick="googleSignUp();" name="facebookRegister" id="google">
				<img alt="" src="images/google.png">&nbsp;&nbsp;&nbsp;&nbsp;google계정으로 회원가입
			</button>
			
			<button onclick="kakaoSignUp();" id="kakao">
				<img alt="" src="images/kakao2.png">&nbsp;&nbsp;&nbsp;&nbsp;카카오 계정으로 회원가입
			</button>
			
			
			<br>

			<br />
			<form action="join.do" method="post" onsubmit="return confirmSubmit()">
				<input type="hidden" name="command" value="loingSingUpRes"/>

				<div id="check">
					<input type="checkbox" name="joinRole" value="멘토" onclick="oneCheckbox(this)"/>멘토 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="joinRole" value="멘티" onclick="oneCheckbox(this)" />멘티
				</div>

	
					<input type="text" class="input_text" name="id" placeholder="아이디" 
						required="required" id="join_span"/>
			
				<span class="check_res" style="display: none"></span> 
				
				<br /> 
				<br />

		
					<input type="email"  id="join_span" class="input_text" id="EmailID" value="" name="joinEmail" placeholder="Email"
						required="required" readonly="readonly" onclick="emailChkConfirm();" /> <!-- 필수 정보 입니다. -->
		
				<span class="check_res" style="display: none"></span>
				 
				<br /> 
				<br />
				 
				
					<input type="password" id="join_span" class="input_text" name="joinPw"
						placeholder="password" required="required" /> <!-- 필수 정보 입니다. -->
				
				 <span class="check_res" style="display: none"></span>
				 
				<br /> 
				<br /> 
				
			
					<input type="password" id="join_span" class="input_text" name="joinPw_chk"
						placeholder="ConfirmPassword" required="required"/> <!-- 필수 정보 입니다. -->
				<span class="check_res" style="display: none"></span> 
				<br /> 
				<br />
				<h4>아이디는 영문 숫자조합 5자리 이상 15자리 이하</h4>
				<br />
				

				<div class="span_text">
					<input type="checkbox"
						name="check" required="required" onclick="consent(this);"/> 
						운토티이용약관 및 개인정보취급방침에<br />	동의합니다.
				</div>

				<br /> <input type="submit" class="join"
					 value="신규회원으로 가입"> <br />
				<br />

				<div class="span_text">
					이미 운토티 회원이신가요? <a href="join.do?command=loginPopUp">로그인하기</a>
				</div>
			</form>
		</div>
	</div>


<footer>@ 2020 all copyrights reserved by 운토티</footer>

</body>
</html>