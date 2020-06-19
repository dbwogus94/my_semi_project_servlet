package member.mentee.exercise.plan.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import All.statics.Util;
import All.statics.join.LoginProfile.dto.LoginProfileDto;
import member.mentee.exercise.plan.biz.PlanBiz;
import member.mentee.exercise.plan.biz.PlanBizImpl;
import member.mentee.exercise.plan.dto.PlanDto;
import member.mentee.exercise.total.biz.TotalBiz;
import member.mentee.exercise.total.biz.TotalBizImpl;
import member.mentee.exercise.total.dto.TotalDto;

@WebServlet("/PlanServlet")
public class PlanServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;

   public PlanServlet() {
   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");
      String command = request.getParameter("command");
      System.out.println("<" + command + ">");

      PlanBiz planBiz = new PlanBizImpl();
      HttpSession session = request.getSession();

      if(command.equals("planMain")) {
         response.sendRedirect("MENTEE/CALENDAR/MENTEE_ExercisePlan.jsp");
      } else if (command.equals("getPlan")) {
         // 아이디
         LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
         String id = menteeDto.getId();
         // 날짜
         Calendar cal = Calendar.getInstance();
         int year = cal.get(Calendar.YEAR);
         int month = cal.get(Calendar.MONTH) + 1;
         int date = cal.get(Calendar.DATE);
         cal.set(year, month - 1, date);
         // 요일
         int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
         String planDayofweek = Util.getDayOfWeek(dayOfWeek);

         System.out.println(year);
         System.out.println(month);
         System.out.println(date);
         System.out.println(planDayofweek);

         PlanDto dto = new PlanDto();
         dto.setId(id);
         dto.setPlanDayofweek(planDayofweek);
         List<PlanDto> planList = planBiz.selectTodayPlan(dto);
         request.setAttribute("year", year);
         request.setAttribute("month", month);
         request.setAttribute("date", date);
         request.setAttribute("planList", planList);
         
         //운동수행기록
         PlanDto dto2 = new PlanDto();
         dto2.setId(id);
         dto2.setPlanDate(year + "" + Util.isTwo(Integer.toString(month)) + "" + Util.isTwo(Integer.toString(date)));
         List<PlanDto> planCList = planBiz.selectPlanC(dto2);
         request.setAttribute("planCList", planCList);
         
         dispacher("MENTEE/CALENDAR/MENTEE_ExerciseInsert.jsp", request, response);

         // 날짜 선택시 선택날짜의 운동플랜 보여주기
      } else if (command.equals("getSelectPlan")) {
         // 아이디
         LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
         String id = menteeDto.getId();
         // 날짜
         Calendar cal = Calendar.getInstance();
         int year = Integer.parseInt(request.getParameter("year"));
         int month = Integer.parseInt(request.getParameter("month"));
         int date = Integer.parseInt(request.getParameter("date"));
         cal.set(year, month - 1, date);
         // 요일
         int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
         String planDayofweek = Util.getDayOfWeek(dayOfWeek);

         PlanDto dto = new PlanDto();
         dto.setId(id);
         dto.setPlanDayofweek(planDayofweek);

         System.out.println(year);
         System.out.println(month);
         System.out.println(date);
         System.out.println();
         List<PlanDto> planList = planBiz.selectTodayPlan(dto);
         System.out.println(planList);
         request.setAttribute("year", year);
         request.setAttribute("month", month);
         request.setAttribute("date", date);
         request.setAttribute("planList", planList);

         //운동수행기록
         PlanDto dto2 = new PlanDto();
         dto2.setId(id);
         dto2.setPlanDate(year + "" + Util.isTwo(Integer.toString(month)) + "" + Util.isTwo(Integer.toString(date)));
         List<PlanDto> planCList = planBiz.selectPlanC(dto2);
         request.setAttribute("planCList", planCList);
         dispacher("MENTEE/CALENDAR/MENTEE_ExerciseInsert.jsp", request, response);

      } else if (command.equals("insertPlanC")) {
         // 날짜
         Calendar cal = Calendar.getInstance();
         int year = Integer.parseInt(request.getParameter("year"));
         int month = Integer.parseInt(request.getParameter("month"));
         int date = Integer.parseInt(request.getParameter("date"));
         cal.set(year, month - 1, date);
         // 요일
         int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
         String planDayofweek = Util.getDayOfWeek(dayOfWeek);

         String category = request.getParameter("category");
         String exerciseName = request.getParameter("exerciseName");
         int count = Integer.parseInt(request.getParameter("count"));

         // 받아온 데이터 dto에 넣어주기
         PlanDto dto = new PlanDto();
         LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
         String id = menteeDto.getId();
         dto.setId(id);
         dto.setPlanDate(year + "" + Util.isTwo(Integer.toString(month)) + "" + Util.isTwo(Integer.toString(date)));
         dto.setPlanCategory(category);
         dto.setExerciseName(exerciseName);
         dto.setPlanDayofweek(planDayofweek);
         if (category.equals("유산소")) {
            dto.setPlanTime(count);
         } else {
            dto.setPlanCount(count);
         }
         System.out.println(dto.getPlanDate());
         System.out.println(dto.getPlanDayofweek());
         // insert
         int res = planBiz.insertPlanC(dto);

      } else if (command.equals("getPlanC")) {
         // 아이디
         LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
         String id = menteeDto.getId();
         // 날짜
         String date = request.getParameter("date");
         System.out.println(date);
         PlanDto dto = new PlanDto();
         dto.setId(id);
         dto.setPlanDate(date);
         List<PlanDto> planList = planBiz.selectPlanC(dto);
         request.setAttribute("planList", planList);
         
         //칼로리, 시간 가져오기
         TotalBiz totalBiz = new TotalBizImpl();
         TotalDto totalDto = new TotalDto();
         totalDto.setTotalDate(date);
         totalDto.setId(id);
         TotalDto selectTimeCal = totalBiz.selectTimeCal(totalDto);
         request.setAttribute("selectTimeCal", selectTimeCal);
         dispacher("MENTEE/CALENDAR/MENTEE_ExerciseDetail.jsp", request, response);

      } else if (command.equals("deletePlanC")) {
         // 아이디
         LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
         String id = menteeDto.getId();
         //날짜
         String date = request.getParameter("date");
         PlanDto dto = new PlanDto();
         dto.setId(id);
         dto.setPlanDate(date);
         //plan 테이블 데이터 삭제
         int planRes = planBiz.deletePlanC(dto);
         //total 테이블 데이터 삭제
         TotalBiz totalBiz = new TotalBizImpl();
         TotalDto totalDto = new  TotalDto();
         totalDto.setId(id);
         totalDto.setTotalDate(date);
         int totalRes = totalBiz.deleteTimeCal(totalDto);
         
      } else if(command.equals("insertPlan")) {
            String date = request.getParameter("date");
            System.out.println(date);
            String category = request.getParameter("category");
            String exerciseName = request.getParameter("exerciseName");
            String count = request.getParameter("count");
         
            
        } else if(command.equals("planInsert")) {
           LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
            String id = menteeDto.getId();
            
            String planCategory = request.getParameter("planCategory");
            String exerciseName = request.getParameter("exerciseName");
            String count = request.getParameter("planCount");
            int planTime = 0;
            String dayOfWeek = request.getParameter("dayOfWeek");
            int planCount = 0;
            
            if(planCategory.equals("유산소")) {
               planTime = Integer.parseInt(request.getParameter("planTime"));
               count = "0";
            }
            
            if(count.equals("10회")) {
               planCount = 10;
            } else if(count.equals("15회")) {
               planCount = 15;
            } else if(count.equals("20회")) {
               planCount = 20;
            }
            
            System.out.println("id: " + id);
            System.out.println("category: " + planCategory);
            System.out.println("exercise: " + exerciseName);
            System.out.println("count: " + planCount);
            System.out.println("time: " + planTime);
            System.out.println("day: " + dayOfWeek);
            
            
            
            if(dayOfWeek.equals("mon")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "월", "P");
               planBiz.insertPlan(dto);
            } else if(dayOfWeek.equals("tue")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "화", "P");
               planBiz.insertPlan(dto);
            } else if(dayOfWeek.equals("wen")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "수", "P");
               planBiz.insertPlan(dto);
            } else if(dayOfWeek.equals("thu")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "목", "P");
               planBiz.insertPlan(dto);
            } else if(dayOfWeek.equals("fri")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "금", "P");
               planBiz.insertPlan(dto);
            } else if(dayOfWeek.equals("sat")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "토", "P");
               planBiz.insertPlan(dto);
            } else if(dayOfWeek.equals("sun")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "일", "P");
               planBiz.insertPlan(dto);
            }
        } else if(command.equals("planDelete")) {
           LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
            String id = menteeDto.getId();
            
            String planCategory = request.getParameter("planCategory");
            String exerciseName = request.getParameter("exerciseName");
            String count = request.getParameter("planCount");
            int planTime = 0;
            String dayOfWeek = request.getParameter("dayOfWeek");
            int planCount = 0;
            
            if(planCategory.equals("유산소")) {
               planTime = Integer.parseInt(request.getParameter("planTime"));
               count = "0";
            }
            
            if(count.equals("10회")) {
               planCount = 10;
            } else if(count.equals("15회")) {
               planCount = 15;
            } else if(count.equals("20회")) {
               planCount = 20;
            }
            
            System.out.println("id: " + id);
            System.out.println("category: " + planCategory);
            System.out.println("exercise: " + exerciseName);
            System.out.println("count: " + planCount);
            System.out.println("time: " + planTime);
            System.out.println("day: " + dayOfWeek);
            
            
            
            if(dayOfWeek.equals("mon")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "월", "P");
               planBiz.deletePlan(dto);
            } else if(dayOfWeek.equals("tue")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "화", "P");
               planBiz.deletePlan(dto);
            } else if(dayOfWeek.equals("wen")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "수", "P");
               planBiz.deletePlan(dto);
            } else if(dayOfWeek.equals("thu")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "목", "P");
               planBiz.deletePlan(dto);
            } else if(dayOfWeek.equals("fri")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "금", "P");
               planBiz.deletePlan(dto);
            } else if(dayOfWeek.equals("sat")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "토", "P");
               planBiz.deletePlan(dto);
            } else if(dayOfWeek.equals("sun")) {
               PlanDto dto = new PlanDto(0, "0", id, planCategory, exerciseName, planCount, planTime, "일", "P");
               planBiz.deletePlan(dto);
            }
        }
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");
      doGet(request, response);
   }

   private void dispacher(String url, HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      RequestDispatcher dispacher = request.getRequestDispatcher(url);
      dispacher.forward(request, response);
   }

}