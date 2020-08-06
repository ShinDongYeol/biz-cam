<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>회의현황/마이크설정</title>
</head>

<body>

<form name="mainFrm" method="post" action="sel_script">
회의현황/마이크설정

<div class="div_normal">
    <div class="tbl">
        <div class="row">
            <div class="cell text_center">MIC ID</div>
            <div class="cell">
                <input type="text" id="mic_ser" name="mic_ser" value="${micListOne.minutes_mic_ser}" readonly>
            </div>
        </div>
        <div class="row">
            <div class="cell text_center">IP</div>
            <div class="cell">
                <input type="text" id="mic_ip" name="mic_ip" value="${micListOne.mic_ipaddr}" readonly>
            </div>
        </div>
        <div class="row">
            <div class="cell text_center">PORT</div>
            <div class="cell">
                <input type="text" id="mic_port" name="mic_port" value="${micListOne.mic_port}" readonly>
            </div>
        </div>
        <div class="row">
            <div class="cell text_center">사용자</div>
            <div class="cell">
                <select id="userName" name="userName">
                    <option value="">-- 선택 --</option>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="cell text_center">사용여부</div>
            <div class="cell">
                <select id="micUseYn" name="micUseYn">
                    <option value="">-- 선택 --</option>
                    <option value="Y">Y</option>
                    <option value="N">N</option>
                </select>
            </div>
        </div>
    </div>
    <div class="pd_mg_top text_right">
        <input type="button" value="Cancel" onclick="cancel();">
        <input type="button" value="OK" onclick="saveOK();">
    </div>
</div>

<input type="hidden" id="site_ser" name="site_ser" value="${frontConfVO.site_ser}">
<input type="hidden" id="room_ser" name="room_ser" value="${frontConfVO.room_ser}">
<input type="hidden" id="mic_ser" name="mic_ser" value="${frontConfVO.mic_ser}">
<input type="hidden" id="meta_ser" name="meta_ser" value="${micListOne.stt_meta_ser}">
<input type="hidden" id="minutes_id" name="minutes_id" value="${frontConfVO.minutes_id}">
<input type="hidden" id="midx" name="midx" value="${frontConfVO.midx}">

</form>

</body>

<script type="text/javascript" src="/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
$(document).ready( function () {
    makeUserNameSelect();
});

//참석자 이름을 부모창에서 가져와서 "사용자"에서 사용할 select box tag 생성
function makeUserNameSelect(){
    let nmArr = window.opener.document.getElementById('confJoinedEmpName').value.split(",");
    let selTag = "";

    for( one in nmArr){
        selTag = selTag + "<option value='" + nmArr[one] + "'>" + nmArr[one] + "</option>";
    }

    $('#userName').append(selTag);
}

function saveOK(){
    let userName = $('#userName').val();
    let useYn = $('#micUseYn').val();

    if(userName.length < 1){
        alert("사용자를 선택해 주시기 바랍니다.");
        $('#userName').focus();
        return false;
    }
    if(useYn.length < 1){
        alert("사용여부를 입력해 주시기 바랍니다.");
        $('#useYn').focus();
        return false;
    }

    let meta_ser = $('#meta_ser').val();
    let site_ser = $('#site_ser').val();
    let room_ser =  $('#room_ser').val();
    let mic_ser = $('#mic_ser').val();
    let minutes_id = $('#minutes_id').val();

    $.ajax({
        url: "setUpMicSave",
        data: {
            meta_ser: meta_ser,
            site_ser: site_ser,
            room_ser: room_ser,
            mic_ser: mic_ser,
            minutes_id: minutes_id,
            userName: userName,
            micUseYn: useYn
        },
        type : "POST"
    }).done(function(data){
        console.log("### SUCC : " + data);
        window.opener.chgMicText('mic' + $('#midx').val(), userName);
        alert("저장되었습니다.");
        self.close();
    }).fail(function(data){
        console.log("### FAIL : " + data);
    });
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
    /*border: 1px solid black;*/
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
