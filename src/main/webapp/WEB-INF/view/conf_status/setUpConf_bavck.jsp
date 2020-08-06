<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
    <!-- Cache reset -->
    <meta http-equiv="Expires" content="Mon, 06 Jan 2016 00:00:01 GMT"/>
    <meta http-equiv="Expires" content="-1"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Cache-Control" content="no-cache"/>

    <title>회의현황/회의설정</title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/all.css'/>" />
    <link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/font-awesome.min.css'/>" />
    <link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/bootstrap-datetimepicker.css'/>" />
</head>

<body>

<form name="mainFrm" method="post" action="sel_script">
회의현황/회의설정

<div class="div_normal">

    <div>
        <div class="tbl">
            <div class="row">
                <div class="cell text_center">회의명</div>
                <div class="cell"><input type="text" id="confName" name="confName" size="60"></div>
            </div>
            <div class="row">
                <div class="cell text_center">회의시간</div>
                <div class="cell">
<%--                    <input type="text" id="confTime" name="confTime" size="60">--%>
                    <div id="picker"></div>
                    <input type="hidden" id="confTime" name="confTime"/>
                </div>
            </div>
            <div class="row">
                <div class="cell text_center">안건</div>
                <div class="cell"><input type="text" id="confTopic" name="confTopic" size="60"></div>
            </div>
            <div class="row">
                <div class="cell text_center">참석자</div>
                <div class="cell"><input type="text" id="confJoinedEmpName" name="confJoinedEmpName" size="60" onclick="setJoinEmp();"></div>
            </div>
        </div>
    </div>
    <div class="pd_mg_top text_right">
        <input type="button" id="confBtnCancel" value="Cancel" onclick="cancel();">
        <input type="button" id="confBtnOk" value="OK" onclick="doConfSave();">
    </div>

    <div class="pd_mg_top">마이크 사용자</div>
    <div>
        <div class="tbl">
            <div class="row">
    <c:forEach items="${micList}" var="micList" varStatus="status">
                <div class="cell text_center">
                    <a href="javascript:micPop('${micList.minutes_mic_ser}', '${status.index}', '${frontConfVO.mrName}');">
                        <img src="<c:url value='/resources/images/icon_mic.png'/>" width="50" height="50">
                    </a>
                    <br>
                    <div id="mic${status.index}">
                    ${micList.mic_name}
                    </div>
                </div>
        <c:if test="${ (status.index + 1) % 4 eq 0 }">
            </div>
            <div class="row">
        </c:if>
    </c:forEach>
            </div>
        </div>
    </div>

    <div class="pd_mg_top text_right">
        <input type="button" id="confBtnClose" value="확인" onclick="doConfClose();">
    </div>

</div>

<!-- hidden. -->
<input type="hidden" id="site_ser" name="site_ser" value="${frontConfVO.site_ser}">
<input type="hidden" id="room_ser" name="room_ser" value="${frontConfVO.room_ser}">

<input type="hidden" id="confJoinedEmpId" name="confJoinedEmpId">

<input type="hidden" id="confSetUpYN" name="confSetUpYN" value="0">
<input type="hidden" id="minutes_id" name="minutes_id" value="">

</form>

</body>


<script type="text/javascript" src="<c:url value='/resources/js/jquery-3.4.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/moment-with-locales.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/bootstrap-datetimepicker.js'/>"></script>

<script type="text/javascript">
$(document).ready( function () {
    $('#picker').dateTimePicker();
    // $('#picker').dateTimePicker({ showTime: false, dateFormat: 'YYYY/MM/DD'});
});

//회의 참석자 검색
function setJoinEmp(){
    let popSize = "width=600,height=450";
    let popOption = "titlebar=no,toolbar=no,menubar=no,location=no,directories=no,status=no,scrollbars=no";
    pop1 = window.open("/setJoinEmp?site_ser=1", "popEmp", popSize + "," + popOption);
}

//마이크 설정 pop up
function micPop(mser, midx){
    if( $('#confSetUpYN').val() == 0 ) {
        alert("회의실 설정 먼저 완료해 주시기 바랍니다.");
    }else{
        let popSize = "width=600,height=300";
        let popOption = "titlebar=no,toolbar=no,menubar=no,location=no,directories=no,status=no,scrollbars=no";
        pop1 = window.open("/setUpMic?site_ser=" + $('#site_ser').val() + "&room_ser=" + $('#room_ser').val() + "&mic_ser=" + mser + "&minutes_id=" + $('#minutes_id').val() + "&midx=" + midx, "popm3", popSize + "," + popOption);
    }
}

//회의실 설정 저장
function doConfSave(){
    let site_ser = $('#site_ser').val();
    let room_ser = $('#room_ser').val();
    let confName = $('#confName').val();
    let confTime = $('#confTime').val();
    let confTopic = $('#confTopic').val();
    let confJoinedEmpName = $('#confJoinedEmpName').val();
    let confJoinedEmpId = $('#confJoinedEmpId').val();

    if( confName.length < 2 ){
        alert("회의명을 2자 이상 입력해 주시기 바랍니다.");
        $('#confName').focus();
        return false;
    }
    if( confTime.length < 2 ){
        alert("회의시간을 지정해 주시기 바랍니다.");
        $('#picker').focus();
        return false;
    }
    if( confTopic.length < 2 ){
        alert("회의 안건을 입력해 주시기 바랍니다.");
        $('#confTopic').focus();
        return false;
    }
    if( confJoinedEmpName.length < 2 ){
        alert("참석자를 입력해 주시기 바랍니다.");
        $('#confJoinedEmpName').focus();
        return false;
    }

    let joinedCnt = confJoinedEmpName.split(',').length;


    $.ajax({
        url : "confSetUpSave",
        data : {site_ser:site_ser, room_ser:room_ser, confName:confName, confTime:confTime, confTopic:confTopic, confJoinedEmpName:confJoinedEmpName, confJoinedEmpId:confJoinedEmpId, confJoinedCnt:joinedCnt},
        type : "POST",
        dataType: "JSON"
    }).done(function(data){
        console.log("### SUCC : " + data);
        console.log("### SUCC M_ID : " + data.minutes_id);
        $('#confSetUpYN').val("1");
        $('#minutes_id').val(data.minutes_id);
        alert("회의실 설정이 완료되었습니다\n마이크 설정을 해주시기 바랍니다.");
    }).fail(function(data){
        console.log("### FAIL : " + data);
    });
}

function doConfClose(){
    alert("회의 설정이 완료되었습니다.");
    opener.location.reload();
    self.close();
}

function chgMicText(mcIdx, uname){
    console.log("### mcIdx=" + mcIdx + ",   uname=" + uname);

    $('#' + mcIdx).text(uname);
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

</style>


</html>