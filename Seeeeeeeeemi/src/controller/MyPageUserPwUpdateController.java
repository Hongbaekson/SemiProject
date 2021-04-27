package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.MyPageService;
import service.impl.MyPageServiceImpl;

/**
 * Servlet implementation class MyPageUserPwUpdateController
 */
@WebServlet("/mypage/pwUpdate")
public class MyPageUserPwUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyPageService myPageService = new MyPageServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("/mypage/pwUpdate [GET]");
		
		
		
		req.getRequestDispatcher("/WEB-INF/views/mypage/pwUpdate.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("/mypage/pwUpdate [POST]");
		
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();


		
		//현재 비밀번호 체크 세션의 userno을 이용
		boolean chk = myPageService.chkPw(req);
		
		if(chk == true) {
			myPageService.updateUserPw(req);
			
			//세션 지우기
			req.getSession().invalidate();
			
			resp.sendRedirect("/main");
		} else {
			
			out.println("<script>alert('비밀번호를 다시 확인하세요'); location.href='/mypage/pwUpdate'; </script>"); 
			out.close();
		}
	
	
	}
}
