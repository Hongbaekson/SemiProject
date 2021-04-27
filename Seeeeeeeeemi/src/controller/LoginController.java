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

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//서비스객체
	UserService userService = new UserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.getRequestDispatcher("/WEB-INF/views/member/login.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				
		//입력받은 정보 파라미터처리
		User user= userService.getParam(req);
		
		//로그인 인증
		boolean login = userService.login(user);
				
		if(login) {
			//로그인 사용자의 정보 얻어오기
			User loginUser = new User();
			loginUser = userService.info(user);
			
			//세션저장
			HttpSession session = req.getSession();
			session.setAttribute("login", login);
			session.setAttribute("userid", loginUser.getUserId() );
			session.setAttribute("usernick", loginUser.getUserNick() );
			session.setAttribute("username", loginUser.getUserName() );
			session.setAttribute("usergrade", loginUser.getUserGrade() );
			session.setAttribute("userno", loginUser.getUserNo() );
			
			resp.sendRedirect("/");
			
		}else {
			resp.sendRedirect("/login");
		}
		
		
		
		
		
	}
	
	
	
}
