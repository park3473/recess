<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--삭제금지-->
<script src="${pageContext.request.contextPath}/resources/sweetalert/jquery-1.12.4.js"></script>
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
<script src="${pageContext.request.contextPath}/resources/js/time_main.js"></script>

<!--공통 헤더 시작-->
<%@ include file="../../include/user//header.jsp" %>
<%@ include file="../../include/user/menu.jsp" %>
<style>
	tbody tr{
	border :1px solid black;
	}
</style>

<div>
	<h2>진단 결과</h2>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>핸드폰</th>
				<th>휴게소</th>
				<th>점수</th>
				<th>선택 상품</th>
				<th>참여 날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${model.list }" varStatus="status">
				<tr onclick="location.href='/view/exam/result_view.do?name=${item.name}&phone=${item.phone }&idx=${item.idx }&exam_idx=${item.exam_idx }'">
					<td>${status.index + 1 }</td>
					<td>${item.name }</td>
					<td>${item.phone }</td>
					<td>${item.place }</td>
					<td>${item.score }</td>
					<td>${item.video }</td>
					<td>${fn:substring(item.create_tm , 0, 11) }</td>
				</tr>
			</c:forEach>
			
		</tbody>
	</table>
</div>

<!--공통하단-->
<%@ include file="../../include/user/footer.jsp" %>
<script type="text/javascript">



</script>
