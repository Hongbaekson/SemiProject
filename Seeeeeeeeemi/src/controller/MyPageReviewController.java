package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.MyPageService;
import service.impl.MyPageServiceImpl;
import util.MyPageReviewPaging;

/**
 * Servlet implementation class MyPageReviewController
 */
@WebServlet("/mypage/review")
public class MyPageReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyPageService myPageService = new MyPageServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//요청파라미터를 전달하여 MyPagingReviewPaging 객체 생성하기
		MyPageReviewPaging paging = myPageService.getReviewPaging(req);
		
		//리뷰 전체 조회
//		List<Map<String, Object>> reviewList = myPageService.getReview(req);
		
		//페이징을 적용한 리뷰 조회
		List<Map<String, Object>> reviewList = myPageService.getReview(req, paging);
		
		
		req.setAttribute("paging", paging);
		
		req.setAttribute("reviewList", reviewList);
		
		req.getRequestDispatcher("/WEB-INF/views/mypage/review.jsp").forward(req, resp);
	}
}
