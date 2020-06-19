package member.match.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import member.match.db.sqlMapConfig;
import member.match.dto.MatchDto;

public class MatchDaoImpl extends sqlMapConfig implements MatchDao {
	private String mapper_name = "member.match.db.Mapper.";
	
	@Override
	public List<MatchDto> search_Mentor_Mentee(String id) {
		SqlSession session = null;
		List<MatchDto> list = null;
		try {
			session=getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name+"search_Mentor_Mentee", id);
		} catch (Exception e) {
			System.out.println("[Error] search_Mentor_Mentee");
			e.printStackTrace();
		}finally {
			session.close();
		}
		return list;
	}

	@Override
	public String search_Mentee_Mentor(String id) {
		SqlSession session = null;
		String mentorId = "";
		
		try {
			session = getSqlSessionFactory().openSession();
			mentorId = session.selectOne(mapper_name+"search_Mentee_Mentor", id);
		} catch (Exception e) {
			System.out.println("[Error] search_Mentee_Mentor");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return mentorId;
	}
	// 멘토 아이디로 메치 테이블 번호와 연결된 멘티 id를 리스트로 가져오기
	@Override
	public List<MatchDto> search_Mentor_Mentee_All(String id) {
		SqlSession session = null;
		List<MatchDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name+"search_Mentor_Mentee_All", id);
		} catch (Exception e) {
			System.out.println("[Error] search_Mentor_Mentee_All");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return list;
	}

	
	// 멘티 아이디로 메치 테이블 번호와 연결된 멘토 id가져오기
	@Override
	public MatchDto search_Mentee_Mentor__All(String id) {
		SqlSession session = null;
		MatchDto matchDto = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			matchDto = session.selectOne(mapper_name+"search_Mentee_Mentor__All", id);
		} catch (Exception e) {
			System.out.println("[Error] search_Mentee_Mentor__All");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return matchDto;
	}
	
	@Override
	public int insertMatch(String menteeId, String mentorId) {
		SqlSession session = null;
		int res = 0;
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("menteeId", menteeId);
		data.put("mentorId", mentorId);

		try {
			session = getSqlSessionFactory().openSession();
			res = session.insert(mapper_name + "insertMatch", data);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[Error] match insertMatch");
			e.printStackTrace();

		} finally {
			session.close();
		}
		return res;
	}

	@Override
	public MatchDto getMyMentor(String id) {
		SqlSession session = null;
		MatchDto res = null;
		try {
			session = getSqlSessionFactory().openSession();
			res = session.selectOne(mapper_name + "getMyMentor", id);
			
		} catch (Exception e) {
			System.out.println("[Error] match getMyMentor");
			e.printStackTrace();

		} finally {
			session.close();
		}
		return res;
	}

	
	
}
