package service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import common.JDBCTemplate;
import dao.face.MainDao;
import dao.impl.MainDaoImpl;
import dto.Room;
import dto.RoomImgReview;
import service.face.MainService;

public class MainServiceImpl implements MainService {
	
	MainDao mainDao = new MainDaoImpl();
	
	@Override
	public RoomImgReview getParam(HttpServletRequest req) {
		RoomImgReview room = new RoomImgReview();
		room.setRoomRoadAddress(req.getParameter("address"));
		return room;
	}
	
	@Override
	public List<RoomImgReview> getRoom(RoomImgReview room) {
		List<RoomImgReview> list = mainDao.selectByAddress(JDBCTemplate.getConnection(), room);
		return list;
	}
	
	@Override
	public List<RoomImgReview> getPopularRoom() {
		List<RoomImgReview> list = mainDao.selectPopularRoom(JDBCTemplate.getConnection());
		return list;
	}
	
}
