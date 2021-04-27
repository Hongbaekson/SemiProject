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
import dao.face.AdminBookingDao;

public class AdminBookingDaoImpl implements AdminBookingDao {
	
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	@Override
	public List<Map<String, Object>> selectAll(Connection conn) {
		String sql = "SELECT "
				+ "		b.booking_no 예약번호"
				+ "		, b.user_no 회원번호"
				+ "		, r.roomName 숙소명"
				+ "		, b.booking_checkin 체크인"
				+ "		, b.booking_checkout 체크아웃"
				+ "		, b.booking_status 예약상태"
				+ " FROM booking b, room r"
				+ " WHERE b.room_no = r.roomNo";
		List<Map<String, Object>> list = new ArrayList<>();
		
		Map<String, Object> map = null;
		try {
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				map = new HashMap<>();
				
				map.put("예약번호", rs.getInt("예약번호"));
				map.put("회원번호", rs.getInt("회원번호"));
				map.put("숙소명", rs.getString("숙소명"));
				map.put("체크인", rs.getString("체크인"));
				map.put("체크아웃", rs.getString("체크아웃"));
				map.put("예약상태", rs.getString("예약상태"));
				
				list.add(map);
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
	public int delete(Connection conn, int bookingno) {
		String sql = "DELETE booking WHERE booking_no = ?";
		
		int result = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, bookingno);
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return result;
	}
}
