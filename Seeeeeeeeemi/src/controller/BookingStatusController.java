package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.MyRoomBookingService;
import service.impl.MyRoomBookingServiceImpl;

@WebServlet("/bstatus/update")
public class BookingStatusController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyRoomBookingService myRoomBookingService = new MyRoomBookingServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("[test]BookingStatusController [POST] 호출");
		
		//요청파라미터 인코딩
		req.setCharacterEncoding("utf-8");
		
		myRoomBookingService.updateStatus(req);
		
		//현재 보고있는 페이지
		int curPage = Integer.parseInt(req.getParameter("curPage"));
		
		//보고 있는 페이지로 리다이렉트
		resp.sendRedirect("/host/booking?curPage="+curPage);
	}
}
