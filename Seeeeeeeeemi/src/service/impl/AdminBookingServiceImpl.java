package service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import common.JDBCTemplate;
import dao.face.AdminBookingDao;
import dao.impl.AdminBookingDaoImpl;
import dto.Room;
import service.face.AdminBookingService;

public class AdminBookingServiceImpl implements AdminBookingService {
	
	AdminBookingDao adminBookingDao = new AdminBookingDaoImpl();
	Connection conn = JDBCTemplate.getConnection();
	@Override
	public List<Map<String, Object>> getList() {
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		list = adminBookingDao.selectAll(conn);
		
		return list;
	}
	@Override
	public void delete(HttpServletRequest req) {
		String[] bookingnoArr = req.getParameterValues("chk");
		List<Integer> bookingnoList = new ArrayList<>();
		for(String s : bookingnoArr) {
			int no = Integer.parseInt(s);
			bookingnoList.add(no);
		}
		
		for(int bookingno : bookingnoList) {
			int result = adminBookingDao.delete(conn, bookingno);
			
			if(result == 1) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}
		}
	}
}
