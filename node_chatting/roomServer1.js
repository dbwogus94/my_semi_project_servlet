
/* jshint esversion: 6*/
//const app = require('express')();   
	/*
	  == import와 초기화(생성)을 같이하는 코드
	  >> const http = require('http');
	  >> const app = express();
	*/


//const http = require('http').Server(app);  
	/*
	  == http를 import하고 서버생성까지 한번에 하는 코드
	  >> const http = require('http');
	  >> const server = http.createServer(app);
	 */

//const io = require('socket.io')(server);

	/*
	  == socket.io를 import 함과 동시에 위에 생성한 http서버를 소켓에 바인딩하고 객체생성(io)
	  >> const socket = require('socket.io');
	  >> const io = socket(server);
	 */

const app = require('express')();    	   // >>> 외장 모듈 express(http확장 모듈) 임포트
											// >> app 객체 생성
const http = require('http').Server(app);  // >>> 내장 모듈 http를 임포트하고 서버 생성

const io = require('socket.io')(http);     // >>> 외부 모듈 sochet.io를 임포트 하고
											// http객체를 바인딩하고 객체생성


app.set('view engine', 'ejs');  // view engine은 템플릿을 ejs를 사용한다. >>> js의 html형식의
								// 문서중 하나로 자바의 jsp같이 확장자를 .ejs를 사용한다.(ex)ejs,
								// pug)
app.set('views', 'views');      // views라는 폴더를 인식하게 설정(express 프레임 워크 기본 생성 폴더)


//var roomRumber_json = { "id1": "id2", "id3": "id4" , "id5":"id6"};


// 입장시 해당 회원의 id와 연결된 id를 받아서 사용할 룸에 추가


  
var room = {}; 
/*
  - 매치테이블시권스  = no  >> 유일값
  - 배열 index 0번지 멘토의 id(이름)
  - 배열 indes 1번지 멘티의 id(이름) 
 room의 구조는 
   = { no0 : [멘토id1, 멘티id1, no0], no1 : [멘토id1, 멘티id2, no1], no2 : [멘토id2, 멘티id3, no2] ... }
 */





// 기본 채팅 메인경로 실행전 Role , myId, otherId, no(매칭된 테이블 시퀀스)를 받는다.
app.get('/', (req, res) => {
// 1) get 방식은 'req(request).query.키' 를 통해 값을 받아온다
	let myId = req.query.myId;
	let myRole = req.query.myRole;
	//let otherId = "";
	console.log(myId, myRole);
	
	
	//멘토일 때
	if(myRole === "mentor"){
		let otherIds = req.query.otherId_json;
		let matchNos = req.query.No_json;
		
		//console.log("멘토 :" + myId);
		//console.log("멘티id :" + otherId);
		console.log("1 메치시퀀스 :" + matchNos);

		// ,기준으로 자르고 배열로 만든다.
		let otherId_Arr = otherIds.split(",");   
		let matchNo_Arr = matchNos.split(",");
		
		
		// 방 생성 
		for(var i in otherId_Arr){ // otherId_Arr 길이만큼 i는 0부터 1++
			if(room[matchNo_Arr[i]] === undefined){  // 배열의 해당 인덱스의 값이 없다면 실행 
			room[matchNo_Arr[i]] = [myId, otherId_Arr[i], matchNo_Arr[i]]  			//	>>> room[no] = [멘토, 멘티, no]
			console.log("멘토에서 방생성 방번호는 : " + matchNo_Arr[i]);						//  >>> room = {no : [멘토, 멘티, no]}
			console.log("방구성 : " + room[matchNo_Arr[i]]);
			}
		}
		
		//응답
		res.render('main', {myRole: myRole, myId: myId, otherId: otherIds, matchNo: matchNos});   // 응답 {}키값으로 적제
	
	// 멘티인 경우	
	} else if(myRole === "mentee"){
		let otherId = req.query.otherId;
		let matchNo = req.query.matchNo;
		//console.log("멘토" + myId);
		console.log("2 메치시퀀스" + matchNo);
		
		//방 생성
		if(room[matchNo] === undefined ){
			room[matchNo] = [otherId, myId, matchNo];   		//  구조 = [멘토, 멘티]
			console.log("멘티에서 방생성 방번호는 : " + matchNo);
			console.log("방구성 : " + room[matchNo]);
		}
		// 응답
		res.render('main', {myRole: myRole, myId: myId, otherId: otherId, matchNo: matchNo});   // 응답 {}키값으로 적제
	}
});	



// 요청 : 본격적인 채팅방입장 
//				>> 만들어둔 room의 키인 메치시퀀스를 사용해서 접근
app.get('/chat', (req, res) => {
	let mathNo = req.query.matchNo; // 방번호
	let myRole = req.query.myRole;  // 역할
	let myId = "";
	let otherId= "";
	
	// 유저의 역할에 따른 id를 room에서 가져온다.
	if(myRole === "mentor"){
		myId = room[mathNo][0];     // 멘토는 0번지 
		otherId = room[mathNo][1];  // 멘티는 1번지
		
	} else if(myRole === "mentee") {
		myId = room[mathNo][1];     // 멘티 1번지
		otherId = room[mathNo][0];  // 멘토 0번지
	}
	
	// 응답
	console.log("방 입장 방번호 : " + mathNo)
	res.render('chat1', {myRole: myRole, myId: myId, otherId: otherId, mathNo: mathNo});
});


io.on('connection', (socket) => {
	console.log("소켓 추가");
	
	/* 방 접속시	 */
	socket.on('joinRoom', (data) => {   // data = {myRole: myRole, myId: myId, otherId: otherId, mathNo: mathNo}
		console.log("방접속");
		
		// socket 변수는 각각의 소켓마다 따로 부여된다. 
		socket.myId = data.myId;     	// 소켓에 내 id 담기
		socket.myRole = data.myRole; 	// 소켓에 내 역할 담기
		socket.otherId = data.otherId;  // 소켓에 상대 id 담기
		socket.mathNo = data.mathNo;	// 소켓에 방번호 담기
		
		console.log("1 : "+socket.myId);
		console.log("2 : "+socket.myRole);
		console.log("3 : "+socket.otherId);
		console.log("4 : "+socket.mathNo);
		

	//{ no0 : [멘토id1, 멘티id1, no0], no1 : [멘토id1, 멘티id2, no1], no2 : [멘토id2, 멘티id3, no2] ... }

		// 방입장
		socket.join(room[socket.mathNo][2], () => {    	// .join() room입장
			console.log(socket.myId + ' 방접속 성공, 방의 번호는 :' + socket.mathNo);	
				
			// 해당룸에 입장하는 사람의 정보 전달
			io.to(room[socket.mathNo][2]).emit('joinRoom', {myId : socket.myId,  myRole: socket.myRole}); // 상태 id, 상대역할
																										// 'OO멘토님이 들어왔습니다' 출력을 위함						
		});
			

	});	
	//서버 메세지 받기
	socket.on('chat message', (data) => { 		   //{myRole: myRole, myId: myId, message : message}
		console.log("메세지 받음 : " + data.message);
		
		console.log("1 전송 : " + data.message);
		
		// 해당 룸으로 받은 메세지 전달
		io.to(room[socket.mathNo][2]).emit('chat message', {myId: socket.myId,  myRole: socket.myRole, message: data.message});	

	});	
	


  // 소켓 탈출 >> 방나갈 때
  socket.on('disconnect', () => {
	    console.log( socket.myId + ' user disconnected');
	    io.to(room[socket.mathNo][2]).emit("leaveRoom", {myId: socket.myId,  myRole: socket.myRole});
  });
  
});


http.listen(8010, () => {
  console.log('Connect at 8010');
});