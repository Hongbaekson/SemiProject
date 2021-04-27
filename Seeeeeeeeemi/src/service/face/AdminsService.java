package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Board;
import dto.Review;
import dto.RoomImgReview;
import dto.User;

public interface AdminsService {
	
	/**
	 * 유저No 파라미터처리 
	 * @param req
	 * @return
	 */
	User getParamNo(HttpServletRequest req);
	/**
	 * 삭제가 되었으면 true반환, 안되었으면 false반환
	 * @param user
	 * @return
	 */
	Boolean delete(User user);
	/**
	 * 입력값 처리 객체반환 
	 * @param req
	 * @return
	 */
	User getInfo(HttpServletRequest req);
	/**
	 * 가입
	 * @param user
	 * @return
	 */
	int insert(User user);
	/**
	 * 공지등록
	 * @param board
	 */
	void writeNotice(Board board);
	/**
	 * 모든 리뷰가져옴
	 * @return
	 */
	List<RoomImgReview> getAllReview();
	/**
	 * 파라미터처리 
	 * @param req
	 * @return
	 */
	Review getParamReview(HttpServletRequest req);
	/**
	 * 리뷰삭제
	 * @param review
	 * @return
	 */
	int deleteReview(Review review);

}
