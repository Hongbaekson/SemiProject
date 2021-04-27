package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board;
import service.face.BoardService;
import service.impl.BoardServiceImpl;

@WebServlet("/admin/notice/delete")
public class AdminNoticeDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	BoardService boardService = new BoardServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("글삭제");
		
		//요청파라미터처리
		Board board = boardService.getParam(req);
			
		//삭제
		boardService.delete(board);
		resp.sendRedirect("/admin/notice/list");
		
	}
}
