package member.board.controller;

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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import All.statics.join.LoginProfile.dto.LoginProfileDto;
import member.board.biz.BoardBiz;
import member.board.biz.BoardBizlmpl;
import member.board.dto.BoardDto;

@WebServlet("/exerciseServlet")
public class ExerciseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; setchar=UTF-8");
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		BoardBiz boardBiz = new BoardBizlmpl();
		HttpSession session = request.getSession();
		LoginProfileDto menteeDto = (LoginProfileDto)session.getAttribute("menteeDto");
		
		String command = request.getParameter("command");
		System.out.println("command : " + command);
		
		if(command.equals("exerciseMain")) {
			List<BoardDto> exerciseCategoryList = boardBiz.selectList_exercise_category();
			request.setAttribute("exerciseCategoryList", exerciseCategoryList);
			dispatch("BOARD/exercisemain.jsp",request,response);
		} else if(command.equals("exerciseCategory")) {
			String boardExerciseCategory = request.getParameter("Category");
			List<BoardDto> exerciseNameList = boardBiz.selectList_exercise_name(boardExerciseCategory);
			JSONObject obj = new JSONObject();
			
			int count = 0;
			for(BoardDto dto : exerciseNameList) {
				obj.put("ExerciseName"+count,dto.getBoard_Exercise_Name());
				count++;
			}
			obj.put("Category",boardExerciseCategory);
			PrintWriter out = response.getWriter();
			out.println(obj.toJSONString());
		} else if(command.equals("exerciseContent")) {
			String exerciseName = request.getParameter("exerciseName");
			BoardDto exerciseDto = boardBiz.selectOne_Exercise(exerciseName);
			System.out.println(exerciseDto);
			JSONObject obj = new JSONObject();
			
			obj.put("exerciseName",exerciseDto.getBoard_Exercise_Name());
			obj.put("exerciseContent",exerciseDto.getBoard_Content());
			obj.put("exerciseUrl",exerciseDto.getBoard_Exercise_Url());
			
			PrintWriter out = response.getWriter();
			out.println(obj.toJSONString());
			
		} else if(command.equals("")) {
			
		} else if(command.equals("")) {
			
		}
	}
	
	
	
	
	
	
	
	
	private void jsResponse(String msg, String url, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String alertOut = "<script type ='text/javascript'>"
							+ "alert('"+msg+"');"
							+ "location.href='"+url+"';"
							+ "</script>";
		out.print(alertOut);
	}
	
	public void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}
}
