<%@page import="member.profile.biz.ProfileBizImpl"%>
<%@page import="member.profile.biz.ProfileBiz"%>
<%@page import="member.profile.dto.ProfileDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="com.oreilly.servlet.MultipartRequest, oracle.sql.*, javax.servlet.http.*,java.io.*, java.sql.*, java.text.*, java.util.*" %>
<%
String savePath = "C:\\Semi_project\\SEMI_1team\\WebContent\\images"; //이미지 저장 경로

int sizeLimit = 1 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "UTF-8");

String timemask = ""+System.currentTimeMillis();
//out.print("timemask="+timemask); -> 현제시간 millis로 뺴줌, 쓸꺼면 upfile2에 추가할것

Enumeration files = multi.getFileNames();//폼 불러오기

String fname = (String)files.nextElement();//폼 이름

String fileName = multi.getFilesystemName(fname);//파일 이름

String id = multi.getParameter("id"); 
out.print("id= "+id+"<br>");
String src ="../images/"+id+".jpg";


String newFileName ="";
File upfile1=null;
File upfile2=null;

if(fileName != null){
	
	  upfile1 = new File(savePath+"/"+fileName); 
	  upfile2 = new File(savePath+"/"+id+fileName.substring(fileName.lastIndexOf(".")));// 파일 이름
	
   if(upfile1.renameTo(upfile2)){//파일 이름 바꾸기
      out.print("이름변경성공");
  	ProfileBiz profilebiz = new ProfileBizImpl();
  	ProfileDto profileDto = new ProfileDto();
  	profileDto.setId(id);
  	profileDto.setMemberContent(src);

  	int res = profilebiz.UpdateSrc_Mentor(profileDto);
    }else{
       out.print("이름변경실패");
   	ProfileBiz profilebiz = new ProfileBizImpl();
   	ProfileDto profileDto = new ProfileDto();
   	profileDto.setId(id);
   	profileDto.setMemberContent(src);

   	int res = profilebiz.UpdateSrc_Mentor(profileDto);
   }

 out.print("변경된 파일명= "+upfile2.getName());
 newFileName = upfile2.getName();

}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="resource/jquery-3.4.1.js"></script>
<script type="text/javascript">
</script>
<title>Insert title here</title>
</head>
<body><form action="profile.do?" method="post">
	<input type="hidden" name="command" value="ImgRes">
	<img alt="ss" id="img" src="images/<%=id%>.jpg"> <!-- 불러올 이미지 경로 -->
	<input type="hidden" name="id" value="<%=id%>">
	<input type="hidden" name="src" value="<%=src%>">
	<input type="submit" value="눌러라">
	</form>
</body>
</html>