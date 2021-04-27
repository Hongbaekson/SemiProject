package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.AdminBookingService;
import service.impl.AdminBookingServiceImpl;

@WebServlet("/admin/bookinglist")
public class AdminBookingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	AdminBookingService adminBookingService = new AdminBookingServiceImpl();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 전체 예약정보리스트
		List<Map<String, Object>> list = adminBookingService.getList();
		
		req.setAttribute("list", list);
		
		req.getRequestDispatcher("/WEB-INF/views/admin/bookingList.jsp")
			.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if( req.getParameterValues("chk") == null ) {
			resp.sendRedirect("/admin/bookinglist");
			return;
		}
		adminBookingService.delete(req);
		
		resp.sendRedirect("/admin/bookinglist");
	}
}
