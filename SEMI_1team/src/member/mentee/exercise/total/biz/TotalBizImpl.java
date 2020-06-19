package member.mentee.exercise.total.biz;

import java.sql.Date;
import java.util.List;

import member.mentee.exercise.total.dao.TotalDao;
import member.mentee.exercise.total.dao.TotalDaoImpl;
import member.mentee.exercise.total.dto.TotalDto;
import net.sf.json.JSONArray;

public class TotalBizImpl implements TotalBiz {

	TotalDao dao = new TotalDaoImpl();

	@Override
	public List<TotalDto> selectList_total(String id) {
		return dao.selectList_total(id);
	}

	@Override
	public List<TotalDto> getCalViewList(String id, String yyyyMM) {
		// TODO Auto-generated method stub
		return dao.getCalViewList(id, yyyyMM);
	}

	@Override
	public int insert_total(TotalDto dto) {
		return dao.insert_total(dto);
	}

	@Override
	public int update_total(TotalDto dto) {
		// TODO Auto-generated method stub
		return dao.update_total(dto);
	}

	@Override
	public JSONArray getWeightChartView(String id) {
		// TODO Auto-generated method stub
		return dao.getWeightChartView(id);
	}

	@Override
	public JSONArray getExerciseChartView(String id) {
		// TODO Auto-generated method stub
		return dao.getExerciseChartView(id);
	}


	@Override
	public int delete_total(TotalDto dto) {
		// TODO Auto-generated method stub
		return dao.delete_total(dto);
	}

	@Override
	public JSONArray getWeightChartViewM(String id, int month) {
		// TODO Auto-generated method stub
		return dao.getWeightChartViewM(id, month);
	}

	@Override
	public JSONArray getExerciseChartViewM(String id, int month) {
		// TODO Auto-generated method stub
		return dao.getExerciseChartViewM(id, month);
	}

	@Override
	public int deleteTimeCal(TotalDto dto) {
		// TODO Auto-generated method stub
		return dao.deleteTimeCal(dto);
	}

	@Override
	public int insertTimeCal(TotalDto dto) {
		return dao.insertTimeCal(dto);
	}


	@Override
	public double getTodayWeight(String id, String totalDate) {
		// TODO Auto-generated method stub
		return dao.getTodayWeight(id, totalDate);
	}

	@Override
	public TotalDto getTodayTotal(String id, String totalDate) {
		// TODO Auto-generated method stub
		return dao.getTodayTotal(id, totalDate);
	}

	@Override
	public TotalDto selectTimeCal(TotalDto dto) {
		// TODO Auto-generated method stub
		return dao.selectTimeCal(dto);
	}
}