package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Review;
import dto.Room;
import web.util.ReviewPaging;

public interface ReviewService {
	/**
	 * 
	 * @param req
	 * @return Review ajax로 받아온 commnet 정보를 객체에 저장. 
	 */
	public Review review(HttpServletRequest req);

	public void addReview(Review reviewParam);

	public List<Review> selectReviewByRoom(Room room);
	
	public List<Review> selectReviewByRoom(Room room, ReviewPaging paging);
	
	public ReviewPaging getPaging(HttpServletRequest req, int roomNo);


}
