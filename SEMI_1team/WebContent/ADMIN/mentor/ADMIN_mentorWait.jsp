<%@page import="All.statics.join.LoginProfile.dto.LoginProfileDto"%>
<%@page import="member.profile.dto.ProfileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	LoginProfileDto loginProfileDto = (LoginProfileDto) request.getAttribute("loginProfileDto");
%>
<body>
		<h1>멘토 승인 대기 팝업</h1>
		<table>
			<tr>
				<td>이름</td>
				<td>
					<%=loginProfileDto.getMemberName() %>
				</td>
			</tr>
			
			<tr>
				<td>이메일</td>
				<td>
					<%=loginProfileDto.getJoinEmail() %>
				</td>
			</tr>
			
			<tr>
				<td>주소</td>
				<td>
					<%=loginProfileDto.getMemberAddr() %>
				</td>
			</tr>
			
			
			<tr>
				<td>번호</td>
				<td>
					<%=loginProfileDto.getMemberPhone() %>
				</td>
			</tr>
			
			
			<tr>
				<td>키/몸무게</td>
				<td>
					<%=loginProfileDto.getMemberHeight() %> / <%=loginProfileDto.getMemberWeight() %>
				</td>
			</tr>
			
			<tr>
				<td>한 줄 소개</td>
				<td>
					<%=loginProfileDto.getMemberOneIntro() %>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="승인" onclick="location.href='profile.do?command=mentorApprove&id=<%=loginProfileDto.getId()%>'"/>
					<input type="button" value="취소" onclick="window.close()"/>
 				</td>
			</tr>
			
		</table>
		
</body>
</html>