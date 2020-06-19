package member.profile.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import All.statics.Exercise;
import All.statics.Util;
import All.statics.join.LoginProfile.dto.LoginProfileDto;
import join.biz.JoinBiz;
import join.biz.JoinBizImpl;
import join.dto.JoinDto;
import member.board.biz.BoardBiz;
import member.board.biz.BoardBizlmpl;
import member.board.dto.BoardDto;
import member.match.biz.MatchBiz;
import member.match.biz.MatchBizImpl;
import member.match.dto.MatchDto;
import member.mentee.dayMenu.biz.DayMenuBiz;
import member.mentee.dayMenu.biz.DayMenuBizImpl;
import member.mentee.exercise.total.biz.TotalBiz;
import member.mentee.exercise.total.biz.TotalBizImpl;
import member.mentee.exercise.total.dto.TotalDto;
import member.profile.biz.ProfileBiz;
import member.profile.biz.ProfileBizImpl;
import member.profile.dto.ProfileDto;
import member.trade.biz.TradeBiz;
import member.trade.biz.TradeBizImpl;
import member.trade.dto.TradeDto;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProfileBiz profileBiz = null;
	private JoinBiz joinBiz = null;
	private MatchBiz matchBiz = null;
	private TradeBiz tradeBiz = null;
	private Exercise Exercise = new Exercise();

	public ProfileServlet() {
		profileBiz = new ProfileBizImpl();
		joinBiz = new JoinBizImpl();
		matchBiz = new MatchBizImpl();
		tradeBiz = new TradeBizImpl();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();

		String command = request.getParameter("command");
		System.out.println("profile Command : " + command);

		// 멘토 프로필 확인 페이지
		if (command.equals("mentorProfile")) {
			response.sendRedirect("MENTOR/MENTOR_mentorProfile.jsp");
			// 멘티 프로필 확인 페이지
		} else if (command.equals("menteeProfile")) {
			response.sendRedirect("MENTEE/MENTEE_menteeProfile.jsp");

			// 멘토 첫 가입시 프로필 추가
		} else if (command.equals("memberMentorInsertRes")) {
			JoinDto joinDto = (JoinDto) session.getAttribute("joinDto");

			// yyyy/dd/mm
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String date = request.getParameter("date");

			// id
			String id = joinDto.getId();
			// 등급
			String memberRole = request.getParameter("memberRole");
			// memberRegisterYn >>> 프로필 작성시 >>> "Y", JOIN_REGISTER_YN = "W" >>> 관리자 허가시
			// JOIN_REGISTER_YN = "Y"
			String memberRegisterYn = "Y";
			// 이름
			String memberName = request.getParameter("memberName");
			// yyyy/dd/mm
			String memberBirth = year + Util.isTwo(month) + Util.isTwo(date);
			// 키/몸무게
			double memberHeight = Integer.parseInt(request.getParameter("memberHeight"));
			double memberWeight = Integer.parseInt(request.getParameter("memberWeight"));
			// 주소
			String memberAddr = request.getParameter("memberAddr");
			// 전화번호
			String[] memberPhoneArr = request.getParameterValues("memberPhone");
			String memberPhone = memberPhoneArr[0] + "-" + memberPhoneArr[1] + "-" + memberPhoneArr[2];
			// 한 줄 소개
			String memberOneIntro = request.getParameter("memberOneIntro");
			// 코인
			int memberCoin = 0;
			// 태그(특기)
			String memberCareer = request.getParameter("memberCareer");
//			// 상세 경력  >>> 이미지
			String memberContent = "../images/mentor2.png";
			// 스코어 >> 보유멘티수
			double memberScore = 0;

			ProfileDto profileDto = new ProfileDto(id, memberRole, memberRegisterYn, memberName, memberBirth,
					memberHeight, memberWeight, memberAddr, memberPhone, memberOneIntro, memberCoin, memberCareer,
					memberContent, memberScore);
			System.out.println("멘토 프로필 : " + profileDto);

			int res = profileBiz.insertProfile_Mentor(profileDto);
			if (res > 0) {
				System.out.println("멘토 프로필 추가 성공");
				jsPrint("프로필 추가성공 다시 로그인 해주세요", "join.do?command=main", response);

				// 멘토는 성공적으로 프로필 작성시 join 테이블의 JOIN_REGISTER_YN의 값을 'W'로 바꾼다
				int update_res = joinBiz.updateJoinRegister(id, "W");
				if (update_res > 0) {
					System.out.println("멘토 JOIN_REGISTER_YN의 값 'W'로 변경완료");
					LoginProfileDto mentorDto = joinBiz.getLoginProfileDto_mentor(id);
					System.out.println(mentorDto.getId() + "/" + mentorDto.getJoinRegisterYn());
					session.setAttribute("mentorDto", mentorDto);
					session.setMaxInactiveInterval(60 * 60);

					jsPrint(profileDto.getMemberName() + "님 프로필 작성 성공", "join.do?command=mentorMain", response);
				}
			} else {
				System.out.println("멘토 프로필 추가 실패");
				jsPrint("프로필 작성 실패", "profile.do?command=memberMentorInsert", response);
			}

			// 멘티 첫 가입시 프로필 추가
		} else if (command.equals("memberMenteeInsertRes")) {
			JoinDto joinDto = (JoinDto) session.getAttribute("joinDto");

			// yyyy/dd/mm
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String date = request.getParameter("date");

			// id
			String id = joinDto.getId();
			// 등급
			String memberRole = request.getParameter("memberRole");
			//
			String memberRegisterYn = "Y";
			// 이름
			String memberName = request.getParameter("memberName");
			// yyyy/dd/mm
			String memberBirth = year + Util.isTwo(month) + Util.isTwo(date);
			// 키/몸무게
			double memberHeight = Integer.parseInt(request.getParameter("memberHeight"));
			double memberWeight = Integer.parseInt(request.getParameter("memberWeight"));
			// 주소
			String memberAddr = request.getParameter("memberAddr");
			// 전화번호
			String[] memberPhoneArr = request.getParameterValues("memberPhone");
			String memberPhone = memberPhoneArr[0] + "-" + memberPhoneArr[1] + "-" + memberPhoneArr[2];
			// 한 줄 소개
			String memberOneIntro = request.getParameter("memberOneIntro");
			// 성별
			String memberGender = request.getParameter("memberGender");
			// 활동량
			int memberActivity = Integer.parseInt(request.getParameter("memberActivity"));
			// 기초
			double memberBasal = Exercise.BMR(memberGender, memberHeight, memberWeight, year);
			// BMI
			double memberBmi = Exercise.BMI(memberHeight, memberWeight);
			
			String memberContent = "../images/meentee2.jpg";

			ProfileDto profileDto = new ProfileDto(id, memberRole, memberRegisterYn, memberName, memberBirth,
					memberHeight, memberWeight, memberAddr, memberPhone, memberOneIntro, memberGender, memberActivity,
					memberBasal, memberBmi, memberContent);
			System.out.println("멘티 프로필 : " + profileDto);

			int res = profileBiz.insertProfile_Mentee(profileDto);

			if (res > 0) { // 프로필 작성 성공 할 경우.
				System.out.println("멘티 프로필 추가 성공");
				// 멘티는 성공적으로 프로필 작성시 join 테이블의 JOIN_REGISTER_YN의 값을 'Y'로 바꾼다.
				int update_res = joinBiz.updateJoinRegister(id, "Y");

				if (update_res > 0) {
					System.out.println("멘티 JOIN_REGISTER_YN의 값 'Y'로 변경완료");
					LoginProfileDto menteeDto = joinBiz.getLoginProfileDto_mentee(id);
					session.setAttribute("menteeDto", menteeDto);
					session.setMaxInactiveInterval(60 * 60);
					System.out.println("join과 profile테이블 join한 dto로 session 세팅 완료");
					jsPrint(menteeDto.getMemberName() + "님 프로필 작성 성공", "join.do?command=menteeMain", response);
				}

			} else {
				System.out.println("멘티 프로필 추가 실패");
				jsPrint("프로필 작성 실패", "profile.do?command=memberMenteeInsert", response);
			}
			// 멘티 프로필 수정
		} else if (command.equals("memberMenteeUpdate")) {
			PrintWriter out = response.getWriter();
			String memberName = request.getParameter("memberName");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			if (month.length() == 1) {
				month = 0 + month;
			}
			String date = request.getParameter("date");
			if (date.length() == 1) {
				date = 0 + date;
			}
			String memberBirth = year + month + date;
			double memberHeight = Double.parseDouble(request.getParameter("memberHeight"));
			double memberWeight = Double.parseDouble(request.getParameter("memberWeight"));
			String memberAddr = request.getParameter("memberAddr");
			String memberPhone1 = request.getParameter("memberPhone1");
			String memberPhone2 = request.getParameter("memberPhone2");
			String memberPhone3 = request.getParameter("memberPhone3");
			String memberPhone = memberPhone1 + "-" + memberPhone2 + "-" + memberPhone3;
			System.out.println(memberPhone);
			String memberOneIntro = request.getParameter("memberOneIntro");
			String memberGender = request.getParameter("memberGender");
			int memberActivity = Integer.parseInt(request.getParameter("memberActivity"));
			// 기초
			double memberBasal = Exercise.BMR(memberGender, memberHeight, memberWeight, year);
			// BMI
			double memberBmi = Exercise.BMI(memberHeight, memberWeight);

			String id = request.getParameter("id");

			ProfileDto profileDto = new ProfileDto(memberName, memberBirth, memberHeight, memberWeight, memberAddr,
					memberPhone, memberOneIntro, memberGender, memberActivity, id, memberBasal, memberBmi);

			int res = profileBiz.updateProfile_Mentee(profileDto);
			if (res > 0) {
				System.out.println("정보 수정 완료");

				LoginProfileDto menteeDto = joinBiz.getLoginProfileDto_mentee(id);

				session.setAttribute("menteeDto", menteeDto);
				session.setMaxInactiveInterval(60 * 60);

				jsPrint("회원 정보 수정 완료", "MENTEE/CALENDAR/MENTEE_Main.jsp", response);

			} else {
				System.out.println("변경실패");
			}
			// 멘토 프로필 수정
		} else if (command.equals("memberMentorUpdate")) {
			// PrintWriter out = response.getWriter();
			String memberName = request.getParameter("memberName");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			if (month.length() == 1) {
				month = 0 + month;
			}
			String date = request.getParameter("date");
			if (date.length() == 1) {
				date = 0 + date;
			}
			String memberBirth = year + month + date;
			double memberHeight = Double.parseDouble(request.getParameter("memberHeight"));
			double memberWeight = Double.parseDouble(request.getParameter("memberWeight"));
			String memberAddr = request.getParameter("memberAddr");
			String memberPhone1 = request.getParameter("memberPhone1");
			String memberPhone2 = request.getParameter("memberPhone2");
			String memberPhone3 = request.getParameter("memberPhone3");
			String memberPhone = memberPhone1 + "-" + memberPhone2 + "-" + memberPhone3;
			String memberCareer = request.getParameter("memberCareer");
			String memberOneIntro = request.getParameter("memberOneIntro");
			String id = request.getParameter("id");

			ProfileDto profileDto = new ProfileDto(memberName, memberBirth, memberHeight, memberWeight, memberAddr,
					memberPhone, memberOneIntro, memberCareer, id);
			int res = profileBiz.updateProfile_Mentor(profileDto);
			if (res > 0) {
				System.out.println("아이디:" + id);
				System.out.println("정보 수정 완료");
				LoginProfileDto mentorDto = joinBiz.getLoginProfileDto_mentor(id);

				System.out.println("확인 : " + mentorDto);
				session.setAttribute("mentorDto", mentorDto);
				session.setMaxInactiveInterval(60 * 60);
				jsPrint("회원 정보 수정 완료", "MENTOR/MENTOR_mentorMain.jsp", response);

			} else {
				System.out.println("변경실패");
			}

			// 주소입력 api
		} else if (command.equals("Address")) {
			response.sendRedirect("MENTEE/MENTEE_menteeProfile_Address.jsp");

			/*
			 * 관리자
			 * =============================================================================
			 * ==================>>
			 */
			// 관리자 메인에서 검색
		} else if (command.equals("admin_MenberSearch")) {
			String search_type = request.getParameter("search_type");
			String search_text = request.getParameter("search_text");

			List<ProfileDto> profileDtoList = null;
			List<JoinDto> joinDtoList = null;
			System.out.println(search_type);
			System.out.println(search_text);

			// search_text ""경우 == search_text에 값을 안 넣었을 경우
			if (search_text.equals("")) {

				// 승인대기 / 미작성
				if (search_type.equals("All_N")) {
					joinDtoList = joinBiz.selectList_join();
					System.out.println("joinDtoList");
					request.setAttribute("list", joinDtoList);
					request.setAttribute("search_type", search_type);
					dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);
					// 멘토 승인 대기
				} else if (search_type.equals("mentorRegister_N")) {
					joinDtoList = joinBiz.selsList_Mentor_reN();
					request.setAttribute("list", joinDtoList);
					request.setAttribute("search_type", search_type);
					dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);
					// 멘티 프로필 미작성
				} else if (search_type.equals("menteeProfile_N")) {
					joinDtoList = joinBiz.selsList_Mentee_reN();
					request.setAttribute("list", joinDtoList);
					request.setAttribute("search_type", search_type);
					dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);
					// 프로필 등록 및 멘토 허가 된 모든 회원
				} else if (search_type.equals("All_Y")) {
					profileDtoList = profileBiz.selectList_Profile();
					request.setAttribute("list", profileDtoList);
					request.setAttribute("search_type", search_type);
					dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);
					// 멘토 허가된 멘토
				} else if (search_type.equals("멘토")) {
					profileDtoList = profileBiz.selectList_Mentor();
					request.setAttribute("list", profileDtoList);
					request.setAttribute("search_type", search_type);
					dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);
					// 프로필 작성한 멘티
				} else if (search_type.equals("멘티")) {
					profileDtoList = profileBiz.selectList_Mentee();
					request.setAttribute("list", profileDtoList);
					request.setAttribute("search_type", search_type);
					dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);

				}
				// search_text "" 아닌경우
			} else if (!(search_text.equals(""))) {

				// 전체에서 id으로 검색
				if (search_type.equals("All_N")) {
					joinDtoList = joinBiz.selectList_join(search_text);
					request.setAttribute("list", joinDtoList);
					request.setAttribute("search_type", search_type);
					dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);
					// 멘토 승인 대기 id로 검색
				} else if (search_type.equals("mentorRegister_N")) {
					joinDtoList = joinBiz.selsList_Mentor_reN(search_text);
					request.setAttribute("list", joinDtoList);
					request.setAttribute("search_type", search_type);
					dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);
					// 멘티 프로필 미작성 id로 검색
				} else if (search_type.equals("menteeProfile_N")) {
					joinDtoList = joinBiz.selsList_Mentee_reN(search_text);
					request.setAttribute("list", joinDtoList);
					request.setAttribute("search_type", search_type);
					dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);
					// 멘토/멘티에서 이름으로 검색
				} else if (search_type.equals("All_Y")) {
					profileDtoList = profileBiz.search_Mentor(search_text);
					request.setAttribute("list", profileDtoList);
					request.setAttribute("search_type", search_type);
					dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);
					// 멘토에서 이름으로 검색
				} else if (search_type.equals("멘토")) {
					profileDtoList = profileBiz.search_Mentor(search_text);
					request.setAttribute("list", profileDtoList);
					request.setAttribute("search_type", search_type);
					dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);
					// 멘티에서 이름으로 검색
				} else if (search_type.equals("멘티")) {
					profileDtoList = profileBiz.search_Memtee(search_text);
					request.setAttribute("list", profileDtoList);
					request.setAttribute("search_type", search_type);
					dispacher("ADMIN/ADMIN_adminMain.jsp", request, response);
				}
			}

			// 승인대기 멘토 팝업
		} else if (command.equals("admin_mentorWait")) {
			String id = request.getParameter("id");
			LoginProfileDto loginProfileDto = joinBiz.getLoginProfileDto_mentor(id);
			request.setAttribute("loginProfileDto", loginProfileDto);
			dispacher("ADMIN/mentor/ADMIN_mentorWait.jsp", request, response);
			// 멘토 승인 Y로 변경
		} else if (command.equals("mentorApprove")) {
			String id = request.getParameter("id");

			int res = joinBiz.updateJoinRegister(id, "Y");
			if (res > 0) {
				System.out.println("멘토 승인 완료");

				PrintWriter out = response.getWriter();
				String s = "<script type='text/javascript'> " + "alert('멘토 승인!!'); "
						+ "opener.window.location.reload(); " // 부모창 새로고침
						+ "close();" + "</script>";
				out.print(s);
			}
			// 관리자에서 멘토, 멘티 상세보기
		} else if (command.equals("admin_MemberSearchDetail")) {
			String memberRole = request.getParameter("memberRole");
			String id = request.getParameter("id");
			BoardBiz boardBiz = new BoardBizlmpl();

			if (memberRole.equals("멘토")) {
				LoginProfileDto memberMentorDto = joinBiz.getLoginProfileDto_mentor(id);
				// 해당 멘토 작성 게시판 리스트
				List<BoardDto> boardList = boardBiz.selectOneId_Board(id);

				// 해당 멘토 결제 내역 리스트
				List<TradeDto> tradeList = tradeBiz.selectList_oneMentor(id);

				// 멘토가 관리하는 멘티 리스트
				List<MatchDto> matchList = matchBiz.search_Mentor_Mentee(id);

				// 멘토의 가 관리하는 멘티의 정보를 담을 리스트
				List<ProfileDto> menteeList = new ArrayList<ProfileDto>();

				// 맨티의 id로 멘티 정보를 하나하나 찾아서 가져온다.
				for (MatchDto matchDto : matchList) {
					ProfileDto profileDto = profileBiz.getProfile(matchDto.getMatchMenteeId());
					menteeList.add(profileDto);
				}

				request.setAttribute("tradeList", tradeList);
				request.setAttribute("memberMentorDto", memberMentorDto); // 불러올 맨토 정보
				request.setAttribute("boardList", boardList); // 해당 맨토가 작성한 게시물
				request.setAttribute("menteeList", menteeList); // 해당 맨토가 관리하는 멘티들 정보
				dispacher("ADMIN/mentor/ADMIN_SearchMentorDetail.jsp", request, response);

			} else if (memberRole.equals("멘티")) {
				// 해당 멘티 정보
				LoginProfileDto memberMenteeDto = joinBiz.getLoginProfileDto_mentee(id);
				// 해당 멘티 작성 게시판 리스트
				List<BoardDto> boardList = boardBiz.selectOneId_Board(id);
				// 해당 멘티 결제 내역 리스트
				List<TradeDto> tradeList = tradeBiz.selectList_oneMenteeAM(id);

				request.setAttribute("memberMenteeDto", memberMenteeDto);
				request.setAttribute("boardList", boardList);
				request.setAttribute("tradeList", tradeList);
				dispacher("ADMIN/mentee/ADMIN_SearchMenteeDetail.jsp", request, response);
			}
			// 관리자 끝

			// 멘토에서 멘티기록 가져오기
		} else if (command.equals("mentor_menteeList")) {
			LoginProfileDto mentorDto = (LoginProfileDto) session.getAttribute("mentorDto");
			List<MatchDto> matchList = matchBiz.search_Mentor_Mentee(mentorDto.getId());

			// 멘토의 가 관리하는 멘티의 정보를 담을 리스트
			List<ProfileDto> menteeList = new ArrayList<ProfileDto>();

			// 맨티의 id로 멘티 정보를 하나하나 찾아서 가져온다.
			for (MatchDto matchDto : matchList) {
				ProfileDto profileDto = profileBiz.getProfile(matchDto.getMatchMenteeId());
				menteeList.add(profileDto);
			}

			request.setAttribute("menteeList", menteeList);
			dispacher("MENTOR/MENTOR_menteeList.jsp", request, response);

			// 멘토에서 수익내역
		} else if (command.equals("mentor_profit")) {
			LoginProfileDto mentorDto = (LoginProfileDto) session.getAttribute("mentorDto");
			List<TradeDto> tradeList = tradeBiz.selectList_oneMentor(mentorDto.getId());
			int cPage;

			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {
				cPage = 1;
			}
			int numPerPage;
			try {
				numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
			} catch (NumberFormatException e) {
				numPerPage = 3;
			}
			List<TradeDto> pagingList = tradeBiz.selectPagingList_oneMentor(mentorDto.getId(), cPage, numPerPage);

			int totalMember = tradeList.size();

			int totalPage = (int) Math.ceil((double) totalMember / numPerPage);

			String pageBar = "";
			int pageBarSize = 3;
			int pageNo = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
			int pageEnd = pageNo + pageBarSize - 1;

			if (pageNo == 1) {
				pageBar += "<span>[이전]</span>";
			} else {
				pageBar += "<a href='profile.do?command=mentor_profit&cPage=" + (pageNo - 1) + "&numPerPage="
						+ numPerPage + "'>[이전]</a>";
			}
			while (!(pageNo > pageEnd || pageNo > totalPage)) {
				if (cPage == pageNo) {
					pageBar += "<span class='cPage'>" + pageNo + "</span>";
				} else {
					pageBar += "<a href='profile.do?command=mentor_profit&cPage=" + (pageNo) + "&numPerPage="
							+ numPerPage + "'>" + pageNo + "</a>";
				}
				pageNo++;
			}
			if (pageNo > totalPage) {
				pageBar += "<span>[다음]</span>";
			} else {
				pageBar += "<a href='profile.do?command=mentor_profit&cPage=" + pageNo + "&numPerPage=" + numPerPage
						+ "'>[다음]</a>";
			}

			request.setAttribute("tradeList", pagingList);
			request.setAttribute("cPage", cPage);
			request.setAttribute("numPerPage", numPerPage);
			request.setAttribute("pageBar", pageBar);
			dispacher("MENTOR/MENTOR_mentorProfit.jsp", request, response);
		} else if (command.equals("getChart")) {
			/*
			 * 차트 그릴 때 필요한 애들 보내주자 1. 총 섭취 칼로리 (getCalorieChartView) 2. 오늘 섭취 칼로리
			 * (getTodayCal(date)) 3. 내 기초 대사량 (getInBody) 4. 총 체중 (getWeightChartView) 5.
			 * 오늘 체중 (getTodayWeight(date)) 6. 내 BMI 지수 (getInBody) 7. 내 영양소 비율
			 * (getNutrientChartView) 8. 총 운동 소모 칼로리 (getExerciseChartView) 9. 오늘 운동 소모 칼로리
			 * + 시간 (getTodayTotal(date))
			 * 
			 * 
			 */

			// 아이디
			LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
			String id = menteeDto.getId();

			// 프로필
			ProfileDto getProfile = profileBiz.getProfile(id);
			request.setAttribute("memberName", getProfile.getMemberName());
			System.out.println(getProfile.getMemberName());

			// 오늘 날짜 yyyyMMdd
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Date today = new Date();
			String date = formatter.format(today);
			System.out.println("[date] : " + date);

			// 1. 총 섭취 칼로리
			DayMenuBiz menuBiz = new DayMenuBizImpl();
			JSONArray getCalorieChartView = menuBiz.getCalorieChartView(id);
			request.setAttribute("getCalorieChartView", getCalorieChartView);
			System.out.println("[1. 총 섭취 칼로리 getCalorieChartView] : " + getCalorieChartView);
			// 2.오늘 섭취 칼로리
			double getTodayCal = menuBiz.getTodayCal(id, date);
			System.out.println("[2. 오늘 섭취 칼로리 getTodayCal] : " + getTodayCal);
			request.setAttribute("getTodayCal", getTodayCal);
			// 3.내 기초 대사량
			double getBasal = getProfile.getMemberBasal();
			request.setAttribute("getBasal", getBasal);
			System.out.println("[3. 내 기초대사량 getBasal] : " + getBasal);
			// 4.총 체중
			TotalBiz totalBiz = new TotalBizImpl();
			JSONArray getWeightChartView = totalBiz.getWeightChartView(id);
			request.setAttribute("getWeightChartView", getWeightChartView);
			System.out.println("[4. 총 체중 getWeightChartView] : " + getWeightChartView);
			// 5.오늘 체중
			double getTodayWeight = totalBiz.getTodayWeight(id, date);
			request.setAttribute("getTodayWeight", getTodayWeight);
			System.out.println("[5. 오늘 체중 getTodayWeight] : " + getTodayWeight);
			// 6.내 BMI 지수
			ProfileDto profileDto = profileBiz.getProfile(id);
			double getBmi = profileDto.getMemberBmi();
			request.setAttribute("getBmi", getBmi);
			System.out.println("[6. 내 BMI 지수 getBmi] : " + getBmi);
			// 7.내 영양소 비율
			JSONArray getNutrientChartView = menuBiz.getNutrientChartView(id, date);
			request.setAttribute("getNutrientChartView", getNutrientChartView);
			System.out.println("[7. 내 영양소 비율 getNutrientChartView] : " + getNutrientChartView);
			// 8.총 운동 소모 칼로리
			JSONArray getExerciseChartView = totalBiz.getExerciseChartView(id);
			request.setAttribute("getExerciseChartView", getExerciseChartView);
			System.out.println("[8. 총 운동 소모 칼로리 getExerciseChartView] : " + getExerciseChartView);
			// 9.오늘 운동 소모 칼로리, 시간
			TotalDto totalDto = totalBiz.getTodayTotal(id, date);
			double getCalorie = 0.0;
			String getTime = "";

			if (totalBiz.getTodayTotal(id, date) == null) {
				getCalorie = 0.0;
				getTime = "";
			} else {
				getCalorie = totalDto.getTotalCalorie();
				getTime = totalDto.getTotalTime();
			}

			request.setAttribute("getCalorie", getCalorie);
			request.setAttribute("getTime", getTime);
			System.out.println("[9. 운동 소모 칼로리 getCalorie] : " + getCalorie);
			System.out.println("[9. 운동 소모 시간getTime] : " + getTime);

			dispacher("MENTEE/CHART/MENTEE_Chart.jsp", request, response);

			// 1, 3, 6개월 범위에 따라 차트 응답
		} else if (command.equals("getChartMonth")) {
			/*
			 * 1. getCalorieChartViewOne 4. getWieghtChartChartViewOne 8.
			 * getExerciseChartViewOne
			 */

			// 아이디
			LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
			String id = menteeDto.getId();
			int month = Integer.parseInt(request.getParameter("month"));
			PrintWriter out = response.getWriter();

			// 1. 총 섭취 칼로리
			DayMenuBiz menuBiz = new DayMenuBizImpl();
			JSONArray getCalorieChartViewM = menuBiz.getCalorieChartViewM(id, month);

			// 4.총 체중
			TotalBiz totalBiz = new TotalBizImpl();
			JSONArray getWeightChartViewM = totalBiz.getWeightChartViewM(id, month);

			// 8.총 운동 소모 칼로리
			JSONArray getExerciseChartViewM = totalBiz.getExerciseChartViewM(id, month);
			System.out.println("[범위지정 !!8. 총 운동 소모 칼로리 getExerciseChartView] : " + getExerciseChartViewM);

			// 1, 4, 8 다시 JSONArray 에 담아서 JSON 형태로 ajax에 응답해주자.
			JSONArray arr = new JSONArray();
			JSONObject obj = new JSONObject();

			obj.put("getCalorieChartViewM", getCalorieChartViewM);
			obj.put("getWeightChartViewM", getWeightChartViewM);
			obj.put("getExerciseChartViewM", getExerciseChartViewM);
			arr.add(obj);

			System.out.println(arr);
			arr.write(out);

			// 폰번호 중복검사
		} else if (command.equals("PhoneNumberCheck")) {
			String PhoneNumber = request.getParameter("PhoneNumber");
			System.out.println(PhoneNumber);
			boolean isPhoneNumbercheck = profileBiz.phoneCheck(PhoneNumber);
			PrintWriter out = response.getWriter();
			if (isPhoneNumbercheck) {
				out.print("fail");
			} else {
				out.print("ok");
			}
			// 내 멘티 차트 보여주자
		} else if (command.equals("getMenteeChart")) {
			// 멘티 아이디
			String id = request.getParameter("id");
			request.setAttribute("id", id);
			// 프로필
			ProfileDto getProfile = profileBiz.getProfile(id);
			request.setAttribute("memberName", getProfile.getMemberName());
			System.out.println(getProfile.getMemberName());

			// 오늘 날짜 yyyyMMdd
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Date today = new Date();
			String date = formatter.format(today);
			System.out.println("[date] : " + date);

			// 1. 총 섭취 칼로리
			DayMenuBiz menuBiz = new DayMenuBizImpl();
			JSONArray getCalorieChartView = menuBiz.getCalorieChartView(id);
			request.setAttribute("getCalorieChartView", getCalorieChartView);
			System.out.println("[1. 총 섭취 칼로리 getCalorieChartView] : " + getCalorieChartView);
			// 2.오늘 섭취 칼로리
			double getTodayCal = menuBiz.getTodayCal(id, date);
			System.out.println("[2. 오늘 섭취 칼로리 getTodayCal] : " + getTodayCal);
			request.setAttribute("getTodayCal", getTodayCal);
			// 3.내 기초 대사량
			double getBasal = getProfile.getMemberBasal();
			request.setAttribute("getBasal", getBasal);
			System.out.println("[3. 내 기초대사량 getBasal] : " + getBasal);
			// 4.총 체중
			TotalBiz totalBiz = new TotalBizImpl();
			JSONArray getWeightChartView = totalBiz.getWeightChartView(id);
			request.setAttribute("getWeightChartView", getWeightChartView);
			System.out.println("[4. 총 체중 getWeightChartView] : " + getWeightChartView);
			// 5.오늘 체중
			double getTodayWeight = totalBiz.getTodayWeight(id, date);
			request.setAttribute("getTodayWeight", getTodayWeight);
			System.out.println("[5. 오늘 체중 getTodayWeight] : " + getTodayWeight);
			// 6.내 BMI 지수
			ProfileDto profileDto = profileBiz.getProfile(id);
			double getBmi = profileDto.getMemberBmi();
			request.setAttribute("getBmi", getBmi);
			System.out.println("[6. 내 BMI 지수 getBmi] : " + getBmi);
			// 7.내 영양소 비율
			JSONArray getNutrientChartView = menuBiz.getNutrientChartView(id, date);
			request.setAttribute("getNutrientChartView", getNutrientChartView);
			System.out.println("[7. 내 영양소 비율 getNutrientChartView] : " + getNutrientChartView);
			// 8.총 운동 소모 칼로리
			JSONArray getExerciseChartView = totalBiz.getExerciseChartView(id);
			request.setAttribute("getExerciseChartView", getExerciseChartView);
			System.out.println("[8. 총 운동 소모 칼로리 getExerciseChartView] : " + getExerciseChartView);
			// 9.오늘 운동 소모 칼로리, 시간
			TotalDto totalDto = totalBiz.getTodayTotal(id, date);
			double getCalorie = 0.0;
			String getTime = "";

			if (totalBiz.getTodayTotal(id, date) == null) {
				getCalorie = 0.0;
				getTime = "";
			} else {
				getCalorie = totalDto.getTotalCalorie();
				getTime = totalDto.getTotalTime();
			}

			request.setAttribute("getCalorie", getCalorie);
			request.setAttribute("getTime", getTime);
			System.out.println("[9. 운동 소모 칼로리 getCalorie] : " + getCalorie);
			System.out.println("[9. 운동 소모 시간getTime] : " + getTime);

			dispacher("MENTOR/CHART/MENTOR_GetMenteeChart.jsp", request, response);
			//내 멘티도 기간별로 보여주자
		} else if (command.equals("getMenteeChartM")) {
			// 아이디
			String id = request.getParameter("id");
			int month = Integer.parseInt(request.getParameter("month"));
			PrintWriter out = response.getWriter();

			// 1. 총 섭취 칼로리
			DayMenuBiz menuBiz = new DayMenuBizImpl();
			JSONArray getCalorieChartViewM = menuBiz.getCalorieChartViewM(id, month);

			// 4.총 체중
			TotalBiz totalBiz = new TotalBizImpl();
			JSONArray getWeightChartViewM = totalBiz.getWeightChartViewM(id, month);

			// 8.총 운동 소모 칼로리
			JSONArray getExerciseChartViewM = totalBiz.getExerciseChartViewM(id, month);

			// 1, 4, 8 다시 JSONArray 에 담아서 JSON 형태로 ajax에 응답해주자.
			JSONArray arr = new JSONArray();
			JSONObject obj = new JSONObject();

			obj.put("getCalorieChartViewM", getCalorieChartViewM);
			obj.put("getWeightChartViewM", getWeightChartViewM);
			obj.put("getExerciseChartViewM", getExerciseChartViewM);
			arr.add(obj);

			System.out.println(arr);
			arr.write(out);
		}else if(command.equals("image")) {
	    	  String idSub1 = request.getParameter("idSub1");
	    	  String idSub2 = request.getParameter("idSub2");
	    	  
	    	  String id = idSub1+idSub2;
	    	  
	    	  System.out.println("id확인"+id);
	    	  dispacher("image.jsp", request, response);
	      }else if(command.equals("ImgRes")) {
	    	  
	    	  LoginProfileDto mentorDto1 = (LoginProfileDto)session.getAttribute("mentorDto");
	    	  LoginProfileDto menteeDto1 = (LoginProfileDto)session.getAttribute("menteeDto");
	    	  String Role = "";
	    	  
	    	  if(mentorDto1  != null) {
	    		   Role = "멘토";  
	    	  }else if(menteeDto1 != null) {
	    		   Role = "멘티";
	    	  }
	    	   
	    	  String id = request.getParameter("id");
	    	  
	    	  String src = request.getParameter("src");
	    	  System.out.println(src);
	    	  System.out.println(id);
	    	  
	    	  ProfileBiz profilebiz = new ProfileBizImpl();
	    	  ProfileDto profileDto = new ProfileDto();
	    	  profileDto.setId(id);
	    	  profileDto.setMemberContent(src);
	    	  //
	    	  
	    	  int res = profilebiz.UpdateSrc_Mentor(profileDto);
	    	  if(res > 0) {
	    		  if(Role.equals("멘토")) {
	    			  LoginProfileDto mentorDto = joinBiz.getLoginProfileDto_mentor(id);
	    			  session.setAttribute("mentorDto", mentorDto);
	    		  }else if (Role.equals("멘티")) {
	    			  LoginProfileDto menteeDto = joinBiz.getLoginProfileDto_mentee(id);
	    			  session.setAttribute("menteeDto", menteeDto);	
	    		  }
	    		  
	    	  }
	    	  System.out.println(res);
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
