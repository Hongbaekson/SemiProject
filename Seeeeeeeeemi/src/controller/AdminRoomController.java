package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Room;
import service.face.AdminRoomService;
import service.impl.AdminRoomServiceImpl;

@WebServlet("/admin/roomlist")
public class AdminRoomController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	AdminRoomService adminRoomService = new AdminRoomServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		List<Room> list = adminRoomService.getList();
		
		//model값 전달
		req.setAttribute("list", list);
		
		
		req.getRequestDispatcher("/WEB-INF/views/admin/roomApproveList.jsp")
			.forward(req, resp);
	}
	
	
}
