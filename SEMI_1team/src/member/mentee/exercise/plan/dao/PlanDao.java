package member.mentee.exercise.plan.dao;

import java.util.List;

import member.mentee.exercise.plan.dto.PlanDto;

public interface PlanDao {
   public List<PlanDto> getCalViewList(String id, String yyyyMM);
   
   // [운동기록] 버튼 누를 시에 나오는 플랜(P)
   public List<PlanDto> selectTodayPlan(PlanDto dto);
   
   // 운동계획수행(C) insert
   public int insertPlanC(PlanDto dto);
   
   // 운동수행기록
   public List<PlanDto> selectPlanC(PlanDto dto);
   
   // 운동수행기록 삭제
   public int deletePlanC(PlanDto dto);
      
   public int insertPlan(PlanDto dto);
   public int deletePlan(PlanDto dto);
}