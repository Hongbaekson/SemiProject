package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Board;
import web.util.Paging;

public interface BoardService {
	
	/**
	 * 조회한 객체를 가져온다(paging없음)
	 * @return 
	 */
	public List<Board> getList();
	/**
	 * 조회한 객체를 가져온다(paging있음)
	 * @param paging
	 * @return
	 */
	public List<Board> getList(Paging paging);
	
	/**
	 * 파라미터 처리
	 * @param req
	 */
	public Board getParam(HttpServletRequest req);
	/**
	 * 상세 가져오기 
	 * @param board 
	 * @return
	 */
	public Board getView(Board board);
	/**
	 * 상세글 삭제
	 * @param viewBoard
	 */
	public void delete(Board viewBoard);
	
	/**
	 * 제목, 내용 파라미터 처리 
	 * @param req
	 * @return
	 */
	public Board getBoard(HttpServletRequest req);
	
	/**
	 * 글 삽입
	 * @param board
	 */
	public void write(Board board);
	/**
	 * 수정할 글 파라미터 가져오기 
	 * @param req
	 * @return
	 */
	public Board getUpdate(HttpServletRequest req);
	
	/**
	 * 글 수정
	 * @param board
	 */
	public void update(Board board);
	
	/**
	 * paging객체 얻어오기 
	 * @param req
	 * @return
	 */
	public Paging getPaging(HttpServletRequest req);
	/**
	 * 공지사항 리스트를 가져온다 
	 * @param paging 
	 * @return
	 */
	
	public List<Board> getNoticeList();
	public List<Board> getNoticeList(Paging paging);
	/**
	 * 공지사항 페이징객체생성해서 반환
	 * @param req
	 * @return
	 */
	public Paging getNoticePaging(HttpServletRequest req);

	
	
	
	
	

	

}
