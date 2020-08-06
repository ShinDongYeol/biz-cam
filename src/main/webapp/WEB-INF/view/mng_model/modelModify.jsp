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
    <!-- icon_favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="${path}/resources/images/ico_favicon_60x60.png"><!-- 윈도우즈 사이트 아이콘, HiDPI/Retina 에서 Safari 나중에 읽기 사이드바 -->
    <!-- css -->
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/popup.css" />

    <title>모델수정 ll 회의록시스템</title>
</head>
<body>
<!-- #pop_wrap -->
<div id="pop_wrap">
    <!-- .pop_top -->
    <div class="pop_top">
        <h1>모델 수정</h1>
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
                    <dd>${model.create_time}</dd>
                </dl>
                <dl class="dlBox">
                    <dt>NAME</dt>
                    <dd><input type="text" class="ipt_txt" id="model_name" name="model_name" value="${model.stt_model_name}"></dd>
                </dl>
                <dl class="dlBox">
                    <dt>모델 설명정보</dt>
                    <dd>
                        <input type="text" class="ipt_txt" id="model_desc" name="model_desc" value="${model.model_desc}">
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>TYPE</dt>
                    <dd>
                        <select class="select" id="deepLearnType" name="deepLearnType">
                            <option value="0" selected>-- 선택 --</option>
                            <option value="CNN">CNN</option>
                            <option value="DNN">DNN</option>
                            <option value="LSTM">LSTM</option>
                        </select>
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>SERVER_IP</dt>
                    <dd>
                        <input type="text" class="ipt_txt" id="stt_server_ip" name="stt_server_ip" value="${model.stt_server_ip}">
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>SERVER_PORT</dt>
                    <dd>
                        <input type="text" class="ipt_txt" id="stt_server_port" name="stt_server_port" value="${model.stt_server_port}">
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>LANGUAGE</dt>
                    <dd>
                        <select class="select" id="model_lang" name="model_lang">
                            <option value="0">--선택--</option>
                            <option value="kor">한글</option>
                            <option value="eng">영어</option>
                        </select>
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>RATE</dt>
                    <dd>
                        <select class="select" id="model_rate" name="model_rate">
                            <option value="0">--선택--</option>
                            <option value="8000 ">8000 </option>
                            <option value="16000">16000</option>
                        </select>
                    </dd>
                </dl>
            </div>
            <input type="text" hidden id="modelNum" name="modelNum" value="${modelVO.model_ser}">
            <!-- //.pop_stn_cont -->
        </div>
        <!-- //.pop_stn -->
    </div>
    <!-- //.pop_mid -->
    <!-- .pop_btm -->
    <div class="pop_btm">
        <button type="button" class="btn_point" onclick="doOk();">수정</button>
        <button type="button" onclick="doCancel();">취소</button>
    </div>
    <!-- //.pop_btm -->
</div>
<!-- //#pop_wrap -->
</body>

<script type="text/javascript" src="resources/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="resources/js/all.js"></script>
<script type="text/javascript">
    $(document).ready(function (){
        var deepLearning = '<c:out value="${model.deep_learning_type}" />';
        var lang = '<c:out value="${model.stt_model_lang}" />';
        var rate = '<c:out value="${model.stt_model_rate}" />';

        $('#deepLearnType').val(deepLearning);
        $('#model_lang').val(lang);
        $('#model_rate').val(rate);

    });

    function doOk() {

        var modelName = $('#model_name').val();
        var modelType = $('#deepLearnType option:selected').val();
        var modelSttServerIp = $("#stt_server_ip").val();
        var modelSttServerPort = $("#stt_server_port").val();
        var modelLang = $('#model_lang option:selected').val();
        var modelRate = $('#model_rate option:selected').val();
        var modelDesc = $('#model_desc').val();

        if($.trim(modelName).length == 0) {
            alert("NAME을 입력하십시오.");
            $('#model_name').focus();
            return false;
        }

        if($.trim(modelDesc).length == 0) {
            alert("모델 설명정보를 입력하십시오.");
            $('#model_desc').focus();
            return false;
        }

        if( modelType == '0' ){
            alert("Type을 선택해주세요.");
            $('#deepLearnType').focus();
            return false;
        }

        if(isEmpty(modelSttServerIp)){
            alert("STT_SERVER_IP를 입력하십시오.");
            $('#stt_server_ip').focus();
            return false;
        }

        if(isEmpty(modelSttServerPort)){
            alert("STT_SERVER_PORT를 입력하십시오.");
            $('#stt_server_port').focus();
            return false;
        }


        if( modelLang == '0' ){
            alert("Language를 선택해주세요.");
            $('#model_lang').focus();
            return false;
        }

        if($.trim(modelRate).length == 0) {
            alert("Rate를 입력하십시오.");
            $('#model_rate').focus();
            return false;
        }


        var param = {
            stt_model_ser : $('#modelNum').val(),
            stt_model_name: modelName,
            stt_server_ip : modelSttServerIp,
            stt_server_port : modelSttServerPort,
            stt_model_lang: modelLang,
            deep_learning_type: modelType,
            stt_model_rate: modelRate,
            model_desc: modelDesc
        };

        $.ajax({
            url : "/modifyModelOk",
            data :param,
            dataType: 'json',
            type : "POST"
        }).done(function(data){
            console.log(data);
            if(data.resultCode == 200) {
                alert("수정되었습니다");
                opener.location.reload();
                self.close();
            }else{
                alert("수정이 실패하였습니다.");
                return false;
            }
        }).fail(function(data){
            console.log("### FAIL : " + data);
            alert("수정 실패했습니다. 다시 시도해 보시기 바랍니다.");
            return false;
        });

    }

    function doCancel(){
        self.close();
    }
</script>
</html>
