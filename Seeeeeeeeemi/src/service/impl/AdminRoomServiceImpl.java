package service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import common.JDBCTemplate;
import dao.face.AdminRoomDao;
import dao.impl.AdminRoomDaoImpl;
import dto.Room;
import service.face.AdminRoomService;

public class AdminRoomServiceImpl implements AdminRoomService {
	
	Connection conn = JDBCTemplate.getConnection();
	AdminRoomDao adminRoomDao = new AdminRoomDaoImpl();
	
	@Override
	public List<Room> getList() {
		
		List<Room> list = adminRoomDao.selectAll(conn);
		
		return list;
	}
	@Override
	public void approve(HttpServletRequest req) {
		
		String[] roomnoArr = req.getParameterValues("chk");
		List<Room> list = new ArrayList<>();
		Room room = null;
		for(String s : roomnoArr) {
			room = new Room();
			room.setRoomNo(Integer.parseInt(s));
			list.add(room);
		}
		
		for(Room updateRoom : list) {
			//숙소 승인하기
			int result = adminRoomDao.updateApprove(conn, updateRoom);
			//해당 숙소주인의 회원번호 얻기
			int userno = adminRoomDao.selectUsernoByRoomno(conn, updateRoom);
			//회원등급 바꾸기
			int result2 = adminRoomDao.updateUserGrade(conn, userno);
			if(result == 1 && result2 == 1) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}
		}
		
	}
	
	@Override
	public void refuse(HttpServletRequest req) {
		String[] roomnoArr = req.getParameterValues("chk");
		List<Room> list = new ArrayList<>();
		Room room = null;
		for(String s : roomnoArr) {
			room = new Room();
			room.setRoomNo(Integer.parseInt(s));
			list.add(room);
		}
		
		for(Room updateRoom : list) {
			int result = adminRoomDao.updateRefuse(conn, updateRoom);
			
			if(result == 1) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}
		}
	}
	
	@Override
	public void delete(HttpServletRequest req) {
		String[] roomnoArr = req.getParameterValues("chk");
		List<Room> list = new ArrayList<>();
		Room room = null;
		for(String s : roomnoArr) {
			room = new Room();
			room.setRoomNo(Integer.parseInt(s));
			list.add(room);
		}
		
		for(Room deleteRoom : list) {
			int result = adminRoomDao.updateDelete(conn, deleteRoom);
			
			if(result == 1) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}
		}
		
	}
}
