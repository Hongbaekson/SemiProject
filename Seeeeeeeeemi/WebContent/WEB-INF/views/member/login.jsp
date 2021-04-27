<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/layout/header.jsp" %>

<div class="inner">

	<div class="loginform">
		<h1>로그인</h1>
		<hr>
		<form action="/login" method="post">
			<div>
				<label for="uid">아이디</label>			
				<input type="text" name="uid" id="uid" placeholder="아이디를 입력하세요">
			</div>
			<div>
				<label for="upw">패스워드</label>
				<input type="password" name="upw" id="upw" placeholder="비밀번호를 입력하세요">
			</div>
			<div>
				<button type="submit" class="btn">로그인</button>
			</div>
		</form>
		<div class="findArea">
			<a href="/find/id">아이디찾기</a><i style="display:inline-block; padding:0 10px;">|</i>
			<a href="/find/pw">비밀번호 찾기</a>
		</div>
	</div>
	
</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>