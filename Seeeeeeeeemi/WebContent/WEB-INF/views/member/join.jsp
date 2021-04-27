<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
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
       if ((uname.value) == ""){
           alert("이름을 입력하지 않았습니다.");
           uname.focus();
           return false;
       }
       //이름 유효성검사
       if (!check(regul3,uname,"이름이 잘못 되었습니다.")) {
           return false;
       }
       
       //닉네임을 입력하지 않았을경우
       if ((unick.value) == ""){
           alert("닉네임을 입력하지 않았습니다.");
           unick.focus();
           return false;
       }
       
       //닉네임 검증
       if (!check(regul3,unick,"닉네임이 잘못 되었습니다.")) {
           return false;
       }
       
       //비밀번호 입력 하지 않았을 경우
       if ((upw.value) == ""){
           alert("비밀번호를 입력해 주세요");
           upw.focus();
           return false;
       }
       if ((upwchk.value=="")){
           alert("비밀번호를 다시 확인하고 입력해 주세요");
           upwchk.focus();
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
       
       //성별을 입력 안했을 경우
       if ((ugender.value) == ""){
           alert("성별을 선택해주세요");
           ugender.focus();
           return false;
       }
       
       //생년월일을 입력 안했을 경우 
       if ((ubirth.value) == ""){
           alert("생년월일을 선택해주세요");
           ubirth.focus();
           return false;
       }
       
       //생년월일 검증
       if (!check(regul4,ubirth,"생년월일이 잘못되었습니다 ")) {
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
       
       
		//핸드폰번호 입력 안했을 경우
       if ((uphone.value)=="") {
           alert("핸드폰번호를 입력해 주세요");
           uphone.focus();
           return false;
       }
       if (!uphone(regul5,uphone,"핸드폰번호를 잘못입력하셨습니다")) {
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



<div class="inner">
	<div class="joinform">
		<H1>회원가입</H1>
		<hr>
		<form action="/join" method="post" onsubmit="return validate()">
			<div>
				<label for="uid">아이디</label>
				<button class="btn" type="button" id="uidchk">중복검사</button>
				<input type="text" id="uid" name="uid" data-idchk="fail">
				<p id="msgId"></p>
			</div>
			<div>
				<label for="uname">이름</label>
				<input type="text" id="uname" name="uname">
				<p></p>
			</div>
			<div>
				<label for="unick">닉네임</label>
				<input type="text" id="unick" name="unick">
				<p></p>
			</div>
			<div>
				<label for="upw">비밀번호 입력</label>
				<input type="password" id="upw" name="upw">
				<p></p>
			</div>
			<div>
				<label for="upwchk">비밀번호 확인</label>
				<input type="password" id="upwchk">
				<p></p>
			</div>
			<div>
				<label for="ugender">성별</label>
				<input type="radio" name="ugender" id="ugender" value="M">남
				<input type="radio" name="ugender" id="ugender" value="F">여
				<p></p>
			</div>
			<div>
				<label for="ubirth">생년월일</label>
				<input type="text" name="ubirth" id="ubirth" placeholder="20010101">
				<p></p>
			</div>
			<div>
				<label for="uemail">이메일 입력</label>
				<button class="btn" type="button" id="uemailchk">중복검사</button>
				<input type="text" name="uemail" id="uemail" data-idchk="fail">
				<p id="msgEmail"></p>
			</div>
			<div>
				<label for="uphone">연락처</label>
				<input type="text" name="uphone" id="uphone" placeholder="01000000000">
				<p></p>					
			</div>
			<div>
				<button type="submit" class="btn">회원가입완료</button>
				<button type="button" class="btn mt10" onclick="location.href='/'">취소</button>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">

$(function() {
    //id중복검사 
    $("#uidchk").click(function() {
    	//아이디 입력 하지 않았을 경우
        if ((uid.value) == ""){
            alert("아이디를 입력하지 않았습니다.");
            uid.focus();
            return false;
        }
        //아이디 유효성 검사
        if (!check(/^[a-zA-Z0-9]{4,12}$/,uid,"아이디는 4~12자의 대소문자와 숫자로만 입력 가능합니다.")) {
            return false;
        } 
    	
        var id =  $("#uid").val(); 
        
        $.ajax({
            type:'post',
            async:false, //false가 기본값임 - 비동기
            url:'/idcheck',
            dataType:'json',
            data:{id:id},
            success: function(data) { 
                if( data ) {
                	$('#msgId').text("이미 사용 중인 아이디입니다.")
                    $('#msgId').removeClass("blue");
                	$('#uid').val("");
                	$('#uid').focus();
               	    $('#uid').attr("data-idchk", "fail");
                } else {
                    $('#msgId').text("사용할 수 있는 ID입니다.");
                    $('#msgId').addClass("blue");
                    $('#uidchk').addClass("blue")
                    $('#uid').attr("data-idchk", "success");
                }
            },
            error:function (data, textStatus) {
                console.log('error');
            }
        })    //ajax
    });
    
 
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
<%@include file="/WEB-INF/views/layout/footer.jsp" %>