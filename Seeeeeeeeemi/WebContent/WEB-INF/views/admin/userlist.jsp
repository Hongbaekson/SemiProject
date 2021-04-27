<%@page import="dto.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% List<User> list = (List)request.getAttribute("list"); %>
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
            <h1 class="m-0">회원관리</h1>
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
		                <h3 class="card-title">전체 회원 조회</h3>		
		              </div>
		              <!-- /.card-header -->
		              <div class="card-body table-responsive p-0" style="margin-top: 14px;">
		                <table class="table table-bordered table-hover dataTable dtr-inline" id="dataTable">
		                  <thead>
		                    <tr>
		                      <th>No.</th>
		                      <th class="sorting_asc_disabled sorting_desc_disabled">아이디</th>
		                      <th class="sorting_asc_disabled sorting_desc_disabled">회원이름</th>
		                      <th class="sorting_asc_disabled sorting_desc_disabled">이메일</th>
		                      <th class="sorting_asc_disabled sorting_desc_disabled">전화번호</th>
		                      <th>권한</th>
		                      <th class="sorting_asc_disabled sorting_desc_disabled">삭제</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                  	<% for(int i=0; i<list.size(); i++) {%>
		                    <tr>
		                    	<td><%=list.get(i).getUserNo() %></td>
		                    	<td><%=list.get(i).getUserId() %></td>
		                    	<td><%=list.get(i).getUserName() %></td>
		                    	<td><%=list.get(i).getUserEmail() %></td>
		                    	<td><%=list.get(i).getUserPhone() %></td>
		                    	<td>
		                    		<% if( list.get(i).getUserGrade()==0 ){ %>
		                    			관리자
		                    		<%} else if( list.get(i).getUserGrade()==1 ){ %>
		                    			사용자
		                    		<%} else if(( list.get(i).getUserGrade()==2 )){ %>
		                    			호스트
		                    		<%} %>
		                    	</td>
		                    	<td>
		                    		<button type="button" class="btn btn-outline-danger btn_del">삭제</button>
		                    		<input type="hidden" value="<%=list.get(i).getUserNo() %>">
		                    	</td>
		                    </tr>
		                    <%} %>
		                  </tbody>
		                </table>
		                
		              </div>
		              <!-- /.card-body -->
		              <div class="card-footer">
		                  <button type="button" class="btn btn-info" data-toggle="modal" data-target="#modal-default">등록</button>
	                  </div>
		            </div>
     			</div>
     		</div>
     	</div>
    </section>
    <!-- /.content -->
    <!-- 회원등록모달 -->
    <div class="modal fade" id="modal-default" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">회원등록</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">×</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="card card-primary">
	              <!-- form start -->
	              <form id="registerForm" novalidate="novalidate" action="/admin/register" method="post">
	                <div class="card-body">
	                  <div class="form-group">
	                    <label for="uid">아이디</label>
	                    <input type="text" name="uid" class="form-control" id="uid">
	            		<p id="msgId"></p>
	                  </div>
	                  <div class="form-group">
	                    <label for="">이름</label>
	                    <input type="text" name="uname" class="form-control">
	                  </div>
	                  <div class="form-group">
	                    <label for="">닉네임</label>
	                    <input type="text" name="unick" class="form-control">
	                  </div>
	                  <div class="form-group">
	                    <label for="">비밀번호</label>
	                    <input type="pwd" name="upw" class="form-control">
	                  </div>
	                  <div class="form-group">
	                    <label for="">성별</label>
	                    <div class="custom-control custom-radio">
		                    <input type="radio" name="ugender" class="form-control custom-control-input" value="F" id="genderF">
		                    <label class="custom-control-label" for="genderF">여성</label>
		                 </div>
		                 <div class="custom-control custom-radio">
		                    <input type="radio" name="ugender" class="form-control custom-control-input" value="M" id="genderM">
		                    <label class="custom-control-label" for="genderM">남성</label>
	                    </div>
	                  </div>
	                  <div class="form-group">
	                    <label for="">생년월일</label>
	                    <input type="text" name="ubirth" class="form-control" placeholder="19901007">
	                  </div>
	                  <div class="form-group">
	                    <label for="uemail">이메일</label>
	                    <input type="text" name="uemail" class="form-control" id="uemail">
	                    <p id="msgEmail"></p>
	                  </div>
	                  <div class="form-group">
	                    <label for="">연락처</label>
	                    <input type="text" name="uphone" class="form-control">
	                  </div>
	                  <div class="form-group">
	                    <label for="">회원구분</label>
	                    <select name="ugrade" class="form-control">
	                    	<option value="0">관리자</option>
	                    	<option value="1">사용자</option>
	                    	<option value="2">호스트</option>
	                    </select>
	                  </div>
	                </div>
	                <!-- /.card-body -->
	                <div class="card-footer">
	                  <button type="submit" class="btn btn-primary">Submit</button>
	                </div>
	              </form>
	            </div>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
    
    
    
    
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
    
	$('.btn_del').click(function(){
		
		var prom= prompt("회원과 관련된 모든정보가 삭제됩니다. 삭제하려면 '삭제'를 입력해주세요 ");
		
		if(prom == "삭제"){
		
		    var userno = $(this).next('input').val(); 
		    	    
			$.ajax({
	            type:'post',
	            url:'/admin/userlist',
	            dataType:'text',
	            data:{"userno": userno },
	            success: function(data) {
					alert("삭제완료!");
					location.href="/admin/userlist"
	            },
	            error:function (data, textStatus) {
	            	alert("삭제실패!")
	            }
	        })    //ajax
		}else{
			alert("입력이 올바르지않습니다")
		}
		
		
	})   
    
    
});
</script>
<script src="/resources/admin/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="/resources/admin/plugins/jquery-validation/additional-methods.min.js"></script>
<script type="text/javascript">
//validater
jQuery( document ).ready(function( $ ) {
 
  $('#registerForm').validate({
    rules: {    
//       uid: {
//         required: true,
//         minlength: 4
//       },
      uname: {
        required: true,
        minlength: 1
      },
      unick: {
          required: true,
          minlength: 4
      },
      ugender: {
          required: true,          
      },
      ubirth: {
          required: true,          
      },
//       uemail: {
//           required: true, 
//           email:true
//       },
      uphone: {
          required: true,          
      },
      ugrade: {
          required: true,          
      },
      
      
    },
    messages: {
//     	uid: {
//            required: "아이디를 입력해주세요",
//            minlength: "4글자 이상이여야됩니다 "
//          },
         uname: {
        	 required: "이름을 입력해주세요",
        	 minlength: "1글자 이상이여야됩니다 "
           },
         unick: {
             required: "닉네임을 입력해주세요",
             minlength: "4글자 이상이여야됩니다 "
         },
         ugender: {
             required: "성별을 선택해주세요",        
         },
         ubirth: {
             required: "생년월일 입력해주세요",         
         },
//          uemail: {
//              required: "이메일을 입력해주세요", 
//              email:true
//          },
         uphone: {
             required: "핸드폰번호를 입력해주세요",          
         }
    },
    errorElement: 'span',
    errorPlacement: function (error, element) {
      error.addClass('invalid-feedback');
      element.closest('.form-group').append(error);
    },
    highlight: function (element, errorClass, validClass) {
      $(element).addClass('is-invalid');
    },
    unhighlight: function (element, errorClass, validClass) {
      $(element).removeClass('is-invalid');
    }
  });
});
</script>
<script type="text/javascript">
jQuery( document ).ready(function( $ ) {
	
	//id중복검사 
    $("#uid").blur(function() {
    	
        var id =  $("#uid").val(); 
        
        if( id!=null && id!=""){
        
	        $.ajax({
	            type:'post',
	            url:'/idcheck',
	            dataType:'json',
	            data:{id:id},
	            success: function(data) { 
	                if( data ) {
	                	$('#msgId').text("이미 사용 중인 아이디입니다.")
	                	$('#msgId').addClass("text-red");
	                    $('#msgId').removeClass("text-green");
	                	$('#uid').val("");
	                	$('#uid').focus();
	               	    $('#uid').addClass("is-invalid");
	                } else {
	                    $('#msgId').text("사용할 수 있는 ID입니다.");
	                    $('#msgId').removeClass("text-red");
	                    $('#msgId').addClass("text-green");                    
	                    $('#uid').addClass('is-valid')
	                }
	            },
	            error:function (data, textStatus) {
	                console.log('error');
	            }
	        })    //ajax
        }else{
        	$('#msgId').text("아이디를 입력해주세요");
        	$('#uid').addClass("is-invalid");
        	$('#msgId').removeClass('text-green');
        	$('#msgId').addClass("text-red");
        	$('#uid').focus();
        }
       
    });
    
 
    //이메일 중복검사
     $("#uemail").blur(function() {
    	
    	 var email =  $("#uemail").val(); 
    	 if( email!=null && email!=""){
	        $.ajax({
	            type:'post',
	            url:'/emailchk',
	            dataType:'json',
	            data:{email:email},
	            success: function(data) { 
	                if( data ) {
	                	$('#msgEmail').text("이미 사용 중인 이메일입니다.")
	                    $('#msgEmail').addClass("text-red");
	                	$('#msgEmail').removeClass("text-green");
	                	$('#uemail').val("");
	                	$('#uemail').focus();
	               	    $('#uemail').addClass("is-invalid");
	               	    
	                } else { 
	                    $('#msgEmail').text("사용할 수 있는 ID입니다.");
	                    $('#msgEmail').removeClass("text-red");
	                    $('#msgEmail').addClass("text-green");                    
	                    $('#uemail').addClass('is-valid')
	                }
	            },
	            error:function (data, textStatus) {
	                console.log('error');
	            }
	        })    //ajax
    	 }else{
         	$('#msgEmail').text("이메일을 입력해주세요");
         	$('#uemail').addClass("is-invalid");
         	$('#msgEmail').removeClass('text-green')
         	$('#msgEmail').addClass("text-red");
         	$('#uemail').focus();
    	 }
    });
	
	
})




</script>




<!-- ./wrapper -->
<%@include file="/WEB-INF/views/admin/include/footer.jsp" %>