package controller;

import java.io.IOException;



import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Restaurant;
import dao.face.RestaurantBoardDao;
import dao.impl.RestaurantBoardDaoImpl;
import service.face.RestaurantBoardService;
import service.impl.RestaurantBoardServiceImpl;
import web.util.Paging;



@WebServlet("/restaurant/search")
public class RestaurantSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//restauranteService 객체 생성
	private RestaurantBoardService restaurantService = new RestaurantBoardServiceImpl();
	private RestaurantBoardDaoImpl restaurantDao = new RestaurantBoardDaoImpl();
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("호출");
		
		//요청파라미터를 전달하여 Paging객체 생성하기
		Paging paging = restaurantService.getPaging(req);
		System.out.println("BoardListController - " + paging);
				
		//맛집 전체 조회
		List<Restaurant> restaurantList = restaurantService.getList();
		
		//int cat = Integer.parseInt(req.getParameter("cat"));
	  //  int h_area1 = Integer.parseInt(req.getParameter("h_area1"));
				
		//페이징을 적용한 게시글 조회
		//List<Restaurant> restaurantList = restaurantService.getList(paging);
		

		//페이징 객체를 MODEL값으로 전달
	//	req.setAttribute("paging", paging);
				
		for(Restaurant r : restaurantList) System.out.println(r);
				
		//조회결과 전달
		req.setAttribute("restaurantList", restaurantList);
		
	//	List<Restaurant> resList = restaurantDao.searchBoardBySearchno(cat, h_area1);
	    
	//	Restaurant restaurantList = restaurantService.getsearchBoardBySearchno(req);
		
		//페이징 객체를 MODEL값으로 전달
	//	req.setAttribute("paging", paging);
		
		
		//조회결과 전달
	//	req.setAttribute("restaurantList", resList);
		

		req.getRequestDispatcher("/WEB-INF/views/restaurant/search.jsp")
			.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("포스트 호출 ㄹㅇ");
		req.setCharacterEncoding("UTF-8");
		//이상태로 한번 돌려보시겠어요?
	    int cat = Integer.parseInt(req.getParameter("cat"));
	    int h_area1 = Integer.parseInt(req.getParameter("h_area1"));

		
	//	String[] cat =req.getParameterValues("cat");
	//	String[] h_area1 = req.getParameterValues("h_area1");
		
		
		Paging paging = restaurantService.getPaging(req);
		
	
		
		//페이징을 적용한 게시글 조회
	//	List<Restaurant> restaurantList = restaurantService.getList(paging);
		
		
		
	//	for(int i=0;i<cat.length;i++) {
	//	    System.out.println(cat[i]);  
	//	}    
		    
	//	    for(int j=0;j<h_area1.length;j++) {
	//	    System.out.println(h_area1[j]);  
		
	//	}
		
		List<Restaurant> resList = restaurantDao.searchBoardBySearchno(cat, h_area1);
		    
		Restaurant restaurantList = restaurantService.getsearchBoardBySearchno(req);
		
		//페이징 객체를 MODEL값으로 전달
		req.setAttribute("paging", paging);
		
		
		//조회결과 전달
		req.setAttribute("restaurantList", resList);
		
		req.getRequestDispatcher("/WEB-INF/views/restaurant/search.jsp")
		.forward(req, resp);
		
	}

}	
	
		
	

