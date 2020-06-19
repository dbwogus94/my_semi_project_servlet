package member.trade.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import member.board.dto.BoardDto;
import member.trade.db.sqlMapConfig;
import member.trade.dto.TradeDto;

public class TradeDaoImpl extends sqlMapConfig implements TradeDao {

	private String namespace = "member.trade.db.Mapper.";

	@Override
	public int insertTradePay(String type, String id, String impUid) {
		SqlSession session = null;
		int res = 0;
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("type", type);
		data.put("id", id);
		data.put("impUid", impUid);

		try {
			session = getSqlSessionFactory().openSession();
			res = session.insert(namespace + "insertTradePay", data);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[Error] total insertTotal");
			e.printStackTrace();

		} finally {
			session.close();
		}
		return res;
	}

	// 멘토 자기 수익 내역 확인
	@Override
	public List<TradeDto> selectList_oneMentor(String id) {
		SqlSession session = null;
		List<TradeDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace+"selectList_oneMentor", id);
		} catch (Exception e) {
			System.out.println("[Error] selectList_oneMentor");
			e.printStackTrace();
		}
				
		return list;
	}
	
	// 관리자가 멘티 지출내역 확인
	@Override
	public List<TradeDto> selectList_oneMenteeAM(String id) {
		SqlSession session = null;
		List<TradeDto> list = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace+"selectList_oneMenteeAM", id);
		} catch (Exception e) {
			System.out.println("[Error] selectList_oneMenteeAM");
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<TradeDto> selectPagingList_oneMentor(String id, int cPage, int numPerPage) {
		SqlSession session = null;
		List<TradeDto> list = null;
		Map<String, String> map = new HashMap<String, String>();

		String Page = Integer.toString(1 + (numPerPage * (cPage - 1)));
		String numPage = Integer.toString(cPage * numPerPage);
		
		map.put("id", id);
		map.put("cPage",Page);
		map.put("numPerPage",numPage);
		
		try {
			session = getSqlSessionFactory().openSession(false);
			list = session.selectList(namespace+"selectPagingList_oneMentor",map);
		} catch (Exception e) {
			System.out.println("[ERROR] selectPagingList_oneMentor");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

}