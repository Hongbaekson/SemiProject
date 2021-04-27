package dao.face;

import java.sql.Connection;
import java.util.List;

import dto.Booking;
import dto.User;

public interface BookingDao {



	public int selectBookingNo(Connection conn);

	public int insertBookingData(Connection conn, Booking booking);

	public List<Booking> selectAll(Connection conn, User user);

}
