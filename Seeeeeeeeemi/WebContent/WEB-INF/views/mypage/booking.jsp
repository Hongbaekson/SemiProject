<%@page import="dto.RoomImg"%>
<%@page import="dto.Booking"%>
<%@page import="dto.Room"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="dto.User"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%	List<Map<String, Object>> bList = (List<Map<String, Object>>) request.getAttribute("bookingList"); %>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
    
<%	User u = (User) request.getAttribute("user"); %>
<!-- <!-- jq -->
<!-- <script type="text/javascript" src="/resources/js/jquery-2.2.4.min.js"></script>     -->
<!-- <!-- 부트스트랩 -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->

<link href="/resources/css/mypage.css" rel="stylesheet">


<script type="text/javascript">
$(document).ready(function() {
	$(".booking-content button").click(function() {
		$(".modal-body").html("")

		var roomno = $(this).attr("data-roomno");
		
		$.ajax({
			type: "get"
			, url: "/mypage/bookingdetail"
			, data: {
				roomno: roomno
			}
			, dataType: "html"
			, success: function( res ) {
				console.log("bookingdetail ajax 성공")
				
				$(".modal-body").html( res )
				
			}
			, error: function() {
				console.log("bookingdetail ajax 실패")
			}
		})
		
	})
})
</script>


<div id="mypage-nav">
	<ul>
		<li><a href="/mypage/user">계정설정</a></li>
		<li><a href="/mypage/booking">예약</a></li>
		<li><a href="/mypage/review">이용후기</a></li>
		<li><a href="/mypage/bookmark">숙소 북마크</a></li>
	</ul>
</div>

<div id="booking" class="inner">

	<h1>예약</h1>
	<p>예약 정보 확인<p>

	<div class="row text-center">
		<div class="text-center booking-header">
			<span class="col-xs-3">사진</span>
			<span class="col-xs-5">예약 정보</span>
			<span class="col-xs-2 rr">예약상태</span>
			<span class="col-xs-1">예약취소</span>
		</div>
		<hr>
		<%	for (int i = 0; i < bList.size(); i++) { %>
		<div class="row text-center booking-content">
			<div class="col-xs-3 img-box">
				<div class="img-box-inner">
					<button type="button" data-toggle="modal" data-target="#myModal" data-roomno="<%=((Room) bList.get(i).get("room")).getRoomNo() %>">
						<img src="/getImg?filename=<%=((RoomImg) bList.get(i).get("roomimg")).getRoomImgFilename()%>" class="img-rounded img-thumbnail">
					</button>
				</div>
			</div>
			<div class="col-xs-5 booking-info">
				<div class="roomname">
					<label for="roomname">숙소이름</label><br>
					<p id="roomname"><%=((Room) bList.get(i).get("room")).getRoomName()%></p>
				</div>
				<div class="guest">
					<label for="guest">게스트</label><br>
					<p id="guest"><%=((Booking) bList.get(i).get("booking")).getBookingGuest()%>명</p>
				</div>
				<label for="checkinout">예약날짜</label><br>
				<p id="checkinout"><%=((Booking) bList.get(i).get("booking")).getBookingCheckin() + " ~ "
						+ ((Booking) bList.get(i).get("booking")).getBookingCheckout()%></p>
			</div><!-- .booking-info -->
			<div class="col-xs-2">
				<%	String status = ((Booking) bList.get(i).get("booking")).getBookingStatus();	%>
				<%	if ( (status).equals("Y") == true ) { %>
					예약완료
				<%	} else if ((status).equals("W") == true) { %>
					예약대기
				<%	} else { %>
					예약취소
				<%	} %>
<%-- 				<%=status%>&emsp; --%>
			</div>
			<div class="col-xs-1 booking-cancel">
				<%	if (status.equals("Y") || status.equals("W")) {	%>
				<button class="btn btn-primary btn-sm" onclick='location.href="/mypage/booking/cancel?booking_no=<%=((Booking) bList.get(i).get("booking")).getBookingNo()%>"'>예약취소</button>
				<%	} else {	%>
				<button class="btn btn-default btn-sm" disabled>예약취소</button>
				<%	} %>
			</div>
		</div><!-- .booking-content -->
		<%	} %>
		
		<div class="modal fade" id="myModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title">예약 상세 정보</h4>
		      </div>
		      <div class="modal-body">
		      
		      </div>
		      <div class="modal-footer">
<!-- 		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
		        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
	</div>

</div><!-- #booking -->




<%@ include file="/WEB-INF/views/layout/myPageBookingPaging.jsp" %>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>