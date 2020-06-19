package member.mentee.exercise.plan.biz;

import java.util.List;

import member.mentee.exercise.plan.dao.PlanDao;
import member.mentee.exercise.plan.dao.PlanDaoImpl;
import member.mentee.exercise.plan.dto.PlanDto;

public class PlanBizImpl implements PlanBiz {
	PlanDao dao = new PlanDaoImpl();

	@Override
	public List<PlanDto> getCalViewList(String id, String yyyyMM) {
		// TODO Auto-generated method stub
		return dao.getCalViewList(id, yyyyMM);
	}

	@Override
	public List<PlanDto> selectTodayPlan(PlanDto dto) {
		// TODO Auto-generated method stub
		return dao.selectTodayPlan(dto);
	}

	@Override
	public int insertPlanC(PlanDto dto) {
		// TODO Auto-generated method stub
		return dao.insertPlanC(dto);
	}

	@Override
	public List<PlanDto> selectPlanC(PlanDto dto) {
		// TODO Auto-generated method stub
		return dao.selectPlanC(dto);
	}

	@Override
	public int deletePlanC(PlanDto dto) {
		// TODO Auto-generated method stub
		return dao.deletePlanC(dto);
	}

	@Override
	public int insertPlan(PlanDto dto) {
		// TODO Auto-generated method stub
		return dao.insertPlan(dto);
	}

	@Override
	public int deletePlan(PlanDto dto) {
		// TODO Auto-generated method stub
		return dao.deletePlan(dto);
	}
}
