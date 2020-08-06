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
        <!-- css -->
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reset.css'/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/font.css'/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/all.css'/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>" />

        <title>회의내용 ll 회의록시스템</title>
    </head>
    <body>
        <!-- .page_loading -->
        <div id="page_loading">
            <div class="page_ldg">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
        <!-- //.page_loading -->

        <!-- #wrap -->
        <div id="wrap">
            <!-- #skipNav -->
            <div id="skipNav">
                <a href="#gnb">주메뉴 메인메뉴</a>
                <a href="#contents">본문 바로가기</a>
            </div>
            <!-- //#skipNav -->
            <!-- #header -->
            <div id="header">
                <h1><a href="#">회의록 시스템</a></h1>
                <!-- .etc -->
                <div class="etc">
                    <ul>
                        <li><a href="#">로그아웃</a></li>
                    </ul>
                </div>
                <!-- //.etc -->
            </div>
            <!-- //#header -->
            <form name="mainFrm" class="mainFrm" method="post" action="javascript:void(0);">
                <!-- #container -->
                <div id="container" class="div_normal">
                    <%@ include file="../common/leftMenu.jsp" %>

                    <!-- #contents -->
                    <div id="contents">
                        <!-- .content -->
                        <div class="content">
                            <!-- .titArea -->
                            <div class="titArea">
                                <h3>회의록 재생 편집용</h3>
                            </div>
                            <!-- //.titArea -->

                            <!-- .section -->
                            <div class="stn meetingInfo">
                                <div class="meeting">
                                    <div class="leftBox">
                                        <dl>
                                            <dt>회의명</dt>
                                            <dd>${sttMeta.minutes_name}</dd>
                                        </dl>
                                        <dl>
                                            <dt>장소</dt>
                                            <dd>${sttMeta.meetingroom_name}</dd>
                                        </dl>
                                        <dl>
                                            <dt>시간</dt>
                                            <dd>${sttMeta.minutes_start_date}</dd>
                                        </dl>
                                        <dl>
                                            <dt>안건</dt>
                                            <dd>${sttMeta.minutes_topic}</dd>
                                        </dl>
                                        <dl>
                                            <dt>참석인</dt>
                                            <dd>${sttMeta.minutes_joined_mem}</dd>
                                        </dl>
                                    </div>
                                    <div class="rightBox">
                                        <%--TODO testFile 고정되어있음 차후 restApi로 수정 필요 --%>
                                        <div class="stateBox">
<%--                                            <p id="state" class="state">
                                                <span class="play">재생</span>
                                                &lt;%&ndash;<span class="record">녹음중</span>&ndash;%&gt;
                                                &lt;%&ndash;<span class="stop">중지</span>&ndash;%&gt;
                                            </p>--%>
                                            <%--<p id="timeDisplay" class="time">00:10:12</p>--%>
                                            <audio id="myAudio" controls="" controlsList="nodownload">
                                                <source src="/resources/test_wav/Tuesday1_1.wav" type="audio/wav">
                                                Your browser does not support the audio tag.
                                            </audio>
                                        </div>

                                        <div class="lst_mic">
                                            <ul>
                                                <c:forEach items="${micSetInfo}" var="micList" varStatus="status">
                                                    <%--(${micList.mic_name})${micList.minutes_joined_name} &nbsp;&nbsp;--%>
                                                    <li><span><em class="name">${micList.minutes_joined_name}</em></span></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- .section -->
                            <div class="stn">
                                <div id="timeline" class="timeline">
                                    <ul>
                                        <c:forEach items="${sttResult}" var="lpList" varStatus="status">
                                            <c:if test="${lpList.minutes_mic_ser ne sttResult[status.index - 1].minutes_mic_ser}">
                                                <li>
                                                    <span class="time" onclick="playAt('${lpList.sntnc_start_time}')">
                                                        <em>${fn:split(lpList.msg_start_time, ' ')[1]}</em>
                                                    </span>
                                                    <span class="name num${lpList.minutes_mic_ser}" onclick="playAt('${lpList.sntnc_start_time}')">
                                                        <em>마이크</em>
                                                    </span>
                                                    <span class="txt">

                                            </c:if>
                                            <em id="stt_${lpList.sntnc_start_time}" onclick="changeToInput(this, ${lpList.stt_meta_ser}, ${lpList.minutes_mic_ser}, ${lpList.sntnc_no})">${lpList.sntnc_desc}</em>

                                            <c:if test="${lpList.minutes_mic_ser ne sttResult[status.index + 1].minutes_mic_ser}">
                                                    </span>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <!-- //.section -->

                            <!-- .section -->
                            <div class="stn">
                                <dl class="memo">
                                    <dt><h4>memo</h4></dt>
                                    <dd>
                                        <%--<textarea id="memo" class="textArea" rows="2">${sttMeta.memo}</textarea>--%>
                                            <input type="text" id="memo" class="textArea"/>
                                        <button type="button" onclick="searchMemo()">검색</button>
                                    </dd>
                                </dl>
                            </div>
                            <!-- //.section -->
                        </div>

                        <input type="hidden" id="meta_ser" name="meta_ser" value="${frontConfVO.meta_ser}">
                        <!-- Active X를 위한 변수 --->
                        <input type="hidden" id="rec_id" name="meta_ser" value="${frontConfVO.meta_ser}">
                        <!-- //.content -->
                    </div>
                    <!-- //#contents -->
                </div>
                <!-- //#container -->
            </form>
        </div>
        <!-- //#wrap -->
    </body>

    <script type="text/javascript" src="<c:url value='/resources/js/jquery-3.4.1.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/all.js'/>"></script>

    <script type="text/javascript">
        const $audio = document.getElementById('myAudio');
        let prev = 0;
        let sttList = new Array();
        let sttTimeVal = 0;


        $(document).ready(function() {
            //edit
            setActiveMenu();
            $('#page_loading').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });

            var sttTimeList = $("em[id^=stt]");
            for(var i=0; i<sttTimeList.length; i++){
                sttTimeVal = parseInt(sttTimeList[i].id.split("_")[1]);
                sttList.push(sttTimeVal);
            }

            $audio.addEventListener('loadedmetadata', function() {
                let duration = $audio.duration;
                //$('#timeDisplay').text(secToTimeFormat(duration));
            });

            $audio.addEventListener('timeupdate', function() {
                let currentTime = $audio.currentTime;
                //$('#timeDisplay').text(secToTimeFormat(currentTime));

                let time = Math.floor(currentTime);
                let $li = $('#stt_' + time);
                if($li.length && time !== prev) {
                    prev = time;
                    let $div = $('#timeline');
                    let liPos = $div.scrollTop() + ($li.offset().top - $div.offset().top) - 20; // -20은 li 여백 처리
                    $div.animate({
                        scrollTop: liPos
                    }, 500);
                }


            });

            $audio.addEventListener('seeking',function(){

                let currentTime = $audio.currentTime;
                let time = Math.floor(currentTime);
                let $li = $('#stt_' + time);
                let position = 0;
                if($li.length == 0 && time !== prev) {

                    for (var i = 1; i < sttList.length; i++) {

                        if (time > sttList[i]) {
                            position = i;
                        } else {
                            break;
                        }

                    }

                    $li = $('#stt_' + sttList[position]);

                    let $div = $('#timeline');
                    let liPos = $div.scrollTop() + ($li.offset().top - $div.offset().top) - 20; // -20은 li 여백 처리
                    $div.animate({
                        scrollTop: liPos
                    }, 500);
                }
            });

            $('#state').click(function(){

                if($audio.paused === false) {
                    $audio.pause();
                    $('#state').html('<span class="play">재생</span>');
                } else {
                    // $audio.currentTime = 0; // 초기화
                    $audio.play();
                    $('#state').html('<span class="stop">중지</span>');
                }

            });

/*            $("#memo").keyup(function() {

                let memoVal = $(this).val();

                // text 강조 부분 초기화
                initEmphasis();

                // text 강조
                setEmphasis(memoVal);

            });*/

        });

        if (!String.prototype.format) {
            String.prototype.format = function() {
                var args = arguments;
                return this.replace(/{(\d+)}/g, function(match, number) {
                    return typeof args[number] != 'undefined' ? args[number]
                        : match;
                });
            };
        }

        function searchMemo(){
            let memoVal = $("#memo").val();

            // text 강조 부분 초기화
            initEmphasis();

            // text 강조
            setEmphasis(memoVal);
        }

        function memoSave(){
            let meta_ser = $('#meta_ser').val();
            let memo = $('#memo').val();

            $.ajax({
                url : "memoSave",
                data : {meta_ser:meta_ser, memo:memo},
                type : "POST"
            }).done(function(data){
                console.log("### SUCC : " + data);
            }).fail(function(data){
                console.log("### FAIL : " + data);
            });
        }

        function playAt(time) {
            $audio.currentTime = Number(time);
            if($audio.paused === true) {
                $audio.play();
                $('#state').html('<span class="stop">중지</span>');
            }
        }

        // text 강조 부분 초기화
        function initEmphasis(){

            $("#timeline > ul > li > span > em").each(function(){

                let regex = new RegExp('/<(\/b|b)([^>]*)>/','gi');
                $(this).html( $(this).text().replace(regex,"") );
            });

        }

        // text 검색한 부분 강조
        function setEmphasis(value){

            let contains = $("#timeline > ul > li > span > em:contains('" + value + "')");

            if((value!="") && (contains.length > 0)){

                contains.each(function(){
                    let regex =  new RegExp(value,'gi');
                    $(this).html( $(this).text().replace(regex, "<b style='color:red;'>"+value+"</b>") );
                });

                let $li = $('#'+contains[0].id);
                let $div = $('#timeline');
                let liPos = $div.scrollTop() + ($li.offset().top - $div.offset().top) - 20; // -20은 li 여백 처리
                $div[0].scrollTop = liPos;

            }else{

                let currentTime = $audio.currentTime;
                //$('#timeDisplay').text(secToTimeFormat(currentTime));

                let time = Math.floor(currentTime);
                let $li = $('#stt_' + time);
                if($li.length && time !== prev) {
                    prev = time;
                    let $div = $('#timeline');
                    let liPos = $div.scrollTop() + ($li.offset().top - $div.offset().top) - 20; // -20은 li 여백 처리
                    $div.animate({
                        scrollTop: liPos
                    }, 500);
                }

            }

        }

        function changeToInput($this, stt_meta_ser, minutes_mic_ser, sntnc_no) {
            let $obj = $($this);

            let $input = $obj.find('input');
            if(!$input.length) {
                let text = $obj.text();

                let str = '';
                str += '<input type="text" style="width:1200px"'
                    + ' onkeydown="enterSubmit(this)"'
                    + ' data-stt_meta_ser="'+ stt_meta_ser +'"'
                    + ' data-minutes_mic_ser="'+ minutes_mic_ser +'"'
                    + ' data-sntnc_no="'+ sntnc_no +'"'
                    + ' data-origin_text="'+ text +'"'
                    + ' value="'+ text +'">';

                $obj.html(str);
                $obj.children(0).focus();
            }
        }

        function enterSubmit($this) {
            let $obj = $($this);

            let stt_meta_ser = $obj.attr('data-stt_meta_ser');
            let minutes_mic_ser = $obj.attr('data-minutes_mic_ser');
            let sntnc_no = $obj.attr('data-sntnc_no');
            let origin_text = $obj.attr('data-origin_text');
            let sntnc_desc = $obj.val();

            if(event.keyCode === 13) {
                $.ajax({
                    url : "sntncSave",
                    data : {
                        meta_ser: stt_meta_ser
                        , mic_ser: minutes_mic_ser
                        , sntnc_no: sntnc_no
                        , sntnc_desc: sntnc_desc
                    },
                    type : "POST"
                }).done(function(data){
                    console.log("### SUCC : " + data);
                    $obj.parent().html(sntnc_desc);
                }).fail(function(data){
                    console.log("### FAIL : " + data);
                    $obj.parent().html(origin_text);
                });
            }
        }

        //seconds를  00:00:00으로 반환
        function secToTimeFormat(seconds){
            let sec = (seconds % 60).toFixed(0);
            let min = parseInt((seconds / 60) % 60);

            sec = leftpadZero(sec);
            min = leftpadZero(min);

            return min+":"+sec;
        }

        //한자리수에 앞에 '0'붙이기
        function leftpadZero(num){
            if(num < 10){
                num = "0"+num;
            }
            return num;
        }
    </script>
</html>
