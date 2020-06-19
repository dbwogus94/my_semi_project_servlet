package member.match.biz;

import java.util.List;

import member.match.dao.MatchDao;
import member.match.dao.MatchDaoImpl;
import member.match.dto.MatchDto;

public class MatchBizImpl implements MatchBiz {
	private MatchDao MatchDao = new MatchDaoImpl();

	@Override
	public List<MatchDto> search_Mentor_Mentee(String id) {
		return MatchDao.search_Mentor_Mentee(id);
	}

	@Override
	public String search_Mentee_Mentor(String id) {
		// TODO Auto-generated method stub
		return MatchDao.search_Mentee_Mentor(id);
	}

	@Override
	public List<MatchDto> search_Mentor_Mentee_All(String id) {
		// TODO Auto-generated method stub
		return MatchDao.search_Mentor_Mentee_All(id);
	}

	@Override
	public MatchDto search_Mentee_Mentor__All(String id) {
		// TODO Auto-generated method stub
		return MatchDao.search_Mentee_Mentor__All(id);
	}

	@Override
	public int insertMatch(String menteeId, String mentorId) {
		// TODO Auto-generated method stub
		return MatchDao.insertMatch(menteeId, mentorId);
	}

	@Override
	public MatchDto getMyMentor(String id) {
		// TODO Auto-generated method stub
		return MatchDao.getMyMentor(id);
	}
	
	

}
