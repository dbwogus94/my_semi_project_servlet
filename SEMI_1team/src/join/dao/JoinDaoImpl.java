package join.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import All.statics.join.LoginProfile.dto.LoginProfileDto;
import join.db.sqlMapConfig;
import join.dto.JoinDto;
import oracle.jdbc.OracleConnection.CommitOption;

public class JoinDaoImpl extends sqlMapConfig implements JoinDao {
	private String mapper_name = "join.db.Mapper.";
	
	// 로그인
	@Override
	public JoinDto Login(String id, String joinPw) {
		SqlSession session = null;
		JoinDto dto = null;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("id",  id);
		map.put("joinPw", joinPw);
		
		try {
			// 1.드라이버 연결 2.계정연결 Connection객체 생성 오토커밋
			session = getSqlSessionFactory().openSession();
			// 3.쿼리준비 4.실행 및 리턴 
			dto = session.selectOne(mapper_name+"Login", map);
			System.out.println("확인: "+dto);
		} catch (Exception e) {
			System.out.println("[Error] Login");
			e.printStackTrace();
		} finally {
			session.close();  // 5.종료
		}
		return dto;
	}

	
	//아이디 체크  >>> id가 있냐? > 있음. 그럼 중복 사용불가
	@Override
	public boolean idCheck(String id) {
		SqlSession session = null;
		String res_id = "";
		boolean b = false;
		
		try {
			session = getSqlSessionFactory().openSession();
			res_id = session.selectOne(mapper_name+"idCheck" , id);
			if(!(res_id.equals(""))) { 	// 빈값이 아니라면 >> 중복
				b = true;					// true면 중복
			}
		} catch (Exception e) {
			System.out.println("[Error] idCheck");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return b;
	}

	@Override
	public boolean emailCheck(String joinEmail) {
		SqlSession session = null;
		String res_email = "";
		boolean b = false;
		
		try {
			session = getSqlSessionFactory().openSession();
			res_email = session.selectOne(mapper_name+"emailCheck", joinEmail);
			if(!(res_email.equals(""))) {
				b = true;
			}
		} catch (Exception e) {
			System.out.println("[Error] emailCheck");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return b;
	}

	@Override
	public int insertMember(JoinDto joinDto) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(false);
			res = session.insert(mapper_name+"insertMember", joinDto);
			System.out.println("res : "+res);
			if(res>0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[Error] insertMember");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}


	
	// 전체 출력
	@Override
	public List<JoinDto> selectList_join() {
		SqlSession session = null;
		List<JoinDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name+"selectList_join");
		} catch (Exception e) {
			System.out.println("[Error] selectList_join");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	
	// 미승인 멘토리스트 출력
	@Override
	public List<JoinDto> selsList_Mentor_reN() {
		SqlSession session = null;
		List<JoinDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name+"selsList_Mentor_reN");
		} catch (Exception e) {
			System.out.println("[Error] selsList_Mentor_reN");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	// 프로필 미작성 멘티 출력
	@Override
	public List<JoinDto> selsList_Mentee_reN() {
		SqlSession session = null;
		List<JoinDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name+"selsList_Mentee_reN");
		} catch (Exception e) {
			System.out.println("[Error] selsList_Mentee_reN");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	
	// 전체에서 아이디으로 검색
	@Override
	public List<JoinDto> selectList_join(String id) {
		SqlSession session = null;
		List<JoinDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name+"selectList_join_id", id);
		} catch (Exception e) {
			System.out.println("[Error] selectList_join");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	// 미승인 멘토 이름으로 검색
	@Override
	public List<JoinDto> selsList_Mentor_reN(String id) {
		SqlSession session = null;
		List<JoinDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name+"selsList_Mentor_reN_id", id);
		} catch (Exception e) {
			System.out.println("[Error] selsList_Mentor_reN");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	// 프로필 미작성 멘티 이름으로 검색
	@Override
	public List<JoinDto> selsList_Mentee_reN(String id) {
		SqlSession session = null;
		List<JoinDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name+"selsList_Mentee_reN_id", id);
		} catch (Exception e) {
			System.out.println("[Error] selsList_Mentee_reN");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	
	
	
	
	
	// 가입자 프로필 작성유무 칼럼 'Y'수정
	@Override
	public int updateJoinRegister(String id, String joinRegisterYn) {
		SqlSession session  = null;
		int res = 0;
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("joinRegisterYn", joinRegisterYn);

		try {
			session = getSqlSessionFactory().openSession(false);
			res = session.update(mapper_name+"updateJoinRegister", map);
			if(res>0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[Error] updateJoinRegister");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	

	
	
	//패스워드 변경용 id, pw 가져오기
	@Override
	public JoinDto passwordChange(String id) {
		SqlSession session = null;
		JoinDto joinDto = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			joinDto = session.selectOne(mapper_name+"passwordChange", id);
		} catch (Exception e) {
			System.out.println("[error] passwordChange");
			e.printStackTrace();
		}finally {
			session.close();
		}
		return joinDto;
	}


	@Override
	public int updatePassword(String id, String pw) {
		SqlSession session = null;
		int res = 0;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pw", pw);
		
		try {
			session = getSqlSessionFactory().openSession();
			res = session.update(mapper_name+"updatePassword", map);
			if(res>0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[error] updatePassword");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res;
	}


	@Override
	public int updateLeave(String id) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession();
			res =  session.update(mapper_name+"updateLeave", id);
			if(res>0) {
				session.commit();
			}
		} catch (Exception e) {
			System.err.println("[error] updateLeave");
			e.printStackTrace();
		}finally {
			session.close();
		}
		return res;
	}

	//아이디 찾기
	@Override
	public JoinDto IdSearch(String email) {
		SqlSession session = null;
		JoinDto joinDto = null;
		

			try {
				session = getSqlSessionFactory().openSession();
				joinDto = session.selectOne(mapper_name+"idSearch", email);
			} catch (Exception e) {
				System.out.println("[error] IdSearch");
				e.printStackTrace();
			}finally {
				session.close();
			}
		return joinDto;
	}

	//비밀번호 찾기용(id, email) 정보 확인
	@Override
	public boolean PwCheck(String id, String email) {
		SqlSession session = null;
		String res_email = "";
		boolean b = false;
		Map<String, String> map = new HashMap<String, String>();
		map.put("id",  id);
		map.put("email", email);
		
		try {
			session = getSqlSessionFactory().openSession();
			res_email = session.selectOne(mapper_name+"PwCheck", map);
			if(!(res_email.equals(""))) {  // 결과가 있다면 등록된 이메일인 것
				b = true;
			}
		} catch (Exception e) {
			System.out.println("[Error] emailCheck");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return b;
	}

//비밀번호 찾기용 정보 불러오기
	@Override
	public JoinDto PwInfo(String id) {
		SqlSession session = null;
		JoinDto joinDto = null;
		
		try {
			session= getSqlSessionFactory().openSession();
			joinDto = session.selectOne(mapper_name+"PwInfo", id);
			
		} catch (Exception e) {
			System.out.println("[error] PwInfo");
			e.printStackTrace();
		}finally {
			session.close();
		}
		return joinDto;
	}



	
	// join테이블 profile테이블 조인 Dao========================	
		
		// id를 이용해   LoginProfileDto의 멘토 정보 접근
		@Override
		public LoginProfileDto getLoginProfileDto_mentor(String id) {
			SqlSession session = null;
			LoginProfileDto loginProfileDto = null;
			
			try {
				session = getSqlSessionFactory().openSession();
				loginProfileDto = session.selectOne(mapper_name+"getLoginProfileDto_mentor", id);
			} catch (Exception e) {
				System.out.println("[Error] getLoginProfileDto_mentor");
				e.printStackTrace();
			} finally {
				session.close();
			}
			
			return loginProfileDto;
		}


		// id를 이용해   LoginProfileDto의 멘티 정보 접근
		@Override
		public LoginProfileDto getLoginProfileDto_mentee(String id) {
			SqlSession session = null;
			LoginProfileDto loginProfileDto = null;
			
			try {
				session = getSqlSessionFactory().openSession();
				loginProfileDto = session.selectOne(mapper_name+"getLoginProfileDto_mentee", id);
			} catch (Exception e) {
				System.out.println("[Error] getLoginProfileDto_mentee");
				e.printStackTrace();
			} finally {
				session.close();
			}
			
			return loginProfileDto;
		}


		@Override
		public List<LoginProfileDto> selectList_MentorList() {
			SqlSession session = null;
			List<LoginProfileDto> list = null;

			try {
				session = getSqlSessionFactory().openSession();
				list = session.selectList("join.db.Mapper.loginProfile_mentorList");
			} catch (Exception e) {
				System.out.println("[Error] join searchMentorList");
				e.printStackTrace();
			} finally {
				session.close();
			}

			return list;
		}

		@Override
		public List<LoginProfileDto> search_MentorName(String memberName) {
			SqlSession session = null;
			List<LoginProfileDto> list = null;

			try {
				session = getSqlSessionFactory().openSession();
				list = session.selectList("join.db.Mapper.loginProfile_mentorSearch", memberName);
			} catch (Exception e) {
				System.out.println("[Error] join searchMentorMemberName");
				e.printStackTrace();
			} finally {
				session.close();
			}

			return list;
		}





}
