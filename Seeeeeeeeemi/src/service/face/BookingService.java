package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Booking;

public interface BookingService {

	
	public Booking getBookingroomParam(HttpServletRequest req);


	public int BookingData(HttpServletRequest req, Booking booking);


	public List<Booking> getAllBookingList(HttpServletRequest req);




}
