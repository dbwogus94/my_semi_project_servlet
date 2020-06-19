package member.mentee.dayMenu.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import All.statics.join.LoginProfile.dto.LoginProfileDto;
import member.mentee.dayMenu.biz.DayMenuBiz;
import member.mentee.dayMenu.biz.DayMenuBizImpl;
import member.mentee.dayMenu.dto.DayMenuDto;
import member.mentee.food.biz.FoodBiz;
import member.mentee.food.biz.FoodBizImpl;
import net.sf.json.JSONObject;


@WebServlet("/DayMenuServlet")
public class DayMenuServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    public DayMenuServlet() {
        super();
        
    }

   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");
      
      String command = request.getParameter("command");
      System.out.println("<"+command+">");
      DayMenuBiz menuBiz = new DayMenuBizImpl();
      FoodBiz foodBiz = new FoodBizImpl();
      HttpSession session = request.getSession();
      
      if(command.equals("deleteMenu")) {
          String menuDate = request.getParameter("menuDate");
          int res = menuBiz.deleteMenu(menuDate);
       } else if(command.equals("dayMenuAjax")) {
  
         List<String> foodList = foodBiz.selectList_foodName();
         Map<String, String> map = new HashMap<String, String>();
   
         for(int i=0; i<foodList.size(); i++) {
            map.put(foodList.get(i), foodList.get(i));
         }

         JSONObject obj = JSONObject.fromObject(map);
         PrintWriter out = response.getWriter();
      
         obj.write(out);
      
      } else if(command.equals("dayMenuInsert")) {
        LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
         String id = menteeDto.getId();
         
         String foodName = request.getParameter("foodName");
         String menuDate = request.getParameter("menuDate");
         String meal = request.getParameter("meal");
         int gram = Integer.parseInt(request.getParameter("gram"));
         
         System.out.println("id : " + id);
         System.out.println("foodName : " + foodName);
         System.out.println("menuDate : " + menuDate);
         System.out.println("meal : " + meal);
         System.out.println("gram : " + gram);
         
         DayMenuDto dayMenuDto = null;
         
         if(meal.equals("아침")) {
            dayMenuDto = new DayMenuDto(0, id, menuDate, foodName, gram, "Y", "N", "N", "N");
            menuBiz.insertDayMenu(dayMenuDto);
         } else if(meal.equals("점심")) {
            dayMenuDto = new DayMenuDto(0, id, menuDate, foodName, gram, "N", "Y", "N", "N");
            menuBiz.insertDayMenu(dayMenuDto);
         } else if(meal.equals("저녁")) {
            dayMenuDto = new DayMenuDto(0, id, menuDate, foodName, gram, "N", "N", "Y", "N");
            menuBiz.insertDayMenu(dayMenuDto);
         } else if(meal.equals("간식")) {
            dayMenuDto = new DayMenuDto(0, id, menuDate, foodName, gram, "N", "N", "N", "Y");
            menuBiz.insertDayMenu(dayMenuDto);
         }
      } else if(command.equals("oneMenuDelete")) {
         LoginProfileDto menteeDto = (LoginProfileDto) session.getAttribute("menteeDto");
          String id = menteeDto.getId();
          
          String foodName = request.getParameter("foodName");
          String menuDate = request.getParameter("menuDate");
          String meal = request.getParameter("meal");
          
          System.out.println("id : " + id);
          System.out.println("foodName : " + foodName);
          System.out.println("menuDate : " + menuDate);
          System.out.println("meal : " + meal);
          
          DayMenuDto dayMenuDto = null;
          
          if(meal.equals("아침")) {
              dayMenuDto = new DayMenuDto(0, id, menuDate, foodName, 0, "Y", "N", "N", "N");
              menuBiz.deleteOneMenu(dayMenuDto);
           } else if(meal.equals("점심")) {
              dayMenuDto = new DayMenuDto(0, id, menuDate, foodName, 0, "N", "Y", "N", "N");
              menuBiz.deleteOneMenu(dayMenuDto);
           } else if(meal.equals("저녁")) {
              dayMenuDto = new DayMenuDto(0, id, menuDate, foodName, 0, "N", "N", "Y", "N");
              menuBiz.deleteOneMenu(dayMenuDto);
           } else if(meal.equals("간식")) {
              dayMenuDto = new DayMenuDto(0, id, menuDate, foodName, 0, "N", "N", "N", "Y");
              menuBiz.deleteOneMenu(dayMenuDto);
           }
      }
      
      
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");
      
      doGet(request, response);
   }

   public void jsResponse(String msg,HttpServletResponse response) throws IOException {
      String s = "<script type='text/javascript'>"
              + "alert('" + msg + "');"
              + "opener.window.location.reload(); window.close(); "
              + "</script>";
      PrintWriter out = response.getWriter();
      out.println(s);
   }
}