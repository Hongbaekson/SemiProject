package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.face.HostService;
import service.impl.HostServiceImpl;

@WebServlet("/host/write")
public class HostRegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	HostService hostService = new HostServiceImpl();
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("[test] HostRegiseterController [GET] 요청");
		
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
		//호스트폼(숙소등록 폼으로 이동)
		req.getRequestDispatcher("/WEB-INF/views/host/write.jsp")
			.forward(req, resp);
		
		
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("[test] HostRegiseterController [POST] 요청");
		System.out.println("[TEST] readonly 도로명 주소 : " + req.getParameter("roadAddress"));
		
		//==== [test]세션에 유저번호 저장 ====
//		HttpSession session = req.getSession();
//		session.setAttribute("userno", 1001);
		//=============================
		//폼데이터 등록 요청
		int roomNo = hostService.registerForm(req);
		
		//상세페이지로 보내기
		resp.sendRedirect("/host/roomview?roomno="+roomNo);
	}

}
