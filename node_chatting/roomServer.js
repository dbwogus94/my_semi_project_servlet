
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


const app = require('express')();    	   // >>> 외장 모듈 express(http확장 모듈) 임포트 >> app 객체 생성 
const http = require('http').Server(app);  // >>> 내장 모듈 http를 임포트하고 서버 생성
const io = require('socket.io')(http);     // >>> 외부 모듈 sochet.io를 임포트 하고  http객체를 바인딩하고 객체생성 


app.set('view engine', 'ejs');  // view engine은 템플릿을 ejs를 사용한다. >>> js의 html형식의 문서중 하나로 자바의 jsp같이 확장자를 .ejs를 사용한다.(ex)ejs, pug)
app.set('views', 'views');      // views라는 폴더를 인식하게 설정(express 프레임 워크 기본 생성 폴더)


//var roomRumber_map = { "id1": "id2",  "id3": "id4" , "id5":"id6"};



let room = ['room1', 'room2'];   // 사용할 룸 생성
let a = 0;


app.get('/', (req, res) => {
  res.render('chat');   // 
});
//화면 팝업 예.
app.get('/chat', (req, res) => {
     res.render('chat');
});


io.on('connection', (socket) => {
  socket.on('disconnect', () => {
    console.log('user disconnected');
  });


  socket.on('leaveRoom', (num, name) => {
    socket.leave(room[num], () => {  //  .leave() room 퇴장 메서드 leave
      console.log(name + ' leave a ' + room[num]);
      io.to(room[num]).emit('leaveRoom', num, name);  // to 귓말
    });
  });


  socket.on('joinRoom', (num, name) => {
    socket.join(room[num], () => {    //.join() room입장 메서드
      console.log(name + ' join a ' + room[num]);
      io.to(room[num]).emit('joinRoom', num, name);
    });
  });


  socket.on('chat message', (num, name, msg) => {
    a = num;
    io.to(room[a]).emit('chat message', name, msg); // >> 해당룸 둘다에게 전송
  });
});


http.listen(3000, () => {
  console.log('Connect at 3000');
});