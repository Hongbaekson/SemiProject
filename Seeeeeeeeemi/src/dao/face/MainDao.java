package dao.face;

import java.sql.Connection;
import java.util.List;

import dto.Room;
import dto.RoomImgReview;

public interface MainDao {
	/**
	 * 주소로 숙소를 조회함 
	 * @param connection
	 * @param room
	 * @return
	 */
	List<RoomImgReview> selectByAddress(Connection connection, RoomImgReview room);
	/**
	 * 인기숙소(리뷰가 최신순이면서 별점이 4개이상인 숙소)검색
	 * @param connection
	 * @return
	 */
	List<RoomImgReview> selectPopularRoom(Connection connection);

}
