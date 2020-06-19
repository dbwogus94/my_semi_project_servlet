<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<% 
String idSub1 = request.getParameter("idSub1");
String idSub2 = request.getParameter("idSub2");

String id = idSub1+idSub2;

%>
</head>
<body>
    <form action="imageUpload.jsp" enctype="multipart/form-data" method="post" >
		<input type="hidden" name="id" value="<%=id%>"><br>      
      사진선택 : <input type="file" name="upfile">
      	<input type="text" id="img" name="imgRes">
      <input type="submit" value="Upload">
      
	</form>

</body>
</html>