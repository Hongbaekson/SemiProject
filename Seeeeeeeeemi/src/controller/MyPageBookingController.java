package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.MyPageService;
import service.impl.MyPageServiceImpl;
import util.MyPageBookingPaging;

/**
 * Servlet implementation class MyPageBookingController
 */
@WebServlet("/mypage/booking")
public class MyPageBookingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyPageService myPageService = new MyPageServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//요청파라미터를 전달하여 Paging객체 생성하기
		MyPageBookingPaging paging = myPageService.getBookingPaging(req);
		
		//예약 전체 조회
//		List<Map<String, Object>> bookingList = myPageService.getBookingInfo(req);
		
		//페이징을 적용한 예약 조회
		List<Map<String, Object>> bookingList = myPageService.getBookingInfo(req, paging);
		
		
		req.setAttribute("paging", paging);
		
		req.setAttribute("bookingList", bookingList);
		
		req.getRequestDispatcher("/WEB-INF/views/mypage/booking.jsp").forward(req, resp);
	}
}
