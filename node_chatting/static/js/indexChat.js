var socket = io();

/* 접속 되었을 때 실행 */
socket.on("connect", function(){
    /* 이름 입력받고 */
    var name = prompt("반갑습니다.", "")    // prompt(message?: string, default?: string): string

    /* 이름 빈칸인 경우 */
    if(!name){
        name = "♥";
    }

    /* 서버에 새로운 유저가 왔다고 알림 */  //서버에 구현
    socket.emit("newUser",name);
});

/* 서버로부터 데이터 받은 경우 */
socket.on("update",function(data){
  console.log("${data.name}:${data.message}");    //터미널 찍기

  var chat = document.getElementById("chat");

  var message = document.createElement("div");
  var node = document.createTextNode(`${data.name}: ${data.message}`);  //$로 값 이동할 때는 ~쪽 따옴표를 사용
  var className = "";

  // 타입에 따라 적용할 클래스를 다르게 지정
  switch(data.type) {
    case "message":
      className = "other";
      break;

    case "connect":
      className = "connect";
      break;

    case "disconnect":
      className = "disconnect";
      break;
  }

  message.classList.add(className);
  message.appendChild(node);
  chat.appendChild(message);
})

/* 메시지 전송 함수 */
function send() {
  // 입력되어있는 데이터 가져오기
  var message = document.getElementById("test").value;
  
  // 가져왔으니 데이터 빈칸으로 변경
  document.getElementById("test").value = "";

  // 내가 전송할 메시지 클라이언트에게 표시
  var chat = document.getElementById("chat");
  var msg = document.createElement("div");
  var node = document.createTextNode(message);
  msg.classList.add("me");
  msg.appendChild(node);
  chat.appendChild(msg);

  // 서버로 message 이벤트 전달 + 데이터와 함께
  socket.emit("message", {type: "message", message: message});
}