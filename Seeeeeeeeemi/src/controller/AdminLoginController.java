package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.User;
import service.face.UserService;
import service.impl.UserServiceImpl;

@WebServlet("/admin/login")
public class AdminLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	UserService userService = new UserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(req, resp);		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//파라미터 처리
		User user = userService.getAdminParam(req);
		
		//로그인처리 
		boolean isAdminMember = userService.loginAdmin(user);
		
		
		if(isAdminMember) {
			//로그인 사용자의 정보 얻어오기
			User loginUser = new User();
			loginUser = userService.info(user);
			
			//세션저장
			HttpSession session = req.getSession();
			session.setAttribute("login", isAdminMember);
			session.setAttribute("userid", loginUser.getUserId() );
			session.setAttribute("usernick", loginUser.getUserNick() );
			session.setAttribute("username", loginUser.getUserName() );
			session.setAttribute("usergrade", loginUser.getUserGrade() );
			session.setAttribute("userno", loginUser.getUserNo() );
			
			resp.sendRedirect("/admin/userlist");
			
		}else {
			resp.sendRedirect("/admin/login");
		}
		
		
		
	}
	
}
