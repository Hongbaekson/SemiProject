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
import util.MyPageBookmarkPaging;

/**
 * Servlet implementation class MyPageBookmarkController
 */
@WebServlet("/mypage/bookmark")
public class MyPageBookmarkController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyPageService myPageService = new MyPageServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//요청파라미터를 전달하여 Paging객체 생성하기
		MyPageBookmarkPaging paging = myPageService.getBookmarkPaging(req);
		
		//북마크 전체 조회
//		List<Map<String, Object>> bookmarkList = myPageService.getBookmark(req);
		
		//페이징을 적용한 북마크 조회
		List<Map<String, Object>> bookmarkList = myPageService.getBookmark(req, paging);
		
		req.setAttribute("paging", paging);
		req.setAttribute("bookmarkList", bookmarkList);
		
		req.getRequestDispatcher("/WEB-INF/views/mypage/bookmark.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("/mypage/bookmark [POST] - 호출 완료");
		
		int bookmarkno = myPageService.getBookmarkNo(req);
		
		myPageService.cancelBookmark(bookmarkno);
		
		resp.sendRedirect("/mypage/bookmark");
	}
	
}
