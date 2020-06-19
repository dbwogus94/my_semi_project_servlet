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
import member.board.dto.AnswerBoardDto;
import member.board.dto.BoardDto;
import member.board.dto.reviewDto;

/**
 * Servlet implementation class MemberServlet
 */
@WebServlet("/MemberServlet")
public class BoardServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
	
	BoardBiz boardBiz = new BoardBizlmpl();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; setchar=UTF-8");
		doGet(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = request.getSession();
		LoginProfileDto menteeDto = (LoginProfileDto)session.getAttribute("menteeDto");
		LoginProfileDto mentorDto = (LoginProfileDto)session.getAttribute("mentorDto");
		
		String loginId = "";
		String loginName = "";
		
		
		
		if(menteeDto == null) {
			loginId = mentorDto.getId();
			loginName = mentorDto.getMemberName();
		}
		
		if(mentorDto == null) {
			loginId = menteeDto.getId();
			loginName = menteeDto.getMemberName();
		}
		
		String command = request.getParameter("command");
		System.out.println("command : " + command);
		if(command.equals("boardMain")) {
		// 게시판 메인화면
			
	        int cPage; //현재 페이지를 의미
	        
	        try {
	            cPage = Integer.parseInt(request.getParameter("cPage"));	// 클릭한 페이지
	        }catch (NumberFormatException e) {
	            cPage = 1;		// 페이지 클릭을 안하고 처음 접속했을때
	        }
	        int numPerPage;    //페이지당 자료수
	        try {
	            numPerPage = Integer.parseInt(request.getParameter("numPerPage"));	// 
	        }catch (NumberFormatException e) {
	            numPerPage = 6;	// 한 페이지당 자료수는 6개로 설정
	        }
	        
	        //페이지수 만큼 데이터를 불러옴
	        List<BoardDto> boardlist = boardBiz.selectPagingList(cPage, numPerPage);
	       
	        //페이지 구성해보기
	        //전체자료수를 확인
	        int totalMember = boardBiz.selectPageingCount();
	        
	        //전체페이수
	        int totalPage = (int)Math.ceil((double)totalMember/numPerPage);
	        
	        //페이지바 html코드 누적변수
	        String pageBar="";
	        //페이지바 길이
	        int pageBarSize =5;
	        int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
	        int pageEnd = pageNo+pageBarSize-1;
	        
	        // 페이지바 구성하기
	        if(pageNo == 1) {
	            pageBar += "<span>[이전]</span>";
	        }else {
	            pageBar += "<a href='board.do?command=boardMain&cPage=" + (pageNo - 1) + "&numPerPage=" + numPerPage + "'>[이전]</a>";
	        }
	        //선택페이지 만들기
	        while(!(pageNo > pageEnd || pageNo > totalPage))
	        {
	            if(cPage == pageNo) {
	                pageBar += "<span class='cPage'>" + pageNo + "</span>";
	            }else {
	                pageBar += "<a href='board.do?command=boardMain&cPage=" + (pageNo) + "&numPerPage=" + numPerPage + "'>" + pageNo + "</a>";
	            }
	            pageNo++;
	        }
	        //[다음] 구현
	        if(pageNo > totalPage) 
	        {
	            pageBar += "<span>[다음]</span>";
	        }else {
	            pageBar += "<a href='board.do?command=boardMain&cPage=" + pageNo + "&numPerPage=" + numPerPage + "'>[다음]</a>";
	        }
	        request.setAttribute("boardlist", boardlist);
	        request.setAttribute("loginId", loginId);
	        request.setAttribute("cPage", cPage);
	        request.setAttribute("numPerPage", numPerPage);
	        request.setAttribute("pageBar", pageBar);
	        dispatch("BOARD/BOARD_BoardMain.jsp",request, response);
			
		} else if(command.equals("boardSearch")) {
		// 게시판 메인페이지 검색
			String searchtext = request.getParameter("search2");
			String searchcategory = request.getParameter("category");
			if(searchtext == "" || searchtext.equals("") || searchcategory == "0" || searchcategory.equals("0")) {
				jsResponse("검색어 입력 및 카테고리를 선택해주세요!!!","board.do?command=boardMain",response);
			} else {
				List<BoardDto> boardList = null;
				int totalMember = 0;
				
				int cPage;
		        
		        try {
		            cPage = Integer.parseInt(request.getParameter("cPage"));
		        }catch (NumberFormatException e) {
		            cPage = 1;
		        }
		        int numPerPage;
		        try {
		            numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
		        }catch (NumberFormatException e) {
		            numPerPage = 6;
		        }
		        
		        if(searchcategory.equals("id")) {
					boardList = boardBiz.selectIdList_board(searchtext, cPage, numPerPage);
					totalMember = boardBiz.selectPageingIdCount(searchtext);
				} else if(searchcategory.equals("name")) {
					boardList = boardBiz.selectNameList_board(searchtext, cPage, numPerPage);
					totalMember = boardBiz.selectPageingNameCount(searchtext);
				} else {
					boardList = boardBiz.selectTitleList_board(searchtext, cPage, numPerPage);
					totalMember = boardBiz.selectPageingTitleCount(searchtext);
				}
		        
		        int totalPage = (int)Math.ceil((double)totalMember/numPerPage);
		        
		        String pageBar="";

		        int pageBarSize =5;
		        int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		        int pageEnd = pageNo+pageBarSize-1;
		        
		        if(pageNo == 1) {
		            pageBar += "<span>[이전]</span>";
		        }else {
		            pageBar += "<a href='board.do?command=boardSearch&cPage=" + (pageNo - 1) + "&numPerPage=" + numPerPage + "&search2=" + searchtext + "&category=" + searchcategory + "'>[이전]</a>";
		        }

		        while(!(pageNo > pageEnd || pageNo > totalPage))
		        {
		            if(cPage == pageNo) {
		                pageBar += "<span class='cPage'>" + pageNo + "</span>";
		            }else {
		                pageBar += "<a href='board.do?command=boardSearch&cPage=" + (pageNo) + "&numPerPage=" + numPerPage + "&search2=" + searchtext + "&category=" + searchcategory + "'>" + pageNo + "</a>";
		            }
		            pageNo++;
		        }

		        if(pageNo > totalPage) 
		        {
		            pageBar += "<span>[다음]</span>";
		        }else {
		            pageBar += "<a href='board.do?command=boardSearch&cPage=" + pageNo + "&numPerPage=" + numPerPage + "&search2=" + searchtext + "&category=" + searchcategory + "'>[다음]</a>";
		        } 
		        request.setAttribute("boardlist", boardList);
		        request.setAttribute("cPage", cPage);
		        request.setAttribute("loginId", loginId);
		        request.setAttribute("numPerPage", numPerPage);
		        request.setAttribute("pageBar", pageBar);
		        dispatch("BOARD/BOARD_BoardMain.jsp",request, response);
			}
		} else if(command.equals("BoardWriteform")) {
		// 글쓰기 클릭
			BoardDto boarddto = new BoardDto(loginId, loginName);
			request.setAttribute("boarddto", boarddto);
			dispatch("BOARD/boardwrite.jsp",request,response);
		} else if(command.equals("BoardWriteres")) {
		// 글 작성 완료
			String boardTitle = request.getParameter("boardTitle");
			String boardContent = request.getParameter("boardContent");
			BoardDto boardDto = new BoardDto(loginId, loginName, boardTitle, boardContent);
			int res = boardBiz.insert_Board(boardDto);
			if(res > 0) {
				jsResponse("글 작성 성공","board.do?command=boardMain",response);
			} else {
				jsResponse("글 작성 실패","board.do?command=boardMain",response);
			}
			
			
			
			
			
		} else if(command.equals("boardUpdate")) {
		// 게시판 글 수정
			int board_Category_No = Integer.parseInt(request.getParameter("boardNo"));
			BoardDto boardDto = boardBiz.selectOne_Category_Board(board_Category_No);
			request.setAttribute("loginId", loginId);
			request.setAttribute("boardDto", boardDto);
			dispatch("BOARD/boardupdate.jsp",request,response);
		} else if(command.equals("boardUpdateres")) {
		// 게시판 글 수정 완료
			int board_Category_No = Integer.parseInt(request.getParameter("boardno"));
			String boardTitle = request.getParameter("title");
			String boardContent = request.getParameter("content");
			BoardDto boardDto = new BoardDto(board_Category_No, loginId, loginName, boardTitle, boardContent);
			int res = boardBiz.update_Board(boardDto);
			if(res > 0) {
				jsResponse("게시판 글 수정 성공","board.do?command=boardMain",response);
			} else {
				jsResponse("게시판 글 수정 실패","board.do?command=boardMain",response);
			}
			
			
			
			
			
			
		} else if(command.equals("BoardDetail")) {
		// 상세 글 보기
			int board_Group = Integer.parseInt(request.getParameter("board_Group"));
			int board_Category_No = Integer.parseInt(request.getParameter("boardNo"));
			List<AnswerBoardDto> boardList = boardBiz.selectdetail_Board(board_Group);
			BoardDto boardDto = boardBiz.selectOne_Category_Board(board_Category_No);
			request.setAttribute("loginId",loginId);
			request.setAttribute("boardList", boardList);
			request.setAttribute("boardDto", boardDto);
			dispatch("BOARD/boarddetail.jsp",request,response);
		} else if(command.equals("reviewtoggle")) {
		// 댓글 클릭하여 댓글의 댓글 출력 (비동기)
			int board_Group = Integer.parseInt(request.getParameter("board_Group"));
			int board_Group_No = Integer.parseInt(request.getParameter("board_Group_No"));
			int board_Category_No = Integer.parseInt(request.getParameter("boardNo"));
			int count = Integer.parseInt(request.getParameter("count"));
			int search = boardBiz.select_Search_End_No();
			
			JSONObject JObject = new JSONObject();
			JSONArray JArray = new JSONArray();
			
			List<AnswerBoardDto> boardList = boardBiz.selectdetail_Board(board_Group);
			BoardDto boardDto = boardBiz.selectOne_Category_Board(board_Category_No);
			request.setAttribute("boardList", boardList);
			request.setAttribute("boardDto", boardDto);
			
			if(search == board_Group_No) {
				List<reviewDto> reviewList = boardBiz.selectList_Search_End_board(board_Group_No);
				for(int i = 0; i < reviewList.size(); i++) {
					JSONObject obj = new JSONObject();
					obj.put("board_Category_No", reviewList.get(i).getBoard_Category_No());
					obj.put("board_Group", reviewList.get(i).getBoard_Group());
					obj.put("board_Group_No", reviewList.get(i).getBoard_Group_No());
					obj.put("board_Tab", reviewList.get(i).getBoard_Tab());
					obj.put("id", reviewList.get(i).getId());
					obj.put("board_Member_Name", reviewList.get(i).getBoard_Member_Name());
					obj.put("board_Content", reviewList.get(i).getBoard_Content());
					JArray.add(obj);
				}
				JObject.put("reviewList", JArray);
				JObject.put("count", count);
			} else {
				int EndCount = boardBiz.selectEndCount(board_Group, board_Group_No);
				List<reviewDto> reviewList = boardBiz.select_reviewAndreview_board(board_Group, board_Group_No, EndCount);
				for(int i = 0; i < reviewList.size(); i++) {
					JSONObject obj = new JSONObject();
					obj.put("board_Category_No", reviewList.get(i).getBoard_Category_No());
					obj.put("board_Group", reviewList.get(i).getBoard_Group());
					obj.put("board_Group_No", reviewList.get(i).getBoard_Group_No());
					obj.put("board_Tab", reviewList.get(i).getBoard_Tab());
					obj.put("id", reviewList.get(i).getId());
					obj.put("board_Member_Name", reviewList.get(i).getBoard_Member_Name());
					obj.put("board_Content", reviewList.get(i).getBoard_Content());
					JArray.add(obj);
				}
				JObject.put("reviewList", JArray);
				JObject.put("count", count);
			}
			PrintWriter out = response.getWriter();
			out.println(JObject.toJSONString());
		} else if(command.equals("BoardDelete")) {
		// 상세 글 보기에서 삭제
			int Board_Group_No = Integer.parseInt(request.getParameter("groupNo"));
			int res = boardBiz.delete_Board(Board_Group_No);
			if(res > 0) {
				jsResponse("글 삭제 성공","board.do?command=boardMain",response);
			} else {
				jsResponse("글 삭제 실패","board.do?command=boardMain",response);
			}
		} else if(command.equals("ReviewWriteres")) {
		// 게시판 댓글 작성
			int board_Group = Integer.parseInt(request.getParameter("group"));
			int board_Category_No = Integer.parseInt(request.getParameter("boardno"));
			String boardContent = request.getParameter("content");
			AnswerBoardDto answerboardDto = new AnswerBoardDto(board_Category_No, board_Group, 0, 0, loginId, loginName, boardContent);
			int updateres = boardBiz.update_first_answer_board(answerboardDto);
			System.out.println("업데이트 된 숫자 : " + updateres);
			int insertres = boardBiz.insert_First_Answer_Board(answerboardDto);
			if(insertres > 0) {
				jsResponse("댓글 작성 성공","board.do?command=boardMain",response);
			} else {
				jsResponse("댓글 작성 실패","board.do?command=boardMain",response);
			}
			
		} else if(command.equals("ReviewUpdate")) {
		// 게시판 댓글 수정
			int board_Category_No = Integer.parseInt(request.getParameter("boardNo"));
			String boardContent = request.getParameter("boardContent");
			BoardDto boardDto = new BoardDto(board_Category_No, boardContent);
			int res = boardBiz.update_Board_Review(boardDto);
			if(res > 0) {
				jsResponse("게시판 댓글 수정 성공","board.do?command=boardMain",response);
			} else {
				jsResponse("게시판 댓글 수정 성공","board.do?command=boardMain",response);
			}
		} else if(command.equals("ReviewDelete")) {
		// 댓글 삭제
			int board_Category_No = Integer.parseInt(request.getParameter("boardNo"));
			int res = boardBiz.delete_review_board(board_Category_No);
			if(res > 0) {
				jsResponse("댓글 삭제 성공","board.do?command=boardMain",response);
			} else {
				jsResponse("댓글 삭제 실패","board.do?command=boardMain",response);
			}
		} else if(command.equals("ReviewAndReview")) {
		// 댓글에 댓글
			int board_Group = Integer.parseInt(request.getParameter("reviewgroup"));
			int board_Group_No = Integer.parseInt(request.getParameter("reviewgroupno"));
			int board_Tab = Integer.parseInt(request.getParameter("reviewtab"));
			String boardContent = request.getParameter("boardContent");
			AnswerBoardDto answerboardDto = new AnswerBoardDto(0,board_Group, board_Group_No, board_Tab, loginId, loginName, boardContent);
			System.out.println("업데이트하려는 댓글의 그룹 : " + board_Group);
			System.out.println("업데이트하려는 댓글의 그룹넘버 : " + board_Group_No);
			int updateres = boardBiz.update_Answer(answerboardDto);
			System.out.println("댓글에 댓글 업데이트 수 : " + updateres);
			int insertres = boardBiz.insert_Answer(answerboardDto);
			if(insertres > 0) {
				jsResponse("댓글 작성 성공","board.do?command=boardMain",response);
			} else {
				jsResponse("댓글 작성 실패","board.do?command=boardMain",response);
			}
		} else if(command.equals("BoardManage")) {
		// 게시글 관리 클릭
	        int cPage;
	        try {
	            cPage = Integer.parseInt(request.getParameter("cPage"));
	        }catch (NumberFormatException e) {
	            cPage = 1;
	        }
	        int numPerPage;
	        try {
	            numPerPage = Integer.parseInt(request.getParameter("numPerPage"));	// 
	        }catch (NumberFormatException e) {
	            numPerPage = 6;
	        }
	        List<BoardDto> boardlist = boardBiz.selectIdList_board(loginId, cPage, numPerPage);
	        int totalMember = boardBiz.selectPageingIdCount(loginId);
	        
	        int totalPage = (int)Math.ceil((double)totalMember/numPerPage);
	        
	        String pageBar="";
	        int pageBarSize =5;
	        int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
	        int pageEnd = pageNo+pageBarSize-1;
	        
	        if(pageNo == 1) {
	            pageBar += "<span>[이전]</span>";
	        }else {
	            pageBar += "<a href='board.do?command=BoardManage&cPage=" + (pageNo - 1) + "&numPerPage=" + numPerPage + "'>[이전]</a>";
	        }

	        while(!(pageNo > pageEnd || pageNo > totalPage))
	        {
	            if(cPage == pageNo) {
	                pageBar += "<span class='cPage'>" + pageNo + "</span>";
	            }else {
	                pageBar += "<a href='board.do?command=BoardManage&cPage=" + (pageNo) + "&numPerPage=" + numPerPage + "'>" + pageNo + "</a>";
	            }
	            pageNo++;
	        }
	        if(pageNo > totalPage) 
	        {
	            pageBar += "<span>[다음]</span>";
	        }else {
	            pageBar += "<a href='board.do?command=BoardManage&cPage=" + pageNo + "&numPerPage=" + numPerPage + "'>[다음]</a>";
	        } 
	        request.setAttribute("boardList", boardlist);
	        request.setAttribute("cPage", cPage);
	        request.setAttribute("loginId", loginId);
	        request.setAttribute("numPerPage", numPerPage);
	        request.setAttribute("pageBar", pageBar);
	        dispatch("BOARD/boardmuldel.jsp",request, response);
		} else if(command.equals("muldelBoard")) {
		// 다중 삭제 완료
			String muldelchkBoard[] = request.getParameterValues("chk");
			if(muldelchkBoard == null || muldelchkBoard.length == 0) {
				jsResponse("하나 이상 선택해 주세요...","board.do?command=boardMain",response);
			} else {
				int res = boardBiz.multiDelete_Board(muldelchkBoard);
				if(res > 0) {
					jsResponse("선택 삭제 성공","board.do?command=boardMain",response);
				} else {
					jsResponse("선택 삭제가 실패했습니다","board.do?command=boardMain",response);
				}
			}
		} else if(command.equals("muldelSearch")) {
		// 게시판 관리에서 검색
			String searchtext = request.getParameter("searchtext");
			if(searchtext.equals("") || searchtext == "") {
				jsResponse("검색어를 입력하세요","board.do?command=BoardManage",response);
			} else {
				int cPage;
		        
		        try {
		            cPage = Integer.parseInt(request.getParameter("cPage"));
		        }catch (NumberFormatException e) {
		            cPage = 1;
		        }
		        int numPerPage;
		        try {
		            numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
		        }catch (NumberFormatException e) {
		            numPerPage = 6;
		        }
		        
		        List<BoardDto> boardList = boardBiz.selectIdAndTitleList_board(loginId, searchtext, cPage, numPerPage);
				int totalMember = boardBiz.selectPageingIdAndTitleCount(loginId, searchtext);
		        int totalPage = (int)Math.ceil((double)totalMember/numPerPage);
		        
		        String pageBar="";

		        int pageBarSize =5;
		        int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		        int pageEnd = pageNo+pageBarSize-1;
		        
		        if(pageNo == 1) {
		            pageBar += "<span>[이전]</span>";
		        }else {
		            pageBar += "<a href='board.do?command=muldelSearch&cPage=" + (pageNo - 1) + "&numPerPage=" + numPerPage + "&searchtext=" + searchtext + "'>[이전]</a>";
		        }

		        while(!(pageNo > pageEnd || pageNo > totalPage))
		        {
		            if(cPage == pageNo) {
		                pageBar += "<span class='cPage'>" + pageNo + "</span>";
		            }else {
		                pageBar += "<a href='board.do?command=muldelSearch&cPage=" + (pageNo) + "&numPerPage=" + numPerPage + "&searchtext=" + searchtext + "'>" + pageNo + "</a>";
		            }
		            pageNo++;
		        }

		        if(pageNo > totalPage) 
		        {
		            pageBar += "<span>[다음]</span>";
		        }else {
		            pageBar += "<a href='board.do?command=muldelSearch&cPage=" + pageNo + "&numPerPage=" + numPerPage + "&searchtext=" + searchtext + "'>[다음]</a>";
		        } 
		        request.setAttribute("boardList", boardList);
		        request.setAttribute("loginId", loginId);
		        request.setAttribute("cPage", cPage);
		        request.setAttribute("numPerPage", numPerPage);
		        request.setAttribute("pageBar", pageBar);
				dispatch("BOARD/boardmuldel.jsp",request,response);
			}
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

