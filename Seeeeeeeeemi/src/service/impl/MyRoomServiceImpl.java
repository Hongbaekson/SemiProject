package service.impl;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import common.JDBCTemplate;
import dao.face.HostDao;
import dao.face.MyRoomBookingDao;
import dao.face.MyRoomDao;
import dao.impl.HostDaoImpl;
import dao.impl.MyRoomBookingDaoImpl;
import dao.impl.MyRoomDaoImpl;
import dto.Room;
import dto.RoomFacilityMapping;
import dto.RoomImg;
import dto.User;
import service.face.MyRoomService;
import web.util.Paging;

public class MyRoomServiceImpl implements MyRoomService {
	
	MyRoomDao myRoomDao = new MyRoomDaoImpl();
	HostDao hostDao = new HostDaoImpl();
	MyRoomBookingDao myRoomBookingDao = new MyRoomBookingDaoImpl();
	Connection conn = JDBCTemplate.getConnection();
	
	@Override
	public List<Room> getRoomList(HttpServletRequest req) {
		
		List<Room> myRoomList = new ArrayList<>();
		myRoomList = myRoomDao.selectAll(conn);
		
		return myRoomList;
	}
	@Override
	public List<Room> getRoomList(HttpServletRequest req, int userno) {
		
		List<Room> myRoomList = new ArrayList<>();
		myRoomList = myRoomDao.selectAll(conn, userno);
		
		return myRoomList;
	}
	
	@Override
	public Room getRoomNo(HttpServletRequest req) {
		int roomNo = Integer.parseInt( req.getParameter("roomno") );
		
		Room room = new Room();
		room.setRoomNo(roomNo);
		
		return room;
	}
	
	@Override
	public Room getRoom(Room room) {
		
		Room roomView = myRoomDao.selectRoom(conn, room);
		
		return roomView;
	}
	
	@Override
	public List<RoomImg> getRoomImgList(Room room) {
		
		List<RoomImg> list = myRoomDao.selectRoomImg(conn, room);
		
		return list;
	}
	
	@Override
	public List<String> getRoomFacList(Room room) {
		
		List<RoomFacilityMapping> list = myRoomDao.selectRoomFac(conn, room);
		
		//편의시설 정보를 문자열로 저장할 리스트
		List<String> stringList = new ArrayList<>();
		for(RoomFacilityMapping r : list) {
			String str = null;
			if(r.getFacilityNo() == 1) {
				str = "주방";
			} else if(r.getFacilityNo() == 2) {
				str = "주차장";
			} else if(r.getFacilityNo() == 3) {
				str = "무선인터넷";
			} else if(r.getFacilityNo() == 4) {
				str = "에어컨";
			} else if(r.getFacilityNo() == 5) {
				str = "수영장";
			} else if(r.getFacilityNo() == 6) {
				str = "헤어드라이어";
			} else if(r.getFacilityNo() == 7) {
				str = "필수품목";
			} else if(r.getFacilityNo() == 8) {
				str = "애완동물 가능";
			}
			stringList.add(str);
		}
		return stringList;
	}
	
	@Override
	public void delete(HttpServletRequest req, Room room) {
		System.out.println("[test] MyRoomService delete() 호출");
		//숙소 이미지 정보 임시저장
		List<RoomImg> list = myRoomDao.selectRoomImg(conn, room);
		
		//편의시설, 이미지, [북마크(같이 지워야함), 예약, 리뷰] => db에서 테이블 생성할 때 on delete cascade 넣어주면 될듯?
//		int bookmarkRes =
//		int bookingRes = myRoomBookingDao.deleteBooking(conn, room);
		int imgRes = myRoomDao.deleteRoomImg(conn, room);
		int facRes = myRoomDao.deleteRoomFac(conn, room);
		int roomRes = myRoomDao.deleteRoom(conn, room);
		
		//서버에 저장된 이미지파일 삭제
		if(roomRes == 1 && imgRes >= 0 && facRes >= 0 ) {
			for(RoomImg r : list) {
				if(r != null) {
					File file = new File(req.getServletContext().getRealPath("upload")+"\\"+r.getRoomImgFilename()); 
					if( file.exists() ){ 
						if(file.delete()){ 
							System.out.println("MyRoomService delete() - 첨부파일삭제 성공"); 
						} else {
							System.out.println("MyRoomService delete() - 첨부파일삭제 실패"); 
						} 
					} else {
						System.out.println("MyRoomService delete() - 파일이 존재하지 않습니다."); 
					} 
				}
			}
		}
		System.out.println("roomRes : " +roomRes);
		System.out.println("imgRes : " +imgRes);
		System.out.println("facRes : " +facRes);
		//DB 트랜잭션 처리
		if(roomRes == 1 && imgRes >= 0 && facRes >= 0 ) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
	}
	
	@Override
	public int update(HttpServletRequest req) {
		System.out.println("[test] HostServiceImpl - registerForm() 호출");
		int roomNo = Integer.parseInt(req.getParameter("roomno"));
		
		//**첨부파일 추가하여 글 작성 처리
		
		//숙소 정보를 저장할 객체
		Room room = null;
		
		//숙소의 편의시설 정보를 저장할 객체
		List<RoomFacilityMapping> roomFacMapList = new ArrayList<>();
		
		//숙소 이미지 파일 정보를 저장할 리스트
		List<RoomImg> roomImgList = new ArrayList<>();
		//숙소 이미지 파일 정보 저장할 객체
		RoomImg roomImg = null;
		
		//파일업로드 형태의 데이터가 맞는지 검사
		boolean isMultipart = false;
		isMultipart = ServletFileUpload.isMultipartContent(req);
		
		//multipart/form-data 인코딩으로 전송되지 않았을 경우
		if( !isMultipart ) {
			System.out.println("[ERROR] multipart/form-data 형식이 아님");
			
			return -1; // 에러 / 메소드 실행 중지
		}
		
		//roomNo를 객체에 저장
		room = new Room();
		room.setRoomNo(roomNo);
		//roomNo가 저장된 객체를 이용하여 해당 숙소 정보 조회
		room = myRoomDao.selectRoom(conn, room);
		
		//편의시설 정보를 문자열로 임시저장할 리스트
		List<String> facList = new ArrayList<>();
		
		//--------- 파일 업로드 설정 -------------
		//디스크기반 아이템 팩토리
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		//메모리 처리 사이즈 지정
		factory.setSizeThreshold( 1 * 1024 * 1024 ); //1MB
		
		
		//임시 저장소 설정
		File repository = new File(req.getServletContext().getRealPath("tmp"));
		repository.mkdir();
		
		factory.setRepository(repository);
		
		//파일업로드 객체 생성
		ServletFileUpload upload = new ServletFileUpload(factory);

		//업로드 용량 제한
		upload.setFileSizeMax( 10*1024*1024 ); //10MB
		
		//전달 데이터 파싱
		List<FileItem> items = null;
		try {
			items = upload.parseRequest(req);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		
		//추출된 전달파라미터 처리 반복자
		Iterator<FileItem> iter = items.iterator();

		//모든 요청 정보 처리하기
		while( iter.hasNext() ) {
			FileItem item = iter.next();
			
			// 1) 빈 파일 처리
			if( item.getSize() <= 0 )	continue;
			
			// 2) 일반적인 요청 데이터 처리
			if( item.isFormField() ) {

				String key = item.getFieldName(); //키 추출
				if( "roadAddress".equals(key) ) { //전달파라미터 name이 "roadAddress"
					try {
						room.setRoomRoadAddress( item.getString("UTF-8") );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if ( "detailAddress".equals(key) ) { //전달파라미터 name이 "detailAddress"
					try {
						room.setRoomDetailedAddress( item.getString("UTF-8") );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if ( "roomName".equals(key) ) { //전달파라미터 name이 "roomName"
					try {
						room.setRoomName( item.getString("UTF-8") );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if ( "roomType".equals(key) ) { //전달파라미터 name이 "roomType"
					try {
						room.setRoomType( item.getString("UTF-8") );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if ( "roomGuests".equals(key) ) { //전달파라미터 name이 "roomGuests"
					try {
						room.setRoomGuests( Integer.parseInt(item.getString("UTF-8")) );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if ( "roomBedroom".equals(key) ) { //전달파라미터 name이 "roomBedroom"
					try {
						room.setRoomBedroom( Integer.parseInt(item.getString("UTF-8")) );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if ( "roomBed".equals(key) ) { //전달파라미터 name이 "roomBed"
					try {
						room.setRoomBed( Integer.parseInt(item.getString("UTF-8")) );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if ( "roomBathroom".equals(key) ) { //전달파라미터 name이 "roomBathroom"
					try {
						room.setRoomBathroom( Integer.parseInt(item.getString("UTF-8")) );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if ( "price".equals(key) ) { //전달파라미터 name이 "price"
					try {
						room.setRoomPrice( Integer.parseInt(item.getString("UTF-8")) );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if ( "roomDesc".equals(key) ) { //전달파라미터 name이 "roomDesc"
					try {
						room.setRoomDesc( item.getString("UTF-8") );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if ( "facility".equals(key) ) { //전달파라미터 name이 "facility"
					try {
						facList.add( item.getString("UTF-8") );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}   // key값 비교 if end
				
			} // if( item.isFormField() ) end - 폼필드 확인
			
			
			
			// 3) 파일 처리
			if( !item.isFormField() ) {
				
				// --- UUID 생성 ---
				UUID uuid = UUID.randomUUID(); //랜덤 UID 생성
				String u = uuid.toString().split("-")[0]; //8자리 uid
				// -----------------
				
				// --- 로컬 저장소의 파일 객체 생성 ---
				File upFolder = new File(req.getServletContext().getRealPath("upload")); // 업로드될 폴더 경로
				upFolder.mkdir();
				
				//확장자 얻어오기
				String originFilename = item.getName();
				
				int dotIdx = originFilename.lastIndexOf("."); //가장 마지막 "."의 인덱스 찾기
			
				//확장자
				String ext = originFilename.substring(dotIdx+1);
				
				//확장자 뗀 파일명
				String filename = originFilename.substring(0, dotIdx);
				System.out.println("[test]ext : " + ext);
				System.out.println("[test]originFilename : " + originFilename);
				System.out.println("[test]filename : " + filename);
				System.out.println("[test]저장된 파일명 : "+filename+"_"+u+"."+ext);
				File up = new File(
						upFolder
						, filename+"_"+u+"."+ext // 원본파일명_uid.확장자
						);
				// ------------------------------------
				
				// --- 첨부파일 정보 객체 ---
				roomImg = new RoomImg(); //객체 생성
				roomImg.setRoomNo(roomNo); //원본파일명
				roomImg.setRoomImgFilename(filename+"_"+u+"."+ext); //저장파일명
				roomImgList.add(roomImg);
				// --------------------------
				
				// --- 처리 완료된 파일 업로드 하기 ---
				try {
					item.write(up); //실제 업로드
					item.delete(); //임시 파일 삭제
				} catch (Exception e) {
					e.printStackTrace();
				}
				// -----------------------------------
				
			} // 파일 처리 end
			
		} // while( iter.hasNext() ) end - FileItem 반복 처리
		
		
		//room 정보 수정하기				
		int roomRes = myRoomDao.updateRoom(conn, room); //  1
		
		//-----room 편의시설 정보 삭제 / 삽입-----
		//삭제
		int roomFacDel = myRoomDao.deleteRoomFac(conn, room); // 0이상
		
		//삽입
		//편의시설 정보리스트를 DTO객체리스트로 만들기
		for(String s : facList) {
			RoomFacilityMapping roomFacMap = new RoomFacilityMapping();
			if("kitchen".equals(s)) {
				roomFacMap.setRoomNo(roomNo);
				roomFacMap.setFacilityNo(1);
			} else if("parking".equals(s)) {
				roomFacMap.setRoomNo(roomNo);
				roomFacMap.setFacilityNo(2);
			} else if("wifi".equals(s)) {
				roomFacMap.setRoomNo(roomNo);
				roomFacMap.setFacilityNo(3);
			} else if("airConditioner".equals(s)) {
				roomFacMap.setRoomNo(roomNo);
				roomFacMap.setFacilityNo(4);
			} else if("pool".equals(s)) {
				roomFacMap.setRoomNo(roomNo);
				roomFacMap.setFacilityNo(5);
			} else if("hairDryer".equals(s)) {
				roomFacMap.setRoomNo(roomNo);
				roomFacMap.setFacilityNo(6);
			} else if("amenity".equals(s)) {
				roomFacMap.setRoomNo(roomNo);
				roomFacMap.setFacilityNo(7);
			} else if("pet".equals(s)) {
				roomFacMap.setRoomNo(roomNo);
				roomFacMap.setFacilityNo(8);
			}
			roomFacMapList.add(roomFacMap);
		}
		
		//삽입결과 오류 있으면 false
		boolean roomFacInsFlag = true;
		//편의시설정보 삽입하기
		for(RoomFacilityMapping data : roomFacMapList) {
			int roomFacRes = hostDao.insertRoomFac(conn, data);
			if(roomFacRes != 1) {
				roomFacInsFlag = false;
			}
		}
		//--------------------------------
		//숙소 이미지가 없으면 기존 파일 유지하고, 이미지가 있으면 기존 파일정보 삭제하고 새로운 정보 삽입
		boolean roomImgInsFlag = true;
		boolean roomImgDelFlag = true;
		
		//기존 파일명을 저장할 리스트
		List<RoomImg> originList = new ArrayList<RoomImg>();
		
		if(roomImgList.size() != 0) {
			//기존 파일명 불러오기
			originList = myRoomDao.selectRoomImg(conn, room);

			//숙소 이미지 파일 정보 삭제하기
			int roomImgDel = myRoomDao.deleteRoomImg(conn, room);
			if(roomImgDel < 0) {
				roomImgDelFlag = false;
			}
			
			//숙소 이미지 파일 정보 삽입하기
			for(RoomImg data : roomImgList) {
				int roomImgRes = hostDao.insertRoomImg(conn, data);
				if(roomImgRes != 1) {
					roomImgInsFlag = false;
				}
			}
		}
		
		//트랜잭션 처리
		if(roomRes == 1 && roomFacDel >= 0 && roomFacInsFlag && roomImgInsFlag && roomImgDelFlag) {
			JDBCTemplate.commit(conn);
			//서버에 저장된 기존 파일 삭제
			if(roomImgList.size() != 0) {
				for(RoomImg r : originList) {
					if(r != null) {
						File file = new File(req.getServletContext().getRealPath("upload")+"\\"+r.getRoomImgFilename()); 
						if( file.exists() ){ 
							if(file.delete()){ 
								System.out.println("MyRoomService update() - 첨부파일삭제 성공"); 
							} else {
								System.out.println("MyRoomService update() - 첨부파일삭제 실패"); 
							} 
						} else {
							System.out.println("MyRoomService update() - 파일이 존재하지 않습니다."); 
						} 
					}
				}
			}
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		
		return roomNo;
	}

	   public List<Room> searchRoom(HttpServletRequest req, int guests, String location){
		      
		      System.out.println("service:" + location + " " + guests);
		      List<Room> myRoomList = new ArrayList<>();
		      myRoomList = myRoomDao.searchRoom(conn, location, guests);
		      
		      return myRoomList;      
		 }
	   
	   public List<Room> searchRoom(HttpServletRequest req, int guests, String location, Paging paging){
		      List<Room> myRoomList = new ArrayList<>();
		      myRoomList = myRoomDao.searchRoom(conn, location, guests, paging);
		      
		      return myRoomList;      
		 }
	
	   @Override
		public Paging getPaging(HttpServletRequest req, String location, int guests) {
			//전달파라미터 curPage 파싱

		    HttpSession session = req.getSession();
			String param = req.getParameter("curpage");
			int curPage = 0;
			if(param != null && !"".equals(param)) {
				curPage = Integer.parseInt(param);
			}
			
			//Board 테이블의 총 게시글 수를 조회한다
			int totalCount = myRoomDao.selectCntRow(JDBCTemplate.getConnection(), location, guests);

			//Paging객체 생성
			Paging paging = new Paging(totalCount, curPage);
			
			return paging;
		}
	
}
