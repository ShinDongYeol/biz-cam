<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Title</title>
</head>
<body>

<form name="mainFrm" method="post" action="sel_script">
치환 사전...
<p>&nbsp;</p>

<div class="div_normal">

    <%@ include file="../common/leftMenu.jsp" %>

    <div class="div_right">
        <div class="div_middle">
            <div class="div_middle">
                <table width="50%">
                    <tr>
                        <td>검색어 :</td>
                        <td><input type="text" id="schWord" name="schWord" value="${frontDicVO.schWord}"></td>
                        <td><input type="button" id="schBtn" name="schBtn" onclick="goSch();" value="검색"></td>
                    </tr>
                </table>
            </div>
            <div class="tbl_50">
                <div class="row">
                    <div class="head_cell">치환 전</div>
                    <div class="head_cell">치환 후</div>
                </div>
    <c:choose>
        <c:when test="${fn:length(dicList) gt 0}">
            <c:forEach items="${dicList}" var="dList" varStatus="status">
                <div class="row">
                    <div class="cell">${dList.before_word}</div>
                    <div class="cell">${dList.after_word}</div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
                <div class="row">단어가 없습니다.</div>
        </c:otherwise>
    </c:choose>
            </div>
        </div>

        <div class="div_bottom">
            <div class="tbl_50">
                <div class="row">
                    <div class="paging row">
                        <%@ include file="../common/paging.jsp" %>
                    </div>
                </div>
            </div>
        </div>

        <input type="hidden" id="currentPage" name="currentPage" value="${frontDicVO.currentPage}">

    </div>
</div>


</form>

</body>

<script type="text/javascript" src="/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
//조회, 검색
function goSch(){
    mainFrm.method = "POST";
    mainFrm.action = "/dicReplace";
    mainFrm.submit();
}

//페이지 이동
function goPage(num){
    $('#currentPage').val(num);

    goSch();
}
</script>

<style type="text/css">
.div_normal{
    position: absolute;
    width: 100%;
    height: 1000px;
    margin: 20px 20px 20px 20px;
}
.div_left{
    position: absolute;
    width: 10%;
    left:0;
    margin: 0px;
}
.div_right{
    position: absolute;
    width: 90%;
    right: 0;
    margin: 5px 5px 5px 0px;
}
.div_box_s{
    position: relative;
    display: table;
    width: 100%;
    margin-top: 20px;
    margin-bottom: 20px;
    vertical-align: middle;
    text-align: center;
    border: 1px solid black;
}

.div_middle {
    display: table;
    width: 100%;
    vertical-align: middle;
    text-align: center;
    margin-bottom: 20px;
}

.div_bottom{
    display: table;
    width: 100%;
    vertical-align: middle;
}

.line_left{
    text-align: left;
    padding: 10px 10px 10px 10px;
}

.tbl{
    display: table;
}
.tbl_100{
    display: table;
    width: 95%;
}
.tbl_50{
    display: table;
    width: 50%;
}
.row{
    display: table-row;
    padding: 0px 0px 0px 0px;
    margin: 0px 0px 0px 0px;
}

.head_cell{
    display: table-cell;
    padding: 0px 5px;
    height: 50px;
    border: 1px solid black;
    vertical-align: middle;
    text-align: center;
    font-weight: bold;
}

.cell{
    display: table-cell;
    padding: 0px 0px 0px 0px;
    margin: 0px 0px 0px 0px;
    height: 50px;
    border: 1px solid black;
    vertical-align: middle;
    text-align: center;
}
.np_cell{
    display: table-cell;
    padding: 0px 0px 0px 0px;
    margin: 0px 0px 0px 0px;
    vertical-align: middle;
    text-align: center;
}
.merged{
    display: table-cell;
    padding: 0px 0px 0px 0px;
    margin: 0px 0px 0px 0px;
    width: 200px;
    border: 1px solid black;
}
.row.paging{
    display: inline-block;
    width: 100%;
    text-align: center;
    margin-bottom: 20px;
}
.field-tip {
    position:relative;
}
.field-tip .tip-content {
    position:absolute;
    top:-22px; /* - top padding */
    right:9999px;
    width:200px;
    margin-right:-220px; /* width + left/right padding */
    padding:10px;
    color:#fff;
    background:#333;
    -webkit-box-shadow:2px 2px 5px #aaa;
    -moz-box-shadow:2px 2px 5px #aaa;
    box-shadow:2px 2px 5px #aaa;
    opacity:0;
    -webkit-transition:opacity 250ms ease-out;
    -moz-transition:opacity 250ms ease-out;
    -ms-transition:opacity 250ms ease-out;
    -o-transition:opacity 250ms ease-out;
    transition:opacity 250ms ease-out;
}
.field-tip .tip-content:before {
    content:' '; /* Must have content to display */
    position:absolute;
    top:50%;
    left:-16px; /* 2 x border width */
    width:0;
    height:0;
    margin-top:-8px; /* - border width */
    border:8px solid transparent;
    border-right-color:#333;
}
.field-tip:hover .tip-content {
    right:-20px;
    opacity:1;
}
</style>

</html>
