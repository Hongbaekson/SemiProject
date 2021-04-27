package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBCTemplate;
import dao.face.UserDao;
import dto.User;

public class UserDaoImpl implements UserDao {
	
	private PreparedStatement ps = null;
	private ResultSet rs  = null;
	
	
	@Override
	public int selectCntByUseridUserPw(Connection conn, User user) {
		String sql ="";
		sql+="select count(*) from users";
		sql+=" where user_id = ? and user_pw= ?";
		
		int res = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserId() );
			ps.setString(2, user.getUserPw() );
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				res = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return res;
	}
	
	@Override
	public User selectByUserid(Connection conn, User user) {
		
		String sql ="";
		sql+="select * from users";
		sql+=" where user_id = ?";
		
		User result = null; 
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserId() );
			rs = ps.executeQuery();
			
			while(rs.next()) {
				result = new User();
				result.setUserId( rs.getString("user_id") );
				result.setUserPw( rs.getString("user_pw") );
				result.setUserNick( rs.getString("user_nick") );
				result.setUserName( rs.getString("user_name") );
				result.setUserGrade(rs.getInt("user_grade"));
				result.setUserNo(rs.getInt("user_no"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
				
		return result;
	}
	
	@Override
	public int insert(Connection conn, User user) {
		
		String sql ="";
		sql+="insert into users(user_no, user_id,user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade )";
		sql+=" values(users_seq.nextval, ?,?,?,?,?,?,?,?,1)";
		
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
			res = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		return res;
	}
	
	@Override
	public User getId(Connection conn, User user) {
		String sql ="";
		sql+=" select * from users";
		sql+=" where user_name=? and user_phone=? ";
		
		User info=null;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserName() );
			ps.setString(2, user.getUserPhone());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				info = new User();
				info.setUserId(rs.getString("user_id"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return info;
	}
	
	@Override
	public User getPw(Connection conn, User user) {
		String sql ="";
		sql+=" select * from users";
		sql+=" where user_name=? and user_phone=? and user_id=? ";
		
		User info=null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserName() );
			ps.setString(2, user.getUserPhone());
			ps.setString(3, user.getUserId() );
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				info = new User();
				info.setUserPw( rs.getString("user_pw") );
				info.setUserEmail(rs.getString("user_email"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return info;
	}
	@Override
	public int getCntPw(Connection conn, User user) {
		String sql ="";
		sql+="select count(*) cnt from users";
		sql+="  where user_name=? and user_phone=? and user_id=? ";
		
		int cnt=-1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserName() );
			ps.setString(2, user.getUserPhone() );
			ps.setString(3, user.getUserId() );
			
			rs = ps.executeQuery();
			while(rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		return cnt;
	}
	
	@Override
	public int getCntId(Connection conn, User user) {
		String sql ="";
		sql+="select count(*) cnt from users";
		sql+="  where user_name=? and user_phone=? ";
		
		int cnt =-1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserName() );
			ps.setString(2, user.getUserPhone() );
					
			rs = ps.executeQuery();
			while(rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return cnt;
	}
	@Override
	public int selectCntByUserId(Connection conn,User user) {
		String sql ="";
		sql+="select count(*) cnt from users";
		sql+="  where user_id=? ";
		
		int cnt =-1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserId() );
					
			rs = ps.executeQuery();
			while(rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		return cnt;
	}
	@Override
	public int selectCntByUserEmail(Connection conn, User user) {
		String sql ="";
		sql+="select count(*) cnt from users";
		sql+="  WHERE user_email =? ";
		
		int cnt =-1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserEmail() );
					
			rs = ps.executeQuery();
			while(rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		return cnt;
	}
	
	@Override
	public int loginAdmin(Connection conn, User user) {
		String sql ="";
		sql+="select count(*) cnt from users";
		sql+="  where user_grade=0 ";
		sql+="  and user_id =? and user_pw =? ";
		
		int cnt=-1; 
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserId() );
			ps.setString(2, user.getUserPw() );
			rs = ps.executeQuery();
			while( rs.next() ) {
				cnt = rs.getInt("cnt");
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
	public List<User> selectAll(Connection conn) {
		
		String sql ="";
		sql+="select * from users";
		
		List<User> list = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				
				User user = new User();
				
				user.setUserNo( rs.getInt("user_no") );
				user.setUserId( rs.getString("user_id") );
				user.setUserPw( rs.getString("user_pw") );
				user.setUserName( rs.getString("user_name") );
				user.setUserGender( rs.getString("user_gender") );
				user.setUserNick( rs.getString("user_nick") );
				user.setUserBithdate( rs.getString("user_birthdate") );
				user.setUserEmail( rs.getString("user_email") );
				user.setUserPhone( rs.getString("user_phone") );
				user.setUserGrade( rs.getInt("user_grade") );
				
				list.add(user);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return list;
	}
}