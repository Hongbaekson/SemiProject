package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

import dto.Booking;
import dto.Room;
import dto.RoomImg;
import service.face.BookingService;
import service.face.MyRoomService;
import service.impl.BookingServiceImpl;
import service.impl.MyRoomServiceImpl;

import javax.servlet.http.HttpSession;

@WebServlet("/room/booking")
public class BookingRoomController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private BookingService bookingService = new BookingServiceImpl();
	private MyRoomService myRoomService = new MyRoomServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 HttpSession session = req.getSession();

	System.out.println("/room/booking [GET] - 요청 완료");
	
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
     	

      System.out.println((String)req.getParameter("room_no_booking"));
      int roomNo = Integer.parseInt((String)req.getParameter("room_no_booking"));
      Room room = new Room();

      List<Room> roomList = myRoomService.getRoomList(req);
      
      for(int i=0; i<roomList.size(); ++i) {
         if(roomList.get(i).getRoomNo() == roomNo) {
            room = roomList.get(i);
            break;
         }
      }
      
       

       List<RoomImg> roomImgList = myRoomService.getRoomImgList(room);
       req.setAttribute("roomImgList", roomImgList);
       req.setAttribute("room", room);
       System.out.println(roomImgList);
       
       req.getRequestDispatcher("/WEB-INF/views/booking/booking.jsp").forward(req, resp);	

       System.out.println("/room/detail [GET] - Complete");
	
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("/room/booking [Post] -요청 완료");
//		
//		HttpSession session = req.getSession();
//		session.setAttribute("userno", 1);

		
		
		Booking booking = bookingService.getBookingroomParam(req);
		System.out.println(req.getParameter("room_no_booking"));
		
		// 예약데이터 예약번호로 가져오기
	 	int bookingNo = bookingService.BookingData(req, booking);
	 	
	 	
	 	
		
		resp.sendRedirect("/mypage/booking");
		
		
		
		 
		
	}
	
	 
	 

}
	

