package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board;
import service.face.AdminsService;
import service.face.BoardService;
import service.impl.AdminsServiceImpl;
import service.impl.BoardServiceImpl;

@WebServlet("/admin/notice/write")
public class AdminNoticeWriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	BoardService boardService = new BoardServiceImpl();
	AdminsService adminService = new AdminsServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//로그인되어있지않으면 메인으로
		if( req.getSession().getAttribute("login")==null ) {
			resp.sendRedirect("/login");
			return;
		}
		
		req.getRequestDispatcher("/WEB-INF/views/admin/noticewrite.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//작성글 파라미터처리
		Board board = boardService.getBoard(req);
		
		adminService.writeNotice(board);
		
		//목록으로 
		resp.sendRedirect("/admin/notice/list");
		
		
		
	}
	
}
