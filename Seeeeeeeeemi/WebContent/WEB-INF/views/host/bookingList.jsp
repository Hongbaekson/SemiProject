<%@page import="util.BookingPaging"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<% List<Map<String, Object>> list = (List)request.getAttribute("list"); %>
<% BookingPaging paging = (BookingPaging) request.getAttribute("paging"); %>

<script type="text/javascript">
$(document).ready(function(){
	//--- 예약상태 변경 modal ---
	const modal = document.querySelector(".modal");
	const overlay = modal.querySelector(".modal_overlay");
	const closeBtn =  modal.querySelector("#closeBtn");
	
	const closeModal = () => {
		modal.classList.add("hidden")
	}
	overlay.addEventListener("click", closeModal);
	closeBtn.addEventListener("click", closeModal);
	
	//--- 이메일전송 modal ---
	const modal2 = document.querySelector(".modal2");
	const overlay2 = modal2.querySelector(".modal2_overlay");
	const closeBtn2 =  modal2.querySelector("#closeBtn2");
	
	const closeModal2 = () => {
		modal2.classList.add("hidden")
	}
	overlay2.addEventListener("click", closeModal2);
	closeBtn2.addEventListener("click", closeModal2);
})
function statusUpdate(bookingno, name, phone, email, msg, chkin, chkout) {
	$("#bookingno").val(bookingno);
	$("#name").text(name);
	$("#phone").text(phone);
	$("#email").text(email);
	$("#message").text(msg);
	$("#checkin").text(chkin);
	$("#checkout").text(chkout);
	$(".modal").removeClass("hidden");
}
function mailSend(guestEmail) {
	$("#guestEmail").val(guestEmail);
	$(".modal2").removeClass("hidden");
}
function checkContent() {
	if( !$("input[name=hostName]").val() ) {
		alert('이름을 입력하세요.');
		console.log("이름")
		$("input[name=hostName]").focus();
		return false;
	} else if ( !$("input[name=hostEmail]").val() ) {
		alert('보내는사람 이메일을 입력하세요.');
		$("input[name=hostEmail]").focus();
		return false;
	} else if ( !$("input[name=guestEmail]").val() ) {
		alert('받는사람 이메일을 입력하세요.');
		$("input[name=guestEmail]").focus();
		return false;
	} else if ( !$("input[name=subject]").val() ) {
		alert('제목을 입력하세요.');
		$("input[name=subject]").focus();
		return false;
	} else if ( !$("textarea[name=content]").val() ) {
		alert('내용을 입력하세요.');
		$("textarea[name=content]").focus();
		return false;
	}   
}
</script>


<style>
.table > tr > td {
	 text-align: center;
}
.subnav {
	width: 700px;
	margin: 20px auto;
	text-align: center;
}
.subnavelement {
	font-size: 20px;
	margin: 20px;
}
.modal, .modal2 {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	z-index: 5;
}
.modal_overlay, .modal2_overlay {
	background-color: rgba(0,0,0, 0.6);
	width: 100%;
	height: 100%;
	position: absolute;
}
.modal_content, .modal2_content {
	background-color: white;
	padding: 50px 50px;
	text-align: center;
	position: relative;
	border-radius: 10px;
	box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
}
.hidden {
	display: none;
}
</style>

<div class="container" style="min-height: 1000px">
<div class="subnav">
	<a href="/host/roomlist"><span class="subnavelement">내가 등록한 숙소</span></a>
	<span class="subnavelement" style="font-weight: bolder;">예약 관리</span>
</div>
<h3>예약 관리</h3>
<hr>

<table class="table table-striped table-hover table-condensed" style="margin-top: 20px;">
		<tr>
			<th class="text-center" style="width: 5%;">예약번호</th>
			<th class="text-center" style="width: 25%;">숙소명</th>
			<th class="text-center" style="width: 10%;">예약자이름</th>
			<th class="text-center" style="width: 15%;">체크인</th>
			<th class="text-center" style="width: 15%;">체크아웃</th>
			<th class="text-center" style="width: 10%;">예약상태</th>
			<th class="text-center" style="width: 10%;">예약상태변경</th>
			<th class="text-center" style="width: 10%;">메일전송</th>
			
		</tr>
		<%for (int i=0; i<list.size(); i++) {%>
		<tr>
			<td class="text-center"><%= list.get(i).get("예약번호") %></td>
			<td class="text-center"><%= list.get(i).get("숙소명") %></td>
			<td class="text-center"><%= list.get(i).get("예약자이름") %></td>
			<td class="text-center"><%= list.get(i).get("체크인") %></td>
			<td class="text-center"><%= list.get(i).get("체크아웃") %></td>
			
				<% if(  "W".equals(list.get(i).get("예약상태"))  ) {%>
					<td class="text-center">대기중</td>
				<% } else if(  "Y".equals(list.get(i).get("예약상태"))  ) { %>
					<td class="text-center" style="color: green;">예약완료</td>
				<% } else if(  "N".equals(list.get(i).get("예약상태"))  ) { %>
					<td class="text-center" style="color: red;">예약거절</td>
				<% } %>
			<td class="text-center">
				<a onclick="statusUpdate(
				'<%= list.get(i).get("예약번호") %>'
				, '<%= list.get(i).get("예약자이름") %>'
				, '<%= list.get(i).get("예약자연락처") %>'
				, '<%= list.get(i).get("예약자이메일") %>'
				, '<%= list.get(i).get("예약자메시지") %>'
				, '<%= list.get(i).get("체크인") %>'
				, '<%= list.get(i).get("체크아웃") %>');">승인/거절</a>
			</td>
			<td class="text-center"><a onclick="mailSend('<%= list.get(i).get("예약자이메일") %>')">메일전송</a></td>
		</tr>
		<% } %>
	</table>
	<%@ include file="/WEB-INF/views/layout/bookingPaging.jsp" %>
</div><!-- .container -->

<!-- 예약상태변경 modal -->
<div class="modal hidden">
	<div class="modal_overlay"></div>
	<div class="modal_content">
		<h2>예약자 정보</h2>
		<form action="/bstatus/update?curPage=<%=paging.getCurPage()%>" method="post">
		<input type="hidden" id="bookingno" name="bookingno"/>
		<table class="table table-bordered" style="width: 700px;">
			<tr>
				<td>이름</td>	<td id="name"></td>
			</tr>
			<tr>
				<td>연락처</td><td id="phone"></td>
			</tr>
			<tr>
				<td>이메일</td><td id="email"></td>
			</tr>
			<tr>
				<td>예약자의 전달메시지</td><td id="message"></td>
			</tr>
			<tr>
				<td>체크인</td><td id="checkin"></td>
			</tr>
			<tr>
				<td>체크아웃</td><td id="checkout"></td>
			</tr>
			<tr>
				<td>예약상태</td>
				<td class="text-center">
					<select class="form-control" name="bookingstatus" style="max-width: 100px; margin: 0 auto;">
						<option value="W">대기</option>
						<option value="Y">승인</option>
						<option value="N">거절</option>
					</select>
				</td>
			</tr>
		</table>
		<button class="btn btn-info" type="submit" id="applyBtn">적용</button>
		<button class="btn btn-default" type="button" id="closeBtn">취소</button>
		</form>
	</div>
</div>

<!-- 이메일 modal -->
<div class="modal2 hidden">
	<div class="modal2_overlay"></div>
	<div class="modal2_content">
		<h2>이메일 전송</h2>
		<form action="/booking/mail?curPage=<%=paging.getCurPage()%>" method="post"  onsubmit="return checkContent();">
		<input type="hidden" id="bookingno" name="bookingno"/>
		<table class="table table-bordered" style="width: 700px;">
			<tr>
				<td>보내는사람 이메일</td>
				<td><input type="email" class="form-control" name="hostEmail" placeholder="exemple@gmail.com"></td>
			</tr>
			<tr>
				<td>보내는사람 이름</td>
				<td><input type="text" class="form-control" name="hostName"></td>
			</tr>
			<tr>
				<td>받는사람 이메일</td>
				<td><input type="email" class="form-control" id="guestEmail" name="guestEmail"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" class="form-control" name="subject"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content" class="form-control" style="min-height: 200px; resize: none;"></textarea></td>
			</tr>
		</table>
		<button class="btn btn-info" type="submit" id="snedBtn">전송</button>
		<button class="btn btn-default" type="button" id="closeBtn2">취소</button>
		</form>
	</div>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>


