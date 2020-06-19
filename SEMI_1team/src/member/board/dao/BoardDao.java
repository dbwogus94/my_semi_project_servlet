package member.board.dao;

import java.util.List;

import member.board.dto.AnswerBoardDto;
import member.board.dto.BoardDto;
import member.board.dto.reviewDto;

public interface BoardDao {
	
	public String NAMESPACE = "member.board.db.Mapper.";
	
	public List<BoardDto> selectList_Board(int board_Group_No);
	public List<BoardDto> selectList_Exercise();
	public List<BoardDto> selectList_exercise_category();
	public List<BoardDto> selectList_exercise_name(String board_Exercise_Category);
	public List<BoardDto> selectList_Review();
	
	public List<AnswerBoardDto> selectdetail_Board(int board_Group);
	
	public String selectId_Board(String Board_Id);
	
	public BoardDto selectOne_Category_Board(int Board_Category_No);
	public BoardDto selectOne_Exercise(String board_Exercise_Name);
	public BoardDto selectOne_Review(int Board_Category_No);
	
	public List<BoardDto> selectOneId_Board(String Board_Id);
	
	public int insert_Board(BoardDto dto);
	public int insert_Review(BoardDto dto);
	
	public int update_Board(BoardDto dto);
	public int update_Board_Review(BoardDto dto);
	public int update_Review(BoardDto dto);
	
	public int delete_Board(int board_Group);
	
	public int delete_review_board(int Board_Category_No);
	
	public int multiDelete_Board(String[] board_Group);
	
	public int insert_First_Answer_Board(AnswerBoardDto dto);
	public int update_first_answer_board(AnswerBoardDto dto);
	public int insert_Answer(AnswerBoardDto dto);
	public int update_Answer(AnswerBoardDto dto);
	
	public List<BoardDto> selectIdList_board(String Board_Id, int cPage, int numPerPage);
	public List<BoardDto> selectNameList_board(String board_Member_Name, int cPage, int numPerPage);
	public List<BoardDto> selectTitleList_board(String board_Title, int cPage, int numPerPage);
	public List<BoardDto> selectIdAndTitleList_board(String Board_Id, String board_Title, int cPage, int numPerPage);
	
	public List<BoardDto> selectPagingList(int cPage, int numPerPage);
	public int selectPageingCount();
	public int selectPageingIdCount(String Board_Id);
	public int selectPageingNameCount(String board_Member_Name);
	public int selectPageingTitleCount(String board_Title);
	public int selectPageingIdAndTitleCount(String Board_Id, String board_Title);
	public int select_Search_End_No();
	public List<reviewDto> selectList_Search_End_board(int board_Group_No);
	public String  check_Id_board(String id);
	
	
	
	public int selectEndCount(int board_Group, int board_Group_No);
	public List<reviewDto> select_reviewAndreview_board(int board_Group, int board_Group_No, int next_board_Group_No);
	
}
