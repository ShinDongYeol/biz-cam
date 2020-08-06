<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="paging_wrap">
    <div class="paging">
        <a class="btn_paging_first" href="javascript:goPage('1')"><span class="fas fa-angle-double-left"><em>처음페이지</em></span> </a></a>
        <a class="btn_paging_prev" href="javascript:goPage('${paging.prevPage}')"><span class="fas fa-angle-left"><em>이전페이지</em></span></a>

        <c:forEach begin="${paging.pageRangeStart}" end="${paging.pageRangeEnd}" varStatus="loopIdx">

            <c:choose>
                <c:when test="${paging.currentPage eq loopIdx.index}">
                    <strong>${loopIdx.index}</strong>
                </c:when>
                <c:otherwise>
                    <a href="javascript:goPage('${loopIdx.index}')">${loopIdx.index}</a>
                </c:otherwise>
            </c:choose>

        </c:forEach>

        <a class="btn_paging_next" href="javascript:goPage('${paging.nextPage}')"><span class="fas fa-angle-right"><em>다음페이지</em></span></a>
        <a class="btn_paging_end" href="javascript:goPage('${paging.totalPage}')"><span class="fas fa-angle-double-right"><em>마지막페이지</em></span></a>

    </div>

</div>