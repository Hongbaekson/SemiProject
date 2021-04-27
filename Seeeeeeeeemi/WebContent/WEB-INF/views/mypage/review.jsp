<%@page import="dto.Room"%>
<%@page import="dto.Review"%>
<%@page import="dto.User"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%	List<Map<String, Object>> rList = (List<Map<String, Object>>) request.getAttribute("reviewList"); %>

<%@include file="/WEB-INF/views/layout/header.jsp" %>

<!-- jq -->
<script type="text/javascript" src="/resources/js/jquery-2.2.4.min.js"></script>    
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link href="/resources/css/mypage.css" rel="stylesheet">




<style>
.star-box {
	/* 별과 별 사이 공백 제거 */
    font-size: 0;
}

.star {
	/* width,height 적용가능하도록 변경 */
	display: inline-block;

	/* 별이 표현되는 영역 크기 */
	width: 12px;
    height: 30px;

	/* 투명한 별 표현 */
	background-image: url(/resources/img/empty.png);
	background-repeat: no-repeat;
	background-size: 200%;
}

.star_left {
	/* 왼쪽 별 */
	background-position: 0 0;
}

.star_right {
	/* 오른쪽 별 */
	background-position: 100% 0;
}

.on {
	/* 채워진 별로 이미지 변경 */
	background-image: url(/resources/img/star.png);
}
</style>

<div id="mypage-nav">
	<ul>
		<li><a href="/mypage/user">계정설정</a></li>
		<li><a href="/mypage/booking">예약</a></li>
		<li><a href="/mypage/review">이용후기</a></li>
		<li><a href="/mypage/bookmark">숙소 북마크</a></li>
	</ul>
</div>

<div id="review" class="inner">

	<h1>내가 작성한 리뷰</h1>

	<div class="row text-center">
		<div class="text-center">
			<span class="col-xs-3 text-center">이름/사진/별점</span>
			<span class="col-xs-3 text-center">숙소이름</span>
			<span class="col-xs-3 text-center">후기</span>
			<span class="col-xs-3 text-center">후기작성일</span>
		</div>
		<% for(int i=0; i<rList.size(); i++) { %>
		<div class="review-info row">
			<div class="line"></div>
			<div class="row text-center review-sub">
				<div class="col-xs-2">
					<span><%=((User)rList.get(i).get("user")).getUserName() %></span><br>
				</div>
				<div class="col-xs-5">
					<span><%=((Room)rList.get(i).get("room")).getRoomName() %></span><br>
				</div>
				<div class="col-xs-5 text-right" style="padding-right:90px">
					<span><%=((Review)rList.get(i).get("review")).getReDate() %></span>
				</div>
			</div>
			<div class="row review-main">
				<div class="col-xs-2 img-star">
<!-- 					<img src="/resources/img/ico_my.png" width="60px"><br> -->
<%-- 					<p><%=((Review)rList.get(i).get("review")).getReStar() %></p> --%>
					
					<% String restar = ((Review)rList.get(i).get("review")).getReStar() ; %>
				    
<%-- 				    <% String[] starr = restar.split("."); %> --%>
<!-- 				    starr[0] = 4 -->
<!-- 				    starr[1] = 5 -->
				    
					<p style="margin:0 auto;" class="starmain"><span style="width:calc(<%=restar %>/5*100%)"></span></p>
<!-- 				restar.matches(.5) -->
<%-- 					<% if %>( <%=starr[1] %> == "5" ) <%  { %> --%>
<%-- 					<% if (restar.matches("[0-9]+(.[5])")) { %> --%>
<%-- 					<% if (restar.contains(".")) { %> --%>
<%-- 						<% 	int star =(int) Double.parseDouble(restar); %> --%>
<!-- 						<div class="star-box"> -->
<%-- 						<% for(int j=0; j<star; j++ ) { %> --%>
<!-- 							<span class="star star_left on"></span> -->
<!-- 							<span class="star star_right on"></span> -->
<%-- 						<% } %>					 --%>
<!-- 						<span class="star star_left on"></span> -->
<!-- 						<span class="star star_right"></span>  -->
<%-- 						<% for(int k=0; k<4-star; k++) {%> --%>
<!-- 							<span class="star star_left"></span> -->
<!-- 							<span class="star star_right"></span> -->
<%-- 						<% } %> --%>
<!-- 						</div> -->
<%-- 					<% } else { %> --%>
<!-- 						<div class="star-box"> -->
<%-- 						<% for(int j=0; j<Integer.parseInt(restar); j++ ) { %> --%>
<!-- 							<span class="star star_left on"></span> -->
<!-- 							<span class="star star_right on"></span> -->
<%-- 						<% } %>					 --%>
<%-- 						<% for(int k=0; k<5-Integer.parseInt(restar); k++ ) { %> --%>
<!-- 							<span class="star star_left"></span> -->
<!-- 							<span class="star star_right"></span> -->
<%-- 						<% } %>					 --%>
<!-- 						</div> -->
<%-- 					<% } %> --%>
				</div>
				<div class="center-block">
					<div class="col-xs-10">
						<div class="review-content col-xs-5 bg-info"><%=((Review)rList.get(i).get("review")).getReContent() %></div>
					</div>
				</div>
			</div>
			<div class="line"></div>
		</div><!-- review-info -->
		<% } %>
	</div>
	

<%@ include file="/WEB-INF/views/layout/myPageReviewPaging.jsp" %>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>