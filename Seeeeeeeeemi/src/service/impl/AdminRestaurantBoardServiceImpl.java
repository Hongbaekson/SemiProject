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
import dao.face.AdminRestaurantBoardDao;
import dao.impl.AdminRestaurantBoardDaoImpl;
import dto.Restaurant;
import dto.Restaurantimg;
import service.face.AdminRestaurantBoardService;

public class AdminRestaurantBoardServiceImpl implements AdminRestaurantBoardService{

	AdminRestaurantBoardDao adminRestaurantBoardDao = new AdminRestaurantBoardDaoImpl();
	
	
	@Override
	public Restaurant getParamNo(HttpServletRequest req) {
		Restaurant restaurant = new Restaurant();
		restaurant.setResNo( Integer.parseInt( req.getParameter("resno")));
		return restaurant;
	}

	@Override
	public Boolean delete(Restaurant restaurant) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int res = adminRestaurantBoardDao.delete(conn, restaurant);
		
		System.out.println("삭제 호출2"); 
		if(res>0) {
			JDBCTemplate.commit(conn);
			return true;
		}else {
			JDBCTemplate.rollback(conn);
			return false;
		}
		
		
		
	}

	@Override
	public int writeRestaurant(Restaurant restaurant) {
		Connection conn=JDBCTemplate.getConnection();
		int resno = adminRestaurantBoardDao.writeRestaurant(conn, restaurant);
		
		if(resno>0) {
			System.out.println("맛집등록성공");
			JDBCTemplate.commit(conn);
		}else {
			System.out.println("맛집등록실패");
			JDBCTemplate.rollback(conn);
		}
		return resno;
		
		
	}

	@Override
	public int insertRestaurant(HttpServletRequest req) {
		System.out.println("인서트 레스토랑 호출");
		Connection conn = JDBCTemplate.getConnection(); 

		int restaurantNo = adminRestaurantBoardDao.selectNextResNo(conn); 


		//게시글 정보 저장 객체 
		Restaurant restaurant = null;

		//레스토랑 이미지 파일 저장 리스트
		List<Restaurantimg> resimgList = new ArrayList<>();

		//첨부파일 정보 저장 객체
		Restaurantimg restaurantimg = null;

		//파일업로드 형태의 데이터가 맞는지 검사
		boolean isMultipart = false;
		isMultipart = ServletFileUpload.isMultipartContent(req);

		//multipart/form-data
		if( !isMultipart ) {
			System.out.println("형식이 알 맞지 않음");

			return -1; //fileupload() 메소드 실행 중지
		}

		restaurant = new Restaurant(); //레스토랑 정보 저장 객체 생성


		//레스토랑 번호 저장
		restaurant.setResNo(restaurantNo);

		//디스트기반 아이템 팩토리
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
				System.out.println(key);
				if( "resname".equals(key) ) { //전달파라미터 name이 res_name
					try {
						restaurant.setResName(item.getString("UTF-8"));
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}

				} else if ( "resphone".equals(key) ) { //전달파라미터 name이 res_phone 
					try {
						restaurant.setResPhone(item.getString("UTF-8") );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if ( "resparking".equals(key) ) { //전달파라미터 name이 res_parking
					try {
						restaurant.setResParking( item.getString("UTF-8") );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}

				} else if ( "restime".equals(key) ) { //전달파라미터 name이 res_time
					try {
						restaurant.setResTime( item.getString("UTF-8") );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}	
				}else if ( "resroad".equals(key) ) { //전달파라미터 name이 res_time
					try {
						restaurant.setResRoad( item.getString("UTF-8") );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}else if ( "filterno".equals(key) ) { //전달파라미터 name이 filterno
					try {
						restaurant.setFilterNo( Integer.parseInt(item.getString("UTF-8")) );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}else if ( "regionno".equals(key) ) { //전달파라미터 name이 regionno
					try {
						restaurant.setRegionNo( Integer.parseInt(item.getString("UTF-8")) );
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}	



				}

			}



			//3) 파일 처리

			if( !item.isFormField() ) {

				// --- UUID 생성 ---
				UUID uuid = UUID.randomUUID(); //랜덤 UID 생성
				String u = uuid.toString().split("-")[0]; //8자리 uid 
				// -----------------

				// --- 로컬 저장소의 파일 객체 생성 ---
				File upFolder = new File(req.getServletContext().getRealPath("image")); // 업로드될 폴더 경로
				upFolder.mkdir();

				//확장자 얻어오기
				String originFilename = item.getName();

				int dotIdx = originFilename.lastIndexOf("."); //가장 마지막 "."의 인덱스 찾기

				//확장자 //여기두 잇어영..! 
				String ext = originFilename.substring(dotIdx+1);

				//확장자 뗀 파일명
				String filename = originFilename.substring(0, dotIdx);
				System.out.println("[test]ext : " + ext);
				System.out.println("[test]originFilename : " + originFilename);
				System.out.println("[test]filename : " + filename);
				System.out.println("[test]저장된 파일명 : "+filename+"_"+u+"."+ext);
				filename = filename+"_"+u+"."+ext;
				File up = new File(
						upFolder
						, filename // 원본파일명_uid.확장자
						);
				// ------------------------------------

				// --- 첨부파일 정보 객체 ---
				restaurantimg = new Restaurantimg();
				restaurantimg.setRestaurantNo(restaurantNo); 
				restaurantimg.setResFilename(filename); 
				
				resimgList.add(restaurantimg);
				//처리 완료 파일 업로드
				try {
					item.write(up); //실제 업로드
					item.delete(); //임시 파일 삭제
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

		}  //while	
		
		//레스토랑 정보 삽입
		int restaurantdetail = adminRestaurantBoardDao.writeRestaurant(conn, restaurant);

		boolean restaurantimgdetailFlag = true;
		//레스토랑 이미지 파일 정보 삽입
		for(Restaurantimg data: resimgList) {
			int restaurantimgdetail = adminRestaurantBoardDao.insertimg(conn, data);
			if (restaurantimgdetail != 1) {
				restaurantimgdetailFlag = false;
			}	
		}	

		System.out.println("레스토랑 정보" + restaurantdetail);
		System.out.println("이미지 정보" + restaurantimgdetailFlag);

		if(restaurantdetail == 1 && restaurantimgdetailFlag) {
			JDBCTemplate.commit(conn);

		} else {
			//데이터베이스 오류
			JDBCTemplate.rollback(conn);
		}

		return restaurantNo; 
	}	
}
