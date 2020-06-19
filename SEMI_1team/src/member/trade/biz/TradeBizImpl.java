package member.trade.biz;

import java.util.List;

import member.trade.dao.TradeDao;
import member.trade.dao.TradeDaoImpl;
import member.trade.dto.TradeDto;

public class TradeBizImpl implements TradeBiz {

	TradeDao dao = new TradeDaoImpl();
	
	@Override
	public int insertTradePay(String type, String id, String impUid) {
		// TODO Auto-generated method stub
		return dao.insertTradePay(type, id, impUid);
	}

	@Override
	public List<TradeDto> selectList_oneMentor(String id) {
		// TODO Auto-generated method stub
		return dao.selectList_oneMentor(id);
	}

	@Override
	public List<TradeDto> selectList_oneMenteeAM(String id) {
		// TODO Auto-generated method stub
		return dao.selectList_oneMenteeAM(id);
	}

	@Override
	public List<TradeDto> selectPagingList_oneMentor(String id, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectPagingList_oneMentor(id, cPage, numPerPage);
	}
}
