package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBCTemplate;
import dao.face.BookingDao;
import dto.Booking;
import dto.User;

public class BookingDaoImpl implements BookingDao {

		PreparedStatement ps = null;
		ResultSet rs = null;
		
	

	@Override
	public int insertBookingData(Connection conn, Booking booking) {
		
		
		String sql ="";
		
		sql += "INSERT INTO booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, "
				+ "booking_message, room_no, booking_username, booking_userphone, booking_useremail)";
		sql += " VALUES(?, ?, ?, ?, ?, ?, ?, ? ,?, ?, ? )";
		
//		
//		sql += "UPDATE /*+bypass_ujvc+*/";
//		sql += " ( SELECT b.booking_no, u.user_no as uno ,r.room_no, b.host_no,";
//		sql +=	" b.booking_username, b.booking_userphone, b.booking_useremail,booking_checkin,"; 
//		sql +=	" b.booking_checkout, b.booking_guest ,b.booking_message,b.booking_status";
//		sql +=	" FROM booking b, users u, room r "; 
//		sql +=	" WHERE b.user_no = u.user_no "; 
//		sql	+=	" AND   b.host_no = u.user_no"; 
//		sql	+=	" AND   b.room_no = r.room_no";  
//		sql	+=	" )";  
//		sql	+=	" SET ";  
//		sql	+=	"    booking_no = booking_seq.nextval,"; 
//		sql	+=	"    booking_username = ?,"; 
//		sql +=	"    booking_userphone= ?,";  
//		sql	+=	"    booking_useremail =?,"; 
//		sql	+=	"    booking_checkin =?," ;
//		sql	+=	"    booking_checkout =?,"; 
//	    sql +=	"    booking_guest =?,";  
//		sql +=	"    booking_message =?,"; 
//		sql +=	"    booking_status =?";
//		
		System.out.println(booking);
		
		int res = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			
			
			ps.setInt(1, booking.getBookingNo());
			ps.setInt(2, booking.getUserNo());
			ps.setInt(3, booking.getBookingGuest());
			ps.setString(4, booking.getBookingCheckin());
			ps.setString(5, booking.getBookingCheckout());
			ps.setString(6, booking.getBookingStatus());
			ps.setString(7, booking.getBookingMessage());
			ps.setInt(8, booking.getRoomNo());
			ps.setString(9, booking.getBookingUsername());
			ps.setString(10, booking.getBookingUserphone());
			ps.setString(11, booking.getBookingUseremail());
			
			res = ps.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
			JDBCTemplate.close(ps);	
			
		}
		
		
		return res;
	}


	@Override
	public int selectBookingNo(Connection conn) {
		
		String sql = "SELECT booking_seq.nextval as next FROM dual";
		
		int bookingNo = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			while(rs.next()) {
				bookingNo = rs.getInt("next");
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
			
		}
		
		
		return bookingNo;
	}


	@Override
	public List<Booking> selectAll(Connection conn, User user) {
		
		
		String sql = "";
		       sql += "SELECT * FROM booking WHERE user_no =? ";
		       
		       List<Booking> list = new ArrayList<>();
		       
		       
		       try {
				ps = conn.prepareStatement(sql);
				
				ps.setInt(1, user.getUserNo());
				
				rs = ps.executeQuery();
				
				while(rs.next()) {
					
					Booking booking  = new Booking();
					
					booking.setBookingNo(rs.getInt("booking_no"));
					booking.setusersNo(rs.getInt("user_no"));
					booking.setBookingGuest(rs.getInt("booking_guest"));
					booking.setBookingCheckin(rs.getString("booking_checkin"));
					booking.setBookingCheckout(rs.getString("booking_checkout"));
					booking.setBookingStatus(rs.getString("booking_status"));
					booking.setBookingMessage(rs.getString("booking_message"));
					booking.setRoomNo(rs.getInt("room_no"));
					booking.setBookingUsername(rs.getString("booking_username"));
					booking.setBookingUserphone(rs.getString("booking_userphone"));
					booking.setBookingUseremail(rs.getString("booking_useremail"));
					
					
					list.add(booking);
					
					
					
					
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				
				JDBCTemplate.close(rs);
				JDBCTemplate.close(ps);
			}
		       
		       
		       
		       
		
		return list;
	}

}