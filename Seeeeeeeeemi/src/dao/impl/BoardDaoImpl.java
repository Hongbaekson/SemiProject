package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBCTemplate;
import dao.face.BoardDao;
import dto.Board;
import web.util.Paging;


public class BoardDaoImpl implements BoardDao {
	
	PreparedStatement ps =null;
	ResultSet rs =null;
	
	@Override
	public List<Board> selectAll(Connection conn) {
		
		String sql="";
		sql+="select * from boards b, users u";
		sql+=" where b.user_no = u.user_no";
		sql+=" and board_type=1";
		sql+="  order by board_no desc";
		
		
		List<Board> list = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				
				Board board = new Board(); 
							
				board.setBoardNo( rs.getInt("board_no"));
				board.setBoardTitle(rs.getString("board_title"));
				board.setBoardContent( rs.getString("board_content"));
				board.setBoardCreateDate(rs.getDate("board_create_date"));
//				board.setUserNo(rs.getInt("user_no"));
				board.setUserNick(rs.getString("user_nick"));
				board.setBoardType(rs.getInt("board_type"));
				list.add(board);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return list;
	}
	@Override
	public List<Board> selectAll(Connection conn, Paging paging) {
		
		String sql="";
		sql+="select * from (";
		sql+=" select rownum rnum, B.* from(";
		sql+="   select board_no, board_title,board_content,board_create_date,user_nick from boards b, users u";
		sql+="		 where b.user_no = u.user_no and board_type=1";
		sql+="		 order by board_no desc";
		sql+=" 		)B";
		sql+=" 	)BOARD";
		sql+=" where rnum between ? and ?";
		
		List<Board> list = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, paging.getStartNo());
			ps.setInt(2, paging.getEndNo());
			
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				
				Board board = new Board(); 
							
				board.setBoardNo( rs.getInt("board_no"));
				board.setBoardTitle(rs.getString("board_title"));
				board.setBoardContent( rs.getString("board_content"));
				board.setBoardCreateDate(rs.getDate("board_create_date"));
//				board.setUserNo(rs.getInt("user_no"));
				board.setUserNick(rs.getString("user_nick"));
				list.add(board);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return list;
	}
	
	
	
	
	@Override
	public Board selectByboardno(Connection conn, Board board) {
		
		String sql="";
		sql+=" select * from boards, users";
		sql+="  where board_no =?";
		sql+="  and boards.user_no = users.user_no";
		
		Board viewBoard = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, board.getBoardNo());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				viewBoard = new Board();
				
				viewBoard.setBoardNo( rs.getInt("board_no"));
				viewBoard.setBoardTitle(rs.getString("board_title"));
				viewBoard.setBoardContent( rs.getString("board_content"));
				viewBoard.setBoardCreateDate(rs.getDate("board_create_date"));
				viewBoard.setUserNo(rs.getInt("user_no"));
				viewBoard.setUserNick(rs.getString("user_nick"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		
		return viewBoard;
	}
	
	@Override
	public int delete(Connection conn, Board viewBoard) {
		
		String sql="";
		sql+=" delete from boards ";
		sql+="  where board_no =?";
		
		int res = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, viewBoard.getBoardNo() );
			res = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		return res;
	}
	@Override
	public int write(Connection conn, Board board) {
		
		String sql="";
		sql+=" insert into boards(board_no, board_title, board_content, user_no) ";
		sql+="  values(boards_seq.nextval, ?, ?, ?)";
		
		int res = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, board.getBoardTitle() );
			ps.setString(2, board.getBoardContent() );
			ps.setInt(3, board.getUserNo() );
			
			res = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		return res;
	}
	@Override
	public int update(Connection conn, Board board) {
		
		String sql="";
		sql+=" update boards ";
		sql+="  set board_title=? ,board_content=? ";
		sql+="   where board_no= ?";
		
		int res = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, board.getBoardTitle() );
			ps.setString(2, board.getBoardContent() );
			ps.setInt(3, board.getBoardNo() );
			
			res = ps.executeUpdate();
			
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		return res;
	}
	@Override
	public int selectCntRow(Connection conn) {
		String sql="";
		sql+=" select count(*) cnt from boards ";
		sql+=" where board_type=1";
		int cnt=0;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				cnt =rs.getInt(1);
			}
				
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return cnt;
	}
	
	@Override
	public List<Board> selectByBoardtype(Connection conn) {
		String sql="";
		sql+="select * from boards b, users u";
		sql+=" where b.user_no = u.user_no";
		sql+=" and board_type=0";
		sql+="  order by board_no desc";
		
		List<Board> list = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				Board board = new Board();
				board.setBoardNo(rs.getInt("board_no") );
				board.setBoardTitle(rs.getString("board_title"));
				board.setBoardContent( rs.getString("board_content") );
				board.setBoardCreateDate(rs.getDate("board_create_date"));
				board.setBoardType(rs.getInt("board_type"));
				board.setUserNo(rs.getInt("user_no"));
				board.setUserNick(rs.getString("user_nick"));
				
				list.add(board);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return list;
	}
	
	
	
	@Override
	public List<Board> selectByBoardtype(Connection conn,Paging paging) {
		
		String sql="";
		sql+=" select * from (";
		sql+="  select rownum rnum,B.* from (";
		sql+="   select * from boards";
		sql+="   	where board_type=0";
		sql+=" 		order by board_no desc";
		sql+="  )B";
		sql+=" )where rnum between ? and ?";
		
		List<Board> list = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, paging.getStartNo());
			ps.setInt(2, paging.getEndNo());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				Board board = new Board();
				board.setBoardNo(rs.getInt("board_no") );
				board.setBoardTitle(rs.getString("board_title"));
				board.setBoardContent( rs.getString("board_content") );
				board.setBoardCreateDate(rs.getDate("board_create_date"));
				board.setBoardType(rs.getInt("board_type"));
				board.setUserNo(rs.getInt("user_no"));
				
				list.add(board);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return list;
	}
	
	@Override
	public int selectCntNotice(Connection conn) {
		String sql="";
		sql+=" select count(*) cnt from boards ";
		sql+=" where board_type=0";
		int cnt=0;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				cnt =rs.getInt(1);
			}
				
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return cnt;
	}
	
}
