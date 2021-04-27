package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.JDBCTemplate;
import dao.face.MyPageDao;
import dto.Booking;
import dto.Bookmark;
import dto.Review;
import dto.Room;
import dto.RoomImg;
import dto.User;
import util.MyPageBookingPaging;
import util.MyPageBookmarkPaging;
import util.MyPageReviewPaging;

public class MyPageDaoImpl implements MyPageDao {

	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	@Override
	public User selectUserInfo(User userid) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		String sql = "";
		sql += "SELECT user_name, user_nick, user_email, user_phone, user_birthdate, user_gender";
		sql += " FROM users";
		sql += " WHERE user_id = ?";
		
		User user = new User();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid.getUserId());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				user.setUserName(rs.getString("user_name"));
				user.setUserNick(rs.getString("user_nick"));
				user.setUserEmail(rs.getString("user_email"));
				user.setUserPhone(rs.getString("user_phone"));
				user.setUserBithdate(rs.getString("user_birthdate"));
				user.setUserGender(rs.getString("user_gender"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return user;
	}

	@Override
	public int updateUser(Connection conn, User user) {
		
		String sql = "";
		sql += "UPDATE users";
		sql += " SET user_name = ?,";
		sql += " 	user_nick = ?,";
		sql	+= " 	user_email = ?,";
		sql	+= " 	user_phone = ?,";
		sql	+= " 	user_birthdate = ?,";
		sql	+= " 	user_gender = ?";
		sql += " WHERE user_id = ?";
		
		int res = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserName());
			ps.setString(2, user.getUserNick());
			ps.setString(3, user.getUserEmail());
			ps.setString(4, user.getUserPhone());
			ps.setString(5, user.getUserBithdate());
			ps.setString(6, user.getUserGender());
			ps.setString(7, user.getUserId());
			
			res = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}

	@Override
	public boolean chkPw(String curpw, int userno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		String sql = "SELECT user_pw FROM users";
		sql += " WHERE user_no = ?";
		
		boolean res = false;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				if( curpw.equals(rs.getString("user_pw")) ) {
					res = true;
				} else {
					res = false;
				}
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int updateUserPw(int userno, String newpw, Connection conn) {
		
		
		String sql = "";
		sql += "UPDATE users";
		sql += " SET user_pw = ?";
		sql += " WHERE user_no = ?";
		
		int res = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, newpw);
			ps.setInt(2, userno);
			
			res = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
		
	}

	@Override
	public List<Map<String, Object>> selectBookingInfo(int userno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		System.out.println(userno);
		
		String sql = "";
		sql += "SELECT";
		sql += "	b.booking_no, b.booking_status, b.booking_guest";
		sql	+= "	, b.booking_checkin, b.booking_checkout";
		sql += "	, r.roomno, r.roomname";
		sql += " FROM booking b, room r";
		sql += " WHERE b.user_no = ?";
		sql += " AND b.room_no = r.roomno";
		sql += " ORDER BY booking_no DESC";
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				
				Room r = new Room();
				Booking b = new Booking();

				r.setRoomNo( rs.getInt("roomno") );
				r.setRoomName( rs.getString("roomname") );
				
				b.setBookingNo( rs.getInt("booking_no") );
				b.setRoomNo( rs.getInt("room_no") );
				b.setBookingStatus( rs.getString("booking_status") );
				b.setBookingCheckin( rs.getString("booking_checkin") );
				b.setBookingCheckout( rs.getString("booking_checkout") );
				b.setBookingGuest( rs.getInt("booking_guest") );
				
				map.put("room", r);
				map.put("booking", b);
				
				list.add(map);
			}
			
			System.out.println(list);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return list;
	}
	
	@Override
	public List<Map<String, Object>> selectBookingInfo(Connection connection, MyPageBookingPaging paging, int userno) {

		Connection conn = JDBCTemplate.getConnection();
		
		String sql = "";
		sql += "SELECT * FROM (";
		sql += "	SELECT rownum rnum, B.* FROM (";
		sql += "		SELECT";
		sql += "			b.room_no, b.booking_no, b.booking_status, b.booking_guest";
		sql	+= "			, b.booking_checkin, b.booking_checkout";
		sql += "			, r.roomname";
		sql += "			, ri.room_img_no, ri.room_img_filename";
		sql += "		FROM booking b, room r";
		
		sql += "		, (SELECT * FROM (";
		sql += "    		SELECT";
		sql += "        		room_img_no, room_no, room_img_filename,";
		sql += "	        	row_number() over( partition by room_no order by room_img_no ) rnum";
		sql += "    			FROM room_img";
		sql += " 			) rmi";
		sql += "		WHERE rnum = 1";
		sql += "		) ri";
		
		sql += " 		WHERE b.user_no = ?";
		sql += " 		AND b.room_no = r.roomno";
		sql += "		AND r.roomno = ri.room_no";
		sql += " 		ORDER BY booking_no DESC";
		sql += " 	) B";
		sql += " ) Booking";
		sql += " WHERE rnum BETWEEN ? AND ?";
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			ps.setInt(2, paging.getStartNo());
			ps.setInt(3, paging.getEndNo());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				
				Room r = new Room();
				Booking b = new Booking();
				RoomImg ri = new RoomImg();

				r.setRoomNo( rs.getInt("room_no") );
				r.setRoomName( rs.getString("roomname") );
				
				b.setBookingNo( rs.getInt("booking_no") );
				b.setRoomNo( rs.getInt("room_no") );
				b.setBookingStatus( rs.getString("booking_status") );
				b.setBookingCheckin( rs.getString("booking_checkin") );
				b.setBookingCheckout( rs.getString("booking_checkout") );
				b.setBookingGuest( rs.getInt("booking_guest") );
				
				ri.setRoomImgNo( rs.getInt("room_img_no") );
				ri.setRoomImgFilename( rs.getString("room_img_filename") );
				ri.setRoomNo(rs.getInt("room_no"));
				
				map.put("room", r);
				map.put("booking", b);
				map.put("roomimg", ri);
				
				list.add(map);
				
			}
			
			System.out.println(list);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return list;
	}
	
	@Override
	public int selectBookingCntAll(Connection conn, int userno) {
		
		String sql = "";
		sql += "SELECT count(*) cnt FROM booking";
		sql += " WHERE user_no =  ?";
		
		//총 게시글 수
		int cnt = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cnt = rs.getInt(1);
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
	public int cancelBooking(Booking booking, Connection conn) {

		String sql = "";
		sql += "UPDATE booking";
		sql += " SET booking_status = 'N'";
		sql += " WHERE user_no = ? AND booking_no = ?";
		
		System.out.println("user_no :" + booking.getusersNo());
		System.out.println("booking_no :" + booking.getBookingNo());
		
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, booking.getusersNo());
			ps.setInt(2, booking.getBookingNo());
			
			res = ps.executeUpdate();
			
			System.out.println("res = " + res);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}

	@Override
	public List<Map<String, Object>> selectReviewList(int userno) {

		Connection conn = JDBCTemplate.getConnection();
		
		String sql = "";
		sql += "SELECT";
		sql += "	u.user_no, u.user_name, r.roomname";
		sql	+= "	, re.re_no, re.room_no, re.re_content";
		sql += "	, re.re_date, re.re_star";
		sql += " FROM users u, review re, room r";
		sql += " WHERE u.user_no = ?";
		sql += " AND u.user_no = re.user_no";
		sql += " AND re.room_no = r.roomno";
		sql += " ORDER BY re_no DESC";
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				
				User u = new User();
				Review re = new Review();
				Room r = new Room();

				u.setUserNo( rs.getInt("user_no") );
				u.setUserName( rs.getString("user_name") );
				
				re.setReNo( rs.getInt("re_no") );
				re.setRoomNo( rs.getInt("room_no") );
				re.setReContent( rs.getString("re_content") );
				re.setReDate(rs.getDate("re_date"));
				re.setReStar( rs.getString("re_star") );
				
				r.setRoomName( rs.getString("roomname") );
				
				map.put("user", u);
				map.put("review", re);
				map.put("room", r);
				
				
				list.add(map);
			}
			
			System.out.println(list);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return list;
	}
	
	@Override
	public List<Map<String, Object>> selectReview(Connection connection, MyPageReviewPaging paging, int userno) {

		Connection conn = JDBCTemplate.getConnection();
		
		String sql = "";
		sql += "SELECT * FROM (";
		sql += "	SELECT rownum rnum, R.* FROM (";
		sql += "		SELECT";
		sql += "			u.user_no, u.user_name, r.roomname";
		sql	+= "			, re.re_no, re.room_no, re.re_content";
		sql += "			, re.re_date, re.re_star";
		sql += " 		FROM users u, review re, room r";
		sql += " 		WHERE u.user_no = ?";
		sql += " 		AND u.user_no = re.user_no";
		sql += " 		AND re.room_no = r.roomno";
		sql += " 		ORDER BY re_no DESC";
		sql += " 	) R";
		sql += " ) REVIEW";
		sql += " WHERE rnum BETWEEN ? AND ?";
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			ps.setInt(2, paging.getStartNo());
			ps.setInt(3, paging.getEndNo());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				
				User u = new User();
				Review re = new Review();
				Room r = new Room();

				u.setUserNo( rs.getInt("user_no") );
				u.setUserName( rs.getString("user_name") );
				
				re.setReNo( rs.getInt("re_no") );
				re.setRoomNo( rs.getInt("room_no") );
				re.setReContent( rs.getString("re_content") );
				re.setReDate(rs.getDate("re_date"));
				re.setReStar( rs.getString("re_star") );
				
				r.setRoomName( rs.getString("roomname") );
				
				map.put("user", u);
				map.put("review", re);
				map.put("room", r);
				
				
				list.add(map);
			}
			
			System.out.println(list);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return list;
	}
	
	@Override
	public int selectReviewCntAll(Connection conn, int userno) {
		String sql = "";
		sql += "SELECT count(*) cnt FROM review";
		sql += " WHERE user_no = ?";
		
		//총 게시글 수
		int cnt = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cnt = rs.getInt(1);
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
	public List<Map<String, Object>> selectBookmarkList(int userno) {
		Connection conn = JDBCTemplate.getConnection();
		
		String sql = "";
		sql += "SELECT";
		sql += "	u.user_no";
		sql += "	, r.roomno, r.roomname";
		sql += "	, r.roomroad_address";	
		sql	+= "	, r.roomdetailed_address";
		sql += "	, ri.room_img_filename";
		sql += "	, b.bookmark_no";
		sql += " FROM (";
		sql += "	    SELECT * FROM (";
		sql += "	        SELECT";
		sql += "	            room_img_no, room_no, room_img_filename,";
		sql += "	            row_number() over( partition by room_no order by room_img_no ) rnum";
		sql += "			FROM room_img";
		sql += "	    ) ROOM";
		sql += "	    WHERE rnum = 1";
		sql += "	) ri, users u, room r, bookmark b";
		sql += " WHERE ri.room_no = r.roomno";
		sql += " AND u.user_no = b.user_no";
		sql += " AND b.room_no = r.roomno";
		sql += " AND u.user_no = ?";
		
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				
				User u = new User();
				Room r = new Room();
				RoomImg ri = new RoomImg();
				Bookmark b = new Bookmark();
				

				u.setUserNo( rs.getInt("user_no") );
				
				r.setRoomNo( rs.getInt("roomno") );
				r.setRoomName( rs.getString("roomname") );
				r.setRoomRoadAddress( rs.getString("roomroadaddress") );
				r.setRoomDetailedAddress( rs.getString("roomdetailedaddress") );
				
				ri.setRoomImgFilename( rs.getString("room_img_filename") );
				
				b.setBookmarkNo( rs.getInt("bookmark_no") );
				
				map.put("user", u);
				map.put("room", r);
				map.put("room_img", ri);
				map.put("bookmark", b);
				
				
				list.add(map);
			}
			
			System.out.println(list);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return list;
	}

	@Override
	public List<Map<String, Object>> selectBookmark(Connection conn, MyPageBookmarkPaging paging, int userno) {
		
		String sql = "";
		sql += "SELECT * FROM (";
		sql += "	SELECT rownum rnum, B.* FROM (";
		sql += "		SELECT";
		sql += "			u.user_no";
		sql += "			, r.roomno, r.roomname";
		sql += "			, r.roomroadaddress";	
		sql	+= "			, r.roomdetailedaddress";
		sql += "			, ri.room_img_filename";
		sql += "			, b.bookmark_no";
		sql += " 		FROM (";
		sql += "	   		 SELECT * FROM (";
		sql += "	       		 SELECT";
		sql += "	          		  room_img_no, room_no, room_img_filename,";
		sql += "	          		  row_number() over( partition by room_no order by room_img_no ) rnum";
		sql += "					FROM room_img";
		sql += "	    		) ROOM";
		sql += "	   		 WHERE rnum = 1";
		sql += "			) ri, users u, room r, bookmark b";
		sql += "		WHERE ri.room_no = r.roomno";
		sql += "		AND u.user_no = b.user_no";
		sql += "		AND b.room_no = r.roomno";
		sql += "		AND u.user_no = ?";
		sql += "		ORDER BY b.bookmark_no DESC";
		sql += " 	) B";
		sql += " ) Bookmark";
		sql += " WHERE rnum BETWEEN ? AND ?";
		
		
		
		
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			ps.setInt(2, paging.getStartNo());
			ps.setInt(3, paging.getEndNo());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				
				User u = new User();
				Room r = new Room();
				RoomImg ri = new RoomImg();
				Bookmark b = new Bookmark();
				

				u.setUserNo( rs.getInt("user_no") );
				
				r.setRoomNo( rs.getInt("roomno") );
				r.setRoomName( rs.getString("roomname") );
				r.setRoomRoadAddress( rs.getString("roomroadaddress") );
				r.setRoomDetailedAddress( rs.getString("roomdetailedaddress") );
				
				ri.setRoomImgFilename( rs.getString("room_img_filename") );
				
				b.setBookmarkNo( rs.getInt("bookmark_no") );
				
				map.put("user", u);
				map.put("room", r);
				map.put("room_img", ri);
				map.put("bookmark", b);
				
				
				list.add(map);
			}
			
			System.out.println(list);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return list;
	}
	
	@Override
	public int deleteBookmarkBybookmarkno(int bookmarkno, Connection conn) {

		String sql = "";
		sql += "DELETE FROM bookmark";
		sql += " WHERE bookmark_no = ?";
		
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bookmarkno);
			
			res = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}

	

	@Override
	public int selectBookmarkCntAll(Connection conn, int userno) {
		String sql = "";
		sql += "SELECT count(*) cnt FROM bookmark";
		sql += " WHERE user_no = ?";
		
		//총 게시글 수
		int cnt = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cnt = rs.getInt(1);
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
	public Map<String, Object> selectBookingDetail(Connection conn, int userno, int roomno) {
		
		String sql = "";
		sql += "		SELECT";
		sql += "			b.room_no, b.booking_no, b.booking_status, b.booking_guest";
		sql	+= "			, b.booking_checkin, b.booking_checkout, b.booking_message";
		sql += "			, r.roomname, r.roomroadaddress, r.roomdetailedaddress";
		sql += "			, ri.room_img_no, ri.room_img_filename";
		sql += "			, ho.user_no, ho.user_email";
		sql	+= "			, ho.user_phone, ho.user_name, ho.user_no";
		sql += "		FROM booking b, room r";
		
		sql += "		, (SELECT * FROM (";
		sql += "    		SELECT";
		sql += "        		room_img_no, room_no, room_img_filename,";
		sql += "	        	row_number() over( partition by room_no order by room_img_no ) rnum";
		sql += "    			FROM room_img";
		sql += " 			) rmi";
		sql += "		WHERE rnum = 1";
		sql += "		) ri";
		
		sql += "		, (SELECT * FROM (";
		sql += "    		SELECT";
		sql += "        		user_no, user_email, user_phone, user_name";
		sql += "    			FROM users";
		sql += " 			) u";
		sql += "		) ho";
		
		sql += " 		WHERE b.user_no = ?";
		sql += " 		AND b.room_no = r.roomno";
		sql += "		AND r.roomno = ri.room_no";
		sql += "		AND r.roomno = ?";
		sql += " 		AND ho.user_no = r.userno";
		sql += " 		ORDER BY booking_no DESC";
		
		
		Map<String, Object> map = null;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			ps.setInt(2, roomno);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				map = new HashMap<>();
				
				Room r = new Room();
				Booking b = new Booking();
				RoomImg ri = new RoomImg();
				User ho = new User();

				r.setRoomNo( rs.getInt("room_no") );
				r.setRoomName( rs.getString("roomname") );
				r.setRoomRoadAddress( rs.getString("roomroadaddress") );
				r.setRoomDetailedAddress( rs.getString("roomdetailedaddress") );
				
				b.setBookingNo( rs.getInt("booking_no") );
				b.setRoomNo( rs.getInt("room_no") );
				b.setBookingStatus( rs.getString("booking_status") );
				b.setBookingCheckin( rs.getString("booking_checkin") );
				b.setBookingCheckout( rs.getString("booking_checkout") );
				b.setBookingGuest( rs.getInt("booking_guest") );
				b.setBookingMessage( rs.getString("booking_message") );
				
				ri.setRoomImgNo( rs.getInt("room_img_no") );
				ri.setRoomImgFilename( rs.getString("room_img_filename") );
				ri.setRoomNo(rs.getInt("room_no"));
				
				ho.setUserNo( rs.getInt("user_no") );
				ho.setUserName( rs.getString("user_name") );
				ho.setUserPhone( rs.getString("user_phone") );
				ho.setUserEmail(rs.getString("user_email"));
				
				map.put("room", r);
				map.put("booking", b);
				map.put("roomimg", ri);
				map.put("host", ho);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return map;
	}

}
