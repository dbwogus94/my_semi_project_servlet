package member.mentee.exercise.total.controller;

import java.io.IOException;

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
import member.mentee.exercise.total.biz.TotalBiz;
import member.mentee.exercise.total.biz.TotalBizImpl;
import member.mentee.exercise.total.dto.TotalDto;

@WebServlet("/TotalServlet")
public class TotalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Exercise Exercise = new Exercise();
	
	public TotalServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();

		String command = request.getParameter("command");
		System.out.println("<" + command + ">");
		TotalBiz totalBiz = new TotalBizImpl();

		if (command.equals("insertWeight")) {
			double weight = Double.parseDouble(request.getParameter("weight"));
			String totalDate = request.getParameter("date");
			String id = request.getParameter("id");
			System.out.println("total servlet id = " + id);
			System.out.println("total servlet date = " + totalDate);
			System.out.println("total servlet weight = " + weight);

			TotalDto dto = new TotalDto(0, totalDate, id, "", "", 0, weight);
			totalBiz.insert_total(dto);

		} else if (command.equals("deleteWeight")) {
			double weight = Double.parseDouble(request.getParameter("weight"));
			String totalDate = request.getParameter("date");
			LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
			String id = menteeDto.getId();

			TotalDto dto = new TotalDto(0, totalDate, id, "", "", 0, weight);
			totalBiz.delete_total(dto);

			// 운동플랜 총 시간 입력
		} else if (command.equals("insertTotalTime")) {
			// 아이디
			LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
			String id = menteeDto.getId();
			// 날짜
			int year = Integer.parseInt(request.getParameter("year"));
			int month = Integer.parseInt(request.getParameter("month"));
			int date = Integer.parseInt(request.getParameter("date"));
			System.out.println("insert total : " + year);

			// 총 운동시간
			int insertTime = Integer.parseInt(request.getParameter("insertTime"));
			// 유산소 시간
			int aerobicTime = Integer.parseInt(request.getParameter("aerobicTime"));
			// 근력운동시간
			int strengthTime = insertTime - aerobicTime;
			// 유산소 칼로리 계산 (유산소이름, 체중, 시간)
			String aerobicName = request.getParameter("aerobicName");
			double weight = menteeDto.getMemberWeight();
			
			int aerobicCalorie = Exercise.AerobicExercise(aerobicName, weight, aerobicTime);
			// 근력 칼로리 계산
			int strengthCalorie = Exercise.StrengthTraining(strengthTime);
			// 총 칼로리 (유산소 + 근력)
			double totalCalorie = aerobicCalorie + strengthCalorie;
			
			TotalDto dto = new TotalDto();
			dto.setId(id);
			dto.setTotalDate(year + "" + Util.isTwo(Integer.toString(month)) + "" + Util.isTwo(Integer.toString(date)));
			dto.setTotalTime(Integer.toString(insertTime));
			dto.setTotalCalorie(totalCalorie);

			int res = totalBiz.insertTimeCal(dto);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	public void dispatch(String url, HttpServletResponse response, HttpServletRequest request)
			throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}
}