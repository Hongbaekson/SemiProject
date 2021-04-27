package controller;

import java.io.IOException;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Restaurant;
import service.face.RestaurantBoardService;
import service.impl.RestaurantBoardServiceImpl;


@WebServlet("/admin/restaurantlist")
public class AdminRestaurantlistController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private RestaurantBoardService restaurantService = new RestaurantBoardServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		List<Restaurant> restaurantList = restaurantService.getList();
		
		req.setAttribute("restaurantList", restaurantList);
		
		req.getRequestDispatcher("/WEB-INF/views/admin/reslist.jsp") //요기 잘못해놧어여 제가 ㅠ
		.forward(req, resp);
	}
	

}