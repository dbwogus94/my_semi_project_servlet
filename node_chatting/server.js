

/* jshint esversion: 6*/

/* 설치한 express 모듈 불러오기 */
const express = require("express");

/* 설치한 socket.io 모듈 불러오기 */
const socket = require("socket.io");

/* Node.js 기본 내장 모듈 불러오기 */
const http = require("http");

/* Node.js 기본 내장 모듈 불러오기 */
const fs = require("fs");


/* express 객체 생성 */
const app = express();

/* express http 서버 생성 */
const server = http.createServer(app);

/* 생성된 서버를 socket.io에 바인딩 */
const io = socket(server);

/* 정적파일 제공 : express모듈.use(미들웨어) */ //일종의 컨트롤러
app.use("/css", express.static("./static/css"));
app.use("/js", express.static("./static/js"));

/* Get 방식으로 / 경로에 접속하면 실행 됨 */
app.get("/", function(request, response) {
  fs.readFile("./static/indexchat.html", function(err, data) {
    if(err) {
      response.send("에러");
    } else {
      response.writeHead(200, {"Content-Type":"text/html"});
      response.write(data); //html데이터
      response.end();       //데이터 전송 완료 시, 종료
    }
  })
})

io.sockets.on("connection", function(socket) {

  /* 새로운 유저가 접속했을 경우 다른 소켓에게도 알려줌 */
  socket.on("newUser", function(name) {
    console.log(name + " 님이 접속하였습니다.");

//NEW!!01.    
    /* 소켓에 이름 저장해두기 */
    socket.name = name; //클라이언트로부터 받은 닉네임 소켓에 저장

//NEW!!02.    
    /* 모든 소켓에게 전송 (시스템 메세지)*/
    io.sockets.emit("update", {type: "connect", name: "SERVER", message: name + " 님이 접속하였습니다."});
  });                         // 서버가 클라에게, connect?

//NEW!!03.  클라이언트에서 메세지를 입력하고 발생하는 이벤트.
  /* 전송한 메시지 받기 */
  socket.on("message", function(data) { // : 유저가 보낸 메세지
    /* 받은 데이터에 누가 보냈는지 이름을 추가 */
    data.name = socket.name; 
    
    console.log(data);

//NEW!!04.    
    /* 보낸 사람을 제외한 나머지 유저에게 메시지 전송 */
    socket.broadcast.emit("update", data); // : 전달할 데이터
  });

//NEW!!05.  
  /* 접속 종료 */
  socket.on("disconnect", function() {
    console.log(socket.name + "님이 나가셨습니다.");

//NEW!!06.    
    /* 나가는 사람을 제외한 나머지 유저에게 메시지 전송 */
    socket.broadcast.emit("update", {type: "disconnect", name: "SERVER", message: socket.name + "님이 나가셨습니다."});
  })
})

/* 서버를 3000 포트로 listen */
server.listen(3000, function() {
  console.log("서버 실행 중..");
});


/* 설정 이벤트 명 
  
message : 클라->서버
update : 서버가_받은 메세지-> 다른 클라 
connectUser : 새로운 유저 접속 서버에게 알림 
              접속종료는 update로 통일
*/

/* 암기사항

io.sockets.emit() = 모든 유저(본인포함)
socket.broadcast.emit() = 본인 제외한 모두

*/