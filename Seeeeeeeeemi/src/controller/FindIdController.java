package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.face.UserService;
import service.impl.UserServiceImpl;


@WebServlet("/find/id")
public class FindIdController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	UserService userService  = new UserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/views/member/findid.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//파라미터처리
		User user = userService.getNameTelParam(req);
		
		//일치하는 행개수가져오기
		boolean isCorrect=userService.getCntId(user);
		
		//일치하는 id를 가져옴
		if(user!=null && isCorrect) { // 일치하는 행이 0이상 true반환할것  일때 
			User userid =userService.getId(user);
			req.setAttribute("userid", userid);
			req.getRequestDispatcher("/WEB-INF/views/member/findidComplete.jsp").forward(req, resp);
		}else {
			resp.sendRedirect("/find/id");
		}
		
	}
	
}
