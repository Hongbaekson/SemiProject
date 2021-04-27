package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.face.UserService;
import service.impl.UserServiceImpl;


@WebServlet("/idcheck")
public class IdCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;
		
	UserService userService = new UserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter(); 
        
//		System.out.println("입력된id : "+req.getParameter("id"));

		//매개변수처리 
		User user = userService.getParamId(req);
				
		boolean isMatch = userService.getMatch(user);
		//아이디 매치하는게있으면 true반환 
		out.println(isMatch);
		
	}
}
