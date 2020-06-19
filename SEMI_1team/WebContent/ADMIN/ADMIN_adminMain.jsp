<%@page import="join.dto.JoinDto"%>
<%@page import="member.profile.dto.ProfileDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="resource/css/ADMIN_css/ADMIN_Search.css" rel="stylesheet" >
<script type="text/javascript">
	function waitPopUp(id){
	//&nbsp;만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	var popupX = ((document.body.offsetWidth/2)-(300/2));  

	//&nbsp;만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY= ((document.body.offsetHeight/2)-(300/2));

	window.open("profile.do?command=admin_mentorWait&id="+id, "", "status=no, width=500px, height=500px , left="+ popupX + ", top="+ popupY);
	
	
	}


</script>
<title>Insert title here</title>
<% 
	String search_type = (String)request.getAttribute("search_type");
	List<Object> list_o = (List<Object>)request.getAttribute("list"); 
	List<ProfileDto> profileDtolist = null;
	List<JoinDto> joinDtoList = null;
	
	if(list_o.size() >0 ){
		if(list_o.get(0) instanceof ProfileDto){
	 		profileDtolist = (List<ProfileDto>) request.getAttribute("list");
	 		System.out.println(profileDtolist);
		} 
		
	 	if(list_o.get(0) instanceof JoinDto){
	 		joinDtoList = (List<JoinDto>) request.getAttribute("list");
	 		System.out.println(joinDtoList);
	 	}	
	}
 	
%>

</head>
<body>
	
		<header>
			<div id="logo">
				<img alt="" src="images/logo_white.png">
			</div>
			<h1>운토티</h1>
		
			<div class="menu_icon" onclick="myFunction(this)">
			  		<div class="bar1"></div>
			 		<div class="bar2"></div>
			 		<div class="bar3"></div>
			</div>
			<div id="myDropdown" class="dropdown-content">
				<a href="#">메인</a><hr>
				<a href="#">메뉴1</a><hr>
				<a href="#">메뉴2</a>
			</div>
		</header>
	<div id="Main_container">
		
		<br>
		<hr><br><h3>관리자 회원관리</h3><br><hr>
	
		<div class="board">	
		<div id="search">
			<h2>운도티 회원목록</h2>
			 <form action="profile.do" method="post">
			 	<input type="hidden" name="command" value="admin_MenberSearch"/>
			 	<input type="hidden" name="" value=""/>
				 <select name="search_type" id="select">
				 	<option value="All_Y" <%=(search_type.equals("All_Y")? "selected": "") %>>멘토/맨티</option>
				 	<option value="멘토" <%=(search_type.equals("멘토")? "selected": "") %>>멘토</option>
				 	<option value="멘티" <%=(search_type.equals("멘티")? "selected": "") %>>맨티</option>
				 	<option value="All_N"  <%=(search_type.equals("All_N")? "selected": "") %>>미작성/미승인</option>
				 	<option value="mentorRegister_N"<%=(search_type.equals("mentorRegister_N")? "selected": "") %>>승인대기</option>
				 	<option value="menteeProfile_N"<%=(search_type.equals("menteeProfile_N")? "selected": "") %>>미작성</option>
				 </select>		
				<input type="text" id="s_text" name="search_text" placeholder="아이디 또는 이름으로 검색"/>
		 		<input type="submit" id="s_sub" value="검색"/>
			 </form>
		</div>
		<br/>
		<br/>
		 	
		 	
			<div id="search_bady">
		<%
			if(profileDtolist != null){     // profileDtolist가 null이 아니라면 
				for(ProfileDto profileDto: profileDtolist){
				// 멘토/멘티, 멘토, 멘티에서 검색하면 >>> 이름사용
		
					if(profileDto.getMemberRole().equals("멘토")){
		%>	
					<fieldset>
		 				<legend style="text-align: center;"><b><%=profileDto.getMemberName() %></b>님 </legend>
		 				<legend style="text-align: left; color: red;"><b>M</b> </legend>
		 				<img alt="" src="images/mentor.png">
		 				<br>
		 				<br>
		 				<input type="button" value="상세보기" onclick="location.href='profile.do?command=admin_MemberSearchDetail&id=<%=profileDto.getId() %>&memberRole=<%=profileDto.getMemberRole() %>'"/>
		 			</fieldset>	
				
		<% 
					} else {
		%>
					<fieldset>
				 		<legend style="text-align: center;"><b><%=profileDto.getMemberName() %></b>님 </legend>
				 		<legend style="text-align: left;"><b>&nbsp;</b> </legend>
				 			<img alt="" src="images/mentor.png">
				 			<br>
				 			<br>
				 			<input type="button" value="상세보기" onclick="location.href='profile.do?command=admin_MemberSearchDetail&id=<%=profileDto.getId() %>&memberRole=<%=profileDto.getMemberRole() %>'"/>
				 	</fieldset>			
		<%
					}
				}
			} else if(joinDtoList != null){ // joinDtolist가 null이 아니라면
				for(JoinDto joinDto: joinDtoList){
					// 전체, 미작성, 승인대기  >>> 아이디 사용
					if(joinDto.getJoinRole().equals("멘토")){
						if(joinDto.getJoinRegisterYn().equals("W")){  // 프로필 작성시 W  >>> 승인 >> Y 
		%>
					<fieldset>
			 			<legend style="text-align: center;"><b><%=joinDto.getId() %></b>님 </legend>
			 			<legend style="text-align: left; color: red;"><b>M</b> </legend>
			 			<img alt="" src="images/mentor.png">
			 			<br>
			 			<br>
						<input type="button" value="승인대기" onclick="waitPopUp('<%=joinDto.getId() %>');"/>
					</fieldset>			
		
		<%					
						} else if(joinDto.getJoinRegisterYn().equals("N")) {
		%>						
							<fieldset>
		 						<legend style="text-align: center;"><b><%=joinDto.getId() %></b>님 </legend>
		 						<legend style="text-align: left; color: red;"><b>M</b> </legend>	
		 						<img alt="" src="images/mentor.png">
		 						<br>
		 						<br>		
								<input type="button" value="승인대기" disabled="disabled"/>
							</fieldset>
		<% 					
						}
					} else{ // 멘티일때			
						if(joinDto.getJoinRegisterYn().equals("N")){  //프로필 미작성
		%>					<fieldset>
					 			<legend style="text-align: center;"><b><%=joinDto.getId() %></b>님 </legend>
					 			<legend style="text-align: left;"><b>&nbsp;</b> </legend>
					 			<img alt="" src="images/mentor.png">
					 			<br>
					 			<br>
								<input type="button" value="미작성" disabled="disabled"/>
							</fieldset>	
		<%					
						}
					}
				}
			}
		%>
		 	
			</div>
		</div>
	</div>
	<footer>@ 2020 all copyrights reserved by 운토티</footer>
</body>
</html>