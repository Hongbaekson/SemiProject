package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.RoomImgReview;
import service.face.AdminsService;
import service.impl.AdminsServiceImpl;

@WebServlet("/admin/review/list")
public class AdminReviewListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	AdminsService adminService = new AdminsServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		List<RoomImgReview> list = adminService.getAllReview();
		
		req.setAttribute("list", list);
		req.getRequestDispatcher("/WEB-INF/views/admin/reviewlist.jsp").forward(req, resp);
	}
	
	
	
}
