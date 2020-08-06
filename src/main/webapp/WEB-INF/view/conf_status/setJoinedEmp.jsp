<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>회의현황/직원검색</title>
</head>

<body>

<form name="mainFrm" method="post" action="sel_script">
회의현황/직원검색

<div class="div_normal">
    <div class="text_center">
        찾기
        <select id="schSel" name="schSel">
            <option value="">--선택--</option>
            <option value="name">이름</option>
            <option value="part">부서</option>
            <option value="position">직급</option>
            <option value="empNo">사번</option>
        </select>
        <input type="text" id="schWord" name="schWord"> <input type="button" value="검색" onclick="goSch()">
    </div>
    <div class="pd_mg_top">
        <table class="table">
            <tr>
                <th></th><th>이름</th><th>부서</th><th>직급</th><th>사번</th>
            </tr>
<c:choose>
    <c:when test="${fn:length(userList) gt 0}">
        <c:forEach items="${userList}" var="list" varStatus="status">
            <tr>
                <td><input type="checkbox" name="chkBoxes" value="${list.minutes_employee_ser},${list.name}" onclick="clickedChk('${list.minutes_employee_ser}', '${list.name}');"></td>
                <td>${list.name}</td>
                <td>${list.part}</td>
                <td>${list.position}</td>
                <td>${list.minutes_employee_ser}</td>
            </tr>
        </c:forEach>
    </c:when>
    <c:otherwise>
            <tr>
                <td colspan="5">검색 결과가 없습니다.</td>
            </tr>
    </c:otherwise>
</c:choose>
        </table>
    </div>

    <div class="text_center">
    <%@ include file="../common/paging.jsp" %>
    </div>

    <div class="pd_mg_top text_right">
        <input type="button" value="Cancel" onclick="cancel();">
        <input type="button" value="OK" onclick="saveOK();">
    </div>
</div>

<input type="hidden" id="site_ser" name="site_ser" value="${frontConfVO.site_ser}">
<input type="hidden" id="currentPage" name="currentPage" value="${frontConfVO.currentPage}">
<input type="hidden" id="clickedName" name="clickedName">
<input type="hidden" id="clickedId" name="clickecId">

</form>

</body>

<script type="text/javascript" src="/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    let schSel = '<c:out value="${frontConfVO.schSel}" />';
    let schWord = '<c:out value="${frontConfVO.schWord}" />';

    $('#schSel').val(schSel);
    $('#schWord').val(schWord);
});

//조회
function goSch(){
    let schSel = $('#schSel').val();
    let schWord = $('#schWord').val();

    if( schWord.length > 2 && schSel.length < 1 ){
        alert("검색 조건을 선택하시기 바랍니다.");
        $('#schSel').focus();
        return false;
    }
    if( schWord.length > 0 && schWord.length < 2){
        alert("검색어는 최소 2자이상 입력해 주시기 바랍니다.");
        $('#schWord').val("");
        $('#schWord').focus();
        return false;
    }

    mainFrm.method = "POST";
    mainFrm.action = "/setJoinEmp";
    mainFrm.submit();
}


//체크박스 클릭
function clickedChk(ser, name){
    let clickedId = $('#clickedId').val();
    let clickedName = $('#clickedName').val();

    if( clickedId.length < 1 ){
        $('#clickedId').val(ser);
    }else{
        $('#clickedId').val( clickedId + "," + ser );
    }

    if( clickedName.length < 1 ){
        $('#clickedName').val(name);
    }else{
        $('#clickedName').val( clickedName + "," + name );
    }
}

//페이지 이동
function goPage(num){
    $('#currentPage').val(num);

    goSch();
}

//OK버튼 클릭. 부모창에 값 이동
function saveOK(){
    let valArr = [];
    let checkedName = "";
    let checkedId = "";

    $('input:checkbox[name=chkBoxes]:checked').each(function(){
        valArr = $(this).val().split(",");

        if(checkedId.length < 1){
            checkedId = valArr[0];
        }else{
            checkedId = checkedId + "," + valArr[0];
        }
        if(checkedName.length < 1) {
            checkedName = valArr[1];
        }else{
            checkedName = checkedName + "," + valArr[1];
        }
    });

    let selectedName = window.opener.document.getElementById('confJoinedEmpName');
    let selectedId = window.opener.document.getElementById('confJoinedEmpId');

    selectedName.value = checkedName;
    selectedId.value = checkedId;

    alert(checkedName + "이 선택되었습니다.");
    self.close();
}
function cancel(){
    self.close();
}
</script>

<style type="text/css">
.div_normal {
    position: relative;
    width: 95%;
    /*height: 800px;*/
    margin: 10px 10px 10px 10px;
    align: center;
}
.tbl{
    display: table;
    width: 100%;
    border: 1px solid black;
 }
.row{
    display: table-row;
    width: 100%;
    height: 30px;
    /*border: 1px solid black;*/
 }
.cell{
    display: table-cell;
    /*border: 1px solid black;*/
    vertical-align: middle;
    margin: 5px 5px 5px 5px;
    padding-top: 5px;
}
.tbl_w_no{
    display: table;
    border: 1px solid black;
}
.row_w_no{
    display: table-row;
}
.cell_w_50{
    display: table-cell;
    width: 50px;
}
.text_center{
    text-align: center;
}
.text_right{
    text-align: right;
}
.pd_mg_top{
    padding-top: 5px;
    margin-top: 5px;
}
.pd_mg_bottom{
    padding-top: 5px;
    margin-top: 5px;
}
table{
    width: 100%;
    border: 1px solid black;
}
tr{
    border: 1px solid black;
}
td{
    vertical-align: middle;
    text-align: center;
}
</style>

</html>
