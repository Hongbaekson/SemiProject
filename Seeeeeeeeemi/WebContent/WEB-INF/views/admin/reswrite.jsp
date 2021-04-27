<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@include file="/WEB-INF/views/admin/include/header.jsp" %>

<!-- DataTables -->
<link rel="stylesheet" href="/resources/admin/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="/resources/admin/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
<style>

<style>
.paginate_button  {
    position: relative;
    float: left;
    padding: 6px 12px;
    margin-left: -1px;
    line-height: 1.42857143;
    color: #337ab7;
    text-decoration: none;
    background-color: #fff;
    border: 1px solid #ddd;
}
.paginate_button.current{
	    z-index: 3;
    color: #fff;
    cursor: default;
    background-color: #337ab7;
    border-color: #337ab7;	

}

</style>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
	<!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="/resources/admin/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>
<%@include file="/WEB-INF/views/admin/include/sidemenu.jsp" %>

<script type="text/javascript" src="/resources/js/jquery-2.2.4.min.js"></script>

<!-- 다음지도 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	//작성버튼 동작
	$("#btnWrite").click(function() {
		$("form").submit();
	});
	
	//취소버튼 동작
	$("#btnCancel").click(function() {
		history.go(-1);
	});
	
	var agent = navigator.userAgent.toLowerCase();
	
	/* ===파일 삭제부분=== */
	$(".btn1").click(function(){ fileReset("input[name='file1']", ".preview1") })
	$(".btn2").click(function(){ fileReset("input[name='file2']", ".preview2") })
	$(".btn3").click(function(){ fileReset("input[name='file3']", ".preview3") })
	$(".btn4").click(function(){ fileReset("input[name='file4']", ".preview4") })
	$(".btn5").click(function(){ fileReset("input[name='file5']", ".preview5") })

	//음식종류 버튼 클릭 이벤트
	$(".fac-btn").click(function() {
		if($(this).hasClass('btn-default')){
			$(this).removeClass('btn-default');
			$(this).addClass('btn-info');
		} else if ($(this).hasClass('btn-info')){
			$(this).removeClass('btn-info');
			$(this).addClass('btn-default');
		}
	})
});

</script>

<style>
.btn-default, .btn-info { 
	margin: 5px;
}
.imgView {
	display: inline-block;
	width: 150px;
	height: 100px;
	position: absolute;
	border: 1px solid #ccc;
}
input[type="file"] {
	display: inline;
}
.imgBox {
	position: relative;
	height: 220px;
	padding: 0;
}
.preview2 {
	left: 150px;
}
.preview3 {
	left: 300px;
}
.preview4 {
	top: 100px;
}
.preview5 {
	top: 100px;
	left: 150px;
}

</style>

 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-12">
            <h1 class="m-0">맛집 등록</h1>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

<hr>
<div class="row">
<div class="col-md-7">
<form class="form-horizontal" action="/admin/restaurantwrite" method="post" enctype="multipart/form-data" onsubmit="return checkForm();"> <!-- 폼은 여기 넣어놨어여 -->


<!-- 맛집 등록 -->
<!-- 이미지 -->
<div class="form-group">
	<label class="col-sm-3 control-label"> 이미지 등록(5장 필수)</label>
	<div class="col-sm-9"> <!-- 그냥 이렇게 이름 돼있고 이런 건 상관업나영...?네 지금하는 작업은 여기페이지랑 아무 상관이 없어요.... DB에서 꺼내오는거잖아요 아하!!!이제 진짜 이해햇어여 다시 안 물어볼게여ㅠㅠㅠ -->
		<input type="file" name="file" accept="image/gif,image/jpeg,image/png"/><button class="btn1" type="button">X</button>
		<input type="file" name="file" accept="image/gif,image/jpeg,image/png"/><button class="btn2" type="button">X</button>
		<input type="file" name="file" accept="image/gif,image/jpeg,image/png"/><button class="btn3" type="button">X</button>
		<input type="file" name="file" accept="image/gif,image/jpeg,image/png"/><button class="btn4" type="button">X</button>
		<input type="file" name="file" accept="image/gif,image/jpeg,image/png"/><button class="btn5" type="button">X</button>
	</div>
</div>

<div class="form-group">
	<label class="col-sm-3 control-label" for="resname">가게명</label>
	<div class="col-sm-9">
	<input class="form-control" type="text" name="resname" id="resname" maxlength="100">
	</div>
</div>
<div class="form-group">
	<label class="col-sm-3 control-label" for="resphone">가게번호</label>
	<div class="col-sm-9">
	<input class="form-control" type="text" name="resphone" id="roomName" maxlength="100">
	</div>
</div>
<div class="form-group">
	<label class="col-sm-3 control-label" for="restime">영업시간</label>
	<div class="col-sm-9">
	<input class="form-control" type="text" name="restime" id="roomName" maxlength="100">
	</div>
</div>

<div class="form-group">
	<label class="col-sm-3 control-label" for="regionno">지역</label>
	<div class="col-sm-9">
	<select class="form-control" id="regionno" name="regionno"> 
	      
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
</div>

<!-- 종류-->
<div class="form-group">
	<label class="col-sm-3 control-label">음식종류</label> 
<div class="btn-group-toggle col-sm-9" data-toggle="buttons">
		<label class="btn btn-info">
			<input type="radio" name="filterno" value="301">한식
		</label>
		<label class="btn btn-info">
			<input type="radio" name="filterno" value="302">양식
		</label>
		<label class="btn btn-info">
			<input type="radio" name="filterno" value="303">중식
		</label>
		<label class="btn btn-info">
			<input type="radio" name="filterno" value="304">일식
		</label>
		<label class="btn btn-info">
			<input type="radio" name="filterno" value="305">아시아 음식
		</label>
		<label class="btn btn-info">
			<input type="radio" name="filterno" value="306">카페 
		</label>
		<label class="btn btn-info">
			 <input type="radio" name="filterno" value="307">분식
		</label>
		<label class="btn btn-info">
			<input type="radio" name="filterno" value="308">기타
		</label>
	</div>

</div>

<!-- 장소 -->
<div class="form-group">
	<label class="col-sm-3 control-label" for="resroad">주소</label>
	<div class="col-sm-9">
	<input class="form-control" type="text" name="resroad" id="resroad" maxlength="100">
	</div>
</div>



<div class="form-group">
	<label class="col-sm-3 control-label" for="resparking">정보</label>
	<div class="col-sm-9">
	<textarea class="form-control" name="resparking" id="resparking" rows="5" maxlength="1300"></textarea>
	</div>
</div>
<br>

<div class="text-center" style="margin: 10px;">
<button type="submit" id="btnWrite" class="btn btn-primary btn-lg">등록</button>
<span>&emsp;</span>
<button id="btnCancel" class="btn btn-danger btn-lg" onclick='location.href="/admin/restaurantlist";'>취소</button>
</div> 
</form> 
<div class="text-center" style="margin-left: 150px; top:100px;">

</div>
 </div><!-- /.content-wrapper -->


</div><!-- .col-md-8 end-->
</div><!-- .row end-->
</div> <!-- .container end  -->



  
  <footer class="main-footer">
    <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
      <b>Version</b> 3.1.0
    </div>
  </footer>
<script type="text/javascript" src="/resources/js/jquery-2.2.4.min.js"></script>
<script src="/resources/admin/plugins/datatables/jquery.dataTables.js"></script>
<script src="/resources/admin/plugins/datatables/jquery.dataTables.min.js"></script>
<script>
$.noConflict();
jQuery( document ).ready(function( $ ) {
    $('#dataTable').DataTable({
    	"paging": true,
        "lengthChange": false,
        "searching": true,
        "ordering": true,
        "info": true,
        "autoWidth": false,
    });
   
 
    
});
</script>

<%@include file="/WEB-INF/views/admin/include/footer.jsp" %>


