package member.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import member.board.db.sqlMapConfig;
import member.board.dto.AnswerBoardDto;
import member.board.dto.BoardDto;
import member.board.dto.reviewDto;

public class BoardDaolmpl extends sqlMapConfig implements BoardDao {

	@Override
	public List<BoardDto> selectList_Board(int board_Group_No) {
		SqlSession session = null;
		List<BoardDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(NAMESPACE+"selectList_board",board_Group_No);
		} catch (Exception e) {
			System.out.println("[ERROR] selectList_Board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	@Override
	public List<BoardDto> selectList_Exercise() {
		SqlSession session = null;
		List<BoardDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(NAMESPACE+"selectList_exercise");
		} catch (Exception e) {
			System.out.println("[ERROR] selectList_Exercise");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	@Override
	public List<BoardDto> selectList_exercise_category() {
		SqlSession session = null;
		List<BoardDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(NAMESPACE+"selectList_exercise_category");
		} catch (Exception e) {
			System.out.println("[ERROR] selectList_exercise_category");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	@Override
	public List<BoardDto> selectList_Review() {
		SqlSession session = null;
		List<BoardDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(NAMESPACE+"selectList_review");
		} catch (Exception e) {
			System.out.println("[ERROR] selectList_Review");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	@Override
	public List<AnswerBoardDto> selectdetail_Board(int board_Group) {
		SqlSession session = null;
		List<AnswerBoardDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(NAMESPACE+"selectdetail_board",board_Group);
		} catch (Exception e) {
			System.out.println("[ERROR] selectdetail_Board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	@Override
	public String selectId_Board(String Board_Id) {
		SqlSession session = null;
		String res = "";
		
		try {
			session = getSqlSessionFactory().openSession();
			res = session.selectOne(NAMESPACE+"selectId_board",Board_Id);
		} catch (Exception e) {
			System.out.println("[ERROR] selectId_Board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}
	
	@Override
	public BoardDto selectOne_Category_Board(int Board_Category_No) {
		SqlSession session = null;
		BoardDto board_dto = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			board_dto = session.selectOne(NAMESPACE+"selectOne_category_board",Board_Category_No);
		} catch (Exception e) {
			System.out.println("[ERROR] selectOne_Category_Board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return board_dto;
	}

	@Override
	public BoardDto selectOne_Exercise(String board_Exercise_Name) {
		SqlSession session = null;
		BoardDto board_dto = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			board_dto = session.selectOne(NAMESPACE+"selectOne_exercise",board_Exercise_Name);
		} catch (Exception e) {
			System.out.println("[ERROR] selectOne_Exercise");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return board_dto;
	}

	@Override
	public BoardDto selectOne_Review(int Board_Category_No) {
		SqlSession session = null;
		BoardDto board_dto = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			board_dto = session.selectOne(NAMESPACE+"selectOne_review",Board_Category_No);
		} catch (Exception e) {
			System.out.println("[ERROR] selectOne_Review");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return board_dto;
	}

	@Override
	public List<BoardDto> selectOneId_Board(String Board_Id) {
		SqlSession session = null;
		List<BoardDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(NAMESPACE+"selectOneId_board",Board_Id);
		} catch (Exception e) {
			System.out.println("[ERROR] selectOneId_Board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	@Override
	public int insert_Board(BoardDto dto) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession();
			res = session.insert(NAMESPACE+"insert_board",dto);
			if(res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] insert_Board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	@Override
	public int insert_Review(BoardDto dto) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession();
			res = session.insert(NAMESPACE+"insert_review",dto);
			if(res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] insert_Review");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	@Override
	public int update_Board(BoardDto dto) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession();
			res = session.update(NAMESPACE+"update_board",dto);
			if(res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] update_Board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	@Override
	public int update_Board_Review(BoardDto dto) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession();
			res = session.update(NAMESPACE+"update_board_review",dto);
			if(res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] update_Board_Review");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	@Override
	public int update_Review(BoardDto dto) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession();
			res = session.update(NAMESPACE+"update_review",dto);
			if(res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] update_Review");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	@Override
	public int delete_Board(int board_Group) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession();
			res = session.delete(NAMESPACE+"delete_board",board_Group);
			if(res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] delete_Board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	@Override
	public int delete_review_board(int Board_Category_No) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession();
			res = session.delete(NAMESPACE+"delete_review_board",Board_Category_No);
			if(res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] delete_review_board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	@Override
	public int insert_First_Answer_Board(AnswerBoardDto dto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getSqlSessionFactory().openSession();
			res = session.insert(NAMESPACE+"insert_first_answer_board",dto);
			if(res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] insert_First_Answer_Board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	@Override
	public int update_first_answer_board(AnswerBoardDto dto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getSqlSessionFactory().openSession();
			res = session.insert(NAMESPACE+"update_first_answer_board",dto);
			if(res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] update_first_answer_board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	@Override
	public int insert_Answer(AnswerBoardDto dto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getSqlSessionFactory().openSession();
			res = session.insert(NAMESPACE+"insert_answer_board",dto);
			if(res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] insert_Answer");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}
	
	@Override
	public int update_Answer(AnswerBoardDto dto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getSqlSessionFactory().openSession();
			res = session.update(NAMESPACE+"update_answer_board",dto);
			if(res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] update_Answer");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	@Override
	public int multiDelete_Board(String[] board_Group) {
		SqlSession session = null;
		int res = 0;
		Map<String, String[]> map = new HashMap<String, String[]>();  // map 형태로 값을 보낸다.
	      
		map.put("board_Groups", board_Group); // key : "seqs", value : seq(입력받은 배열)
	      
		try {
			session = getSqlSessionFactory().openSession(false);        // 오토커밋 사용하지 않음
			res = session.delete(NAMESPACE+"multiDelete_board",map);          // map를 전달
			//if(res == board_Group.length) {
				session.commit(); // 전부 삭제 성공했을시만 커밋
			//}
		} catch(Exception e) {
			System.out.println("[ERROR] multiDelete_Board");
			e.printStackTrace();
			} finally {
				session.close();
			}
		return res;
		}

	@Override
	public List<BoardDto> selectList_exercise_name(String board_Exercise_Category) {
		SqlSession session = null;
		List<BoardDto> list = null;
		try {
			session = getSqlSessionFactory().openSession(false);
			list = session.selectList(NAMESPACE+"selectList_exercise_name",board_Exercise_Category);
		} catch (Exception e) {
			System.out.println("[ERROR] selectList_exercise_name");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	@Override
	public List<BoardDto> selectIdList_board(String id, int cPage, int numPerPage) {
		SqlSession session = null;
		List<BoardDto> list = null;
		Map<String, String> map = new HashMap<String, String>();

		String Page = Integer.toString(1 + (numPerPage * (cPage - 1)));
		String numPage = Integer.toString(cPage * numPerPage);
		
		map.put("id", id);
		map.put("cPage",Page);
		map.put("numPerPage",numPage);
		
		try {
			session = getSqlSessionFactory().openSession(false);
			list = session.selectList(NAMESPACE+"selectIdList_board",map);
		} catch (Exception e) {
			System.out.println("[ERROR] selectIdList_board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	@Override
	public List<BoardDto> selectNameList_board(String board_Member_Name, int cPage, int numPerPage) {
		SqlSession session = null;
		List<BoardDto> list = null;
		Map<String, String> map = new HashMap<String, String>();

		String Page = Integer.toString(1 + (numPerPage * (cPage - 1)));
		String numPage = Integer.toString(cPage * numPerPage);
		
		map.put("board_Member_Name", board_Member_Name);
		map.put("cPage",Page);
		map.put("numPerPage",numPage);
		
		try {
			session = getSqlSessionFactory().openSession(false);
			list = session.selectList(NAMESPACE+"selectNameList_board",map);
		} catch (Exception e) {
			System.out.println("[ERROR] selectNameList_board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	@Override
	public List<BoardDto> selectTitleList_board(String board_Title, int cPage, int numPerPage) {
		SqlSession session = null;
		List<BoardDto> list = null;
		Map<String, String> map = new HashMap<String, String>();

		String Page = Integer.toString(1 + (numPerPage * (cPage - 1)));
		String numPage = Integer.toString(cPage * numPerPage);
		
		map.put("board_Title1", board_Title);
		map.put("board_Title2", "%"+board_Title);
		map.put("board_Title3", board_Title+"%");
		map.put("board_Title4", "%"+board_Title+"%");
		map.put("cPage",Page);
		map.put("numPerPage",numPage);
		
		try {
			session = getSqlSessionFactory().openSession(false);
			list = session.selectList(NAMESPACE+"selectTitleList_board",map);
		} catch (Exception e) {
			System.out.println("[ERROR] selectTitleList_board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	
	
	
	@Override
	public List<BoardDto> selectPagingList(int cPage, int numPerPage) {
		SqlSession session = null;
		List<BoardDto> list = null;
		
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		map.put("PageStart", 1 + (numPerPage * (cPage - 1)));
		map.put("PageEnd", cPage * numPerPage);

		try {
			session = getSqlSessionFactory().openSession(false);
			list = session.selectList(NAMESPACE+"selectPagingList_board",map);
		} catch (Exception e) {
			System.out.println("[ERROR] selectPagingList");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	@Override
	public int selectPageingCount() {
		SqlSession session = null;
		int count = 0;
		try {
			session = getSqlSessionFactory().openSession();
			count = session.selectOne(NAMESPACE+"selectAllCount_board");
		} catch (Exception e) {
			System.out.println("[ERROR] selectPageingCount");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return count;
	}

	@Override
	public int selectPageingIdCount(String id) {
		SqlSession session = null;
		int count = 0;
		try {
			session = getSqlSessionFactory().openSession();
			count = session.selectOne(NAMESPACE+"selectIdCount_board",id);
		} catch (Exception e) {
			System.out.println("[ERROR] selectPageingIdCount");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return count;
	}
	
	@Override
	public int selectPageingNameCount(String board_Member_Name) {
		SqlSession session = null;
		int count = 0;
		try {
			session = getSqlSessionFactory().openSession();
			count = session.selectOne(NAMESPACE+"selectNameCount_board",board_Member_Name);
		} catch (Exception e) {
			System.out.println("[ERROR] selectPageingNameCount");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return count;
	}
	
	@Override
	public int selectPageingTitleCount(String board_Title) {
		SqlSession session = null;
		int count = 0;
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("board_Title1", board_Title);
		map.put("board_Title2", "%"+board_Title);
		map.put("board_Title3", board_Title+"%");
		map.put("board_Title4", "%"+board_Title+"%");
		
		try {
			session = getSqlSessionFactory().openSession();
			count = session.selectOne(NAMESPACE+"selectTitleCount_board",map);
		} catch (Exception e) {
			System.out.println("[ERROR] selectPageingTitleCount");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return count;
	}

	@Override
	public int selectEndCount(int board_Group, int board_Group_No) {
		SqlSession session = null;
		int EndCount = 0;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("board_Group", board_Group);
		map.put("board_Group_No", board_Group_No);
		
		try {
			session = getSqlSessionFactory().openSession();
			EndCount = session.selectOne(NAMESPACE+"select_End_Count",map);
		} catch (Exception e) {
			System.out.println("[ERROR] selectEndCount");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return EndCount;
	}

	@Override
	public List<reviewDto> select_reviewAndreview_board(int board_Group, int board_Group_No, int next_board_Group_No) {
		SqlSession session = null;
		List<reviewDto> reviewdto = null;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("group", board_Group);
		map.put("groupno", board_Group_No + 1);
		map.put("nextgroupno", next_board_Group_No - 1);
		
		try {
			session = getSqlSessionFactory().openSession();
			reviewdto = session.selectList(NAMESPACE+"select_reviewAndreview_board",map);
		} catch (Exception e) {
			System.out.println("[ERROR] select_reviewAndreview_board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return reviewdto;
	}

	@Override
	public List<BoardDto> selectIdAndTitleList_board(String Board_Id, String board_Title, int cPage, int numPerPage) {
		SqlSession session = null;
		List<BoardDto> list = null;
		Map<String, String> map = new HashMap<String, String>();

		String Page = Integer.toString(1 + (numPerPage * (cPage - 1)));
		String numPage = Integer.toString(cPage * numPerPage);
		
		
		map.put("board_Title1", board_Title);
		map.put("board_Title2", "%"+board_Title);
		map.put("board_Title3", board_Title+"%");
		map.put("board_Title4", "%"+board_Title+"%");
		map.put("board_Id", Board_Id);
		map.put("cPage",Page);
		map.put("numPerPage",numPage);
		
		try {
			session = getSqlSessionFactory().openSession(false);
			list = session.selectList(NAMESPACE+"selectIdAndTitleList_board",map);
		} catch (Exception e) {
			System.out.println("[ERROR] selectIdAndTitleList_board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	@Override
	public int selectPageingIdAndTitleCount(String Board_Id, String board_Title) {
		SqlSession session = null;
		int count = 0;
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("board_Title1", board_Title);
		map.put("board_Title2", "%"+board_Title);
		map.put("board_Title3", board_Title+"%");
		map.put("board_Title4", "%"+board_Title+"%");
		map.put("board_Id", Board_Id);
		
		try {
			session = getSqlSessionFactory().openSession();
			count = session.selectOne(NAMESPACE+"selectIdAndTitleCount_board",map);
		} catch (Exception e) {
			System.out.println("[ERROR] selectPageingIdAndTitleCount");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return count;
	}

	@Override
	public int select_Search_End_No() {
		SqlSession session = null;
		int EndCount = 0;
		
		try {
			session = getSqlSessionFactory().openSession();
			EndCount = session.selectOne(NAMESPACE+"select_Search_End_No");
		} catch (Exception e) {
			System.out.println("[ERROR] select_Search_End_No");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return EndCount;
	}

	@Override
	public List<reviewDto> selectList_Search_End_board(int board_Group_No) {
		SqlSession session = null;
		List<reviewDto> reviewdto = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			reviewdto = session.selectList(NAMESPACE+"selectList_Search_End_board",board_Group_No);
		} catch (Exception e) {
			System.out.println("[ERROR] selectList_Search_End_board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return reviewdto;
	}

	@Override
	public String check_Id_board(String id) {
		SqlSession session = null;
		String res = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			res = session.selectOne(NAMESPACE+"check_Id",id);
		} catch (Exception e) {
			System.out.println("[ERROR] check_Id_board");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	

	

}