<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<Board> list = (List)request.getAttribute("list"); %>
<%@include file="/WEB-INF/views/admin/include/header.jsp" %>
<!-- DataTables -->
<link rel="stylesheet" href="/resources/admin/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="/resources/admin/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
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
            <h1 class="m-0">자유게시판 조회</h1>
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
		                <h3 class="card-title">자유게시판 목록</h3>		
		              </div>
		              <!-- /.card-header -->
		              <div class="card-body table-responsive p-0" style="margin-top: 14px;">
		                <table class="table table-bordered table-hover dataTable dtr-inline" id="dataTable">
		                  <thead>
		                    <tr>
		                      <th style="width:10%">글번호</th>
		                      <th class="sorting_asc_disabled sorting_desc_disabled">제목</th>
		                      <th style="width:10%">작성일</th>
		                      <th class="sorting_asc_disabled sorting_desc_disabled" style="width:13%">글쓴이</th>
		                      <th class="sorting_asc_disabled sorting_desc_disabled" style="width:10%">삭제</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                  	<% for(int i =0; i<list.size(); i++){ %>
		                    <tr>
		                    	<td><%=list.get(i).getBoardNo() %></td>
		                    	<td>
		                    		<a href="/admin/board/view?boardno=<%=list.get(i).getBoardNo() %>">
		                    			<%=list.get(i).getBoardTitle() %>
		                    		</a>
		                    	</td>
		                    	<td><%=list.get(i).getBoardCreateDate() %></td>
		                    	<td><%=list.get(i).getUserNick() %></td>
		                    	<td>
		                    		<button type="button" class="btn btn-outline-danger btn_del" onclick="location.href='/admin/board/delete?boardno=<%=list.get(i).getBoardNo() %>'">삭제</button>
		                    	</td>
		                    </tr>
		                    <%} %>
		                  </tbody>
		                </table>
		                
		              </div>
		              <!-- /.card-body -->
		              
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
        "order": [[2, 'desc']],
        "ordering": true,
        "info": true,
        "autoWidth": false,
    });
});
</script>
<%@include file="/WEB-INF/views/admin/include/footer.jsp" %>