package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBCTemplate;
import dao.face.AdminRoomDao;
import dto.Room;

public class AdminRoomDaoImpl implements AdminRoomDao{
	
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	@Override
	public List<Room> selectAll(Connection conn) {
		String sql = "SELECT * FROM room";
		
		List<Room> list = new ArrayList<>();
		Room room = null;
		
		try {
 			ps = conn.prepareStatement(sql);
 			
 			rs = ps.executeQuery();
 			
 			while(rs.next()) {
 				room = new Room();
 				
 				room.setRoomNo(rs.getInt("roomNo"));
				room.setUserNo(rs.getInt("userNo"));
				room.setRoomName(rs.getString("roomName"));
				room.setRoomGuests(rs.getInt("roomGuests"));
				room.setRoomPrice(rs.getInt("roomPrice"));
				room.setRoomBedroom(rs.getInt("roomBedroom"));
				room.setRoomBed(rs.getInt("roomBed"));
				room.setRoomAdminCheck(rs.getString("roomAdminCheck"));
				room.setRoomDesc(rs.getString("roomDesc"));
				room.setRoomBathroom(rs.getInt("roomBathroom"));
				room.setRoomType(rs.getString("roomType"));
				room.setRoomRoadAddress(rs.getString("roomRoadAddress"));
				room.setRoomDetailedAddress(rs.getString("roomDetailedAddress"));
 				
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
	public int updateApprove(Connection conn, Room updateRoom) {
		String sql = "UPDATE room SET roomAdminCheck = 'Y' WHERE roomNo = ?";
		int result = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, updateRoom.getRoomNo());
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return result;
	}
	
	@Override
	public int updateRefuse(Connection conn, Room updateRoom) {
		String sql = "UPDATE room SET roomAdminCheck = 'N' WHERE roomNo = ?";
		int result = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, updateRoom.getRoomNo());
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return result;
	
	}
	
	@Override
	public int updateDelete(Connection conn, Room deleteRoom) {
		String sql = "DELETE room WHERE roomNo = ?";
		int result = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, deleteRoom.getRoomNo());
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return result;
	}
	
	@Override
	public int selectUsernoByRoomno(Connection conn, Room updateRoom) {
		String sql = "SELECT userno FROM room WHERE roomNo = ?";
		int userno = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, updateRoom.getRoomNo());
			
			rs = ps.executeQuery();
			if(rs.next()) {
				userno = rs.getInt("userno");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return userno;
	}
	
	@Override
	public int updateUserGrade(Connection conn, int userno) {
		String sql = "UPDATE users SET user_grade = ? WHERE user_no = ?";
		int result = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, 2);
			ps.setInt(2, userno);
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		return result;
	}
}
