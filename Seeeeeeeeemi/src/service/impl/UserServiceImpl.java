package service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import common.JDBCTemplate;
import dao.face.UserDao;
import dao.impl.UserDaoImpl;
import dto.User;
import service.face.UserService;

public class UserServiceImpl implements UserService {
	
	//UserDao객체
	UserDao userDao = new UserDaoImpl();
	
	@Override
	public User getParam(HttpServletRequest req) {
		
		User user = new User();
		user.setUserId( req.getParameter("uid") );
		user.setUserPw( req.getParameter("upw") );
				
		return user;
	}
	
	@Override
	public boolean login(User user) {
			
		if( userDao.selectCntByUseridUserPw(JDBCTemplate.getConnection(), user) ==1 ) {
			return true; //로그인성공
		} else {
			return false;
		}
	}
	
	@Override
	public User info(User user) {
		return userDao.selectByUserid(JDBCTemplate.getConnection(),user);
	}
	
	@Override
	public User getJoinInfo(HttpServletRequest req) {
		
		User user = new User();
		user.setUserId(req.getParameter("uid"));
		user.setUserName(req.getParameter("uname"));
		user.setUserNick(req.getParameter("unick"));
		user.setUserPw(req.getParameter("upw"));
		user.setUserGender(req.getParameter("ugender"));
		user.setUserBithdate(req.getParameter("ubirth"));
		user.setUserEmail(req.getParameter("uemail"));
		user.setUserPhone(req.getParameter("uphone"));
	
		return user;
	}
	
	@Override
	public int join(User user) {
		
		int res = userDao.insert(JDBCTemplate.getConnection(),user);
		if(res>0) {
			JDBCTemplate.commit(JDBCTemplate.getConnection());
			System.out.println("회원가입 성공");
			return res;
		}else {
			JDBCTemplate.close(JDBCTemplate.getConnection());
			System.out.println("회원가입 실패 ");
			return res;
		}
	}
	
	@Override
	public User getNameTelParam(HttpServletRequest req) {
		
		User user = new User();
		
		String name = req.getParameter("uname");
		String tel= req.getParameter("utel");
		
		if( name!=null && tel !=null && !"".equals(name) && !"".equals(name)) {
			user.setUserName( name );
			user.setUserPhone( tel );
			
			return user;
		}else {
			return null;
		}
		
	}
	@Override
	public User getId(User user) {
		return userDao.getId(JDBCTemplate.getConnection(), user);
	}
	
	@Override
	public User getNameIdTelParam(HttpServletRequest req) {
		User user = new User();
		user.setUserName( req.getParameter("uname"));
		user.setUserPhone( req.getParameter("utel") );
		user.setUserId( req.getParameter("uid") );
		return user;
	}
	@Override
	public User getPw(User user) {
		return userDao.getPw(JDBCTemplate.getConnection(), user);
	}
	
	@Override
	public boolean getCntPw(User user) {
		
		int cnt = userDao.getCntPw(JDBCTemplate.getConnection(), user);
		if(cnt>0) {
			return true;
		}else {
			return false;
		}
	}
	@Override
	public boolean getCntId(User user) {
		int cnt = userDao.getCntId(JDBCTemplate.getConnection(), user);
		if(cnt>0) {
			return true;
		}else {
			return false;
		}
		
	}
	@Override
	public User getParamId(HttpServletRequest req) {
		User user = new User();
		user.setUserId( req.getParameter("id") );
		return user;
	}
	
	@Override
	public boolean getMatch(User user) {
		
		int cnt = userDao.selectCntByUserId(JDBCTemplate.getConnection(), user);
		if(cnt>0) {
			return true;
		}else {
			return false;
		}
	}
	
	@Override
	public User getParamEmail(HttpServletRequest req) {
		
		User user = new User();
		user.setUserEmail(req.getParameter("email") );
		return user;
	}
	@Override
	public Boolean getMatchEmail(User user) {
		
		int cnt = userDao.selectCntByUserEmail(JDBCTemplate.getConnection(), user);
		if(cnt>0) {
			return true;
		}else {
			return false;
		}
		
	}
	@Override
	public User getAdminParam(HttpServletRequest req) {
		
		User user = new User();
		user.setUserId(req.getParameter("uid"));
		user.setUserPw(req.getParameter("upw"));
			
		return user;
	}
	@Override
	public boolean loginAdmin(User user) {
		
		int cnt = userDao.loginAdmin(JDBCTemplate.getConnection(), user);
		if(cnt>0) {
			return true;
		}else {
			return false;
		}
	}
	@Override
	public List<User> getAllUser() {	
		return userDao.selectAll(JDBCTemplate.getConnection());
	}
}
