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
	<ul>
		<li>이름 : <input type="text" name="name"></li>
		<li>핸드폰 : <input type="text" name="phone" placeholder="-제외한 010부터 숫자만 입력해주세요." oninput="this.value = this.value.replace(/[^0-9]/g, '');"></li>
	</ul>
	<button type="button" onclick="result_list()">확인</button>
</div>

<!--공통하단-->
<%@ include file="../../include/user/footer.jsp" %>
<script type="text/javascript">

function result_list(){
	
	location.href='/view/exam/result_list.do?name='+$('[name=name]').val()+'&phone='+$('[name=phone]').val()+'';
	
}

</script>