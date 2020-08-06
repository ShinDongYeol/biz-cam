<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="div_box_s">
    <div class="div_box_s_nc_30">
        <table>
            <tr>
                <li>${sttMeta.meetingroom_name}</li>
                <li>${sttMeta.minutes_name}</li>
                <li>${sttMeta.minutes_start_date}</li>
                <li>안건:${sttMeta.minutes_topic}</li>
                <li>참석인:${sttMeta.minutes_joined_mem}</li>
            </tr>
        </table>
    </div>

    <div class="div_box_s_nc_30">
        <li>녹음용 - 00:10:12</li>
        <li>
            <c:forEach items="${micSetInfo}" var="micList" varStatus="status">
                (${micList.mic_name})${micList.minutes_joined_name} &nbsp;&nbsp;
            </c:forEach>
        </li>
        <p>&nbsp;</p>
        <c:choose>
            <c:when test="${sttMeta.minutes_status eq 1}">
                <input type="button" id="btnConfStart" value="시작" onclick="meetingStatus('${sttMeta.stt_meta_ser}', '1');">
            </c:when>
            <c:otherwise>
                <input type="button" id="btnConfStart" value="시작" onclick="meetingStatus('${sttMeta.stt_meta_ser}', '1');" disabled>
            </c:otherwise>
        </c:choose>
        /
        <c:choose>
            <c:when test="${sttMeta.minutes_status eq 2}">
                <input type="button" id="btnConfEnd" value="종료" onclick="meetingStatus('${sttMeta.stt_meta_ser}', '2');">
            </c:when>
            <c:otherwise>
                <input type="button" id="btnConfEnd" value="종료" onclick="meetingStatus('${sttMeta.stt_meta_ser}', '2');" disabled>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="div_box_m" id="div_conf_script">
    <table id="conf_savedScript">
        <c:forEach items="${sttResult}" var="lpList" varStatus="status">
            <tr>
                <td>
                    <c:if test="${lpList.minutes_mic_ser ne sttResult[status.index - 1].minutes_mic_ser}">
                        ${lpList.sntnc_start_time}
                    </c:if>
                </td>
                <td width="10%" align="center">
                    <c:if test="${lpList.minutes_mic_ser ne sttResult[status.index - 1].minutes_mic_ser}">
                        ${lpList.minutes_mic_ser}
                    </c:if>
                </td>
                <td>
                        ${lpList.sntnc_desc}
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<div class="div_box_b">
    <table>
        <tr>
            <td class="td_w_center_10p">메모</td>
            <td class="td_w_left_80p">
                <input type="text" id="memo" name="memo" size="120" value="${sttMeta.memo}">
                <input type="button" id="memoSave" name="memoSave" value="저장" onclick="memoSave();">
            </td>
        </tr>
    </table>
</div>

<input type="text" id="meta_ser" name="meta_ser" value="${frontConfVO.meta_ser}">
<input type="text" id="recStartSec" name="recStartSec" value="${sttMeta.rec_start_time_sec}">

<!-- Active X를 위한 변수 --->
<input type="hidden" id="rec_id" name="meta_ser" value="${frontConfVO.meta_ser}">

</body>

<script type="text/javascript" src="/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
var ws;
var speaker;
var speakerTmp;
var recStartSec = $('#recStartSec').val();

$(document).ready(function() {
    conn_ws();
});

//websocket main function
function conn_ws(){
    let cur_micId = "";
    let new_micId = "";

    // ws = new WebSocket( 'ws://127.0.0.1:34990' );
    ws = new WebSocket( 'ws://10.122.66.73:8200/callsocket' );

    ws.onmessage = function(e){
        let rcv_data = e.data;
        console.log("### GOT DATA:" + rcv_data.toString());

        rcv_data = JSON.parse(e.data);
        // if( rcv_data.EventType == 'STT' && rcv_data.Event == "interim" ){
        //     console.log("### STT, interim data");
        //     appendMsgTag(rcv_data);
        // }
        if( rcv_data.EventType == 'STT' && rcv_data.Event == 'stop'){
            console.log("### STT, stop data");
            confEndPos(rcv_data);
        }

        let tbl_height = $('#conf_savedScript').height();
        $('#div_conf_script').scrollTop(tbl_height);
    };
    ws.onopen = function(){
        console.log("==> Socket Opened");
        // let ser = $('#meta_ser').val();
        // let sendMsg = '{"EventType":"STT", "Event":"subscribe", "rec_id":"' + ser + '"}';
        //
        // ws.send(sendMsg);
        // console.log("==> Sent opening message : subscribe : sendMsg : " + sendMsg);
    }
}

//메세지 추가
function appendMsgTag(rcv_data){
    let msgTag = '';
    let msgTrId = 0;


    //행 id세팅
    if( rcv_data.text.indexOf('##') > -1 ){
        msgTrId = parseInt(rcv_data.sntnc_no) + 1;
    }else{
        msgTrId = parseInt(rcv_data.sntnc_no);
    }
    msgTag = '<tr id="' + msgTrId +'">';


    //화자 표시
    tmpSpeaker = rcv_data.mic_ser;
    if( speaker != tmpSpeaker ) {
        msgTag = msgTag + '<td>' + rcv_data.mic_ser + '</td>';
        speaker = tmpSpeaker;
    }else{
        msgTag = msgTag + '<td></td>';
    }


    //문장 시작 시간 표시
    let addStartSec = parseInt(recStartSec) + parseInt(rcv_data.start);
    let viewSec = new Date( addStartSec );
    msgTag = msgTag + '<td>' + viewSec.toLocaleString() + '</td>';


    //문장 표시
    msgTag = msgTag + '<td>' + appendMsgRearrange(rcv_data.text) + '</td>';
    msgTag = msgTag + '</tr>';
    console.log("### msgTag=" + msgTag);
    $('#' + msgTrId).remove();
    $('#conf_savedScript').append(msgTag);
}

//'##' 제거
function appendMsgRearrange(text){
    console.log("### before text:" + text);
    return text.replace(/[\##]/gi, '');
}

//회의 종료 팝업
function confEndPos(rcv_data){
    alert("회의가 종료되었습니다.");
}


if (!String.prototype.format) {
    String.prototype.format = function() {
        var args = arguments;
        return this.replace(/{(\d+)}/g, function(match, number) {
            return typeof args[number] != 'undefined' ? args[number]
                : match;
        });
    };
}

//메모 저장
function memoSave(){
    let meta_ser = $('#meta_ser').val();
    let memo = $('#memo').val();

    $.ajax({
        url : "memoSave",
        data : {meta_ser:meta_ser, memo:memo},
        type : "POST"
    }).done(function(data){
        console.log("### SUCC : " + data);
        alert("메모 저장 성공");
    }).fail(function(data){
        console.log("### FAIL : " + data);
        alert("메모 저장 실패");
    });
}

// 시작 / 종료 버튼 클릭
function meetingStatus(ser, status){
    $.ajax({
        url : "meetingStatusUpdate",
        data : {meta_ser:ser, meetStatus:status},
        type : "POST"
    }).done(function(data){
        console.log("### SUCC : " + data);

        let rcv_data = JSON.parse(data);

        let sendMsg = '';
        $('#recStartSec').val(rcv_data[0]);
        if( status == '1' ){
            sendMsg = '{"EventType":"COMMAND", "Event":"start", "rec_id":"' + ser + '", "mic_ip":"' + rcv_data[1] + '", "mic_port1":"' + rcv_data[2] + '", "mic_port2":"' + rcv_data[3] + '", "mic_port3":"' + rcv_data[4] + '", "mic_port4":"' + rcv_data[5] + '", "mic_port5":"' + rcv_data[6] + '", "mic_port6":"' + rcv_data[7] + '", "mic_port7":"' + rcv_data[8] + '", "mic_port8":"' + rcv_data[9] + '"}';
        }else{
            sendMsg = '{"EventType":"COMMAND", "Event":"stop", "rec_id":"' + ser + '", "mic_ip":"' + rcv_data[1] + '", "mic_port1":"' + rcv_data[2] + '", "mic_port2":"' + rcv_data[3] + '", "mic_port3":"' + rcv_data[4] + '", "mic_port4":"' + rcv_data[5] + '", "mic_port5":"' + rcv_data[6] + '", "mic_port6":"' + rcv_data[7] + '", "mic_port7":"' + rcv_data[8] + '", "mic_port8":"' + rcv_data[9] + '"}';
        }
        ws.send(sendMsg);
        console.log("### sent message : " + sendMsg);

        if( status == '1' ) {
            alert("회의 녹음이 시작되었습니다.");
            $('#btnConfStart').prop("disabled", true);
            $('#btnConfEnd').prop("disabled", false);
        }else{
            //alert("회의 녹음이 종료되었습니다.");
            $('#btnConfEnd').prop("disabled", true);
        }
    }).fail(function(data){
        console.log("### FAIL : " + data);
        location.reload();
    });
}
</script>

<style type="text/css">
.div_box_s{
    position: relative;
    display: table;
    width: 100%;
    vertical-align: middle;
    text-align: center;
    margin-bottom: 20px;
}

.div_box_s_nc_30{
    position: relative;
    float: left;
    width: 30%;
    margin-right: 20px;
    margin-bottom: 20px;
    vertical-align: middle;
    text-align:left;
    border: 1px solid black;
}

.div_box_m{
    position: relative;
    overflow: scroll;
    width: 1024px;
    height: 500px;
    vertical-align: middle;
    margin-bottom: 10px;
    border: 1px solid black;
}

.div_box_b{
    position: relative;
    display: table;
    width: 1024px;
    vertical-align: middle;
    text-align: left;
    margin-bottom: 10px;
    border: 1px solid black;
}

.td_w_center_10p{
    width: 10%;
    text-align: center;
}
.td_w_right_10p{
    width: 10%;
    text-align: right;
}
.td_w_left_80p{
    width: 80%;
    text-align: left;
}
</style>

</html>
