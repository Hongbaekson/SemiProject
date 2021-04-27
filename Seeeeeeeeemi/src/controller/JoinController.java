package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.face.UserService;
import service.impl.UserServiceImpl;

@WebServlet("/join")
public class JoinController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	UserService userService = new UserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.getRequestDispatcher("/WEB-INF/views/member/join.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		//UserService객체이용 - 파라미터 처리 
		User user = userService.getJoinInfo(req);
		
		//가입처리
		int res = userService.join(user);
		String PageUrl="";
		
		if(res>0) {
			System.out.println("회원가입성공");
			PageUrl = "/login";
			out.println("<script>alert('회원가입 성공!'); location.href='"+PageUrl+"';</script>");
			out.close();

		}else {
			PageUrl = "/join";
			out.println("<script>alert('회원가입실패!'); location.href='"+PageUrl+"';</script>");
			out.close();
		}
			
		
	}
	
}
