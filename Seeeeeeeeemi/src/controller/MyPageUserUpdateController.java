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
 * Servlet implementation class MyPageUserUpdateController
 */
@WebServlet("/mypage/update")
public class MyPageUserUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyPageService myPageService = new MyPageServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		System.out.println("/mypage/update [POST] - 호출 완료");
		
		req.setCharacterEncoding("utf-8");
		
		User user = myPageService.getParam(req);
		
		myPageService.updateUser(req, user);
		
		resp.sendRedirect("/mypage/user");
	
	}
}
