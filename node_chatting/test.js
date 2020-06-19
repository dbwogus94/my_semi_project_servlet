/* jshint esversion: 6*/
var express = require("express");  //서버적인 기능을 확장한 모듈
var socket = require("socket.io");
var http = require("http");
var fs = require("fs");  // + 02


var app = express(); //객체 생성
var server = http.createServer(app) // 서버 생성
var io = socket(server);  //생성한 서버를 소켓에 바인딩
/*
var http = require("http").Server(app);
var io = require("socket.io")(http);
이 두줄로 모듈 두개 불러오고-서버객체생성-소켓에바인딩까지 가능
*/

/*
서버에 방에 입장하기 요청을 보내고 그 응답 결과(방 데이터가 되어야 겠습니다)로 State.rooms를 갱신하고 State.activeRoom의 참조를 갱신합니다.

*/




//let room = ['room1', 'room2'];
//let a= 0;

////커플 담을 map필요 <- 이미 있음
////방번호 담을 배열 필요 (100개 만들어서 방번호 달아주기)
////방번호에 커플 담아주기


//var room = new Array(100);
//for(var i=0; i<room.length; i++){
//    console.log(room[i]);
//    //room.push(i);  //방 하나씩 늘려주기+값 담아주기
//    //room[i] += '커플명' or 숫자  //커플 담아주기
//}






//(서버가 작업하지 않은)정적파일 제공
app.use("/css", express.static("./폴더/폴더"));   //≒컨트롤러
app.use("/js", express.static("./폴더/폴더"));

app.get("/",function(req, res){
   console.log("유저가 get방식으로 / 경로에 접속했습니다.");
//   res.send("서버->브라우저 전달 데이터");
   fs.readFile("./폴더/index.html", function(err, data){
      if(err){
      res.send("에러가 떴습니다.");
      }else{
      res.writeHead(200,{"Content-Type":"text/html"});  //html파일입니다 하고 알려주는알림.
      res.write(data);  //html 데이터를 보내줍니다.
      res.end();  //모두 보냈으면 완료
      }
   });
});











//통신관련   (on : 콜백함수 실행 / emit
io.sockets.on("connection",function(socket){  //socket: sockets중 해당 이벤트로 접속된 소켓

   
  //새로운 유저 접속 시 알림메세지
   socket.on("newUser", function(name){
   console.log(name + " 님이 접속했습니다.");  //콘솔창에 찍히는 메세지
    //소켓에 이름 저장   
   socket.name= name;
    /* 모든 소켓에게 전송 (입장알림음)  */
       io.sockets.emit("update", {type: "connect", name: "SERVER", message: name + " 님이 접속하였습니다."});
   });




  //클라에서 입력한 메세지 받는 이벤트
    //메세지 받기
   socket.on("send", function(data){
//    console.log("전달된 메세지:", data.msg);  //메세지, 내용
    data.name = socket.name;  // 받은 데이터에 누가 보냈는지 이름을 추가

    console.log(data);

    socket.broadcast.emit("update", data);  // 데이터 뿌리기
   });

   



    //접속종료
   socket.on("disconnect", function(){
    console.log("접속이 종료됩니다.");
   });

    //혼자 남았다고 찍어주기
   socket.broadcast.emit("update", {type: "disconnect", name: "SERVER", message: socket.name + "님이 나가셨습니다."});
});






server.listen(8081, function(){
   console.log("8081에서 서버 실행중..");
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