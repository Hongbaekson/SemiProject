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

@WebServlet("/board/update")
public class BoardUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	BoardService boardService = new BoardServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("update");
		
		//파라미터 처리
		Board board = boardService.getParam(req);
		Board viewBoard = boardService.getView(board);
		req.setAttribute("viewBoard", viewBoard);
						
		req.getRequestDispatcher("/WEB-INF/views/board/update.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Board board = boardService.getUpdate(req);
		//쓴 글 업데이트
		System.out.println(board);
		boardService.update(board);
		
				
		
		resp.sendRedirect("/board/list");
	}
	
	
}
