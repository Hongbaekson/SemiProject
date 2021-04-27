package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Room;
import dto.RoomImg;
import service.face.BookingService;
import service.face.MyRoomService;
import service.face.ReviewService;
import service.impl.BookingServiceImpl;
import service.impl.MyRoomServiceImpl;
import service.impl.ReviewServiceImpl;
import web.util.Paging;
@WebServlet("/room/search")
public class RoomSerarchController extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
   private BookingService bookingService = new BookingServiceImpl();
   private MyRoomService myRoomService = new MyRoomServiceImpl();
   private ReviewService reviewService = new ReviewServiceImpl();

   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

      System.out.println("/room/search [GET] - 완료");
      int guests=0;
      if((String)req.getParameter("adult") != null && (String)req.getParameter("children") != null) {
         int adult=0, children=0;
         if((String)req.getParameter("adult") != "")
            adult =  Integer.parseInt((String)req.getParameter("adult"));
         if((String)req.getParameter("children") != "")
            children = Integer.parseInt((String)req.getParameter("children"));
            
         guests = adult + children;
      }

      String location = (String)req.getParameter("location");
      Paging paging = myRoomService.getPaging(req, location, guests);
      List<Room> roomList = myRoomService.searchRoom(req, guests, location, paging);
      
      List<String> starList = new ArrayList<String>();
      float starSum = 0.0f;
      int count=0;
      
      List<RoomImg> thumbNails = new ArrayList<RoomImg>();
      for(int i=0; i<roomList.size(); ++i) {
         RoomImg img = myRoomService.getRoomImgList(roomList.get(i)).get(0); //roomlist중 첫번째 사진을 썸네일로 정함
         thumbNails.add(img);
         for(int j=0; j<reviewService.selectReviewByRoom(roomList.get(i)).size(); ++j) {
             starSum += Float.parseFloat(reviewService.selectReviewByRoom(roomList.get(i)).get(j).getReStar());
             count += 1;
          }
          float average = starSum / (float)count;
          if(average >= 0.0 && average < 1.0)
             starList.add("☆☆☆☆☆");
          
          else if(average >= 1.0 && average < 2.0)
             starList.add("★☆☆☆☆");
          
          else if(average >= 2.0 && average < 3.0)
             starList.add("★★☆☆☆");

          else if(average >= 3.0 && average < 4.0)
             starList.add("★★★☆☆");

          else if(average >= 4.0 && average < 5.0)
             starList.add("★★★★☆");

          else if(average == 5.0)
             starList.add("★★★★★");
          else
        	  starList.add("☆☆☆☆☆");
          
          count = 0;
          starSum = 0;
      }
      
      System.out.println("roomList: " + roomList.size());
      System.out.println("starList: " + starList.size());
      
      
      
      

      HttpSession session = req.getSession();
      session.setAttribute("guests", guests);
      session.setAttribute("location", location);
      
      req.setAttribute("roomList", roomList);
      req.setAttribute("roomImgList", thumbNails);
      req.setAttribute("paging", paging);
      req.setAttribute("starList", starList);
      

      req.getRequestDispatcher("/WEB-INF/views/room/list.jsp").forward(req, resp);
      
   }

   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


      HttpSession session = req.getSession();
      
      int guests=0;
      
      if((String)req.getParameter("guest") != null)
         guests = Integer.parseInt(String.valueOf(session.getAttribute("guests"))) + Integer.parseInt((String)req.getParameter("guest"));

      System.out.println("session="+session.getAttribute("guests")+" " + "guests="+guests);
      
      session.setAttribute("guests", guests);
      String location = String.valueOf(session.getAttribute("location"));
      

      List<Room> roomList = myRoomService.searchRoom(req, guests, location);
      req.setAttribute("roomList", roomList);
      
      System.out.println("/room/search [Post] - 완료 ");
      
      
      req.getRequestDispatcher("/WEB-INF/views/room/list.jsp").forward(req, resp);
      
      
   }
   

}