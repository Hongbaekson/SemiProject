package service.impl;


import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.JDBCTemplate;
import dao.face.MyRoomBookmarkDao;
import dao.impl.MyRoomBookmarkDaoImpl;
import dto.Bookmark;
import dto.Room;
import dto.RoomFacilityMapping;
import dto.RoomImg;
import dto.User;
import service.face.MyRoomBookmarkService;

import web.util.Paging;

public class MyRoomBookmarkServiceImpl implements MyRoomBookmarkService {
   

   MyRoomBookmarkDao myRoomBookmarkDao = new MyRoomBookmarkDaoImpl();

   public void insertBookmark(HttpServletRequest req) {
      Connection conn = JDBCTemplate.getConnection();
      HttpSession session = req.getSession();
      int user_no = (int)session.getAttribute("userno");
      int room_no = Integer.parseInt((String) req.getParameter("bookmarkRoomNo"));
      
      Bookmark bookmark = new Bookmark();
      bookmark.setUserNo(user_no);
      bookmark.setRoomNo(room_no);
      
      myRoomBookmarkDao.insertBookmark(conn, bookmark);
   }

}