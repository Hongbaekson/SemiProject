package service.impl;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import common.JDBCTemplate;
import dao.face.HostDao;
import dao.impl.HostDaoImpl;
import dto.Room;
import dto.RoomFacilityMapping;
import dto.RoomImg;
import service.face.HostService;

public class HostServiceImpl implements HostService {
	
	HostDao hostDao = new HostDaoImpl();
	Connection conn = JDBCTemplate.getConnection();
	
	@Override
	public int registerForm(HttpServletRequest req) {
		System.out.println("[test] HostServiceImpl - registerForm() 호출");
		int roomNo = hostDao.selectNextRoomNo(conn);
		
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
		
		//숙소 정보 저장할 객체 생성
		room = new Room();
		
		//숙소번호 저장
		room.setRoomNo(roomNo);
		//숙소 정보 객체에 유저번호 저장(세션을 이용)
		room.setUserNo((Integer)req.getSession().getAttribute("userno"));
		//숙소 관리자승인정보 저장 (처음 등록 -> W (대기상태) )
		room.setRoomAdminCheck("W");
		
		//편의시설 정보를 문자열로 임시저장할 리스트
		List<String> facList = new ArrayList<>();
		
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
		
		//room 정보 삽입하기				
		int roomRes = hostDao.insertRoom(conn, room);
		
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
		boolean roomFacFlag = true;
		//편의시설정보 삽입하기
		for(RoomFacilityMapping data : roomFacMapList) {
			int roomFacRes = hostDao.insertRoomFac(conn, data);
			if(roomFacRes != 1) {
				roomFacFlag = false;
			}
		}
		
		boolean roomImgFlag = true;
		//숙소 이미지 파일 정보 삽입하기
		for(RoomImg data : roomImgList) {
			int roomImgRes = hostDao.insertRoomImg(conn, data);
			if(roomImgRes != 1) {
				roomImgFlag = false;
			}
		}
		System.out.println("[test] req.getServletContext().getRealPath(\"upload\") : " + req.getServletContext().getRealPath("upload"));
		System.out.println("[test] roomRes : "+roomRes);
		System.out.println("[test] roomFacFlag : "+roomFacFlag);
		System.out.println("[test] roomImgFlag : "+roomImgFlag);
		if(roomRes == 1 && roomFacFlag && roomImgFlag) {
			//데이터 삽입 성공
			JDBCTemplate.commit(conn);
		} else {
			//데이터베이스 오류
			JDBCTemplate.rollback(conn);
		}
		
		System.out.println("[TEST] HostServiceImpl - registerForm() 마지막부분");
		return roomNo;
	}
}
