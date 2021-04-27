package dao.face;

import java.sql.Connection;
import java.util.List;

import dto.User;

public interface UserDao {
	/**
	 * 유저아이디,비밀번호가 일치하는 행을 조회한다
	 * @param connection
	 * @param user
	 * @return 일치하는행이 있으면 1, 아니면 0
	 */
	public int selectCntByUseridUserPw(Connection connection, User user);
	/**
	 * 입력받은 아이디와 일치하는 아이디의 정보를 조회한다  
	 * @param connection
	 * @param user - 입력받은 아이디 
	 * @return 전체정보를 포함한 객체
	 */
	public User selectByUserid(Connection connection, User user);
	
	/**
	 * 입력받은 객체를 db에 insert한다 
	 * @param connection
	 * @param user
	 * @return insert성공 - 1 , insert실패 -0
	 */
	public int insert(Connection connection, User user);
	
	/**
	 * user-name,tel을 입력받아서 일치하는 아이디를조회한다 
	 * @param connection
	 * @param user
	 * @return
	 */
	
	public User getId(Connection connection, User user);
	/**
	 * user-name,tel,id을 입력받아서 일치하는 비밀번호를조회한다 
	 * @param connection
	 * @param user
	 * @return
	 */
	public User getPw(Connection connection, User user);
	/**
	 * user-name,tel,id을 입력받아서 일치하는 행의 갯수를 반환 
	 * @param connection
	 * @param user
	 * @return
	 */
	public int getCntPw(Connection connection, User user);
	/**
	 * user-name, tel 받아서 일치하는 행의 갯수를 반환 
	 * @param connection
	 * @param user
	 * @return
	 */
	public int getCntId(Connection connection, User user);
	/**
	 * 입력한 user id와 일치하는 행의 갯수를 반환함 
	 * @param user
	 * @return
	 */
	public int selectCntByUserId(Connection connection,User user);
	/**
	 * 입력한 user email과 일치하는 행의 갯수를 반환함 
	 * @param connection
	 * @param user
	 * @return
	 */
	public int selectCntByUserEmail(Connection connection, User user);
	/**
	 * 입력한 user id, user pw 와 일치하는 행을 조회하고 갯수를 반환함 
	 * @param connection
	 * @param user
	 * @return
	 */
	public int loginAdmin(Connection connection, User user);
	/**
	 * 전체유저를 조회한다 
	 * @param connection
	 * @return
	 */
	public List<User> selectAll(Connection connection);

}
