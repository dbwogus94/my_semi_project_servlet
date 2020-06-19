<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="414765760234-41pmr1ehu69sp6j7qrntkdq9fkulbg0h.apps.googleusercontent.com">
   
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />

<link rel="stylesheet"
	href="resource/css/LOGIN_css/LOGIN_LoginPopUp.css">

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="resource/jquery-3.4.1.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript">
	// 값을 post방식으로 보내기
	/*
	 * path : 전송 URL
	 * params : 전송 데이터 {'q':'a','s':'b','c':'d'...}으로 키:값 묶어서 사용  (name : value)
	 * method : 전송 방식(생략가능)
	 */
	function postSend(path, params, method) {
		method = method || "post";
		var form = document.createElement("form");
		form.setAttribute("method", method);
		form.setAttribute("action", path);

		// 히든으로 값을 넣는다.
		for ( var key in params) { // {'name1':'var1','name2':'var2','name3':'var3'}
			var input_tag = document.createElement("input");
			input_tag.setAttribute("type", "hidden");
			input_tag.setAttribute("name", key) // name1, name2, name3
			input_tag.setAttribute("value", params[key]) // var1, var2, var3

			console.log("name : " + key);
			console.log("value : " + params[key]);

			form.appendChild(input_tag);
		}
		document.body.appendChild(form);
		form.submit();
	}
	
	

	//구글 로그인
	function onSignIn(googleUser) {
		var profile = googleUser.getBasicProfile();
		var userID = profile.getId();

		// 로그인  
		var path = "join.do"
		var params = {
			"command" : "loginCheck",
			"id" : userID,
			"joinPw" : "google"
		};

		// ??
		var id_token = googleUser.getAuthResponse().id_token;
		
		// 로그아웃
		 var auth2 = gapi.auth2.getAuthInstance();
         auth2.signOut().then(function () {});
         auth2.disconnect();
		
		//토큰(id), 이메일 포스트 방식으로 보낸다.
		 postSend(path, params);

		
	}
	
	function out01(){
            var auth2 = gapi.auth2.getAuthInstance();
            auth2.signOut().then(function () {
         	});
            auth2.disconnect();
	}
	

	//카카오톡 로그인
	function kakaoLogin() {

		//Kakao.init('70d3537d1fcd39317f206eb8c09a486d');
		Kakao.init('9f7a7d3a273350b18a01ba15bdae8c67');
		// 카카오 로그인 버튼을 생성합니다.
		Kakao.Auth.loginForm({
			success : function(authObj) {
				Kakao.API.request({
					url : '/v2/user/me',
					success : function(res) {
						console.log(res);

						var userID = res.id; //유저의 카카오톡 고유 토큰
						var userEmail = res.kakao_account.email; //유저의 이메일

						// 로그인  
						var path = "join.do"
						var params = {
							"command" : "loginCheck",
							"id" : userID,
							"joinPw" : "kakao"
						};

						//토큰(id), 이메일 포스트 방식으로 보낸다.
						postSend(path, params);

						//로그아웃
						Kakao.Auth.logout();
					},
					fail : function(error) {
						alert(JSON.stringify(error));
					}
				});

			},
			fail : function(err) {
				alert(JSON.stringify(err));
			}
		});
	}
	
	function IdSearch() {
		window.open("join.do?command=IdSearch","","width=400px,height=350px;");
		
	}
	function PwSearch() {
		window.open("join.do?command=PwSearch","","width=400px,height=350px;");
	}
	
	
</script>
<title>로그인</title>
</head>
<body>
	<header>
		<div id="logo">
			<img src="images/logo_white.png" onclick="location.href='join.do?command=main'"/>
		</div>
		<h1 id="untoti">운토티</h1>
		<div class="container" onclick="myFunction(this)">
			<div class="bar1"></div>
			<div class="bar2"></div>
			<div class="bar3"></div>
		</div>
	</header>

	<div id="main_container">
		<h1>로그인</h1>
		<div id="join_container">
			<br>
			<br>
			<button onclick="" name="" data-width="320" data-height="40"
				class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"
				id="google">
				<img alt="" src="images/google.png">&nbsp;&nbsp;&nbsp;&nbsp;google
				로그인
			</button>
			<button onclick="kakaoLogin();" id="kakao">
				<img alt="" src="images/kakao2.png">&nbsp;&nbsp;&nbsp;&nbsp;카카오
				로그인
			</button>

			<br />
			<form action="join.do" method="post">
				<input type="hidden" name="command" value="loginCheck" /> <span
					class="join_span"> <input type="text" class="input_text"
					name="id" placeholder="아이디" id="id" required="required"
					maxlength="20" />
				</span> <br /> <span class="join_span"> <input type="password"
					class="input_text" name="joinPw" placeholder="PassWord"
					required="required" onclick="emailChkConfirm();" /> <!-- 필수 정보 입니다. -->
				</span> <br /> <br /> <br /> <br /> <input type="submit"
					class="input_button" value="Login"> <br /> <br />

				<div class="span_text" id="chk">
					아이디가 없으신가요? 
					<a href="join.do?command=loginSingUp">회원가입 </a><br>
					까먹었어요ㅜㅜ?
					<a href="join.do?command=loginPopUp" onclick="IdSearch();">아이디찾기</a>
					<a href="join.do?command=loginPopUp" onclick="PwSearch();">비밀번호찾기</a>
				</div>
			</form>
		</div>
	</div>
	<footer>@ 2020 all copyrights reserved by 운토티</footer>
</body>
</html>