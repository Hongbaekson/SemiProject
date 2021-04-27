package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.face.MyPageService;
import service.impl.MyPageServiceImpl;

/**
 * Servlet implementation class MyPageUserController
 */
@WebServlet("/mypage/user")
public class MyPageUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyPageService myPageService = new MyPageServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		System.out.println("/mypage/user [GET] - 호출 완료");
		
		
		//userid을 가져온다
		User userid = myPageService.getUserid(req);
		
		//DB에서 개인정보 불러오기
		User user = myPageService.getUser(userid);
		
		req.setAttribute("user", user);
		
		req.getRequestDispatcher("/WEB-INF/views/mypage/user.jsp").forward(req, resp);
	
	}
	
}
