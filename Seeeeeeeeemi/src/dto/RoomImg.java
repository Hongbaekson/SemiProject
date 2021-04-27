package dto;

public class RoomImg {
	private int roomImgNo; //숙소이미지 번호
	private int roomNo; //숙소번호
	private String roomImgFilename; // 저장된 이미지파일명
	
	@Override
	public String toString() {
		return "RoomImg [roomImgNo=" + roomImgNo + ", roomNo=" + roomNo + ", roomImgFilename=" + roomImgFilename + "]";
	}
	
	public int getRoomImgNo() {
		return roomImgNo;
	}
	public void setRoomImgNo(int roomImgNo) {
		this.roomImgNo = roomImgNo;
	}
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public String getRoomImgFilename() {
		return roomImgFilename;
	}
	public void setRoomImgFilename(String roomImgFilename) {
		this.roomImgFilename = roomImgFilename;
	}
	
	
}
