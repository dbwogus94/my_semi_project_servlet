package member.trade.biz;

import java.util.List;

import member.trade.dto.TradeDto;

public interface TradeBiz {
	public int insertTradePay(String type, String id, String impUid);
	
	// id로 해당 내역 가져오기
	public List<TradeDto> selectList_oneMentor(String id);
	
	// 관리자에서 id로 해당 멘티 지출 내역 가져오기
	public List<TradeDto> selectList_oneMenteeAM(String id);
	
	// 멘토 수익 페이징 리스트
	public List<TradeDto>selectPagingList_oneMentor(String id, int cPage, int numPerPage);
}
