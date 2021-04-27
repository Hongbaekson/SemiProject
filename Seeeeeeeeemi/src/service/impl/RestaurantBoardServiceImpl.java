package service.impl;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import common.JDBCTemplate;

import dto.Restaurant;
import dto.Restaurantimg;
import dao.face.RestaurantBoardDao;
import dao.impl.RestaurantBoardDaoImpl;
import service.face.RestaurantBoardService;
import web.util.Paging;


public class RestaurantBoardServiceImpl implements RestaurantBoardService {
	
	//BoardDao 객체 생성
	private RestaurantBoardDao restaurantBoardDao = new RestaurantBoardDaoImpl();
		
		
	
	@Override
	public List<Restaurant> getList() {
		return restaurantBoardDao.selectAll(JDBCTemplate.getConnection());
		
	}

	@Override
	public Paging getPaging(HttpServletRequest req) {
		//전달파라미터 curPage 파싱
		String param = req.getParameter("curPage");
		int curPage = 0;
		if(param != null && !"".equals(param)) {
		curPage = Integer.parseInt(param);
		}
				
		//레스토랑 테이블의 총 게시글 수를 조회한다
		int totalCount = restaurantBoardDao.selectCntAll(JDBCTemplate.getConnection());

		//Paging객체 생성
		Paging paging = new Paging(totalCount, curPage);
				
		return paging;
			}

	@Override
	public List<Restaurant> getList(Paging paging) {
		//게시글 전체 조회 결과 처리
		return restaurantBoardDao.selectAll(JDBCTemplate.getConnection(), paging);
			}

	@Override
	public Restaurant getRestaurantno(HttpServletRequest req) {
		
		
	//	Restaurant restaurant = new Restaurant();
	//	restaurant.setResNo(req.getParameter("resno"));
	//	restaurant.setFilterNo(req.getParameter("filterno"));
	//	restaurant.setResName(req.getParameter("resname"));
	//	restaurant.setResPhone(req.getParameter("resphone"));
	//	restaurant.setResTime(req.getParameter("restime"));
	//	restaurant.setResParking(req.getParameter("resparking"));
	//	restaurant.setResRoad(req.getParameter("resroad"));
	//	
	//	return restaurant;
			
			//Restaurantno를 저장할 객체 생성
		Restaurant restaurantno = new Restaurant();
			
			//Restaurantno 전달파라미터 검증 - null, ""
			String param = req.getParameter("resno");
			if(param!=null && !"".equals(param)) {
				
				//Restaurantno 전달파라미터 추출
				restaurantno.setResNo( Integer.parseInt(param) );
			}
			System.out.println("레스토랑 넘버"); 
			System.out.println(restaurantno);
			
			//결과 객체 반환
			return restaurantno;
		}

	@Override
	public Restaurant view(Restaurant Restaurantno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		
		//게시글 조회
		Restaurant restaurant = restaurantBoardDao.selectBoardByRestaurantno(conn, Restaurantno); 
				
				return restaurant;
	}

	@Override
	public Restaurant getsearchBoardBySearchno(HttpServletRequest req) {
		//searchBoardBySearchno를 저장할 객체 생성
		Restaurant searchBoardBySearchno = new Restaurant();
			
			//Restaurantno 전달파라미터 검증 - null, ""
			String param = req.getParameter("filterno");
			if(param!=null && !"".equals(param)) {
				
				//Restaurantno 전달파라미터 추출 -String int change
				searchBoardBySearchno.setFilterNo( Integer.parseInt(param) );
				searchBoardBySearchno.setRegionNo( Integer.parseInt(param) );
			}
			System.out.println("레스토랑 서치넘버"); 
			System.out.println(searchBoardBySearchno);
			
			//결과 객체 반환
			return searchBoardBySearchno;
	}

	@Override
	public void delete(Restaurant restaurant) {
		Connection conn = JDBCTemplate.getConnection(); //아 이거요! 맞나요..?
		
		if( restaurantBoardDao.deleteRestaurantImg (conn, restaurant) > 0 ) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		if( restaurantBoardDao.delete(conn, restaurant) > 0 ) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
	}

	@Override
	public void write(HttpServletRequest req) {
		
		Connection conn = JDBCTemplate.getConnection(); 
		
		int restaurantNo = restaurantBoardDao.selectRestaurantno(conn); 
		
		
		//게시글 정보 저장 객체 
		Restaurant restaurant = null;
		
		//첨부파일 정보 저장 객체
		Restaurantimg restaurantimg = null;
		
		//파일업로드 형태의 데이터가 맞는지 검사
		boolean isMultipart = false;
		isMultipart = ServletFileUpload.isMultipartContent(req);
		
		//multipart/form-data 인코딩으로 전송되지 않았을 경우
		if( !isMultipart ) {
			System.out.println("[ERROR] multipart/form-data 형식 오류");
					
			return; //fileupload() 메소드 실행 중지
				}
		
		restaurant = new Restaurant();
		
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
						if( "res_name".equals(key) ) { //전달파라미터 name이 res_name
							try {
								restaurant.setResName(item.getString("UTF-8"));
							} catch (UnsupportedEncodingException e) {
								e.printStackTrace();
							}
							 
						} else if ( "res_phone".equals(key) ) { //전달파라미터 name이 res_phone 
							try {
								restaurant.setResPhone(item.getString("UTF-8") );
							} catch (UnsupportedEncodingException e) {
								e.printStackTrace();
							}
							} else if ( "res_parking".equals(key) ) { //전달파라미터 name이 res_parking
								try {
									restaurant.setResParking( item.getString("UTF-8") );
								} catch (UnsupportedEncodingException e) {
									e.printStackTrace();
								}
								
							} else if ( "res_time".equals(key) ) { //전달파라미터 name이 res_time
								try {
									restaurant.setResTime( item.getString("UTF-8") );
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
					
					File up = new File(
							upFolder
							, item.getName()+"_"+u // 원본파일명_uid
							);
					// ------------------------------------
					
					// --- 첨부파일 정보 객체 ---
					restaurantimg = new Restaurantimg();
					restaurantimg.setRestaurantNo(restaurantNo); 
					restaurantimg.setResFilename(item.getName()+"_"+u); 
					
					try {
						item.write(up); //실제 업로드
						item.delete(); //임시 파일 삭제
					} catch (Exception e) {
						e.printStackTrace();
					}
					
				}
				
				
				//게시글 번호 생성 - Dao 이용
				Restaurant restaurantno = restaurantBoardDao.selectBoardByRestaurantno(conn, restaurant);
				
				if(restaurant != null) {
					
					
					restaurant.setResNo(restaurantno.getResNo());
				
				//게시글 삽입
				if( restaurantBoardDao.insert(conn, restaurant) > 0 ) {
					JDBCTemplate.commit(conn);
				} else {
					JDBCTemplate.rollback(conn);
				}
			
			}
			//첨부파일 정보가 있을 경우
			if(restaurantimg != null) {
				//게시글 번호 입력
				restaurantimg.setResimgNo(restaurantimg.getResimgNo());
				

				//첨부파일 삽입
				if( restaurantBoardDao.insertimg(conn, restaurantimg) > 0 ) {
					JDBCTemplate.commit(conn);
				} else {
					JDBCTemplate.rollback(conn);
				
				}		
				
			} 	
		}	
	}
		
				
	
	@Override
	public Restaurantimg viewFile(Restaurant viewrestaurantimg) {
		return restaurantBoardDao.selectImg(JDBCTemplate.getConnection(), viewrestaurantimg);
	}

	@Override
	public Restaurant getres(HttpServletRequest req) {
		System.out.println("지역 번호 호출");
		System.out.println("---" +req.getParameter("regionno"));

		Restaurant restaurant = new Restaurant();
		
		restaurant.setFilterNo(Integer.parseInt(req.getParameter("filterno")));
		restaurant.setRegionNo(Integer.parseInt(req.getParameter("regionno")));
		
		restaurant.setResName(req.getParameter("resname"));
		restaurant.setResPhone(req.getParameter("resphone"));
		restaurant.setResTime(req.getParameter("restime"));
		restaurant.setResParking(req.getParameter("resparking"));
		restaurant.setResRoad(req.getParameter("resroad"));
		
		return restaurant;
	}

	@Override
	public int getresno(HttpServletRequest req) {
		System.out.println("이미지 번호 호출");
		return Integer.parseInt(req.getParameter("resno"));
	}


	//@Override
//	public Restaurant searchno(String[] cat, String[] h_area1) {
	//	Connection conn = JDBCTemplate.getConnection();
		
		
		//게시글 조회
	//	Restaurant restaurant = (Restaurant) restaurantBoardDao.searchBoardBySearchno(cat, h_area1);
				
				
//				return restaurant;
//	}




	
	}

