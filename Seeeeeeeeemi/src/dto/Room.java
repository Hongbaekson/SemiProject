package dto;

public class Room {
	private int roomNo; //숙소번호
	private int userNo; //회원번호
	private String roomName; //숙소명
	private int roomGuests; //숙소최대게스트
	private int roomPrice; //1박당 가격
	private int roomBedroom; //침실 수
	private int roomBed; //침대/침구류 수
	private int roomBathroom; //욕실 수
	private String roomType; //숙소유형
	private String roomRoadAddress; //숙소 도로명주소
	private String roomDetailedAddress; //숙소 상세주소
	private String roomDesc; //숙소에 대한 설명
	private String roomAdminCheck; //숙소에 대한 관리자 승인 여부 (Y/N/W)
	
	
	
	@Override
	public String toString() {
		return "Room [roomNo=" + roomNo + ", userNo=" + userNo + ", roomName=" + roomName + ", roomGuests=" + roomGuests
				+ ", roomPrice=" + roomPrice + ", roomBedroom=" + roomBedroom + ", roomBed=" + roomBed
				+ ", roomBathroom=" + roomBathroom + ", roomType=" + roomType + ", roomRoadAddress=" + roomRoadAddress
				+ ", roomDetailedAddress=" + roomDetailedAddress + ", roomDesc=" + roomDesc + ", roomAdminCheck="
				+ roomAdminCheck + "]";
	}
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public int getRoomGuests() {
		return roomGuests;
	}
	public void setRoomGuests(int roomGuests) {
		this.roomGuests = roomGuests;
	}
	public int getRoomPrice() {
		return roomPrice;
	}
	public void setRoomPrice(int roomPrice) {
		this.roomPrice = roomPrice;
	}
	public int getRoomBedroom() {
		return roomBedroom;
	}
	public void setRoomBedroom(int roomBedroom) {
		this.roomBedroom = roomBedroom;
	}
	public int getRoomBed() {
		return roomBed;
	}
	public void setRoomBed(int roomBed) {
		this.roomBed = roomBed;
	}
	public int getRoomBathroom() {
		return roomBathroom;
	}
	public void setRoomBathroom(int roomBathroom) {
		this.roomBathroom = roomBathroom;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public String getRoomRoadAddress() {
		return roomRoadAddress;
	}
	public void setRoomRoadAddress(String roomRoadAddress) {
		this.roomRoadAddress = roomRoadAddress;
	}
	public String getRoomDetailedAddress() {
		return roomDetailedAddress;
	}
	public void setRoomDetailedAddress(String roomDetailedAddress) {
		this.roomDetailedAddress = roomDetailedAddress;
	}
	public String getRoomDesc() {
		return roomDesc;
	}
	public void setRoomDesc(String roomDesc) {
		this.roomDesc = roomDesc;
	}
	public String getRoomAdminCheck() {
		return roomAdminCheck;
	}
	public void setRoomAdminCheck(String roomAdminCheck) {
		this.roomAdminCheck = roomAdminCheck;
	}
	
}