<%@page import="java.util.Map"%>
<%@page import="dto.Room"%>
<%@page import="dto.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<Map<String, Object>> list = (List) request.getAttribute("list"); %>
<%@include file="/WEB-INF/views/admin/include/header.jsp" %>
<!-- DataTables -->
<link rel="stylesheet" href="/resources/admin/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="/resources/admin/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	//거절버튼
	$("#deleteBtn").click(function(){
		if (confirm("정말로 삭제하시겠습니까?") == false) return false;

		$("#statusForm").attr("action", "/admin/bookinglist")
		$("#statusForm").submit();
	})
	//체크박스 전체선택/해제
	$("#chkAll").click(function(){
		if( $("#chkAll").prop("checked") ){
			$("input[name=chk]").prop("checked", true);
		} else {
			$("input[name=chk]").prop("checked", false);
		}
	})
	
	//체크가 되었을 때 버튼 활성화
	$("input[type=checkbox]").click(function(){
		var tmp = null;
		$("input[name=chk]").each(function (index, item){
			if( $(item).prop('checked') ){
				tmp = true;
				return false;
			}
		})
		
		var cnt = $("input[name=chk]:checked").length;
		if(tmp==true || cnt>0){
		    $(".btn").prop("disabled",false);
		} else {
		    $(".btn").prop("disabled",true);
		}
	})
})
</script>

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
  
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-12">
            <h1 class="m-0">예약 조회</h1>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
     	<div class="container-fluid">
     		<div class="row">
     			<div class="col-md-12">
     				<div class="card">
		              <div class="card-header">
		                <h3 class="card-title">전체 예약 리스트</h3>		
		              </div>
		              <!-- /.card-header -->
		              <form id="statusForm" method="post">
		              <div class="card-body table-responsive p-0" style="margin-top: 14px;">
		                <table class="table table-bordered table-hover dataTable dtr-inline" id="dataTable">
		                  <thead>
		                    <tr>
		                      <th class="sorting_asc_disabled sorting_desc_disabled">
			                      <input type="checkbox" id="chkAll">
		                      </th>
		                      <th>예약번호</th>
		                      <th class="sorting_asc_disabled sorting_desc_disabled">회원번호</th>
		                      <th class="sorting_asc_disabled sorting_desc_disabled" style="width:550px;">숙소명</th>
		                      <th class="sorting_asc_disabled sorting_desc_disabled">체크인</th>
		                      <th class="sorting_asc_disabled sorting_desc_disabled">체크아웃</th>
		                      <th>예약상태</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                  	<% for(int i=0; i<list.size(); i++) {%>
		                    <tr>
		                    	<td>
		                    		<input type="checkbox" name="chk" value="<%=list.get(i).get("예약번호")%>">
		                    	</td>
		                    	<td><%=list.get(i).get("예약번호") %></td>
		                    	<td><%=list.get(i).get("회원번호") %></td>
		                    	<td><%=list.get(i).get("숙소명") %></td>
		                    	<td><%=list.get(i).get("체크인") %></td>
		                    	<td><%=list.get(i).get("체크아웃") %></td>
		                    	
	                    		<% if ( "W".equals(list.get(i).get("예약상태")) ) { %>
	                    			<td>대기중</td>
	                    		<% } else if( "Y".equals(list.get(i).get("예약상태")) ) { %>
	                    			<td style="color: green; ">완료</td>
	                    		<% } else if( "N".equals(list.get(i).get("예약상태")) ) { %>
	                    			<td style="color: red; ">거절</td>
	                    		<% } %>
		                    	
		                    	
		                    </tr>
		                    <%} %>
		                  </tbody>
		                </table>
		                
		              </div>
		              </form>
		              <!-- /.card-body -->
		              <div class="card-footer">
		                  <button type="button" id="deleteBtn" class="btn btn-danger" disabled="disabled">삭제</button>
	                  </div>
		            </div>
     			</div>
     		</div>
     	</div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
      <b>Version</b> 3.1.0
    </div>
  </footer>

  

</div>
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
<!-- ./wrapper -->
<%@include file="/WEB-INF/views/admin/include/footer.jsp" %>