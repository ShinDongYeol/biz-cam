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
회의결과
<p>&nbsp;</p>

<div class="div_normal">

    <%@ include file="../common/leftMenu.jsp" %>

    <div class="div_right">
        <div class="div_middle">
            <div class="div_middle">
                <table width="95%">
                    <tr>
                        <td>회의명</td>
                        <td><input type="text" id="confName" name="confName"></td>
                        <td>회의룸</td>
                        <td><input type="text" id="confRoom" name="confRoom"></td>
                        <td>회의일자</td>
                        <td>
                            <div id="picker"></div>
                            <input type="hidden" id="confDateStart" name="confDateStart" size="8">
                            ~
                            <div id="picker2"></div>
                            <input type="hidden" id="confDateEnd" name="confDateEnd" size="8">
                        </td>
                        <td rowspan="2">
                            <input type="button" onclick="goSch()" value="조회">
                            <p></p>
                            <input type="button" onclick="doInit()" value="초기화">
                        </td>
                    </tr>
                    <tr>
                        <td>참석자</td>
                        <td><input type="text" id="joinedMem" name="joinedMem"></td>
                        <td>메모내용</td>
                        <td><input type="text" id="confMemo" name="confMemo"></td>
                        <td>선택추가</td>
                        <td><input type="text" id="other" name="other"></td>
                    </tr>
                </table>
            </div>

            <div class="tbl_100">
                <div class="row">
                    <div class="head_cell">회의명</div>
                    <div class="head_cell">회의룸</div>
                    <div class="head_cell">참석인수</div>
                    <div class="head_cell">회의일시</div>
                    <div class="head_cell">시작시간</div>
                    <div class="head_cell">종료시간</div>
                    <div class="head_cell">녹음길이</div>
                    <div class="head_cell">회의록 내용</div>
                </div>
            <c:forEach items="${resultList}" var="rList" varStatus="status">
                <div class="row">
                    <div class="cell">${rList.minutes_name}</div>
                    <div class="cell">${rList.meetingroom_name}</div>
                    <div class="cell">
                        <span class="field-tip">
                            ${rList.minutes_joined_cnt} <img src="/img/icon_magnifier.jpg" width="15px" height="15px">
                            <span class="tip-content">${rList.minutes_joined_mem}</span>
                        </span>
                    </div>
                    <div class="cell">${rList.minutes_start_date}</div>
                    <div class="cell">${rList.rec_start_time}</div>
                    <div class="cell">${rList.rec_end_time}</div>
                    <div class="cell">${rList.rec_time}</div>
                    <div class="cell">
                        <input type="button" value="재생" onclick="goScriptView('${rList.stt_meta_ser}', 'RT');">
                        /
                        <input type="button" value="편집" onclick="goScriptView('${rList.stt_meta_ser}', 'REC');">
                    </div>
    <%--                <div class="cell">${mainList.update_time}</div>--%>
    <%--                <div class="cell">--%>
    <%--                    <input type="button" value="수정" onclick="javascript:editUser('${mainList.minutes_user_ser}')">--%>
    <%--                </div>--%>
                </div>
            </c:forEach>
            </div>
        </div>

        <div class="div_bottom">
            <div class="tbl_100">
                <div class="row">
                    <div class="paging row">
                        <%@ include file="../common/paging.jsp" %>
                    </div>
                </div>
            </div>
        </div>

        <input type="hidden" id="currentPage" name="currentPage" value="${frontConfVO.currentPage}">

        <input type="hidden" id="meta_ser" name="meta_ser">
    </div>
</div>

</form>

</body>

<link type="text/css" rel="stylesheet" href="/css/datetimepicker.css"></link>
<script type="text/javascript" src="/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/js/moment-with-locales.min.js"></script>
<script type="text/javascript" src="/js/datetimepicker.js"></script>
<script type="text/javascript">
$(document).ready( function () {
    $('#picker').dateTimePicker();
    // $('#picker').dateTimePicker({ showTime: false, dateFormat: 'YYYY/MM/DD'});

    $('#picker2').dateTimePicker();
    // $('#picker2').dateTimePicker({ showTime: false, dateFormat: 'YYYY/MM/DD'});
});

//조회 버튼
function goSch(){
    mainFrm.method = "POST";
    mainFrm.action = "/confResult";
    mainFrm.submit();
}

//페이지 이동
function goPage(num){
    $('#currentPage').val(num);

    goSch();
}

//초기화 버튼
function doInit(){
    alert("초기화 버튼 클릭");

    $('#confName').val("");
    $('#confRoom').val("");
    $('#confDateStart').val("");
    $('#confDateEnd').val("");
    $('#joinedMem').val("");
    $('#confMemo').val("");
    $('#other').val("");
}

//돋보기 아이콘에  마우스 오버
function viewJoinedMem(num){
    alert("### vjm:" + num);
}

// 재생 or 편집 버튼 클릭
function goScriptView(ser, part){
    console.log("### ser:" + ser + ",   part:" + part);
    let url = "rt_script"

    if( part == 'REC'){
        url = "rec_script";
    }

    $('#meta_ser').val(ser);

    mainFrm.method = "POST";
    mainFrm.action = url;
    mainFrm.submit();

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
