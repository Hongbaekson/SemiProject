package dto;

public class RoomFacilityMapping {
	private int roomNo; //숙소번호
	private int facilityNo; //편의시설 번호
	
	
	@Override
	public String toString() {
		return "RoomFacilityMapping [roomNo=" + roomNo + ", facilityNo=" + facilityNo + "]";
	}
	
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public int getFacilityNo() {
		return facilityNo;
	}
	public void setFacilityNo(int facilityNo) {
		this.facilityNo = facilityNo;
	}
	
	
}
