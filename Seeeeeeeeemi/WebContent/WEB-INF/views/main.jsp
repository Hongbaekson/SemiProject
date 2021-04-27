<%@page import="dto.RoomImgReview"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<RoomImgReview> list = (List)request.getAttribute("list"); %>
<% List<RoomImgReview> poplist = (List)request.getAttribute("poplist"); %>
<%@include file="/WEB-INF/views/layout/header.jsp" %>

<!-- 검색영역 -->
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
						<input type="text" placeholder="체크인" name="chkin" id="checkIn" autocomplete ="off">
					</div>
					<div class="col">
						<input type="text" placeholder="체크아웃" name="chkout" id="checkOut"  autocomplete ="off">
					</div>
				</div>
				<div>
					<div class="col">
						<input type="number" placeholder="성인" name="adult" min="0">
					</div>
					<div class="col">
						<input type="number" placeholder="어린이" name="children" min="0">
					</div>
					<div class="col">
						<button type="submit">검색</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>


<div class="inner">
	
	 	
	
	<!-- 숙소추천 -->
	<div class="recommendRoom">
		<p>숙소를 추천해드려요 <span class="small badge">현재위치 : <b id="address"></b></span><a href="/room/list">+</a></p>
		<div>
			<div class="row recommendArea">
				
			</div>
			<p id="nodata" class=""></p>
		</div>
	</div>
		
	<!-- 실시간 숙소 -->
	<div class="popularRoom">
		<p>실시간 인기숙소를 확인하세요</p>
		<div>
			<div class="row">
				<%for(int i=0; i<poplist.size(); i++){ %>
				<div class="col-md-4">
					<div class="box">
						<div>
							<a href="room/detail?room_no=<%=poplist.get(i).getRoomNo() %>">
								<img src="/resources/upload/<%=poplist.get(i).getRoomImgFilename() %>">
							</a>
						</div>
						<div>
							<p class="text-bold"><%=poplist.get(i).getRoomName() %></p>
							<div class="row">
								<div class="col-md-6">
									<p class="starmain"><span style="width:calc(<%=poplist.get(i).getReStar() %>/5*100%)"></span></p>
								</div>
								<div class="col-md-6 text-right">
									<%=poplist.get(i).getReDate() %>
								</div>
							</div>							
							<p><%=poplist.get(i).getReContent() %></p>
							<div><span class="usericon"></span><%=poplist.get(i).getUserNick() %></div>
						</div>
					</div>
				</div>
				<%} %>
			</div>
		</div>
	</div>
	
	<!-- 호스트되기 배너 -->
	<div class="hostArea">
		<a href="/host/write">
			
			<img src="/resources/img/hostBanner.jpg" style="width:100%;">
			
		</a>
	</div>
	
	
	
	
	
	
	
</div>
<style>
#content .inner{
	padding:0;
}


</style>

<script src="/resources/js/jquery.js"></script>
<script src="/resources/js/jquery-ui.min.js"></script>
<script>
 $( function() {
	 
     $("#checkIn").datepicker({
    	 dateFormat: "yy-mm-dd"
     });
     $("#checkOut").datepicker({
    	 dateFormat: "yy-mm-dd"
     });
   
 } );
 </script>
 <script>
window.onload = function(){
	 getLocation();
}

var lon;
var lat;

function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else { 
	  nodata.innerHTML = "사용자의 위치를 가져올수 없습니다 ";
  }
}

function showPosition(position) {
  lon = position.coords.longitude; 
  lat = position.coords.latitude;
  
  
  
  
  $.ajax({
		url : 'https://dapi.kakao.com/v2/local/geo/coord2address.json?x=' + lon +'&y=' + lat,	
	    type : 'GET',
	    headers : {
	    	'Content-Type': 'application/json; charset=utf-8',
	    	'Authorization' : 'KakaoAK c211b65c74a5571d3d8abc542c4af1c6'
	    	}
		,
	    success : function(data) {	      
	      console.log(data);
	      var address = data.documents[0].address.region_2depth_name;
	      $('#address').text( data.documents[0].address.region_1depth_name + " "+ data.documents[0].address.region_2depth_name );
	      
	      $.ajax({
	            type:'get',
	            url:'/recommend',
	            dataType:'html',
	            data:{address:address},
	            success: function(data) { 
	                console.log('success');
	                $('.recommendArea').html(data);
	            },
	            error:function (data, textStatus) {
	                console.log('error');
	            }
	        })    //ajax
	      
	    },
	    error : function(e) {
	      console.log(e);
	    }
	  });
}




</script>
 
 
<%@include file="/WEB-INF/views/layout/footer.jsp" %>