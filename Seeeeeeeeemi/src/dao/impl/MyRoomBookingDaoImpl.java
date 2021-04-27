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
import dao.face.MyRoomBookingDao;
import dto.Room;
import util.BookingPaging;

public class MyRoomBookingDaoImpl implements MyRoomBookingDao {
	
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	@Override
	public int selectCntByRoomno(Connection conn, int roomno) {
		String sql = "SELECT count(*) cnt FROM booking"
				+ " WHERE room_no = ?";
		
		//호스트의 총 예약 수
		int cnt = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, roomno);
			
			rs = ps.executeQuery();
			if(rs.next()) {
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
	public List<Map<String, Object>> selectByPaging(Connection conn, int hostNo, BookingPaging paging) {
		String sql = "SELECT * FROM (" 
					+" SELECT rownum rnum, BB.* FROM(" 
					+" 	SELECT"
					+" 		B.booking_no 예약번호"
					+" 		, R.roomName 숙소명"
					+" 		, B.booking_username 예약자이름"
					+" 		, B.booking_userphone 예약자연락처"
					+" 		, B.booking_checkin 체크인"
					+" 		, B.booking_checkout 체크아웃"
					+" 		, B.booking_message 예약자메시지"
					+" 		, B.booking_status 예약상태"
					+" 		, B.booking_useremail 예약자이메일"
					+" 	FROM ROOM R, BOOKING B"
					+"	WHERE R.ROOMNO = B.ROOM_NO AND R.USERNO = ?" 
					+" 	ORDER BY B.booking_checkin DESC) BB"
					+" ) WHERE rnum between ? and ?";
		
		//정보를 담을 Map
		Map<String, Object> map = null;
		
		//정보 리스트
		List<Map<String, Object>> list = new ArrayList<>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, hostNo);
			ps.setInt(2, paging.getStartNo());
			ps.setInt(3, paging.getEndNo());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				map = new HashMap<String, Object>();
				
				map.put("예약번호", rs.getInt("예약번호"));
				map.put("숙소명", rs.getString("숙소명"));
				map.put("예약자이름", rs.getString("예약자이름"));
				map.put("예약자연락처", rs.getString("예약자연락처"));
				map.put("체크인", rs.getString("체크인"));
				map.put("체크아웃", rs.getString("체크아웃"));
				map.put("예약자메시지", rs.getString("예약자메시지"));
				map.put("예약상태", rs.getString("예약상태"));
				map.put("예약자이메일", rs.getString("예약자이메일"));
				
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
	public int updateStatus(Connection conn, int bookingno, String bookingStatus) {
		String sql = "UPDATE booking SET booking_status = ?"
				+ " WHERE booking_no = ?";
		
		int result = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, bookingStatus);
			ps.setInt(2, bookingno);
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return result;
	}
	
	@Override
	public List<Integer> selectRoomnoByUserno(Connection conn, int hostNo) {
		String sql = "SELECT roomNo FROM room WHERE USERNO = ?";
		
		List<Integer> list = new ArrayList<>();
		int roomno = -1;
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, hostNo);
			
			rs = ps.executeQuery();
			while(rs.next()) {
				roomno = rs.getInt("roomNo");
				
				list.add(roomno);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		
		return list;
	}
	/* 없어도될듯
	 * @Override public int deleteBooking(Connection conn, Room room) { String sql =
	 * "DELETE booking WHERE booking_no = ?";
	 * 
	 * int result = -1;
	 * 
	 * try { ps = conn.prepareStatement(sql);
	 * 
	 * ps.setInt(1, room.getRoomNo());
	 * 
	 * result = ps.executeUpdate(); } catch (SQLException e) { e.printStackTrace();
	 * } finally { JDBCTemplate.close(ps); } return result; }
	 */
}
