package service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.JDBCTemplate;
import dao.face.MyRoomBookingDao;
import dao.impl.MyRoomBookingDaoImpl;
import service.face.MyRoomBookingService;
import util.BookingPaging;

public class MyRoomBookingServiceImpl implements MyRoomBookingService {
	
	Connection conn = JDBCTemplate.getConnection();
	MyRoomBookingDao myRoomBookingDao = new MyRoomBookingDaoImpl();
	
	@Override
	public BookingPaging getPaging(HttpServletRequest req) {
		//전달파라미터 curPage 파싱
		String param = req.getParameter("curPage");
		
		HttpSession session = req.getSession();
		int hostNo = (Integer)session.getAttribute("userno");
		
		int curPage=0;
		if(param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		//호스트번호로 호스트가 가진 숙소번호 리스트 얻기
		List<Integer> roomno = new ArrayList<>();
		roomno = myRoomBookingDao.selectRoomnoByUserno(conn, hostNo);
		
		//호스트의 예약 테이블의 총 갯수를 조회한다.
		int totalCount = 0;
		for(int n : roomno) {
			totalCount += myRoomBookingDao.selectCntByRoomno(conn, n);
		}
		
		//Paging 객체 생성
		BookingPaging paging = new BookingPaging(totalCount, curPage);
		
		return paging;
	}
	
	@Override
	public List<Map<String, Object>> getList(int hostNo, BookingPaging paging) {
		
		List<Map<String, Object>> list = myRoomBookingDao.selectByPaging(conn, hostNo, paging);
			
		return list;
	}
	
	@Override
	public void updateStatus(HttpServletRequest req) {
		
		int bookingno = Integer.parseInt(req.getParameter("bookingno"));
		
		String bookingStatus = req.getParameter("bookingstatus");
		
		int result = myRoomBookingDao.updateStatus(conn, bookingno, bookingStatus);
		
		if(result == 1) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
	}
}
