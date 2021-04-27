package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.JDBCTemplate;
import dao.face.HostDao;
import dto.Room;
import dto.RoomFacilityMapping;
import dto.RoomImg;

public class HostDaoImpl implements HostDao {
	PreparedStatement ps = null;
	ResultSet rs = null;
	@Override
	public int selectNextRoomNo(Connection conn) {
		String sql = "SELECT room_seq.nextval as next FROM dual";
		int roomNo = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				roomNo = rs.getInt("next");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return roomNo;
	}
	@Override
	public int insertRoom(Connection conn, Room room) {
		System.out.println("[TEST] HostDaoImpl - insertRoom() 호출");
		String sql = "INSERT INTO room(roomNo, userNo, roomName, roomGuests, roomPrice,"
				+ " roomBedroom, roomBed, roomAdminCheck, roomDesc, roomBathroom, roomType,"
				+ " roomRoadAddress, roomDetailedAddress)"
				+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,? ,?)";
		int res = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, room.getRoomNo());
			ps.setInt(2, room.getUserNo());
			ps.setString(3, room.getRoomName());
			ps.setInt(4, room.getRoomGuests());
			ps.setInt(5, room.getRoomPrice());
			ps.setInt(6, room.getRoomBedroom());
			ps.setInt(7, room.getRoomBed());
			ps.setString(8, room.getRoomAdminCheck());
			ps.setString(9, room.getRoomDesc());
			ps.setInt(10, room.getRoomBathroom());
			ps.setString(11, room.getRoomType());
			ps.setString(12, room.getRoomRoadAddress());
			ps.setString(13, room.getRoomDetailedAddress());
			
			res = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		return res;
	}
	@Override
	public int insertRoomFac(Connection conn, RoomFacilityMapping data) {
		System.out.println("[TEST] HostDaoImpl - insertRoomFac() 호출");
		String sql = "INSERT INTO room_facility_mapping(room_no, facility_no)"
				+ " VALUES(?, ?)";
		int res = -1; 
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, data.getRoomNo());
			ps.setInt(2, data.getFacilityNo());
			
			res = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}
	@Override
	public int insertRoomImg(Connection conn, RoomImg data) {
		System.out.println("[TEST] HostDaoImpl - insertRoomImg() 호출");
		String sql = "INSERT INTO room_img(room_img_no, room_no, room_img_filename)"
				+ " VALUES(ROOM_IMG_SEQ.nextval, ?, ?)";
		int res = -1;
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, data.getRoomNo());
			ps.setString(2, data.getRoomImgFilename());
			
			res = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}
}
