package member.board.biz;

import java.util.List;

import member.board.dao.BoardDao;
import member.board.dao.BoardDaolmpl;
import member.board.dto.AnswerBoardDto;
import member.board.dto.BoardDto;
import member.board.dto.reviewDto;

public class BoardBizlmpl implements BoardBiz{

	BoardDao board_dao = new BoardDaolmpl();
	
	@Override
	public List<BoardDto> selectList_Board(int board_Group_No) {
		return board_dao.selectList_Board(board_Group_No);
	}

	@Override
	public List<BoardDto> selectList_Exercise() {
		return board_dao.selectList_Exercise();
	}
	
	@Override
	public List<BoardDto> selectList_exercise_category() {
		return board_dao.selectList_exercise_category();
	}

	@Override
	public List<BoardDto> selectList_Review() {
		return board_dao.selectList_Review();
	}
	
	@Override
	public List<AnswerBoardDto> selectdetail_Board(int board_Group) {
		return board_dao.selectdetail_Board(board_Group);
	}
	
	@Override
	public String selectId_Board(String Board_Id) {
		return board_dao.selectId_Board(Board_Id);
	}
	
	@Override
	public BoardDto selectOne_Category_Board(int Board_Category_No) {
		return board_dao.selectOne_Category_Board(Board_Category_No);
	}
	
	@Override
	public BoardDto selectOne_Exercise(String board_Exercise_Name) {
		return board_dao.selectOne_Exercise(board_Exercise_Name);
	}

	@Override
	public BoardDto selectOne_Review(int Board_Category_No) {
		return board_dao.selectOne_Review(Board_Category_No);
	}
	
	@Override
	public List<BoardDto> selectOneId_Board(String Board_Id) {
		return board_dao.selectOneId_Board(Board_Id);
	}

	@Override
	public int insert_Board(BoardDto dto) {
		return board_dao.insert_Board(dto);
	}

	@Override
	public int insert_Review(BoardDto dto) {
		return board_dao.insert_Review(dto);
	}

	@Override
	public int update_Board(BoardDto dto) {
		return board_dao.update_Board(dto);
	}
	
	@Override
	public int update_Board_Review(BoardDto dto) {
		return board_dao.update_Board_Review(dto);
	}

	@Override
	public int update_Review(BoardDto dto) {
		return board_dao.update_Review(dto);
	}
	
	@Override
	public int delete_Board(int board_Group) {
		return board_dao.delete_Board(board_Group);
	}
	
	@Override
	public int delete_review_board(int Board_Category_No) {
		return board_dao.delete_review_board(Board_Category_No);
	}
	
	@Override
	public int insert_First_Answer_Board(AnswerBoardDto dto) {
		return board_dao.insert_First_Answer_Board(dto);
	}
	
	@Override
	public int update_first_answer_board(AnswerBoardDto dto) {
		return board_dao.update_first_answer_board(dto);
	}
	
	@Override
	public int insert_Answer(AnswerBoardDto dto) {
		return board_dao.insert_Answer(dto);
	}
	
	@Override
	public int update_Answer(AnswerBoardDto dto) {
		return board_dao.update_Answer(dto);
	}

	@Override
	public int multiDelete_Board(String[] board_Group) {
		return board_dao.multiDelete_Board(board_Group);
	}

	@Override
	public List<BoardDto> selectList_exercise_name(String board_Exercise_Category) {
		return board_dao.selectList_exercise_name(board_Exercise_Category);
	}

	@Override
	public List<BoardDto> selectIdList_board(String Board_Id, int cPage, int numPerPage) {
		return board_dao.selectIdList_board(Board_Id, cPage, numPerPage);
	}

	@Override
	public List<BoardDto> selectNameList_board(String board_Member_Name, int cPage, int numPerPage) {
		return board_dao.selectNameList_board(board_Member_Name, cPage, numPerPage);
	}

	@Override
	public List<BoardDto> selectTitleList_board(String board_Title, int cPage, int numPerPage) {
		return board_dao.selectTitleList_board(board_Title, cPage, numPerPage);
	}

	
	@Override
	public List<BoardDto> selectPagingList(int cPage, int numPerPage) {
		return board_dao.selectPagingList(cPage, numPerPage);
	}

	@Override
	public int selectPageingCount() {
		return board_dao.selectPageingCount();
	}

	@Override
	public int selectPageingIdCount(String Board_Id) {
		return board_dao.selectPageingIdCount(Board_Id);
	}

	@Override
	public int selectPageingNameCount(String board_Member_Name) {
		return board_dao.selectPageingNameCount(board_Member_Name);
	}

	@Override
	public int selectPageingTitleCount(String board_Title) {
		return board_dao.selectPageingTitleCount(board_Title);
	}
	
	@Override
	public List<BoardDto> selectIdAndTitleList_board(String Board_Id, String board_Title, int cPage, int numPerPage) {
		return board_dao.selectIdAndTitleList_board(Board_Id, board_Title, cPage, numPerPage);
	}

	@Override
	public int selectPageingIdAndTitleCount(String Board_Id, String board_Title) {
		return board_dao.selectPageingIdAndTitleCount(Board_Id, board_Title);
	}
	
	@Override
	public int select_Search_End_No() {
		return board_dao.select_Search_End_No();
	}

	@Override
	public int selectEndCount(int board_Group, int board_Group_No) {
		return board_dao.selectEndCount(board_Group, board_Group_No);
	}

	@Override
	public List<reviewDto> select_reviewAndreview_board(int board_Group, int board_Group_No, int next_board_Group_No) {
		return board_dao.select_reviewAndreview_board(board_Group, board_Group_No, next_board_Group_No);
	}

	@Override
	public List<reviewDto> selectList_Search_End_board(int board_Group_No) {
		return board_dao.selectList_Search_End_board(board_Group_No);
	}

	@Override
	public String check_Id_board(String id) {
		return board_dao.check_Id_board(id);
	}

	

	

	

	

	

		
}
