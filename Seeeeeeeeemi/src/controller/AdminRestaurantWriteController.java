package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.impl.RestaurantBoardDaoImpl;
import dto.Restaurant;
import service.face.AdminRestaurantBoardService;
import service.face.RestaurantBoardService;
import service.impl.AdminRestaurantBoardServiceImpl;
import service.impl.RestaurantBoardServiceImpl;

@WebServlet("/admin/restaurantwrite")
public class AdminRestaurantWriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private RestaurantBoardService restaurantService = new RestaurantBoardServiceImpl();
	private AdminRestaurantBoardService adminRestaurantBoardService = new AdminRestaurantBoardServiceImpl();
	private RestaurantBoardDaoImpl restaurantDao = new RestaurantBoardDaoImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/views/admin/reswrite.jsp")
		.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("호출");
		
		//한글 인코딩
		req.setCharacterEncoding("utf-8");
	
	//	Restaurant restaurant = restaurantService.getres(req); 
		
		int restaurantNo = adminRestaurantBoardService.insertRestaurant(req);
		System.out.println("작성 호출");
		
		//작성글 삽입
		
	//	adminRestaurantBoardService.writeRestaurant(restaurant);
		
		System.out.println("여기는 되나염 작성글 삽입부분");
		
		//목록으로 리다이렉션
		resp.sendRedirect("/admin/restaurantlist");
		
	}
}