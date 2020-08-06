<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <!-- Cache reset -->
    <meta http-equiv="Expires" content="Mon, 06 Jan 2016 00:00:01 GMT">
    <meta http-equiv="Expires" content="-1">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">

    <%@ include file="../common/commonHeader.jspf" %>
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/popup.css" />

    <title>사이트등록 ll 회의록시스템</title>
</head>
<body>
<!-- #pop_wrap -->
<div id="pop_wrap">
    <!-- .pop_top -->
    <div class="pop_top">
        <h1>사이트 수정</h1>
        <button type="button" class="pop_close" onclick="doCancel();">닫기</button>
    </div>
    <!-- //.pop_top -->
    <!-- .pop_mid -->
    <div class="pop_mid">
        <!-- .pop_stn -->
        <div class="pop_stn">
            <!-- .pop_stn_cont -->
            <div class="pop_stn_cont">
                <dl class="dlBox">
                    <dt>등록일</dt>
                    <dd>${siteVO.create_time}</dd>
                </dl>
                <dl class="dlBox">
                    <dt>사이트 명</dt>
                    <dd><input type="text" class="ipt_txt" id="site_name" name="site_name" value="${siteVO.site_name}"></dd>
                </dl>
                <dl class="dlBox">
                    <dt>최대 미팅룸</dt>
                    <dd><input type="number"  class="ipt_txt" id="max_meeting_room_cnt" name="max_meeting_room_cnt"  value="${siteVO.max_meeting_room_cnt}"></dd>
                </dl>
                <dl class="dlBox">
                    <dt>최대 마이크</dt>
                    <dd><input type="number" class="ipt_txt" id="max_mic_cnt" name="max_mic_cnt" value="${siteVO.max_mic_cnt}"></dd>
                </dl>
                <dl class="dlBox">
                    <dt>모델정보 설명</dt>
                    <dd>
                        <select class="select" id="model_desc" name="model_desc">
                            <option value="0" selected>-- 선택 --</option>
                            ${modelListTag}
                        </select>
                    </dd>
                </dl>
            </div>
            <input type="text" hidden id="minutes_site_ser" name="minutes_site_ser" value="${siteVO.minutes_site_ser}">
            <input type="text" hidden id="sch_model_ser" name="sch_model_ser" value="${siteVO.stt_model_ser}">
            <!-- //.pop_stn_cont -->
        </div>
        <!-- //.pop_stn -->
    </div>
    <!-- //.pop_mid -->
    <!-- .pop_btm -->
    <div class="pop_btm">
        <button type="button" class="btn_point" onclick="doOk();">등록</button>
        <button type="button" onclick="doCancel();">취소</button>
    </div>
    <!-- //.pop_btm -->
</div>
<!-- //#pop_wrap -->
</body>

<script type="text/javascript">
    $(document).ready(function (){
        var model_ser = $('#sch_model_ser').val();
        $('#model_desc').val(model_ser);
    });

    function doOk() {

        var siteName = $('#site_name').val();
        var meetingRoom = $('#max_meeting_room_cnt').val();
        var maxMic = $('#max_mic_cnt').val();
        var model = $('#model_desc option:selected').val();

        if($.trim(siteName).length === 0) {
            alert("사이트명을 입력해주십시오.");
            $('#site_name').focus();
            return false;
        }


        if($.trim(meetingRoom).length === 0) {
            alert("최대 미팅룸을 입력해주십시오.");
            $('#max_meeting_room_cnt').focus();
            return false;
        }

        if( maxMic === '0' ){
            alert("최대 마이크수를 입력해주십시오.");
            $('#max_mic_cnt').focus();
            return false;
        }


        if( model === '0' ){
            alert("모델을 선택해주십시오.");
            $('#model_desc').focus();
            return false;
        }


        var param = {
            minutes_site_ser: $('#minutes_site_ser').val(),
            site_name: siteName,
            max_meeting_room_cnt: meetingRoom,
            max_mic_cnt: maxMic,
            stt_model_ser: model
        };

        $.ajax({
            url : "/updateSite",
            data :param,
            dataType:'json',
            type : "POST"
        }).done(function(data){
            console.log(data);
            if(data.resultCode === 200) {
                alert("수정되었습니다");
                opener.location.reload();
                self.close();
            }else{
                alert("수정이 실패하였습니다.");
                return false;
            }
        }).fail(function(data){
            alert("수정 실패했습니다. 다시 시도해 보시기 바랍니다.");
            return false;
        });

    }

    function doCancel(){
        self.close();
    }

</script>
</html>
