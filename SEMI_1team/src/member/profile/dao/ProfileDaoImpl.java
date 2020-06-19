package member.profile.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import member.profile.db.sqlMapConfig;
import member.profile.dto.ProfileDto;

public class ProfileDaoImpl extends sqlMapConfig implements ProfileDao {

	private String mapper_name = "member.profile.db.Mapper.";

	@Override
	public ProfileDto getProfile(String id) {
		SqlSession session = null;
		ProfileDto dto = null;

		try {
			session = getSqlSessionFactory().openSession();
			dto = session.selectOne(mapper_name + "getProfile", id);
		} catch (Exception e) {
			System.out.println("[Error] profile getProfile");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return dto;
	}

	@Override // 전체 출력
	public List<ProfileDto> selectList_Profile() {
		SqlSession session = null;
		List<ProfileDto> list = null;

		try {
			// 1.2. 커넥션 객체 생성
			session = getSqlSessionFactory().openSession();
			// 3.4
			list = session.selectList(mapper_name + "selectList_Profile");
		} catch (Exception e) {
			System.out.println("[Error] selectList_Profile");
			e.printStackTrace();
		} finally {
			session.close(); // 5
		}

		return list;
	}

	// 멘토 리스트 출력
	@Override
	public List<ProfileDto> selectList_Mentor() {
		SqlSession session = null;
		List<ProfileDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name + "selectList_Mentor");
		} catch (Exception e) {
			System.out.println("[Error] selectList_Mentor");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	// 멘티 리스트 출력
	@Override
	public List<ProfileDto> selectList_Mentee() {
		SqlSession session = null;
		List<ProfileDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name + "selectList_Mentee");
		} catch (Exception e) {
			System.out.println("[Error] selectList_Mentee");
			e.printStackTrace();
		}

		return list;
	}

	// 이름으로 검색 전체에서 , 멘토에서, 멘티에서
	@Override
	public List<ProfileDto> search_Member(String memberName) {
		SqlSession session = null;
		List<ProfileDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name + "search_Member", memberName);
		} catch (Exception e) {
			System.out.println("[Error] search_Member");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<ProfileDto> search_Mentor(String memberName) {
		SqlSession session = null;
		List<ProfileDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name + "search_Mentor", memberName);
		} catch (Exception e) {
			System.out.println("[Error] search_Mentor");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<ProfileDto> search_Memtee(String memberName) {
		SqlSession session = null;
		List<ProfileDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name + "search_Memtee", memberName);
		} catch (Exception e) {
			System.out.println("[Error] search_Memtee");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<ProfileDto> search_Mentor_Mentee(String id) {
		SqlSession session = null;
		List<ProfileDto> list = null;
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name + "search_Mentor_Mentee", id);
		} catch (Exception e) {
			System.out.println("[Error] search_Mentor_Mentee");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	// 로그인 계정 프로필 가져오기(멘토 멘티)
	@Override
	public ProfileDto selectOne_Mentor(String id) {
		SqlSession session = null;
		ProfileDto profileDto = null;

		try {
			session = getSqlSessionFactory().openSession();
			profileDto = session.selectOne(mapper_name + "selectOne_Mentor", id);
		} catch (Exception e) {
			System.out.println("[Error] selectOne_Mentor");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return profileDto;
	}

	@Override
	public ProfileDto selectOne_Mentee(String id) {
		SqlSession session = null;
		ProfileDto profileDto = null;

		try {
			session = getSqlSessionFactory().openSession();
			profileDto = session.selectOne(mapper_name + "selectOne_Mentee", id);
		} catch (Exception e) {
			System.out.println("[Error] selectOne_Mentee");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return profileDto;
	}

	// 멘토 프로필 입력
	@Override
	public int insertProfile_Mentor(ProfileDto profileDto) {
		SqlSession session = null;
		int res = 0;

		try {
			session = getSqlSessionFactory().openSession(false);
			res = session.insert(mapper_name + "insertProfile_Mentor", profileDto);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[Error] insertProfile_Mentor");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	// 멘티 프로필 입력
	@Override
	public int insertProfile_Mentee(ProfileDto profileDto) {
		SqlSession session = null;
		int res = 0;

		try {
			session = getSqlSessionFactory().openSession(false);
			res = session.insert(mapper_name + "insertProfile_Mentee", profileDto);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[Error] insertProfile_Mentee");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	// 프로필 수정(멘토)
	@Override
	public int updateProfile_Mentor(ProfileDto profileDto) {
		SqlSession session = null;
		int res = 0;
		try {
			session =getSqlSessionFactory().openSession(false);
			res = session.update(mapper_name+"updateProfileMentor", profileDto);
			System.out.println(profileDto.getMemberCareer());
			if(res>0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[error] updateProfile_Mentor");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	// 프로필 수정(멘티)
	@Override
	public int updateProfile_Mentee(ProfileDto profileDto) {
		SqlSession session = null;
		int res = 0;
		try {
			session =getSqlSessionFactory().openSession(false);
			res = session.update(mapper_name+"updateProfileMentee", profileDto);
			System.out.println(profileDto.getMemberCareer());
			if(res>0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[error] updateProfile_Mentee");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	@Override
	public List<ProfileDto> getMentorList() {
		SqlSession session = null;
		List<ProfileDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name + "getMentorList");
		} catch (Exception e) {
			System.out.println("[Error] profile getMentorList");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public int updateProfilePay(String id) {
		SqlSession session = null;
		int res = 0;

		try {
			session = getSqlSessionFactory().openSession();
			res = session.update(mapper_name + "updateProfilePay", id);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	@Override
	public List<ProfileDto> searchMentor(String name) {
		SqlSession session = null;
		List<ProfileDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(mapper_name + "searchMentor", name);
		} catch (Exception e) {
			System.out.println("[Error] profile getMentorList");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public boolean phoneCheck(String profilePhoneNumber) {
		SqlSession session = null;
		String res_phoneNumber = "";
		boolean b = false;
		try {
			session=getSqlSessionFactory().openSession();
			res_phoneNumber = session.selectOne(mapper_name+"phoneCheck", profilePhoneNumber);
			if(!(res_phoneNumber.equals(""))) {
				b=true;
			}
		} catch (Exception e) {
			System.out.println("[error] phoneCheck");
			e.printStackTrace();
		}finally {
			session.close();
		}
		return b;
	}
	
	//멘토 이미지 src 추가
		@Override
		public int UpdateSrc_Mentor(ProfileDto profileDto) {
			SqlSession session = null;
			int res = 0;
			System.out.println("매퍼:"+profileDto.getId());
			System.out.println("매퍼"+profileDto.getMemberContent());
			
			try {
				session = getSqlSessionFactory().openSession();
				res = session.update(mapper_name+"updateSrc", profileDto);
				if(res>0) {
					session.commit();
				}
				
			} catch (Exception e) {
				System.out.println("[error] UpdateSrc");
				e.printStackTrace();
			}finally {
				session.close();
			}
			return res;
		}


}
