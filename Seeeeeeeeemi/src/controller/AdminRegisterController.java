package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.face.AdminsService;
import service.impl.AdminsServiceImpl;


@WebServlet("/admin/register")
public class AdminRegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	AdminsService adminsService = new AdminsServiceImpl();
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		//파라미터처리
		User user = adminsService.getInfo(req);
		
		System.out.println(user);

		//가입
		int res = adminsService.insert(user);
		
		if(res>0) {
			//가입성공
			out.println("<script>alert('회원가입 성공!'); location.href='/admin/userlist'; </script>");
			
		}else {
			//가입실패
			out.println("<script>alert('회원가입 실패!'); location.href='/admin/userlist'; </script>");
		}
		
		
		
	}
}
