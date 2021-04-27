<%@page import="dto.User"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
 
<%@include file="/WEB-INF/views/layout/header.jsp" %>

<!-- jq -->
<script type="text/javascript" src="/resources/js/jquery-2.2.4.min.js"></script>    
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link href="/resources/css/mypage.css" rel="stylesheet">


<script>
$(function(){	
	$(document).ready(function(){
		$('select[name=emailSelection]').change(function() {
			if($(this).val()=="1"){
				$('#email2').val("");
			} else {
				$('#email2').val($(this).val());
				$("#email2").attr("readonly", true);
			}
		});
	});
});
</script>
<script type="text/javascript">
function validate() {

       //아이디와 패스워드 값 데이터 정규화 공식
       var regul1 = /^[a-zA-Z0-9]{4,12}$/;
      
       //이메일 정규화 공식
       var regul2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
       
       //이름 정규화 공식
       var regul3 = /^[가-힝a-zA-Z]{2,}$/;
       		
       //생년월일 정규화공식 19991122
       var regul4 = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;

    	//핸드폰번호 정규식 
    	var regul5 = (/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3"); 

    	//아이디 입력 하지 않았을 경우
        if ((uid.value) == ""){
            alert("아이디를 입력하지 않았습니다.");
            uid.focus();
            return false;
        }
        //아이디 유효성 검사
        if (!check(regul1,uid,"아이디는 4~12자의 대소문자와 숫자로만 입력 가능합니다.")) {
            return false;
        }
     	//아이디중복체크했는지 
      	if( uid.getAttribute('data-idchk')=="fail"){
      		alert("아이디 중복체크를 해주시기 바랍니다.");
      		uid.focus();
      		return false;
      	}
      

        //이름 입력하지 않았을 경우
       if ((username.value) == ""){
           alert("이름을 입력하지 않았습니다.");
           username.focus();
           return false;
       }
       //이름 유효성검사
       if (!check(regul3,username,"이름이 잘못 되었습니다.")) {
           return false;
       }
       
       //닉네임을 입력하지 않았을경우
       if ((usernick.value) == ""){
           alert("닉네임을 입력하지 않았습니다.");
           unick.focus();
           return false;
       }
       
       //닉네임 검증
       if (!check(regul3,usernick,"닉네임이 잘못 되었습니다.")) {
           return false;
       }
       

       //비밀번호 유효성 검사
       if (!check(regul1,upw,"비밀번호는 4~12자의 대소문자와 숫자로만 입력 가능합니다.")) {
           return false;
       }
       
       //비밀번호와 비밀번호 확인이 일치 하지 않을 경우
       if ((upw.value)!=(upwchk.value)) {
           alert("비밀번호가 일치 하지 않습니다.");
           upw.focus();
           upwchk.focus();
           return false;
       }
       
       
       //생년월일 검증
       if (!check(regul4,userbirth,"생년월일이 잘못되었습니다 ")) {
           return false;
       }
       
       //이메일 입력 안했을 경우
       if ((uemail.value)=="") {
           alert("이메일을 입력해 주세요");
           objEmail.focus();
           return false;
       }
       //이메일이 잘못된 경우
       if (!check(regul2,uemail,"이메일을 잘못 입력 했습니다.")) {
           return false;
       }
       
       //닉네임중복체크했는지   	
       if( umail.getAttribute('data-idchk')=="fail"){
     		alert("이메일 중복체크를 해주시기 바랍니다.");
     		umail.focus();
     		return false;
     	}
       
       if (!uphone(regul5,userphone,"핸드폰번호를 잘못입력하셨습니다")) {
           return false;
       }
       
     
  
   }
   function check(re,what,message){//정규화데이터,아이템 id,메세지
       if (re.test(what.value)) {//what의 문자열에 re의 패턴이 있는지 나타내는 함수 test
       //만약 내가 입력한 곳의 값이 정규화 데이터를 썼다면 true를 반환해서 호출 된 곳으로 리턴됨
           return true;
       }
       what.nextElementSibling.innerHTML=message;
       what.value = "";
       what.focus();
   }

   </script>
<script type="text/javascript">

$(function() {
    //이메일 중복검사
    $("#uemailchk").click(function() {
    	//이메일 입력 하지 않았을 경우
        if ((uemail.value) == ""){
            alert("이메일을 입력하지 않았습니다.");
            uemail.focus();
            return false;
        }
    	//이메일정규식
        var regul2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
        
        //이메일정규식 유효성 검사
        if (!check(regul2,uemail,"이메일이 잘못 되었습니다.")) {
           return false;
       }
    	
        var email =  $("#uemail").val(); 
        
        $.ajax({
            type:'post',
            //async:false, //false가 기본값임 - 비동기
            url:'/emailchk',
            dataType:'json',
            data:{email:email},
            success: function(data) { 
                if( data ) {
                	$('#msgEmail').text("이미 사용 중인 이메일입니다.")
                    $('#msgEmail').removeClass("blue");
                	$('#uemail').val("");
                	$('#uemail').focus();
               	    $('#uemail').attr("data-idchk", "fail");
                } else {                	
                    $('#msgEmail').text("사용할 수 있는 이메일입니다.");
                    $('#msgEmail').addClass("blue");
                    $('#uemailchk').addClass("blue")
                    $('#uemail').attr("data-idchk", "success");
                }
            },
            error:function (data, textStatus) {
                console.log('error');
            }
        })    //ajax
    });
    
    $('input').each(function(){
    	
    	$('input').blur(function(){
    			
    		if( $('#uid').val()==null || $('#uid').val() == '' 
    			|| 	$('#uname').val()==null || $('#uname').val() == ''
    			||  $('#upw').val()==null || $('#upw').val() == ''
    			||  $('#upwchk').val()==null || $('#upwchk').val() == ''
    			||  $('#ugender').val()==null || $('#ugender').val() == ''
    			|| $('#ubirth').val()==null || $('#ubirth').val() == ''
   				|| $('#uphone').val()==null || $('#uphone').val() == '' 				
    		){
    			$("button[type='submit']").removeClass("blue")
    			return false;
    		}else{
    			$("button[type='submit']").addClass('blue');	
    		}
    		
    	})
    })
    
});


</script>


<%	User u = (User) request.getAttribute("user"); %>

<div id="mypage-nav">
	<ul>
		<li><a href="/mypage/user">계정설정</a></li>
		<li><a href="/mypage/booking">예약</a></li>
		<li><a href="/mypage/review">이용후기</a></li>
		<li><a href="/mypage/bookmark">숙소 북마크</a></li>
	</ul>
</div>

<div class="inner">
	<div class="joinform">
		<H1>개인정보</H1>
		<hr>
		<form action="/mypage/update" method="post" class="form-inline" onsubmit="return validate()">
		
			<div class="">
				<label for="username">이름</label>
				<input class="form-control" type="text" id="username" name="username" value="<%=u.getUserName()%>">
			</div>
			<div class="">
				<label for="usernick">닉네임</label>
				<input class="form-control" type="text" id="usernick" name="usernick" value="<%=u.getUserNick()%>">
				<p></p>
			</div>
			<div>
				<label for="usergender">성별</label>
				<%	if ((u.getUserGender()).equals("M")) { %>
				<input type="radio" name="usergender" id="username" value="M" checked>남
				<input type="radio" name="usergender" id="username" value="F">여
				<%	} else { %>
				<input type="radio" name="usergender" id="username" value="M">남
				<input type="radio" name="usergender" id="username" value="F" checked>여
				<%	} %>
			</div>
			<div>
				<label for="userbirth">생년월일</label>
				<input class="form-control" type="text" name="userbirth" id="userbirth" value="<%=u.getUserBithdate()%>">
				<p></p>
			</div>
			<div class="form-inline">
			<%	String[] email = (u.getUserEmail()).split("@"); %>
				<label>이메일 입력</label>
				<div class="form-group">
					<label for="email1" class="sr-only">이메일1</label>
					<input class="form-control" type="text" name="useremail1" id="email1" data-idchk="fail" value="<%=email[0]%>">
				</div>
				<div class="form-group">
					<span>@</span>
				</div>
				<div class="form-group">
					<label for="email2" class="sr-only">이메일2</label>
					<input class="form-control" type="text" name="useremail2" id="email2" data-idchk="fail" value="<%=email[1]%>">
				</div>
				<div class="form-group">
					<label for="emailSelection" class="sr-only">선택</label>
					<select class="form-control" id="emailSelection" name="emailSelection">
							<option value="1" selected="selected">직접입력</option>
							<option value="gmail.com">gmail.com</option>
							<option value="naver.com">naver.com</option>
							<option value="hanmail.net">hanmail.net</option>
					</select>
				</div>
				<p id="msgEmail"></p>
				</div>
			<div>
				<label for="userphone">연락처</label>
				<input class="form-control" type="text" name="userphone" id="userphone" value="<%=u.getUserPhone()%>">
				<p></p>					
			</div>
			<div>
				<button type="submit" class="btn">수정</button>
				<button type="button" class="btn mt10" onclick="location.href='/'">취소</button>
			</div>
		</form>
		<button class="btn" onclick='location.href="/mypage/pwUpdate"'>비밀번호 변경</button>
	</div>
</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>