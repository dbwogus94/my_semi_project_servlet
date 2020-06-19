package join.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import All.statics.join.LoginProfile.dto.LoginProfileDto;
import join.biz.JoinBiz;
import join.biz.JoinBizImpl;
import join.dto.JoinDto;
import member.match.biz.MatchBiz;
import member.match.biz.MatchBizImpl;
import member.match.dto.MatchDto;
import member.profile.biz.ProfileBiz;
import member.profile.biz.ProfileBizImpl;
import member.profile.dto.ProfileDto;

/**
 * Servlet implementation class JoinServlet
 */
@WebServlet("/JoinServlet")
public class JoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private JoinBiz joinBiz = null;
	private ProfileBiz profileBiz = null;
	private MatchBiz matchBiz = null;

	public JoinServlet() {
		joinBiz = new JoinBizImpl();
		profileBiz = new ProfileBizImpl();
		matchBiz = new MatchBizImpl();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession(); // 새션생성 
		

		String command = request.getParameter("command");
		System.out.println("join Command : " + command);

		if (command.equals("main")) {
			response.sendRedirect("Main.jsp");
			// 로그인 페이지
		} else if (command.equals("loginPopUp")) {
			response.sendRedirect("LOGIN_LoginPopUp.jsp");
			// 회원가입 페이지
		} else if (command.equals("loginSingUp")) {
			response.sendRedirect("LOGIN_LoginSignUp.jsp");

			// 회원가입 결과
		} else if (command.equals("loingSingUpRes")) {
			String joinRole = request.getParameter("joinRole");
			String id = request.getParameter("id");
			String joinEmail = request.getParameter("joinEmail");
			String joinPw = request.getParameter("joinPw");
			JoinDto joinDto = new JoinDto(id, joinPw, joinEmail, joinRole);
			System.out.println("dto : " + joinDto);

			int res = joinBiz.insertMember(joinDto);
			if (res > 0) {
				System.out.println("회원가입 성공");
				// 팝업을 종료하고 메인창으로 이동
				jsPrint("가입 성공!", "join.do?command=main", response);
			} else {
				System.out.println("회원가입 실패");
				// 해당 팝업창에서 다시 회원가입을 띄운다
				jsPrint("회원가입 실패!", "join.do?command=loginSingUp", response);
			}

			// 카카오 구글 회원가입 joinPw를 kakako 또는 google으로 준다.
		} else if (command.equals("loingSingUpRes_API")) {
			String joinRole = request.getParameter("joinRole");
			String id = request.getParameter("id");
			String joinEmail = request.getParameter("joinEmail");
			String joinPw = request.getParameter("API");
			JoinDto joinDto = new JoinDto(id, joinPw, joinEmail, joinRole);
			System.out.println("dto : " + joinDto);

			int res = joinBiz.insertMember(joinDto);
			if (res > 0) {
				System.out.println("회원가입 성공");

				// 팝업을 종료하고 메인창으로 이동
				jsPrint("가입 성공!", "join.do?command=main", response);
			} else {
				System.out.println("회원가입 실패");
				// 해당 팝업창에서 다시 회원가입을 띄운다
				jsPrint("회원가입 실패!", "join.do?command=loginSingUp", response);
			}

			// 로그인
		} else if (command.equals("loginCheck")) {
			String id = request.getParameter("id");
			String joinPw = request.getParameter("joinPw");
			JoinDto joinDto = joinBiz.Login(id, joinPw);
			System.out.println(joinDto);

			// 로그인 성공시
			if (joinDto != null) {
				System.out.println("Login 성공");
				System.out.println(joinDto);

				if (joinDto.getJoinRole().equals("관리")) {
					session.setAttribute("joinDto", joinDto); // 관리자는 joinDto를 session에 사용
					session.setMaxInactiveInterval(10 * 60);
					String search_type = "All_Y"; // 셀렉트 값
					List<ProfileDto> profineDto = profileBiz.selectList_Profile();
					request.setAttribute("search_type", search_type);
					request.setAttribute("list", profineDto);
					jsPrint("관리자 계정 로그인", "join.do?command=adminMain", response);

				} else if (joinDto.getJoinRole().equals("멘티")) {
					if (joinDto.getJoinRegisterYn().equals("N")) { // 프로필이 작성되어 있지 않다면 >> 프로필 작성으로
						session.setAttribute("joinDto", joinDto);
						session.setMaxInactiveInterval(10 * 60);
						jsPrint("아이디 : " + joinDto.getId() + " 멘티님 첫 방문을 환영합니다.", "join.do?command=menteeFirstProfile",
								response);

					} else { // 프로필을 작성하였다면 >>> 멘티 메인으로
						// 로그인한 id를 통하여 멘티의
						LoginProfileDto menteeDto = joinBiz.getLoginProfileDto_mentee(id);
						System.out.println("menteeDto : " + menteeDto);
						session.setAttribute("menteeDto", menteeDto);
						session.setMaxInactiveInterval(60 * 60);

						// 멘티 메인으로 화면전환
						jsPrint(menteeDto.getMemberName() + " 멘티님 환영합니다.", "join.do?command=menteeMain", response);
					}

				} else if (joinDto.getJoinRole().equals("멘토")) {

					if (joinDto.getJoinRegisterYn().equals("N")) { // 프로필이 작성되어 있지 않다면 >> 프로필 작성으로
						session.setAttribute("joinDto", joinDto);
						session.setMaxInactiveInterval(10 * 60);
						jsPrint("아이디 : " + joinDto.getId() + " 멘토님 첫 방문을 환영합니다.", "join.do?command=mentorFirstProfile",
								response);
					} else {
						LoginProfileDto mentorDto = joinBiz.getLoginProfileDto_mentor(id);
						System.out.println("mentorDto : " + mentorDto);
						session.setAttribute("mentorDto", mentorDto);
						session.setMaxInactiveInterval(60 * 60);

						// 멘토 메인으로 화면전환
						jsPrint(mentorDto.getMemberName() + " 멘토님 환영합니다.", "join.do?command=mentorMain", response);
					}
				}
			} else {
				jsPrint("로그인 실패", "join.do?command=main", response);
			}

			// 각 로그인시 각각 메인 페이지 이동
		} else if (command.equals("adminMain")) { // 관리자 페이지
			ProfileBiz profileBiz = new ProfileBizImpl();
			List<ProfileDto> list = profileBiz.selectList_Profile();;
			String search_type = "All_Y";
			request.setAttribute("search_type", search_type);
			request.setAttribute("list", list);
			dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);
			response.sendRedirect("ADMIN/ADMIN_adminMain.jsp");

			// 멘티 메인
		} else if (command.equals("menteeMain")) {
			response.sendRedirect("MENTEE/CALENDAR/MENTEE_Main.jsp");
			// 멘토 메인
		} else if (command.equals("mentorMain")) {
			LoginProfileDto mentorDto = (LoginProfileDto)session.getAttribute("mentorDto");
			// 로그인한 멘토가 관리하는 멘티 숫자
			int countMentee = matchBiz.search_Mentor_Mentee(mentorDto.getId()).size();
			
			request.setAttribute("countMentee", countMentee);
			dispacher("MENTOR/MAIN/MENTOR_Main.jsp", request, response);

			// 첫 로그인시 첫 프로필 작성화면 이동
		} else if (command.equals("menteeFirstProfile")) {
			response.sendRedirect("MENTEE/MENTEE_menteeFirstProfile.jsp");
		} else if (command.equals("mentorFirstProfile")) {
			response.sendRedirect("MENTOR/MENTOR_mentorFirstProfile.jsp");

			// 이메일 인증
		} else if (command.equals("emailChk")) {
			response.sendRedirect("emailChk.jsp");

			// id 중복확인 Ajax
		} else if (command.equals("idCheck")) {
			String id = request.getParameter("id");
			boolean isIdCheck = joinBiz.idCheck(id);

			PrintWriter out = response.getWriter();
			if (isIdCheck) {
				String res = "fail";
				out.print(res);
			} else {
				out.print("ok");
			}
			// email 중복확인 Ajax
		} else if (command.equals("emailCheck")) {
			String joinEmail = request.getParameter("email");
			boolean isEmailcheck = joinBiz.emailCheck(joinEmail);
			PrintWriter out = response.getWriter();

			if (isEmailcheck) {
				out.print("fail");
			} else {
				out.print("ok");
			}

			// 카카오 로그인 회원가입 페이지
		} else if (command.equals("kakaoSingUp")) {
			response.sendRedirect("LOGIN_kakao_LoginSignUp.jsp");
			// 구글 로그인 회원가입 페이지
		} else if (command.equals("googleSingUp")) {
			response.sendRedirect("LOGIN_google_LoginSignUp.jsp");
			// 비밀번호 이동
		} else if (command.equals("passwordChange")) {
			String id = request.getParameter("id");
			JoinDto JoinDto = joinBiz.passwordChange(id);
			request.setAttribute("JoinDto", JoinDto);
			dispacher("PasswordChange.jsp", request, response);

			// 비밀번호 변경 결과
		} else if (command.equals("PasswordChangeRes")) {
			PrintWriter out = response.getWriter();

			String ChangePW = request.getParameter("ChangePW");
			String id = request.getParameter("id");
			int res = joinBiz.updatePassword(id, ChangePW);
			if (res > 0) {

				System.out.println("변경성공");
				// jsPrint("비밀번호 변경 완료", "join.do?command=main", response);
				String str = "";
				str = "<script language='javascript'>";
				str += "self.close();";
				str += "alert('다시 로그인 해주세요.');";
				str += "</script>";
				out.print(str);
			} else {
				System.out.println("변경실패");
			}
			// 회원탈퇴
		} else if (command.equals("leave")) {
			PrintWriter out = response.getWriter();
			String id = request.getParameter("id");
			int res = joinBiz.updateLeave(id);
			if (res > 0) {
				System.out.println("회원탈퇴성공");
				String str = "";
				str = "<script language='javascript'>";
				str += "alert('회원탈퇴성공');";
				str += "location.href='./join.do?command=main'";
				str += "</script>";
				out.print(str);
			} else {
				System.out.println("회원탈퇴실패");
			}
			// id 찾기 이동
		} else if (command.equals("IdSearch")) {
			response.sendRedirect("IdSearch.jsp");
			// id 찾기 결과
		} else if (command.equals("IdSearchRes")) {
			String s = "";
			PrintWriter out = response.getWriter();
			String email = request.getParameter("email");
			JoinDto JoinDto = joinBiz.IdSearch(email);
			boolean emailChk = joinBiz.emailCheck(email);
			if (emailChk) {
				s += "<html>" + "<body>" + "<h1>" + "ID: " + JoinDto.getId() + "</h1>" + "</body>" + "</html>";
				out.print(s);
			} else {
				s += "<script type='text/javascript'> " + "alert('" + "일치하는 아이디가 없습니다." + "'); "
						+ "location='join.do?command=IdSearch'" + "</script>";
				out.print(s);

			}
			// pw찾기 이동
		} else if (command.equals("PwSearch")) {
			response.sendRedirect("PwSearch.jsp");
			// pw찾기
		} else if (command.equals("PwSearchId")) {
			String id = request.getParameter("id");
			String email = request.getParameter("email");

			boolean PwCheck = joinBiz.PwCheck(id, email);

			PrintWriter out = response.getWriter();
			if (PwCheck) { // PwCheck == true 등록된 이메일이 있음
				out.print("ok"); //
			} else {
				out.print("fail");
			}
			// pw찾기 결과
		} else if (command.equals("PwSearchRes")) {
			String id = request.getParameter("id");
			String email = request.getParameter("email");
			JoinDto joinDto = joinBiz.PwInfo(id);
			request.setAttribute("joinDto", joinDto);
			dispacher("PwSearchEmail.jsp", request, response);
			// 멘티에서 채팅 접근
			// 멘티에서 채팅 접근
		} else if (command.equals("chat_mentee")) {
			LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
			String menteeId = menteeDto.getId();
			String myRole = "mentee";
			System.out.println(menteeId);
			System.out.println("롤 : " + myRole);

			MatchDto matchDto = matchBiz.search_Mentee_Mentor__All(menteeId);
			System.out.println("매치dto" + matchDto);

			String mentorId = matchDto.getMatchMentorId(); // 맨토 id
			String matchNo = matchDto.getMatchNo() + "";

			System.out.println("멘티 id " + menteeId);
			System.out.println("멘티 매치no " + matchNo);

			response.sendRedirect("http://192.168.110.232:8010/?myRole=" + myRole + "&myId=" + menteeId + "&otherId="
					+ mentorId + "&matchNo=" + matchNo);

			// 멘토 채팅 접근
		} else if (command.equals("chat_mentor")) {
			LoginProfileDto mentorDto = (LoginProfileDto) session.getAttribute("mentorDto");
			String mentorId = mentorDto.getId();
			String myRole = "mentor";
			System.out.println("롤 : " + myRole);

			List<MatchDto> menteeIdList = matchBiz.search_Mentor_Mentee_All(mentorId);

			String[] menteeIdArr = new String[menteeIdList.size()];
			String[] matchNoArr = new String[menteeIdList.size()];

			String menteeId_json = "";
			String No_json = "";
			for (int i = 0; i < menteeIdList.size(); i++) {
				menteeIdArr[i] = menteeIdList.get(i).getMatchMenteeId();
				matchNoArr[i] = menteeIdList.get(i).getMatchNo() + "";
				if (i == 0) {
					menteeId_json += menteeIdArr[i];
					No_json += matchNoArr[i];
				} else {
					menteeId_json += "," + menteeIdArr[i];
					No_json += "," + matchNoArr[i];
				}
				// String menteeIdArr = id1, id2;
				// String matchNoArr = "1", "2";
			}

			System.out.println(
					"멘토 >> 체팅 멘토 아이디 : " + mentorId + ", 멘티id 정보 : " + menteeId_json + ", 메치시퀀스번호 : " + No_json);
			response.sendRedirect("http://192.168.110.232:8010/?myRole=" + myRole + "&myId=" + mentorId + "&otherId_json="
					+ menteeId_json + "&No_json=" + No_json);
		}

	}

	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		doGet(request, response);
	}

	// js 알림창 뜨고 화면 전환
	private void jsPrint(String msg, String url, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String s = "<script type='text/javascript'> " + "alert('" + msg + "'); " + "location='" + url + "'; "
				+ "</script>";
		out.print(s);
	}

	// 알람 후 팝업창 종료 화면 전환
	private void jsPupUpClose(String msg, String url, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String s = "<script type='text/javascript'> " + "alert('" + msg + "'); " + "window.close(); "
				+ "window.opener.location.href=" + "'" + url + "'; " + "</script>";
		out.print(s);
	}

	private void dispacher(String url, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispacher = request.getRequestDispatcher(url);
		dispacher.forward(request, response);
	}

}
