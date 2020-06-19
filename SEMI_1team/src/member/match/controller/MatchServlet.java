package member.match.controller;

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
import member.match.biz.MatchBiz;
import member.match.biz.MatchBizImpl;
import member.match.dto.MatchDto;
import member.profile.biz.ProfileBiz;
import member.profile.biz.ProfileBizImpl;
import member.profile.dto.ProfileDto;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class MatchServlet
 */
@WebServlet("/MatchServlet")
public class MatchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MatchBiz MatchBiz = null;

	public MatchServlet() {
		MatchBiz = new MatchBizImpl();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		HttpSession session = request.getSession();
		String command = request.getParameter("command");
		System.out.println("Match Command : " + command);

		if (command.equals("mentor_menteeList")) {
			String mentorID = request.getParameter("mentorID");
			System.out.println(mentorID);
			List<MatchDto> list = MatchBiz.search_Mentor_Mentee(mentorID);
			request.setAttribute("list", list);
			for (int i = 0; i < list.size(); i++) {
				System.out.println(list.get(i).getMatchMenteeId());
				System.out.println(list.size());
				System.out.println("멘토에서 멘티 기록 가져오기 완료");
				dispacher("MENTOR/MENTOR_menteeList.jsp", request, response);
			}

		} else if (command.equals("getMatchView")) {
			// 아이디
			LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
			String id = menteeDto.getId();

			JoinBiz joinBiz = new JoinBizImpl();
			List<LoginProfileDto> mentorList = joinBiz.selectList_MentorList();
			request.setAttribute("mentorList", mentorList);
			MatchBiz matchBiz = new MatchBizImpl();
			MatchDto getMyMentor = matchBiz.getMyMentor(id);
			boolean getMyMentorBtn = true;
			if (getMyMentor != null) {
				getMyMentorBtn = false;
			}
			request.setAttribute("getMyMentor", getMyMentorBtn);
			dispacher("MENTEE/MATCH/MENTEE_MentorFind.jsp", request, response);

		} else if (command.equals("searchMentor")) {
			String memberName = request.getParameter("name");
			JoinBiz joinBiz = new JoinBizImpl();
			List<LoginProfileDto> mentorList = joinBiz.selectList_MentorList();

			PrintWriter out = response.getWriter();
			JSONArray arr = new JSONArray();
			JSONObject obj = new JSONObject();

			for (LoginProfileDto dto : mentorList) {
				obj.put("memberName", dto.getMemberName());

				if (obj != null) {
					arr.add(obj);
				}
			}

			arr.write(out);

		} else if (command.equals("searchMentorPro")) {
			// 아이디
			LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
			String id = menteeDto.getId();

			String memberName = request.getParameter("name");
			JoinBiz joinBiz = new JoinBizImpl();
			List<LoginProfileDto> searchMentor = joinBiz.search_MentorName(memberName);

			MatchBiz matchBiz = new MatchBizImpl();
			MatchDto getMyMentor = matchBiz.getMyMentor(id);
			boolean getMyMentorBtn = true;
			if (getMyMentor != null) {
				getMyMentorBtn = false;
			}
			request.setAttribute("getMyMentor", getMyMentorBtn);

			request.setAttribute("mentorList", searchMentor);
			dispacher("MENTEE/MATCH/MENTEE_MentorFind.jsp", request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		doGet(request, response);
	}

	private void dispacher(String url, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispacher = request.getRequestDispatcher(url);
		dispacher.forward(request, response);
	}

}
