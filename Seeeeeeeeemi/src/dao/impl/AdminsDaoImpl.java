package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBCTemplate;
import dao.face.AdminsDao;
import dto.Board;
import dto.Review;
import dto.RoomImgReview;
import dto.User;

public class AdminsDaoImpl implements AdminsDao {
	
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	@Override
	public int delete(Connection conn, User user) {
		String sql="";
		sql+="delete from users";
		sql+=" where user_no=?";
		
		int res=-1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, user.getUserNo() );
			res = ps.executeUpdate();
			
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		return res;
	}
	@Override
	public int insert(Connection conn, User user) {
		String sql="";
		sql+="insert into users(user_no, user_id,user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade )";
		sql+=" values(users_seq.nextval, ?,?,?,?,?,?,?,?,?)";
		
		int res = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserId() );
			ps.setString(2, user.getUserPw() );
			ps.setString(3, user.getUserName() );
			ps.setString(4, user.getUserGender() );
			ps.setString(5, user.getUserNick() );
			ps.setString(6, user.getUserBithdate() );
			ps.setString(7, user.getUserEmail() );
			ps.setString(8, user.getUserPhone() );
			ps.setInt(9, user.getUserGrade() );
			res = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		return res;	
	}
	
	@Override
	public int writeNotice(Connection conn, Board board) {
		String sql="";
		sql+=" insert into boards(board_no, board_title, board_content, board_type,user_no) ";
		sql+="  values(boards_seq.nextval, ?, ?,0, ?)";
		
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
	public List<RoomImgReview> selectReview(Connection conn) {
		String sql="";
		sql+=" select v.*,r.roomname,user_nick  from review v,room r, users u ";
		sql+="  where v.room_no = r.roomno and u.user_no = v.user_no";
		sql+="   order by re_no desc";
		
		List<RoomImgReview> list = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);			
			rs = ps.executeQuery();
			while(rs.next()) {
				
				RoomImgReview room = new RoomImgReview();
				
				room.setReNo( rs.getInt("re_no"));
				room.setUserNoReview( rs.getInt("user_no"));
				room.setRoomNo( rs.getInt("room_no"));
				room.setReContent( rs.getString("re_content"));
				room.setReDate( rs.getDate("re_date"));
				room.setReStar( rs.getInt("re_star"));
				room.setRoomName(rs.getString("roomname"));
				room.setUserNick( rs.getString("user_nick"));
				
				list.add(room);
				
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
	public int deleteByReviewno(Connection conn, Review review) {
		String sql="";
		sql+="delete from review";
		sql+=" where re_no=?";
		
		int res=-1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, review.getReNo() );
			res = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}
}
