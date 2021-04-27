package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.face.AdminsService;
import service.face.UserService;
import service.impl.AdminsServiceImpl;
import service.impl.UserServiceImpl;

@WebServlet("/admin/userlist")
public class AdminUserListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	UserService userService = new UserServiceImpl();
	AdminsService adminsService = new AdminsServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		List<User> list = userService.getAllUser();
		
		req.setAttribute("list", list);
		
		req.getRequestDispatcher("/WEB-INF/views/admin/userlist.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		System.out.println("dopost");
		
		//파라미터처리
		User user = adminsService.getParamNo(req);

		//삭제
		boolean isDelete = adminsService.delete(user);
		if(isDelete) {
			out.println(true); 
		}else {
			out.println(false);
		}
		
		
		
	}
	
	
	
}
