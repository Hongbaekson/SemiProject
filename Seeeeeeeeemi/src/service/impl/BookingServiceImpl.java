package service.impl;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import common.JDBCTemplate;
import dao.face.BookingDao;
import dao.impl.BookingDaoImpl;
import dto.Booking;
import dto.User;
import service.face.BookingService;

public class BookingServiceImpl implements BookingService {
	
	private BookingDao bookingDao = new BookingDaoImpl();
	

	@Override
	public Booking getBookingroomParam(HttpServletRequest req) {
		
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
	
		//객체 생성 
		Booking booking = new Booking(); 
		
		String param = req.getParameter("bookingGuest");
	
		int guest = 0;
		
		if(param !=null && !"".contentEquals(param) ) {
			guest =  Integer.parseInt(param);
		}
	
		booking.setBookingGuest(guest);
		booking.setBookingCheckin(req.getParameter("bookingCheckin"));
		booking.setBookingCheckout(req.getParameter("bookingCheckout"));
		booking.setBookingMessage(req.getParameter("bookingMessage"));
		booking.setRoomName(req.getParameter("roomName"));
		booking.setRoomType(req.getParameter("roomType"));
		booking.setBookingUsername(req.getParameter("bookingUserName"));
		booking.setBookingUserphone(req.getParameter("bookingUserPhone"));
		booking.setBookingUseremail(req.getParameter("bookingUserEmail"));
		booking.setBookingStatus(req.getParameter("bookingStatus"));
		//예약을 위한 유저 넘버  
	    booking.setUserNo((Integer)req.getSession().getAttribute("userno"));
		//예약을 위한 호스트 넘버 = 유저 넘버 
	    //예약 상태 표시 
	    booking.setBookingStatus("W");
	    
	    booking.setRoomNo(Integer.parseInt(req.getParameter("room_no_booking")));
	    System.out.println(booking.getRoomNo());
		
		return booking;
	}

	

	
	@Override
	public int BookingData(HttpServletRequest req , Booking booking) {
		
		Connection conn =JDBCTemplate.getConnection();
		
		// 다음 예약번호 가져오기 ( Booking_SEQ 가져오기 )  
		int bookingNo = bookingDao.selectBookingNo(conn);
		
		//예약번호 저장 
		booking.setBookingNo(bookingNo);
	    
		
		int addBooking = bookingDao.insertBookingData(conn, booking);
	
	    if(addBooking == 1 ) {
			//데이터 삽입 성공
			JDBCTemplate.commit(conn);
		} else {
			//데이터베이스 오류
			JDBCTemplate.rollback(conn);
		}
	
		
		return bookingNo;
	}




	@Override
	public List<Booking> getAllBookingList(HttpServletRequest req) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		
		User user = new User();
		user.setUserNo((Integer)req.getSession().getAttribute("userno"));
		
		
		List<Booking> bookingList = bookingDao.selectAll(conn,user);
		
		
		return bookingList;
	}








	

	

}