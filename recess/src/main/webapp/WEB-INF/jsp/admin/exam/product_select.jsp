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

    <!--본문-->
    <section id="adm_sc">
        <div id="adm_sc_area">
            <div id="adm_sc_con">
                <div class="adm_sc_size">

                    <!--본문 내용-->
                    <section class="adm_sc_txt" style="width:auto !important">
                    	<input type="hidden" id="btnNum" value="">
                        <div class="sc_con">
                            <div class="title">
                                <span></span>
                                <span>상품 관리</span>
                            </div>
                            <div class="table_wrap">
                                <table id="bootstrap-data-table">
                                    <tr>
                                        <th class="number">번호</th>
                                        <th class="name">상품명</th>
                                        <th class="image">이미지</th>
                                        <th class="create_tm">생성일시</th>
                                        <th class="update_tm">수정일시</th>
                                        <th class="setting">비고</th>
                                    </tr>
                                    <c:forEach var="item" items="${model.list}" varStatus="status">
                                    <tr data-role="button" data-id="${item.idx}"  >
                                        <td>${model.itemtotalcount - (status.index + model.page *  model.itemcount)}</td>
                                        <td>${item.name }</td>
                                        <td><button type="button" onclick="image_view('${item.image}')">이미지 보기</button></td>
                                        <td>
                                            ${fn:substring(item.create_tm,0,11)}
                                        </td>
                                        <td>
                                            ${fn:substring(item.update_tm,0,11)}
                                        </td>
                                        <td>
                                        	<button type="button" onclick="selectProduct(this)" data-idx="${item.idx }" data-name="${item.name }" >선택</button>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>

                            <!--관리자 버튼-->
                            <div class="page_seach">
                                <div>
                                    <select id="SEARCH_TYPE" name="SEARCH_TYPE">
                                        <option value="ALL">전체</option>
                                        <option value="name" <c:if test="${model.before.SEARCH_TYPE == 'name'}">selected</c:if>>이름</option>
                                    </select>
                                    <input style="width: 191px;" type="text" value="${model.before.SEARCH_TEXT }" name="SEARCH_TEXT" id="SEARCH_TEXT" >
                                    <button type="button" value="검색" onClick="searchBtnClick()">검색</button>
                                </div>
                                <div class="adm_btn_wrap stats_btn_area">
                                    <ul>
                                    <li class="delete">
                                        <a href="./insert.do">상품 등록</a>
                                    </li>
                                </ul>
                                </div>
                            </div>

                            <!--관리자 버튼 end-->


                            <!--페이지 넘버-->
                            <nav class="paging_number">
                                <ul class="page">
                                   <%@ include file="../include/pageing.jsp" %>
                                </ul>
                            </nav>
                            <!--페이지 넘버 end-->
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

function searchBtnClick(){
	
	 URL = './list.do';
     URL = URL + "?PAGE=0";
     URL = URL + "&ITEM_COUNT=" + '5';

     URL = URL + "&SEARCH_TEXT=" + encodeURI($('#SEARCH_TEXT').val());
     URL = URL + "&SEARCH_TYPE=" + $('#SEARCH_TYPE').val();

	location.href = URL;
	
}

$(document).ready(function () {
	
	$(".adm_menu_con > li").eq(3).find(".sub_menu_con").show();
	$(".adm_menu_con > li").eq(3).css({
	    backgroundColor: "#fff"
	});
});

function image_view(image_name){
	
	Swal.fire({
		  title: '',
		  html: '<img style="width:100%" src="/resources/upload/product/image/'+image_name+'" alt="상품이미지">',
		  showCloseButton: true,
		  showConfirmButton : false,
		}).then((result) => {
		  // 닫기 버튼 클릭 시 처리할 로직 작성
		  console.log('닫기 버튼이 클릭되었습니다.');
		});
	
}

function selectProduct(e){

	var pro_idx = $(e).attr('data-idx');
	var name = $(e).attr('data-name');
	
	console.log('pro-idx : ' + pro_idx);
	console.log('name : ' + name);

	var btnNum = $('#btnNum').val();
	
	console.log('btnNum : ' + btnNum);
	
	opener.$('#in_'+btnNum+' [name=pro_idx]').val(pro_idx);
	opener.$('#in_'+btnNum+' [name=name]').val(name);
	
	window.close();
	
}

</script>

</html>