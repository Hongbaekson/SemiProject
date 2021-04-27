package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Room;
import dto.RoomImgReview;

public interface MainService {
	/**
	 * 파라미터 처리 
	 * @param req
	 * @return
	 */
	RoomImgReview getParam(HttpServletRequest req);
	/**
	 * 숙소 정보들을 가져온다 
	 * @param room
	 * @return
	 */
	List<RoomImgReview> getRoom(RoomImgReview room);
	/**
	 * 인기숙소를 가져온다 
	 * @return
	 */
	List<RoomImgReview> getPopularRoom();

}
