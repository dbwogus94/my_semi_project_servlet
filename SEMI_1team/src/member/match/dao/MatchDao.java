package member.match.dao;

import java.util.List;

import member.match.dto.MatchDto;

public interface MatchDao {
	
	// 멘토에서 아이디로 멘티 검색
	public List<MatchDto> search_Mentor_Mentee(String id);
	
	// 멘티에서 멘토 검색
	public String search_Mentee_Mentor(String id);
	
	// 멘토아이디로 메치 테이블 번호와 멘티아이디를 리스트로 가져온다.
	public List<MatchDto> search_Mentor_Mentee_All(String id);
	
	// 멘티아이디로 메치 테이블 번호와 멘토아이디 가져오기
	public MatchDto search_Mentee_Mentor__All(String id);
	
	//멘토 멘티 매칭
	public int insertMatch(String menteeId, String mentorId);
	
	//멘토있으면
	public MatchDto getMyMentor(String id);
	
}
