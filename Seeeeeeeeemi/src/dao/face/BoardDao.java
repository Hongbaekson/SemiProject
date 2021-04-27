package dao.face;

import java.sql.Connection;
import java.util.List;

import dto.Board;
import web.util.Paging;

public interface BoardDao {
	/**
	 * 테이블전체를 조회한다 (페이징없)
	 * @param connection 
	 */
	public List<Board> selectAll(Connection connection);
	/**
	 * 테이블조회(페이징있)
	 * @param connection
	 * @param paging
	 * @return
	 */
	public List<Board> selectAll(Connection connection, Paging paging);
	
	
	/**
	 * boardno으로 board를 조회한다 
	 * @param connection
	 * @param board
	 * @return
	 */
	public Board selectByboardno(Connection connection, Board board);
	
	/**
	 * 작성된 글을 지운다 
	 * @param viewBoard
	 * @return
	 */
	public int delete(Connection connection, Board viewBoard);
	/**
	 * 작성된 글을 삽입한다 
	 * @param connection
	 * @param board
	 * @return
	 */
	public int write(Connection connection, Board board);
	
	/**
	 * 글을 수정한다 
	 * @param connection
	 * @param board
	 * @return
	 */
	public int update(Connection connection, Board board);
	/**
	 * 전체 행의 개수를 조회한다 
	 * @param connection
	 * @return
	 */
	public int selectCntRow(Connection connection);
	/**
	 * boardtype으로 전체행을 조회한다 
	 * @param connection
	 * @param paging 
	 * @return - 공지사항 리스트 
	 */
	public List<Board> selectByBoardtype(Connection connection);
	public List<Board> selectByBoardtype(Connection connection, Paging paging);
	/**
	 * notice의 행의 수를 구한다 
	 * @param connection
	 * @return
	 */
	public int selectCntNotice(Connection connection);
	
	
	
	
}
