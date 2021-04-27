package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Booking;
import service.face.MyPageService;
import service.impl.MyPageServiceImpl;

/**
 * Servlet implementation class MyPageBookingCancelController
 */
@WebServlet("/mypage/booking/cancel")
public class MyPageBookingCancelController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyPageService myPageService = new MyPageServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int bookingno = Integer.parseInt(req.getParameter("booking_no"));
		System.out.println("booking_no : " + bookingno);
		
		req.setAttribute("bookingno", bookingno);

		req.getRequestDispatcher("/WEB-INF/views/mypage/bookingCancel.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int userno = (int)req.getSession().getAttribute("userno");
		System.out.println("세션의 userno : " + userno);
		int bookingno = Integer.parseInt(req.getParameter("booking_no"));
		
		Booking booking = myPageService.getBookingByUserno(userno, bookingno);
		
		myPageService.cancelBooking(booking);
		
		resp.sendRedirect("/mypage/booking");
		
	}
}
