package member.trade.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.match.biz.MatchBiz;
import member.match.biz.MatchBizImpl;
import member.profile.biz.ProfileBiz;
import member.profile.biz.ProfileBizImpl;
import member.trade.biz.TradeBiz;
import member.trade.biz.TradeBizImpl;


@WebServlet("/TradeServlet")
public class TradeServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       

    public TradeServlet() {
    }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
       response.setContentType("text/html; charset=UTF-8");
       String command = request.getParameter("command");
       System.out.println("<"+command+">");
       
       if(command.equals("payment")) {  	// 성공 
          // 결제 성공하면 여기로 옴
          // [멘티] TRADE에 INSERT
          String MenteeId = request.getParameter("MenteeId"); 
          String impUid = request.getParameter("imp_uid"); 
          TradeBiz tradeBiz = new TradeBizImpl();
          // 입금내역 추가
          int menteeRes = tradeBiz.insertTradePay("출금" ,MenteeId, impUid);
          
          //[멘토] TRADE에 INSERT
          String MentorId = request.getParameter("MentorId");
          int mentorRes = tradeBiz.insertTradePay("입금" ,MenteeId, impUid);
          
          if((menteeRes>0) && (mentorRes > 0)) {
        	  System.out.println("멘티 출금 내역 추가, 멘토 입금 내역 추가 ");
        	  
        	  //[맨토] PROFILE에 COIN 업데이트
        	  ProfileBiz profileBiz = new ProfileBizImpl();
        	  // 출금내역 추가 
              int mentorCoinUpdate  = profileBiz.updateProfilePay(MentorId);
              if(mentorCoinUpdate > 0) {
            	 System.out.println("멘토 현재 출금가능 금액 칼럼 수정");
              }
              
              //[MATCH]
              // >>> 금액 지불완료시,  멘토멘티 매칭
              MatchBiz matchBiz = new MatchBizImpl();
              int matchRes = matchBiz.insertMatch(MenteeId, MentorId);
              if(matchRes > 0) {
            	  System.out.println("신규 멘토 멘티 매칭 완료");
            	  
            	  // 확인 메세지 >>> 어디로?
              }
          }
          
       } else if(command.equals("")) {
    	   
       }
         
   }
   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
       response.setContentType("text/html; charset=UTF-8");
      doGet(request, response);
   }
   
   private void jsResponse(String msg, String url, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String alertOut = "<script type ='text/javascript'>"
							+ "alert('"+msg+"');"
							+ "location.href='"+url+"';"
							+ "</script>";
		out.print(alertOut);
	}
   

}