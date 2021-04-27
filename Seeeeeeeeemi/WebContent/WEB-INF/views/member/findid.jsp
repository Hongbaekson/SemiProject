<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<div class="inner">
	
	<div class="loginform">
		<h1>아이디 찾기</h1>
		
		<form action="/find/id" method="post">
			<div>
				<label>이름</label>
				<input type="text" name="uname">
			</div>
			<div>
				<label>연락처</label>
				<input type="text" name="utel">
			</div>
			<div>
				<button class="btn blue">아이디찾기</button>
			</div>
		</form>
	</div>
</div>
<%@include file="/WEB-INF/views/layout/footer.jsp" %>