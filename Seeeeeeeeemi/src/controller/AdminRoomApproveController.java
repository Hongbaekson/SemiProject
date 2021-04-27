package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.AdminRoomService;
import service.impl.AdminRoomServiceImpl;

@WebServlet("/admin/room/approve")
public class AdminRoomApproveController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	AdminRoomService adminRoomService = new AdminRoomServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("[test] AdminRoomApproveController [post] 호출");
		if( req.getParameterValues("chk") == null ) {
			resp.sendRedirect("/admin/roomlist");
			return;
		}
		adminRoomService.approve(req);
		
		resp.sendRedirect("/admin/roomlist");
	}
}
