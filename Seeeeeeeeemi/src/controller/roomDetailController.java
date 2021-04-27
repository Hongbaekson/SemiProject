package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Booking;
import dto.Review;
import dto.Room;
import dto.RoomImg;
import dto.User;
import service.face.MyRoomService;
import service.face.ReviewService;
import service.face.UserService;
import service.impl.MyRoomServiceImpl;
import service.impl.ReviewServiceImpl;
import service.impl.UserServiceImpl;
import web.util.ReviewPaging;

@WebServlet("/room/detail")
public class roomDetailController extends HttpServlet {
   private static final long serialVersionUID = 1L;
   Review review = new Review();

   private ReviewService reviewService = new ReviewServiceImpl();
   private MyRoomService myRoomService = new MyRoomServiceImpl();
   private UserService userService = new UserServiceImpl();
   
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      
     System.out.println((String)req.getParameter("room_no"));
     int roomNo = Integer.parseInt((String)req.getParameter("room_no"));
     Room room = new Room();
     ReviewPaging paging = reviewService.getPaging(req, roomNo);

     List<Room> roomList = myRoomService.getRoomList(req);
     
     for(int i=0; i<roomList.size(); ++i) {
        if(roomList.get(i).getRoomNo() == roomNo) {
           room = roomList.get(i);
           break;
        }
     }
     
     review.setRoomNo(Integer.parseInt((String)req.getParameter("room_no")));
     System.out.println("/room/detail [GET] - Complete");
      

      List<RoomImg> roomImgList = myRoomService.getRoomImgList(room);
      List<String> roomFacList = myRoomService.getRoomFacList(room);
      List<Review> allReview = reviewService.selectReviewByRoom(room);
      List<Review> reviewList = reviewService.selectReviewByRoom(room, paging);
      List<User> allUser = userService.getAllUser();
      List<String> reviewUser = new ArrayList<>();
      for(int i=0; i<reviewList.size(); ++i) {
    	  for(int j=0; j<allUser.size(); ++j) {
        	  if(reviewList.get(i).getUserNo() == allUser.get(j).getUserNo())
        		  reviewUser.add(allUser.get(j).getUserName());
    	  }
      }
      System.out.println("유저이름: " + reviewUser);
      req.setAttribute("roomImgList", roomImgList);
      req.setAttribute("roomFacList", roomFacList);
      req.setAttribute("room", room);
      req.setAttribute("reviewList", reviewList);
      req.setAttribute("paging", paging);
      req.setAttribute("reviewUser", reviewUser);
      req.setAttribute("allReview", allReview);
      
      req.getRequestDispatcher("/WEB-INF/views/room/roomDetail.jsp").forward(req, resp);
   }
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//      
//      Map<Integer,String> ratingOptions = new HashMap<>();
//      ratingOptions.put(0, "☆☆☆☆☆");
//      ratingOptions.put(1, "★☆☆☆☆");
//      ratingOptions.put(2, "★★☆☆☆");
//      ratingOptions.put(3, "★★★☆☆");
//      ratingOptions.put(4, "★★★★☆");
//      ratingOptions.put(5, "★★★★★");
//      req.setAttribute("ratingOptions", ratingOptions);

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
	      	
     SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
     Date time  = new Date();
     String time1 = format1.format(time);
     java.sql.Date date = java.sql.Date.valueOf(time1);
     
      String comment = (String)req.getParameter("reContent");
      float stars = 0.0f;
      
      if((String)req.getParameter("stars") != null)
         stars = Float.parseFloat((String)req.getParameter("stars"));
      
      System.out.println("comment=" + comment);
      System.out.println("stars=" + stars);
      
      review.setUserNo((int)session.getAttribute("userno"));
      review.setReContent(comment);
      review.setReStar(Float.toString(stars));
      review.setReDate(date);
      reviewService.addReview(review);
      resp.setContentType("text/html; charset=UTF-8");
      


      Room room = new Room();
      
	  room.setRoomNo(Integer.parseInt(req.getParameter("room_no_booking")));

      resp.sendRedirect("/room/detail?room_no=" + room.getRoomNo());
 

   }
   
   
   
}