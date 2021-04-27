package controller;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/resimg")
public class Resimg extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("[test] GetImg [get] 호출");
		System.out.println("[test]filename :" +req.getParameter("filename"));
		
		//저장된 파일이름
				String filename = req.getParameter("filename");
				
				//확장자 얻어오기 //여기도 있고 
				int dotIdx = filename.lastIndexOf("."); //가장 마지막 "."의 인덱스 찾기
			
				//확장자
				String ext = filename.substring(dotIdx+1);
				System.out.println("[test]ext : " + ext);
				System.out.println("[test]filename : " + filename);
				
				resp.setContentType("image/" + ext);

				byte[] by = new byte[1024]; //한번에 읽어올 파일크기 1024 바이트

				//출력을위한 OutputStream 객체
				ServletOutputStream out = resp.getOutputStream();
				BufferedInputStream in = null;
				try {
					//이미지 주소 저장
					String imagePath = getServletContext().getRealPath("image") + "/"+ filename;
					
					System.out.println("[test] imagePath : " + imagePath);

					//inputStream : 파일을 1바이트씩 읽어옴

					//BufferedInputStream : inputStream객체로 버퍼객체를 생성

					in = new BufferedInputStream(new FileInputStream(imagePath));
					
					

					//버퍼(in)에 있는 데이터를 1024바이트(by) 만큼 읽어오고 데이터가 없을경우 반복문 종료
					int len = 0;
					while((len = in.read(by)) > 0) {
						out.write(by, 0, len); //1024바이트씩 출력
					}
					out.flush();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					in.close(); 
					out.close();
				}

			}
	}

