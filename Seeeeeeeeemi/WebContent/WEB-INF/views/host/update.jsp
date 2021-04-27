<%@page import="dto.RoomImg"%>
<%@page import="java.util.List"%>
<%@page import="dto.Room"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<% Room updateRoom = (Room) request.getAttribute("updateRoom");%>
<% List<RoomImg> imgList = (List) request.getAttribute("imgList"); %>

<!-- 다음지도 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	//수정버튼 동작
	$("#btnUpdate").click(function() {
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
	
	//===미리보기=== 
	$("input[name='file1']").change(function(e){ preview(e, ".preview1") })
	$("input[name='file2']").change(function(e){ preview(e, ".preview2") })
	$("input[name='file3']").change(function(e){ preview(e, ".preview3") })
	$("input[name='file4']").change(function(e){ preview(e, ".preview4") })
	$("input[name='file5']").change(function(e){ preview(e, ".preview5") })
	
	//편의시설 버튼 클릭 이벤트
	$(".fac-btn").click(function() {
		if($(this).hasClass('btn-default')){
			$(this).removeClass('btn-default');
			$(this).addClass('btn-info');
		} else if ($(this).hasClass('btn-info')){
			$(this).removeClass('btn-info');
			$(this).addClass('btn-default');
		}
	})
	
	//숙소유형 불러오기
	$("option[value='<%=updateRoom.getRoomType()%>']").attr("selected", "selected");
});
//파일 삭제시  미리보기 초기화
function fileReset(input, preview) {
	var agent = navigator.userAgent.toLowerCase();
	if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
	    $(input).replaceWith($(input).clone(true));
	}else{
	    $(input).val("");
	}
	$(preview).empty();
}
//미리보기 
function preview(e, p){
	var files = e.target.files;
	//이미지만 처리할 수 있도록 적용
	if( !files[0].type.includes("image")){
		alert("이미지가 아닙니다.")
		e.target.value = null;
		return false;// 이벤트 처리 중단
	}

	var reader = new FileReader();

	reader.onload = function(ev) {
		//미리보기 구현
		$(p).html(
				$("<img>").attr({
					"src": ev.target.result
					, "width": "150"
					, "height": "100"
				})
			)
		}
	
	reader.readAsDataURL(files[0])

}
//입력 여부 확인
function checkForm() {
	if( !$("input[name=roadAddress]").val() ) {
		alert('주소검색을 해주세요.');
		return false;
	} else if ( !$("input[name=detailAddress]").val() ) {
		alert('상세주소를 입력하세요.');
		$("input[name=detailAddress]").focus();
		return false;
	} else if ( !$("input[name=roomName]").val() ) {
		alert('숙소명을 입력하세요.');
		$("input[name=roomName]").focus();
		return false;
	} else if ( !$("input[name=roomGuests]").val() ) {
		alert('최대숙박인원을 입력하세요.');
		$("input[name=roomGuests]").focus();
		return false;
	} else if ( !$("input[name=roomBedroom]").val() ) {
		alert('침실 수를 입력하세요.');
		$("input[name=roomBedroom]").focus();
		return false;
	} else if ( !$("input[name=roomBed]").val() ) {
		alert('침대/침구류 수를 입력하세요.');
		$("input[name=roomBed]").focus();
		return false;
	} else if ( !$("input[name=roomBathroom]").val() ) {
		alert('욕실 수를 입력하세요.');
		$("input[name=roomBathroom]").focus();
		return false;
	} else if ( !$("input[name=price]").val() ) {
		alert('1박당 비용을 입력하세요.');
		$("input[name=price]").focus();
		return false;
	} else if ( !$("textarea[name=roomDesc]").val() ) {
		alert('숙소 설명을 입력하세요.');
		$("textarea[name=roomDesc]").focus();
		return false;
	}
}
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

<div class="container" style="min-height: 1000px">
<h3>숙소 수정하기</h3>
<hr>
<div class="row">
<div class="col-md-7">
<form class="form-horizontal" action="/host/roomupdate?roomno=<%=updateRoom.getRoomNo() %>" method="post" enctype="multipart/form-data" onsubmit="return checkForm();">

<!-- 장소 -->
<div class="form-group">
	<label class="col-sm-3 control-label">주소</label>
	<div class="col-sm-9">
	<input type="button" class="btn btn-default" onclick="sample4_execDaumPostcode()" value="주소 검색">
	</div>
</div>
<!-- <div class="form-group">
	<label class="col-sm-3 control-label"></label>
	<div class="col-sm-9">
	<input class="form-control" type="text" id="sample4_postcode" placeholder="우편번호" readonly>
	</div>
</div> -->
<div class="form-group">
	<label class="col-sm-3 control-label"></label>
	<div class="col-sm-9">	
	<input class="form-control" type="text" id="sample4_roadAddress"
	 placeholder="도로명주소" name="roadAddress" readonly="readonly" value="<%=updateRoom.getRoomRoadAddress() %>">
	</div>
</div>
<div class="form-group">
	<label class="col-sm-3 control-label"></label>
	<div class="col-sm-9">
	<input class="form-control" type="text" id="sample4_detailAddress"
	 placeholder="상세주소" name="detailAddress" value="<%=updateRoom.getRoomDetailedAddress() %>">
	</div>
</div>

<!-- 숙소정보 -->
<div class="form-group">
	<label class="col-sm-3 control-label" for="roomName">등록할 숙소명</label>
	<div class="col-sm-9">
	<input class="form-control" type="text" name="roomName" id="roomName" maxlength="100" value="<%=updateRoom.getRoomName() %>" >
	</div>
</div>
<div class="form-group">
	<label class="col-sm-3 control-label" for="roomName">숙소 유형</label>
	<div class="col-sm-9">
	<select class="form-control" id="roomTypes" name="roomType">
	    <option value="아파트">아파트</option>
	    <option value="주택">주택</option>
	    <option value="료칸">료칸</option>
	    <option value="콘도">콘도</option>
	    <option value="호텔">호텔</option>
	</select>
	</div>
</div>
<div class="form-group">
	<label class="col-sm-3 control-label" for="roomGuests">최대숙박인원</label>
	<div class="col-sm-9">
	<input class="form-control" type="number" name="roomGuests" id="roomGuests" min="0"
	 value="<%=updateRoom.getRoomGuests()%>"/>
	</div>
</div>
<div class="form-group">
	<label class="col-sm-3 control-label" for="roomBedroom">침실 수</label>
	<div class="col-sm-9">
	<input class="form-control" type="number" name="roomBedroom" id="roomBedroom" min="0"
	 value="<%=updateRoom.getRoomBedroom()%>"/>
	</div>
</div>
<div class="form-group">
	<label class="col-sm-3 control-label" for="roomBed">침대/침구류 수</label>
	<div class="col-sm-9">
	<input class="form-control" type="number" name="roomBed" id="roomBed" min="0"
	 value="<%=updateRoom.getRoomBed()%>"/>
	</div>
</div>
<div class="form-group">
	<label class="col-sm-3 control-label" for="roomBathroom">욕실 수</label>
	<div class="col-sm-9">
	<input class="form-control" type="number" name="roomBathroom" id="roomBathroom" min="0"
	 value="<%=updateRoom.getRoomBathroom()%>"/>
	</div>
</div>
<div class="form-group">
	<label class="col-sm-3 control-label" for="roomprice">1박당 숙박비(&#8361;)</label>
	<div class="col-sm-9">
	<input class="form-control" type="number" name="price" id="roomprice" min="0"
	 value="<%=updateRoom.getRoomPrice() %>"/>
	</div>
</div>
<div class="form-group">
	<label class="col-sm-3 control-label" for="roomDesc">숙소 설명</label>
	<div class="col-sm-9">
	<textarea class="form-control" name="roomDesc" id="roomDesc" rows="7" maxlength="1300">
	<%=updateRoom.getRoomDesc() %>
	</textarea>
	</div>
</div>
<br>
<!-- 편의시설 -->
<div class="form-group">
	<label class="col-sm-3 control-label">편의시설</label>
	<div class="btn-group-toggle col-sm-9" data-toggle="buttons">
		<label class="btn btn-default fac-btn">
			<input type="checkbox" name="facility" value="kitchen">주방
		</label>
		<label class="btn btn-default fac-btn">
			<input type="checkbox" name="facility" value="parking">주차장
		</label>
		<label class="btn btn-default fac-btn">
			<input type="checkbox" name="facility" value="wifi">무선인터넷
		</label>
		<label class="btn btn-default fac-btn">
			<input type="checkbox" name="facility" value="airConditioner">에어컨
		</label>
		<label class="btn btn-default fac-btn">
			<input type="checkbox" name="facility" value="pool">수영장
		</label>
		<label class="btn btn-default fac-btn">
			<input type="checkbox" name="facility" value="hairDryer">헤어드라이어
		</label>
		<label class="btn btn-default fac-btn">
			 <input type="checkbox" name="facility" value="amenity">필수품목
		</label>
		<label class="btn btn-default fac-btn">
			<input type="checkbox" name="facility" value="pet">애완동물가능
		</label>
	</div>

</div>
<!-- 기존 이미지 파일 -->
<div class="form-group">
	<label class="col-sm-3 control-label">기존 이미지파일</label>
	<div class="col-sm-9">
		<% for(RoomImg r : imgList) {%>
			<a href="/upload/<%=r.getRoomImgFilename() %>" download="<%=r.getRoomImgFilename() %>">
				<%=r.getRoomImgFilename().substring(0, r.getRoomImgFilename().length() -13) %> 
			</a>
		<% } %>
	</div>
</div>
<!-- 이미지 -->
<div class="form-group">
	<label class="col-sm-3 control-label">숙소 이미지<br>(** 첨부파일 추가시 기존 파일은 삭제됩니다.)</label>
	<div class="col-sm-9">
		<input type="file" name="file1" accept="image/gif,image/jpeg,image/png"/><button class="btn1" type="button">X</button>
		<input type="file" name="file2" accept="image/gif,image/jpeg,image/png"/><button class="btn2" type="button">X</button>
		<input type="file" name="file3" accept="image/gif,image/jpeg,image/png"/><button class="btn3" type="button">X</button>
		<input type="file" name="file4" accept="image/gif,image/jpeg,image/png"/><button class="btn4" type="button">X</button>
		<input type="file" name="file5" accept="image/gif,image/jpeg,image/png"/><button class="btn5" type="button">X</button>
	</div>
</div>
<!-- 이미지 미리보기  -->
<div>
	<label class="col-sm-3 control-label"></label>
	<div class="imgBox col-sm-9">
		<div class="imgView preview1"></div>
		<div class="imgView preview2"></div>
		<div class="imgView preview3"></div>
		<div class="imgView preview4"></div>
		<div class="imgView preview5"></div>
	</div>
</div>
</form>
</div><!-- .col-md-8 end-->
</div><!-- .row end-->
</div> <!-- .container end  -->

<div class="text-center" style="margin: 15px;">
<button id="btnUpdate" class="btn btn-primary btn-lg">수정</button>
<span>&emsp;</span>
<button id="btnCancel" class="btn btn-danger btn-lg">취소</button>
</div>


<!-- 다음지도 주소찾기  -->
<script>
//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            /* if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            } */

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            /* document.getElementById('sample4_postcode').value = data.zonecode; */
            document.getElementById("sample4_roadAddress").value = roadAddr;
           /*document.getElementById("sample4_jibunAddress").value = data.jibunAddress; */
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            /* if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            } */

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            } 
        }
    }).open();
}
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>


