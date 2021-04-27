package dao.face;

import java.sql.Connection;
import java.util.List;

import dto.Bookmark;
import dto.Room;
import dto.RoomFacilityMapping;
import dto.RoomImg;
import dto.User;
import web.util.Paging;

public interface MyRoomBookmarkDao {

   public int insertBookmark(Connection conn, Bookmark bookmark);
}