package member.mentee.exercise.plan.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import member.mentee.exercise.plan.db.sqlMapConfig;
import member.mentee.exercise.plan.dto.PlanDto;

public class PlanDaoImpl extends sqlMapConfig implements PlanDao {

   private String namespace = "member.mentee.exercise.plan.db.Mapper.";

   @Override
   public List<PlanDto> getCalViewList(String id, String yyyyMM) {
      SqlSession session = null;
      List<PlanDto> list = null;
      HashMap<String, String> data = new HashMap<String, String>();
      data.put("id", id);
      data.put("yyyyMM", yyyyMM);

      try {
         session = getSqlSessionFactory().openSession();
         list = session.selectList(namespace + "getCalViewList", data);
      } catch (Exception e) {
         System.out.println("[Error] Plan getCalViewList");
         e.printStackTrace();
      } finally {
         session.close();
      }
      return list;
   }

   @Override
   public List<PlanDto> selectTodayPlan(PlanDto dto) {
      SqlSession session = null;
      List<PlanDto> list = null;

      try {
         session = getSqlSessionFactory().openSession();
         list = session.selectList(namespace + "selectTodayPlan", dto);
      } catch (Exception e) {
         System.out.println("[Error] Plan selectTodayPlan");
         e.printStackTrace();
      } finally {
         session.close();
      }

      return list;
   }

   @Override
   public int insertPlanC(PlanDto dto) {
      SqlSession session = null;
      int res = 0;

      try {
         session = getSqlSessionFactory().openSession();
         res = session.insert(namespace + "insertPlanC", dto);
         if (res > 0) {
            session.commit();
         }
      } catch (Exception e) {
         System.out.println("[Error] Plan insertPlanC");
         e.printStackTrace();
      } finally {
         session.close();
      }

      return res;
   }

   @Override
   public List<PlanDto> selectPlanC(PlanDto dto) {
      SqlSession session = null;
      List<PlanDto> list = null;

      try {
         session = getSqlSessionFactory().openSession();
         list = session.selectList(namespace + "selectPlanC", dto);
      } catch (Exception e) {
         System.out.println("[Error] Plan selectPlanC");
         e.printStackTrace();
      } finally {
         session.close();
      }

      return list;
   }

   @Override
   public int deletePlanC(PlanDto dto) {
      SqlSession session = null;
      int res = 0;

      try {
         session = getSqlSessionFactory().openSession();
         res = session.insert(namespace + "deletePlanC", dto);
         if (res > 0) {
            session.commit();
         }
      } catch (Exception e) {
         System.out.println("[Error] Plan deletePlanC");
         e.printStackTrace();
      } finally {
         session.close();
      }

      return res;
   }
   
   
   @Override
   public int insertPlan(PlanDto dto) {
      SqlSession session = null;
      int res = 0;
      
      try {
         session = getSqlSessionFactory().openSession();
         res = session.insert(namespace + "insertPlan", dto);
         
         if(res > 0) {
            session.commit();
         }
      } catch(Exception e) {
         System.out.println("[ERROR] Plan Insert");
         e.printStackTrace();
      } finally {
         session.close();
      }
      
      return res;
   }
   
   @Override
   public int deletePlan(PlanDto dto) {
      SqlSession session = null;
      int res = 0;
      
      try {
         session = getSqlSessionFactory().openSession();
         res = session.delete(namespace + "deletePlan", dto);
         
         if(res > 0) {
            session.commit();
         }
      } catch(Exception e) {
         System.out.println("[ERROR] Plan Delete");
         e.printStackTrace();
      } finally {
         session.close();
      }
      
      return res;
   }

}