<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--삭제금지-->
<script src="${pageContext.request.contextPath}/resources/sweetalert/jquery-1.12.4.js"></script>
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->


<!--공통 헤더 시작-->
<%@ include file="../../include/user//header.jsp" %>
<%@ include file="../../include/user/menu.jsp" %>

<div>
	<h2>진단 결과</h2>
	<ul>
		<li>이름 : ${model.view.name }</li>
		<li>전화번호 : ${model.view.phone }</li>
		<li>점수 : ${model.view.score }</li>
		
	</ul>
	<h2>진단 상품</h2>
	<c:forEach var="item" items="${model.ProductList }" varStatus="status">
		<ul id="product_${status.index }">
			<li>최소 점수 : ${item.min_score }</li>
			<li>최대 점수 : ${item.max_score }</li>
			<li>상품명 : ${item.NAME }</li>
			<li>상품이미지 : <button type="button" onclick="image_view('${item.IMAGE}')">상품이미지 보기</button></li>
			<li>휴식시간 : ${item.recess }</li>
			<c:if test="${model.view.product == '' }">
				<li><button type="button" onclick="product_select('${item.NAME}' , '${item.pro_idx }')" >해당 상품 선택</button></li>
			</c:if>
		</ul>
	</c:forEach>
	<script>
	const ranges = [
        <c:forEach var="product" items="${model.ProductList}" varStatus="status">
            [${product.min_score}, ${product.max_score}]<c:if test="${not status.last}">,</c:if>
        </c:forEach>
    	];
		const a = ${model.view.score};
		let product;
		let found = false;
		for (let i = 0; i < ranges.length; i++) {
		  const range = ranges[i];
		  if (a >= range[0] && a <= range[1]) {
		    found = true;
		    product = i;
		    $('#product_'+product+'').attr('style','border : 1px solid #48aaff;background : aliceblue');
		  }
		}
	</script>
	<c:if test="${model.view.video == 'no' }">
		<button type="button" onclick="video_view()">버튼</button>
	</c:if>
</div>

<!--공통하단-->
<%@ include file="../../include/user/footer.jsp" %>
<script type="text/javascript">

//상품 이미지 보기
function image_view(image_name){
	
	Swal.fire({
		  title: '',
		  html: '<img style="width:100%" src="/resources/upload/product/image/'+image_name+'" alt="상품이미지">',
		  showCloseButton: true,
		}).then((result) => {
		  // 닫기 버튼 클릭 시 처리할 로직 작성
		  console.log('닫기 버튼이 클릭되었습니다.');
		});
	
}

function sms_test(){
	
	var Message = '메세지 테스트';
	var Phone = '01034733452';
	var Sms_type = 'L';
	var Type = '0';
	
	$.ajax({
		url : '/view/sms/send.do',
		type : 'POST',
		data : ({
			MESSAGE : Message,
			PHONE : Phone,
			SMS_TYPE : Sms_type,
			TYPE : Type
		}),
		success : function(xhr , status){
			console.log('success');
		},
		error : function(xhr , status , error){
			console.log('error');
		}
		
		
	})
	
}

function video_view() {
    Swal.fire({
        title : '영상을 시청하시겠습니까?',
        text : '영상을 시청하시겠습니까?',
        icon : 'question',
        showCancelButton : true,
        confirmButtonText : '예',
        cancelButtonText : '아니오'
    }).then((result) => {
        if(result.isConfirmed){
            Swal.fire({
                title: '영상 시청',
                html: '<video id="videoInSwal" width="100%" controls><source src="/resources/video/1.mp4" type="video/mp4">Your browser does not support the video tag.</video>',
                showCloseButton: true,
                showConfirmButton: false,
                focusConfirm: false,
                didOpen: () => {
                    const videoElement = document.getElementById('videoInSwal');
                    videoElement.play().catch(error => {
                        console.error("Video play failed: ", error);
                    });
                    videoElement.addEventListener('timeupdate', function() {
                        if(videoElement.currentTime === videoElement.duration) {
                            Swal.fire({
                                title: '점수가 추가되었습니다!',
                                text: '축하합니다! 영상 시청을 완료하셨습니다.',
                                icon: 'success',
                                confirmButtonText: '확인'
                            });
                        }
                    });
                }
            });
        }
    });
}




</script>