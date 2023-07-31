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
	<h2>해당 진단 을 완료하였습니다.</h2>
	<button type="button" onclick="exam_result_view()">검사결과 확인하기</button>
</div>

<div id="view">
	<form action="/view/exam/result_view.do" method="POST">
		<input type="text" name="idx" value="${model.before.idx }">
		<input type="text" name="name" value="${model.before.name }">
		<input type="text" name="phone" value="${model.before.phone }">
		<input type="text" name="exam_idx" value="${model.before.exam_idx }">
	</form>
</div>


<!--공통하단-->
<%@ include file="../../include/user/footer.jsp" %>
<script type="text/javascript">

function exam_result_view(){
	
	$('#view form').submit();
	
}

</script>