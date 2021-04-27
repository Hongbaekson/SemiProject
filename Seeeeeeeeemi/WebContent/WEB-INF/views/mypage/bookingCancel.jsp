<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	int bookingno = (int) request.getAttribute("bookingno"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
function cancel() {
	if ( confirm('예약을 취소하시겠습니까?') ) {
		if ( confirm( '정말로 취소하시겠습니까?') ){
			alert("취소 완료")
		} else {
			alert('돌아가기')
			window.location = '/mypage/booking/cancel';
		}
	} else {
		alert('돌아가기')
		window.location = '/mypage/booking/cancel';
	}
}
</script>


</head>
<body>
	<h1>예약 취소 페이지</h1>
	<form action="/mypage/booking/cancel?booking_no=<%=bookingno %>" method="post">
		<input type="submit" value="예약취소" onclick="cancel()">
	</form>
<!-- 	<button onclick='cancel()'>예약 취소</button> -->
	<button onclick='"/mypage/booking"'>돌아가기</button>
</body>
</html>