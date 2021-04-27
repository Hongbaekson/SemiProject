package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Room;
import service.face.MyRoomBookingService;
import service.impl.MyRoomBookingServiceImpl;
import util.BookingPaging;

@WebServlet("/host/booking")
public class MyRoomBookingListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyRoomBookingService myRoomBookingService = new MyRoomBookingServiceImpl();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("[TEST] MyRoomBookingListController [GET] 요청");
		
		//==== [test]세션에 유저번호 저장 ====
//		HttpSession session = req.getSession();
//		session.setAttribute("userno", 1001);
		//=============================
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
		} else if ( (Integer)session.getAttribute("usergrade") != 2) {
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter script = resp.getWriter();
			script.println("<script>");
			script.println("alert('호스트가 되면 이용할 수 있습니다.')");
			script.println("location.href='/host/roomlist'");
			script.println("</script>");
			script.close();
			return;
		}
		//요청파라미터를 전달하여 Paging객체 생성하기
		BookingPaging paging = myRoomBookingService.getPaging(req);
		System.out.println("BookingListController - " + paging );
		
		int hostNo = (Integer)session.getAttribute("userno");
		
		//페이징처리 게시글 조회
		List<Map<String, Object>> list = myRoomBookingService.getList(hostNo, paging);
		
		//MODEL값 전달
		req.setAttribute("list", list);
		req.setAttribute("paging", paging);
		
		req.getRequestDispatcher("/WEB-INF/views/host/bookingList.jsp")
			.forward(req, resp);
		
		
	}
}
