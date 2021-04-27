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
import util.MyPageBookmarkPaging;

/**
 * Servlet implementation class MyPageBookmarkController
 */
@WebServlet("/mypage/bookingdetail")
public class MyPageBookingDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyPageService myPageService = new MyPageServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		int roomno = myPageService.getParamRoomno(req);
		
		Map<String, Object> detail = myPageService.getBookingDetail((int)req.getSession().getAttribute("userno"), roomno);
		
		System.out.println(detail);
		
		req.setAttribute("detail", detail);
		 
		req.getRequestDispatcher("/WEB-INF/views/mypage/bookingdetail.jsp").forward(req, resp);
	}
}
