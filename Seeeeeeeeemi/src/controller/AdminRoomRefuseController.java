package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.AdminRoomService;
import service.impl.AdminRoomServiceImpl;

@WebServlet("/admin/room/refuse")
public class AdminRoomRefuseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	AdminRoomService adminRoomService = new AdminRoomServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("[test] AdminRoomRefuseController [post] 호출");
		if( req.getParameterValues("chk") == null ) {
			resp.sendRedirect("/admin/roomlist");
			return;
		}
		adminRoomService.refuse(req);
		
		resp.sendRedirect("/admin/roomlist");
	}
}
