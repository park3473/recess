<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="../include/header.jsp" %>
</head>

<style>
	#bootstrap-data-table tr th{
	
	text-align: center;
	
	}
</style>

<body>
    <!--헤더-->
	<%@ include file="../include/menu.jsp" %>
    <!--헤더 end-->

    <!--본문-->
    <section id="adm_sc">
        <div id="adm_sc_area">
            <div id="adm_sc_con">
                <div class="adm_sc_size">

                    <!--본문 내용-->
                    <section class="adm_sc_txt">
                        <div class="sc_con">
                            <div class="title">
                                <span></span>
                                <span>상품 및 휴식 리스트</span>
                            </div>
                            
                            <!--관리자 버튼-->
                            <div class="page_seach">
                                <div class="adm_btn_wrap stats_btn_area">
                                    <ul>
	                                    <li class="delete">
	                                        <button onclick="selectAppend()">추가</button>
	                                    </li>
	                                </ul>
                                </div>
                            </div>
                            <!--관리자 버튼 end-->
                            <div class="table_wrap">
                                <table id="bootstrap-data-table">
                                    <tr>
                                        <th class="min_score">상품 최소 점수</th>
                                        <th class="max_score">상품 최대 점수</th>
                                        <th class="recess">휴식 시간</th>
                                        <th class="name">상품명</th>
                                        <th class="create_tm">생성일시</th>
                                        <th class="update_tm">수정일시</th>
                                        <th class="setting">비고</th>
                                    </tr>
                                    <c:forEach var="item" items="${model.list}" varStatus="status">
                                    <tr data-role="button" class="list_tr">
                                    	<td>${item.min_score }</td>
                                    	<td>${item.max_score }</td>
                                    	<td>${item.recess }</td>
                                        <td>${item.NAME }</td>
                                        <td>${item.TYPE }</td>
                                        <td>
                                            ${fn:substring(item.create_tm,0,11)}
                                        </td>
                                        <td>
                                            ${fn:substring(item.update_tm,0,11)}
                                        </td>
                                        <td>
                                        	<button type="button"  onclick="location.href='/admin/product/view.do?idx=${item.pro_idx}'" data-idx="${item.idx }">상품 보기</button>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </section>
                    <!--본문 내용 end-->
                </div>
            </div>
        </div>
    </section>
    <!--본문 end-->

    <!--푸터-->
    <footer>
	<%@ include file="../include/footer.jsp" %>
    </footer>
    <!--푸터 end-->

</body>
<script>

$(document).ready(function () {
	
	$(".adm_menu_con > li").eq(2).find(".sub_menu_con").show();
	$(".adm_menu_con > li").eq(2).css({
	    backgroundColor: "#fff"
	});
});

function selectOpen(){
	
	var url = '/admin/exam/product_list/select.do';
	
	window.open(url, '상품 추가', 'width=1600, height=500');
	
}

function selectAppend(){
	
	var html = ``;
	html += `<tr class="insert">`;
	html += `<td><input type="text" name="min_score" id="min_score" oninput="this.value = this.value.replace(/[^0-9]/g, '');" ></td>`;
	html += `<td><input type="text" name="max_score" id="max_score" oninput="this.value = this.value.replace(/[^0-9]/g, '');" ></td>`;
	html += `<td><input type="text" name="recess" id="recess" oninput="this.value = this.value.replace(/[^0-9]/g, '');" ></td>`;
	html += `<td><input type="text" name="" id="" readonly="readonly" placeholder="상품 선택 버튼을 클릭"></td>`;
	html += `<td colspan="3"><button type="button" onclick="selectOpen()">상품 선택</button></td>`
	html += `</tr>`
	$('#bootstrap-data-table').append(html);
	
	
}

</script>

</html>

