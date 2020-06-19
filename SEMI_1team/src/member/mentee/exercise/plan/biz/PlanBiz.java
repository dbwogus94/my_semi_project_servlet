package member.mentee.exercise.plan.biz;

import java.util.List;

import member.mentee.exercise.plan.dto.PlanDto;

public interface PlanBiz {
   public List<PlanDto> getCalViewList(String id, String yyyyMM);
   public List<PlanDto> selectTodayPlan(PlanDto dto);
   
   //운동계획수행 insert
   public int insertPlanC(PlanDto dto);
   
   //운동수행기록
   public List<PlanDto> selectPlanC(PlanDto dto);
   
   //운동수행기록 삭제
   public int deletePlanC(PlanDto dto);

   public int insertPlan(PlanDto dto);
   public int deletePlan(PlanDto dto);
}