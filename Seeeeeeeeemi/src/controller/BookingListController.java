package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Booking;
import service.face.BookingService;
import service.impl.BookingServiceImpl;

@WebServlet("/room/list")
public class BookingListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private BookingService bookingService = new BookingServiceImpl();
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		System.out.println("/room/list [GET] -Requested");
		
		HttpSession session = req.getSession();
		session.setAttribute("userno", 1);
		
	
		//모든 예약 리스트 
		List<Booking> BookingList =  bookingService.getAllBookingList(req);
		
		req.getRequestDispatcher("/WEB-INF/views/room/list.jsp").forward(req, resp);
	
		
		
	}
	
	
	
}
