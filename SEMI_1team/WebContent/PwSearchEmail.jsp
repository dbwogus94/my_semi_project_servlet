<%@page import="join.dto.JoinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="resource/jquery-3.4.1.js"></script>
<script type="text/javascript">
	window.close();
	alert("비밀번호가 이메일로 전송되었습니다.");
</script>
<title>Insert title here</title>
</head>
<body>
	<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="com.mail.SMTPAuthenticatior"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
JoinDto joinDto = (JoinDto)request.getAttribute("joinDto");
String to = joinDto.getJoinEmail();
String id = joinDto.getId();
String pw = joinDto.getJoinPw();
  
String email = request.getParameter("email");
Properties p = new Properties(); // 정보를 담을 객체
  
p.put("mail.smtp.host","smtp.naver.com");
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");
 
  
try{
    Authenticator auth = new SMTPAuthenticatior();
    Session ses = Session.getInstance(p, auth);
      
    ses.setDebug(true);
    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체 
 
    msg.setSubject("운토티 비밀번호 전송 이메일입니다."); //  제목
 
    StringBuffer buffer = new StringBuffer();
    buffer.append(id);
    buffer.append(" 님의 "+"<br>");
    buffer.append("비밀번호: ");
    buffer.append(pw+"<br>");
    Address fromAddr = new InternetAddress("igs99275@naver.com");//보내는사람
    msg.setFrom(fromAddr); 
 
    Address toAddr = new InternetAddress(to);// 받는 사람
    msg.addRecipient(Message.RecipientType.TO, toAddr); 
     
    msg.setContent(buffer.toString(), "text/html;charset=UTF-8"); // 내용
    Transport.send(msg); // 전송  
 
} catch(Exception e){
    e.printStackTrace();
    return;
}
%>

</body>
</html>