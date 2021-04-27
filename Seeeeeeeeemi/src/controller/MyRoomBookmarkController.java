package controller;

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

import dto.Room;
import service.face.MyRoomBookingService;
import service.face.MyRoomBookmarkService;
import service.impl.MyRoomBookingServiceImpl;
import service.impl.MyRoomBookmarkServiceImpl;
import util.BookingPaging;

@WebServlet("/room/bookmark")
public class MyRoomBookmarkController extends HttpServlet {
   private static final long serialVersionUID = 1L;
   
   MyRoomBookingService myRoomBookingService = new MyRoomBookingServiceImpl();
   MyRoomBookmarkService myRoombookmarkService = new MyRoomBookmarkServiceImpl();
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      System.out.println("[TEST] MyRoomBookmarkController [GET] 요청");
      

      HttpSession session = req.getSession();
      if( session.getAttribute("login") == null ) {
         resp.setContentType("text/html; charset=UTF-8");
         PrintWriter script = resp.getWriter();
         script.println("<script>");
         script.println("alert('로그인 후 이용해주세요')");
         script.println("location.href='/main'");
         script.println("</script>");
         script.close();
         return;
      }
      System.out.println( session.getAttribute("userno") );   
      System.out.println( (String)req.getAttribute("bookmarkRoomNo") );   
      
   }

   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      System.out.println("[TEST] MyRoomBookmarkController [Post] 요청");

      HttpSession session = req.getSession();
      if( session.getAttribute("login") == null ) {
         resp.setContentType("text/html; charset=UTF-8");
         PrintWriter script = resp.getWriter();
         script.println("<script>");
         script.println("alert('로그인 후 이용해주세요')");
         script.println("location.href='/main'");
         script.println("</script>");
         script.close();
         return;
      }
      myRoombookmarkService.insertBookmark(req);
      resp.sendRedirect("/main");
   }
}