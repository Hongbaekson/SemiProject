package dao.face;

import java.sql.Connection;
import java.util.List;

import dto.Review;
import dto.Room;
import web.util.ReviewPaging;

public interface ReviewDao {

	public int insertReview(Connection conn, Review reviewParam);
	public List<Review> selectReviewByRoom(Connection conn, Room room);
	public List<Review> selectReviewByRoom(Connection conn, Room room, ReviewPaging paging);
	public int selectCntRow(Connection conn, int roomNo);
	

}
