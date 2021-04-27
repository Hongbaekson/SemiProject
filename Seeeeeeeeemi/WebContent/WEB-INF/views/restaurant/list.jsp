<%@page import="dto.Restaurant"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <%	List<Restaurant> list = (List<Restaurant>)request.getAttribute("restaurantList"); %>
 

<%@include file="/WEB-INF/views/layout/header.jsp" %>


<!-- jQuery 2.2.4 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<!-- 아이콘 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">

<!-- 부트스트랩 3.2.2 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	    
	    
<style type="text/css">

.main {
	width: 100%;
	height: 100%;
	text-align: center;
	position: relative;
	z-index: 1;
	

}

.main::after {
	width: 100%;
	height: 100%;
	content: "";
	background-image: url('/resources/img/food2.jpg');
	background-size: cover;
	position: absolute;
	top: 0;
	left: 0;
	z-index: -1;
	opacity: 0.5;
}

#food {
	text-align: center;

}

#map {
	float: right;
/* 	width: 45%; */
}

#list {
	float: left;
/* 	hegiht: 100px; */
/* 	margin-left: 10%; */
	width: 650px;
}

.wrapper {
	border-left: 1px solid #ccc;
	border-right: 1px solid #ccc;
	width: 1200px;
	margin: 0 auto;
}

</style>

<!-- 지역 검색 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script type="text/javascript">

 var cat1_num = new Array(900, 901,902,903,904,905,906,907,908,909,801,802,803,804,805,806);
 var cat1_name = new Array('서울','부산','대구','인천','광주','대전','울산','강원','경기','경남','경북','전남','전북','제주','충남','충북');

function cat1_change(key,sel){
 if(key == '') return;
 var name = cat2_name[key];
 var val = cat2_num[key];

 for(i=sel.length-1; i>=0; i--)
  sel.options[i] = null;
 sel.options[0] = new Option('-선택-','', '', 'true');
 for(i=0; i<name.length; i++){
  sel.options[i+1] = new Option(name[i],val[i]);
 }
}

//검색 초기화 
$(document).ready(function(){
//btn_reset 을 클릭했을때의 함수
$( "#btn_reset").click(function () {
    $( "#reset_form" ).each( function () {
        this.reset();
    	});
	});
});


</script>

<div class="main">
<h1><strong>추천맛집 조회</strong></h1>
<hr></div>


<div class="wrapper">

<div id="food">
<!-- 지역 검색 -->

<form action="./list" method="post">
<div id="search">


검색<span style="color:skyblue"><i class="fas fa-search"></i></span>  
<select name="h_area1" onChange="cat1_change(this.value,h_area2)" >

  <option selected>-선택-</option>
<option value='900'>서울</option>
<option value='901'>부산</option>
<option value='902'>대구</option>
<option value='903'>인천</option>
<option value='904'>광주</option>
<option value='905'>대전</option>
<option value='906'>울산</option>
<option value='907'>강원</option>
<option value='908'>경기</option>
<option value='909'>경남</option>
<option value='801'>경북</option>
<option value='802'>전남</option>
<option value='803' >전북</option>
<option value='804'>제주</option>
<option value='805'>충남</option>
<option value='806'>충북</option>
  </select>

</div>
<br>

 <!-- 필터 체크박스 -->
  <div class="check_wrap">
 필터<span style="color:skyblue;"><i class="fas fa-filter"></i></span>
 <input type="checkbox" name="cat" value="301">한식
 <input type="checkbox" name="cat" value="302">양식
 <input type="checkbox" name="cat" value="303">중식
 <input type="checkbox" name="cat" value="304">일식
 <input type="checkbox" name="cat" value="305">아시아 음식
 <input type="checkbox" name="cat" value="306">카페
 <input type="checkbox" name="cat" value="307">분식
 <input type="checkbox" name="cat" value="308">기타
 </div>
 <br>
  <!-- 검색 버튼 -->
<button type="button" id="btn_reset" class="btn btn-success btn-sm" >검색 초기화</button>
 
 <button type="submit" class="btn btn-warning btn-sm" onclick='location.href="/restaurant/search";'>돌아가기</button>


<br>


<br>
<br>
</form>

</div>


<div id="list">
<table class="table table-striped table-hover table-condensed">
<tr>
	<th class="success" style="width:4%;">NO</th>
	<th class="success" style="width:3%;"></th>
	<th class="success" style="width:20%;">가게명</th>
	<th class="success" style="width:28%;">정보</th>
	
</tr>
<%	for(int i=0; i<list.size(); i++) { %>
<tr class="warning">
	<td><%=list.get(i).getResNo() %></td>
	<td><li><img src="/resources/img/slider1.gif" width="150px;"/></li></td>
	<td>
		<a href="/restaurant/detail?resno=<%=list.get(i).getResNo()%>">
		<%=list.get(i).getResName() %>
		</a></td>
	<td><%=list.get(i).getResPhone() %><br>
	<%=list.get(i).getResTime()%><br>
	<%=list.get(i).getResRoad()%> 
</tr>
<%	} %>
</table>
</div>

<div>
<!-- 카카오 지도 -->
<div id="map"  style="width:45%; height:400px;"></div>
<!-- <div id="map" style=" display: inline-block; width:40%; height:400px; margin-left:250px; "></div> -->
</div>

<div class="clearfix"></div>

</div><!-- .wrapper -->




<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=908b23f5c4a47ae402b09a8b48260b99"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨 
    }; 

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
        
        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            message = '<div style="padding:5px;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다
        
        // 마커와 인포윈도우를 표시합니다
        displayMarker(locPosition, message);
            
      });
    
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation을 사용할수 없어요..'
        
    displayMarker(locPosition, message);
}

// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition, message) {

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    }); 
    
    var iwContent = message, // 인포윈도우에 표시할 내용
        iwRemoveable = true;

    // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // 인포윈도우를 마커위에 표시합니다 
    infowindow.open(map, marker);
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);      
}    
</script>

<%@ include file="/WEB-INF/views/layout/paging.jsp" %>


<%@include file="/WEB-INF/views/layout/footer.jsp" %>
