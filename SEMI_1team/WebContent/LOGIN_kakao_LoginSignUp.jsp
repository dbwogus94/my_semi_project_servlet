<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
  
  <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
  <link rel="stylesheet" href="resource/css/LOGIN_css/kakao_LoginSignUp.css">
<script type="text/javascript" src="resource/jquery-3.4.1.js"></script>
<script type="text/javascript">
	var chk1 = false; 
	var chk2 = false;
	var chk3 = false; 
	var chk4 = false;
		

	function idChkAjax(value){
		var idRes = document.getElementsByClassName("check_res")[0]; 
		$.ajax({
			url:"join.do", 
			type:"post",
			async: true,
			data:{
				command:"idCheck",
				id: value
			},
			dataType:"text",
			success: function(text){
				if(text === "fail"){
					idRes.style.display="block";
					idRes.textContent="이미 존재하는 아이디 입니다.";
				} else if(text === "ok") {  // 사용가능한 아이디
					chk1 = true;
					idRes.style.display="block";
					idRes.style.color="blue";
					idRes.textContent="사용가능한 아이디 입니다.";
				}
			},
			error: function(){
				alert("통신 실패");
			}
		});	
	}
	
	function emailChkAjax(value){
		var emailRes = document.getElementsByClassName("check_res")[1]; 
		$.ajax({
			url:"join.do", 
			type:"post",
			async: true,
			data:{
				command:"emailCheck",
				email: value
			},
			dataType:"text",
			success: function(text){
				if(text === "fail"){
					emailRes.style.display="block";
					emailRes.textContent="이미 존재하는 이메일 입니다.";
				} else if(text === "ok") {
					chk2 = true;
					emailRes.style.display="block";
					emailRes.style.color="blue";
					emailRes.textContent="사용가능한 이메일 입니다.";
				}
			},
			error: function(){
				alert("통신 실패");
			}
		});
	}
	
	window.onload = function(){	
		$(".input_text").eq(0).click(function(){ 
			var id = document.getElementsByClassName("input_text")[0]; 
			var idRes = document.getElementsByClassName("check_res")[0]; 
		
			if(id.value===""){
				idRes.style.display="block";
				idRes.textContent="카카오 로그인을 눌러주세요";
			}
		});
	
		$(".input_text").eq(1).click(function(){
			var email = document.getElementsByClassName("input_text")[1];
			var emailRes = document.getElementsByClassName("check_res")[1]; 
			
			if(email.value===""){
				emailRes.style.display="block";
				emailRes.textContent="카카오 로그인을 눌러주세요";
				return false;
			}
		});
		
		
	} //window.onload 바디  끝
	
	
	
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
    	}
	} 
	
	// 약관동의
	function consent(obj){
		if(obj){
			chk3 = true;
		} else {
			chk3 = false;	
		}
	}
	
	// 서브밋 유효성 검사
	function  confirmSubmit() {
		
		if(chk1 && chk2 && chk3 && chk4){
			var con = confirm("해당내용 회원가입 하시겠습니까?")
			if(con){
				return true;
			} else {
				return false;
			}
		} else if(!chk1) {
			alert("카카오 인증을 완료하세요");
			return false;
		} else if(!chk2) {
			alert("이메일을 인증")
			return false;
		} else if(!chk3) {
			alert("약관에 동의하세요");
			return false;
		} else if(!chk4){
			alert("멘토 또는 멘티를 체크하세요");
			return false;
		} else {
			return true;
		}
		
		return false;
	}
		
		
	//카카오톡 로그인
	function kakaoLogin() {
      
        //Kakao.init('70d3537d1fcd39317f206eb8c09a486d');
        Kakao.init('9f7a7d3a273350b18a01ba15bdae8c67');
         
         // 카카오 로그인 버튼을 생성합니다.
         Kakao.Auth.loginForm({
                       success: function(authObj) {
                          Kakao.API.request({
                               url: '/v2/user/me',
                               success: function(res) {
                                console.log(res);
                                
                                var userID = res.id;      //유저의 카카오톡 고유 id
                                var userEmail = res.kakao_account.email;   //유저의 이메일
                                
                                document.getElementById('EmailID').value =userEmail;
                                document.getElementById('id').value =userID;
                               
                                idChkAjax(userID);
                                emailChkAjax(userEmail);
                                
                                Kakao.Auth.logout();
                                
                               },
                               fail: function(error) {
                                alert(JSON.stringify(error));
                               }
                              });
                          
                       },
                       fail: function(err) {
                         alert(JSON.stringify(err));
                       }
                    });
      
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
			<br><br>
			<button onclick="kakaoLogin();" id="kakao">
				<img alt="" src="images/kakao2.png">&nbsp;&nbsp;&nbsp;&nbsp;카카오 로그인
			</button>
			<br>

			<br />
			<br /> 
			<form action="join.do" method="post" onsubmit="return confirmSubmit()">
				<input type="hidden" name="command" value="loingSingUpRes_API" />
				<input type="hidden" name="API" value="kakao" />
					
				<div id="chk">
					<input type="checkbox" name="joinRole" value="멘토" onclick="oneCheckbox(this)"/>멘토 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="joinRole" value="멘티" onclick="oneCheckbox(this)" />멘티
				</div>

				<span class="join_span"> 
					<input type="password" class="input_text" name="id" placeholder="카카오 인증번호"  id="id" 
					 readonly="readonly" required="required" maxlength="20"/>
				</span>
				<span class="check_res" style="display: none"></span> 
				
				<br /> 
				<br />
				<br /> 

				<span class="join_span"> 
					<input type="text" class="input_text" id="EmailID" name="joinEmail" placeholder="Email"
						required="required" readonly="readonly" onclick="emailChkConfirm();" />
				</span> 
				<span class="check_res" style="display: none"></span>
				 
				<br /> 
				<br /> 
				 
				<div class="span_text" id="chk">
					  <br /> <input type="checkbox"
						name="check" required="required" onclick="consent(this);"/> 운토티이용약관 및 개인정보취급방침에 동의합니다.
				</div>

				<br /> 
				<br /> 
				
				<input type="submit" class="input_button" value="신규회원으로 가입"> <br />
				<br />

				<div class="span_text" id="chk">
					이미 운토티 회원이신가요? <a href="join.do?command=loginPopUp">로그인하기</a>
				</div>
			</form>
		</div>
	</div>
<footer>@ 2020 all copyrights reserved by 운토티</footer>
</body>
</html>