<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
 
<%@include file="/WEB-INF/views/layout/header.jsp" %>

<link href="/resources/css/mypage.css" rel="stylesheet">

<script type="text/javascript">
	
    
   function validate() {

       //아이디와 패스워드 값 데이터 정규화 공식
       var regul1 = /^[a-zA-Z0-9]{4,12}$/;
      
       
       //비밀번호 입력 하지 않았을 경우
       if ((newpw.value) == ""){
           alert("비밀번호를 입력해 주세요");
           upw.focus();
           return false;
       }
       if ((upwchk.value == "")){
           alert("비밀번호를 다시 확인하고 입력해 주세요");
           upwchk.focus();
           return false;
       }
       
    	//아이디중복체크했는지 
     	if( curpw.getAttribute('data-idchk')=="fail"){
     		alert("비밀번호가 틀립니다.");
     		uid.focus();
     		return false;
     	}

       //비밀번호 유효성 검사
       if (!check(regul1,newpw,"비밀번호는 4~12자의 대소문자와 숫자로만 입력 가능합니다.")) {
           return false;
       }
       
       //비밀번호와 비밀번호 확인이 일치 하지 않을 경우
       if ((newpw.value)!=(upwchk.value)) {
           alert("비밀번호가 일치 하지 않습니다.");
           upw.focus();
           upwchk.focus();
           return true;
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

<div class="loginform">
	<h1>비밀번호 변경</h1>
	<hr>
	
	<form action="/mypage/pwUpdate" method="post" onsubmit="return validate()">
			<div>
				<label for="curpw">현재 비밀번호</label>			
				<input type="text" name="curpw" id="curpw" placeholder="현재 비밀번호를 입력하세요">
			</div>
			<div>
				<label for="newpw">새로운 비밀번호</label>
				<input type="password" name="newpw" id="newpw" placeholder="새 비밀번호를 입력하세요">
				<p></p>
			</div>
			<div>
				<label for="upwchk">비밀번호 확인</label>
				<input type="password" id="upwchk" placeholder="새 비밀번호 확인">
				<p></p>
			</div>
			<div>
				<button type="submit" class="btn" id="chpw">변경</button>
			</div>
	</form>
	<button type="button" class="btn mt10" onclick="history.go(-1)">취소</button>
</div>

</div>


<%@include file="/WEB-INF/views/layout/footer.jsp" %>