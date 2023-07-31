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
	<c:forEach var="item" items="${model.ProductList }">
		<ul>
			<li>최소 점수 : ${item.min_score }</li>
			<li>최대 점수 : ${item.max_score }</li>
			<li>상품명 : ${item.NAME }</li>
			<li>상품이미지 : <button type="button" onclick="image_view('${item.IMAGE}')">상품이미지 보기</button></li>
			<li>휴식시간 : ${item.recess }</li>
		</ul>
	</c:forEach>
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

</script>