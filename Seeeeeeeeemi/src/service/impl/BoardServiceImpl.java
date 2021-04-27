package service.impl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.JDBCTemplate;
import dao.face.BoardDao;
import dao.impl.BoardDaoImpl;
import dto.Board;
import service.face.BoardService;
import web.util.Paging;

public class BoardServiceImpl implements BoardService {
	
	BoardDao boardDao = new BoardDaoImpl();
	
	
	@Override
	public List<Board> getList() {
		List<Board> list = boardDao.selectAll(JDBCTemplate.getConnection());
		return list;
	}
	
	@Override
	public List<Board> getList(Paging paging) {
		List<Board> list = boardDao.selectAll(JDBCTemplate.getConnection(),paging);
		return list;
	}
	
	
	@Override
	public Board getParam(HttpServletRequest req) {
		Board board = new Board();
		board.setBoardNo(Integer.parseInt( req.getParameter("boardno") ));
		
		return board;
	}
	
	@Override
	public Board getView(Board board) {
		
		Board viewBoard = boardDao.selectByboardno(JDBCTemplate.getConnection(), board);
		
		return viewBoard;
	}
	
	@Override
	public void delete(Board viewBoard) {
		
		int res = boardDao.delete(JDBCTemplate.getConnection(),viewBoard);
		
		if(res>0) {
			JDBCTemplate.commit(JDBCTemplate.getConnection());
		}else {
			JDBCTemplate.rollback(JDBCTemplate.getConnection());
		}
	}
	@Override
	public Board getBoard(HttpServletRequest req) {
		
		Board board = new Board();
		board.setBoardTitle( req.getParameter("title") );
		board.setBoardContent(req.getParameter("content"));
		board.setUserNo(Integer.parseInt( req.getParameter("userno") ) );
		return board;
	}
	@Override
	public void write(Board board) {
		
		int res = boardDao.write(JDBCTemplate.getConnection(), board);
		if(res>0) {
			JDBCTemplate.commit(JDBCTemplate.getConnection());
		}else {
			JDBCTemplate.rollback(JDBCTemplate.getConnection());
		}
	}
	
	@Override
	public Board getUpdate(HttpServletRequest req) {
		Board board = new Board();
		board.setBoardNo(Integer.parseInt( req.getParameter("boardno") ) );
		board.setBoardTitle( req.getParameter("title") );
		board.setBoardContent(req.getParameter("content"));
		board.setUserNo(Integer.parseInt( req.getParameter("userno") ) );
		return board;
	}
	
	@Override
	public void update(Board board) {
		int res = boardDao.update(JDBCTemplate.getConnection(), board);
		if(res>0) {
			System.out.println("수정성공");
			JDBCTemplate.commit(JDBCTemplate.getConnection());
		}else {
			System.out.println("수정실패");
			JDBCTemplate.rollback(JDBCTemplate.getConnection());
		}
	}
	
	@Override
	public Paging getPaging(HttpServletRequest req) {
		//전달파라미터 curPage 파싱
		String param = req.getParameter("curpage");
		int curPage = 0;
		if(param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		//Board 테이블의 총 게시글 수를 조회한다
		int totalCount = boardDao.selectCntRow(JDBCTemplate.getConnection());

		//Paging객체 생성
		Paging paging = new Paging(totalCount, curPage);
		
		return paging;
	}
	@Override
	public List<Board> getNoticeList() {
		List<Board> list = boardDao.selectByBoardtype(JDBCTemplate.getConnection());
		return list;
	}
	
	@Override
	public List<Board> getNoticeList(Paging paging) {
		List<Board> list = boardDao.selectByBoardtype(JDBCTemplate.getConnection(),paging);
		return list;
	}
	@Override
	public Paging getNoticePaging(HttpServletRequest req) {
		
		//전달파라미터 curPage 파싱
		String param = req.getParameter("curpage");
		int curPage = 0;
		if(param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		//Board 테이블의 총 게시글 수를 조회한다
		int totalCount = boardDao.selectCntNotice(JDBCTemplate.getConnection());

		//Paging객체 생성
		Paging paging = new Paging(totalCount, curPage);
		
		return paging;
	}
	
}
