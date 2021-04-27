<%@ page import="dto.Room" %>
<%@ page import="dto.RoomImg" %>
<%@ page import="java.util.List" %>
<%@page import="web.util.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
List<Room> roomList= (List)request.getAttribute("roomList");
%>
<%
List<RoomImg> roomImgList= (List)request.getAttribute("roomImgList");
%>
<%
List<String> starList= (List)request.getAttribute("starList");
%>
<%
Paging paging = (Paging)request.getAttribute("paging");
%>
<% HttpSession session1 = request.getSession(); %>

<%@include file="/WEB-INF/views/layout/header.jsp" %>
    <link
     rel="stylesheet"
      href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"
    />
    <script
      src="https://kit.fontawesome.com/3f7a375eec.js"
      crossorigin="anonymous"
    ></script>
    <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <!-- datepicker 한국어로 -->
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
   <script>
      $(function () {
        //오늘 날짜를 출력
        $("#today").text(new Date().toLocaleDateString());

        //datepicker 한국어로 사용하기 위한 언어설정
        $.datepicker.setDefaults($.datepicker.regional["ko"]);

        // 시작일(checkIn)은 종료일(checkOut) 이후 날짜 선택 불가
        // 종료일(checkOut)은 시작일(checkIn) 이전 날짜 선택 불가

        //시작일.
        $("#checkIn").datepicker({
          showOn: "focus", // 달력을 표시할 타이밍 (both: focus or button)
          dateFormat: "yy-mm-dd", // 날짜의 형식
          changeMonth: true, // 월을 이동하기 위한 선택상자 표시여부
          //minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
          onClose: function (selectedDate) {
            // 시작일(checkIn) datepicker가 닫힐때
            // 종료일(checkOut)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
            $("#checkOut").datepicker("option", "minDate", selectedDate);
          },
        });

        //종료일
        $("#checkOut").datepicker({
          showOn: "focus",
          dateFormat: "yy-mm-dd",
          changeMonth: true,
          //minDate: 0, // 오늘 이전 날짜 선택 불가
          onClose: function (selectedDate) {
            // 종료일(checkOut) datepicker가 닫힐때
            // 시작일(checkIn)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정
            $("#checkIn").datepicker("option", "maxDate", selectedDate);
          },
        });
      });
    </script>


<div class="container">
     <div class="searchArea">
	<div class="inner">
		<div>
			<p>호스트 분들이 있기에 가능합니다</p>
			<p>마음에 드는 숙소나 맛집을 찾아볼까요?</p>
			<form action="/room/search" method="get">
				<div>
					<input type="text" placeholder="위치" name="location">
				</div>
				<div>
					<div class="col">
						<input type="text" placeholder="체크인" name="chkin" id="checkIn">
					</div>
					<div class="col">
						<input type="text" placeholder="체크아웃" name="chkout" id="checkOut">
					</div>
				</div>
				<div>
					<div class="col">
						<input type="number" placeholder="성인" name="adult">
					</div>
					<div class="col">
						<input type="number" placeholder="어린이" name="children">
					</div>
					<div class="col">
						<button type="submit">검색</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
   



<hr>
   
   
   <h1>검색된 숙소</h1>
   <div></div>
   <hr>
   <hr>
        
        <div class="row">
           <% for(int i=0; i<roomList.size(); i++){ %>
          <div class="col-sm-6 col-md-4 col-lg-3 mt-4"  style='height: 441.61px'>
                <div class="card">
               <img  class="card-img-top" src="/getImg?filename=<%=roomImgList.get(i).getRoomImgFilename()%>">
                    <div class="card-block">
                        <figure class="profile">
                     <img class="profile-avatar" src="/getImg?filename=<%=roomImgList.get(i).getRoomImgFilename()%>">
                     <img  class="profile-avatar" src="/getImg?filename=<%=roomImgList.get(i).getRoomImgFilename()%>">
                        
                        </figure>
                        <h4 class="card-title mt-3" style='height: 20px; overflow: hidden'><%=roomList.get(i).getRoomName() %> </h4>
                        <div class="meta" style='height: 20px; overflow: hidden'>
                            <a>게스트 <%=roomList.get(i).getRoomGuests()%>명 * 침대 <%=roomList.get(i).getRoomBed()%>개 * 욕실 <%=roomList.get(i).getRoomBathroom() %>개 </a>
                            
                        </div>
                         <div class="meta" style='height: 20px; overflow: hidden'>
                            <a><%=roomList.get(i).getRoomRoadAddress() %>  <%=roomList.get(i).getRoomDetailedAddress()%>  </a>
                            
                        </div>
                        <div class="card-text" style='height: 20px; overflow: hidden'>
                                <%=roomList.get(i).getRoomDesc() %>
                        </div>
                    </div>
                    
                    <div class="card-footer">
                        <small> <%=starList.get(i)%> </small>
                        							<div class="price"><%=roomList.get(i).getRoomPrice() %><small>원</small></div>
                        
                        <div class="buttons" style='display:flex'>
                           <form action="/room/detail" method="get">
                              <input type="hidden" name="room_no" value=<%=roomList.get(i).getRoomNo()%> />
                              <button type="submit" class="btn btn-secondary float-right btn-sm" style='margin-right:10px'>상세보기</a>
                           </form>
                           <form action="/room/booking" method="get">
                              <input type="hidden" name="room_no_booking" value=<%=roomList.get(i).getRoomNo()%> />                           
                              <button type="submit" class="btn btn-secondary float-right btn-sm">예약하기</a>
                           </form>
                        </div>
                           
                    </div>
                </div> 
            </div>
            <% } %>
          
     </div>
     
     <div class="text-center">
			<ul class="pagination">
				<% if(paging.getCurPage()>1){ %>
				<li><a href="/room/search?location=<%=session.getAttribute("location") %>&chkin=&chkout=&adult=&children=<%=session.getAttribute("guests") %>&curpage=<%=paging.getCurPage()-1 %>">&lt; </a></li>
				<% } %>
				
				<% for(int i=paging.getStartPage(); i<=paging.getEndPage(); i++ ){ %>
					<% if(i==paging.getCurPage()){ %>
					<li class="active"><a href="/room/search?location=<%=session.getAttribute("location") %>&chkin=&chkout=&adult=&children=<%=session.getAttribute("guests") %>&curpage=<%=i%>"><%=i%></a></li>
					<%}else{ %>
					<li><a href="/room/search?location=<%=session.getAttribute("location") %>&chkin=&chkout=&adult=&children=<%=session.getAttribute("guests") %>&curpage=<%=i%>"><%=i%></a></li>
					<%} %>
				<%} %>
				
				<% if(paging.getTotalPage() !=paging.getCurPage()){ %>
				<li><a href="/room/search?location=<%=session.getAttribute("location") %>&chkin=&chkout=&adult=&children=<%=session.getAttribute("guests") %>&curpage=<%=paging.getCurPage()+1%>">&gt;</a>
				<% } %>
			</ul>
		</div>
 </div>
 </div>
 
 
 
 
 <hr>
 
 
 
 <%@include file="/WEB-INF/views/layout/footer.jsp" %>
    