package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.User;

public interface UserService {

	/**
	 * 로그인화면에서 아이디랑 비밀번호를 받아서 User 객체로 반환한다 
	 * @param req 
	 */
	public User getParam(HttpServletRequest req);
	
	/**
	 * 로그인 인증
	 * @param user - 입력받은 아이디랑 비밀번호
	 * @return 
	 */
	
	public boolean login(User user);
	
	/**
	 * 입력받은아이디로 조회해서 사용자의 정보 가져오기 
	 * @param user - 입력받은 아이디, 비밀번호
	 * @return - 사용자의 정보 
	 */
	public User info(User user);
	
	/**
	 * 회원가입 파라미터 처리 
	 * @param req
	 * @return 
	 */
	
	public User getJoinInfo(HttpServletRequest req);

	/**
	 * 입력된 정보를 db에 입력한다
	 * @param user - 회원가입폼에 입력한 객체정보
	 */
	public int join(User user);
	
	/**
	 * 아이디랑 비밀번호를 받아서 객체로 반환한다 
	 * @param req
	 * @return
	 */
	
	public User getNameTelParam(HttpServletRequest req);
	/**
	 * 아이디를 가져옴
	 * @param user
	 * @return
	 */
	public User getId(User user);
	/**
	 * 이름, 아이디, 연락처를 받아서 객체로 반환한다  
	 * @param req
	 * @return
	 */
	public User getNameIdTelParam(HttpServletRequest req);
	/**
	 * 비밀번호를 가져옴
	 * @param user
	 * @return
	 */
	public User getPw(User user);
	/**
	 * 비밀번호 일치하는 행이 있는지 
	 * @param user
	 * @return
	 */
	public boolean getCntPw(User user);
	/**
	 * 이름, 연락처가 일치하는 행이 있는지 
	 * @param user
	 * @return
	 */

	public boolean getCntId(User user);
	
	/**
	 * 입력받은 아이디를 객체에 저장 
	 * @param req
	 * @return
	 */
	public User getParamId(HttpServletRequest req);
	/**
	 * 아이디가 일치하는지 조회
	 * @param user
	 * @return 일치하면 true반환 
	 */
	public boolean getMatch(User user);
	/**
	 * 입력받은 이메일을 객체에 저장해서 반환
	 * @param req
	 * @return
	 */
	public User getParamEmail(HttpServletRequest req);
	/**
	 * 이메일이 일치하는지 조회
	 * @param user
	 * @return
	 */
	public Boolean getMatchEmail(User user);
	/**
	 * 관리자 id와 pw파라미터 처리 
	 * @param req
	 * @return
	 */
	public User getAdminParam(HttpServletRequest req);
	/**
	 * 관리자 id와 pw일치하면 true
	 * @param user
	 * @return
	 */
	public boolean loginAdmin(User user);
	/**
	 * 전체유저를 가져옴
	 * @return
	 */
	public List<User> getAllUser();

}
