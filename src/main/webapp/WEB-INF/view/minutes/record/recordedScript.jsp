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
    <%@ include file="../../common/commonHeader.jspf" %>
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/popup.css" />
    <title>회의록 재생 청취 ll 회의록시스템</title>
</head>
<body>

<div id="pop_wrap">
    <!-- .pop_top -->
    <div class="pop_top">
        <h1>회의록 재생 청취</h1>
        <%--<button type="button" class="pop_close" onclick="closePopup();">닫기</button>--%>
    </div>
    <!-- //.pop_top -->
    <!-- .pop_mid -->
    <div class="pop_mid">
        <!-- .section -->
        <div class="stn meetingInfo">
            <div class="meeting">
                <div class="leftBox">
                    <dl>
                        <dt>회의명</dt>
                        <dd>${sttMeta.minutes_name}</dd>
                    </dl>
                    <dl>
                        <dt>회의실</dt>
                        <dd>${sttMeta.minutes_meetingroom}</dd>
                    </dl>
                    <dl>
                        <dt>시간</dt>
                        <dd>${sttMeta.start_time} ~ ${sttMeta.end_time}</dd>
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
                    <div class="stateBox">
                        <p id="state" class="state">
                            <span class="play">재생</span>
                            <%--<span class="record">녹음중</span>--%>
                            <%--<span class="stop">중지</span>--%>
                        </p>
                        <p id="timeDisplay" class="time">00:10:12</p>
                        <audio id="myAudio">
                            <source src="${sttMeta.file_url}" type="audio/wav">
                            Your browser does not support the audio tag.
                        </audio>
                    </div>
                    <div class="lst_mic">
                    <c:choose>
                        <c:when test="${fn:length(sttResult) gt 0}">
                            <ul>
                            <c:forEach items="${employee}" var="employeeList" varStatus="status">
                                <li>
                                <span>
                                    <em class="name"><input type="text" class="ipt_txt inline" value="${employeeList.minutes_employee}"></em>
                                </span>
                                </li>
                            </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
                    </div>
                </div>
            </div>
        </div>
        <!-- .section -->
        <div class="stn">
            <div id="timeline" class="timeline">
                <ul>
                    <c:choose>
                        <c:when test="${fn:length(sttResult) gt 0}">
                            <c:forEach items="${sttResult}" var="lpList" varStatus="status">
                            <li>
                                <span class="time" onclick="playAt('${lpList.stt_diff_time}')">
                                    <em>${fn:split(lpList.stt_result_start, ' ')[1]}</em>
                                </span>
                                <span class="name num1" onclick="playAt('${lpList.stt_diff_time}')">
                                    <em>${lpList.minutes_employee}</em>
                                </span>
                                <span class="txt">
                                    <em id="stt_${lpList.stt_diff_time}">
                                      <c:choose>
                                          <c:when test="${not empty lpList.stt_chg_result}">
                                              ${lpList.stt_chg_result}
                                          </c:when>
                                          <c:otherwise>
                                              ${lpList.stt_org_result}
                                          </c:otherwise>
                                      </c:choose>
                                    </em>
                                </span>
                            </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                                    <li>
                                        <span>
                                            <h3>데이터가 없습니다.</h3>
                                        </span>
                                    </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
        <!-- //.section -->

        <!-- .section -->
        <div class="stn">
            <dl class="memo">
                <dd>
                    <textarea class="textArea">${sttMeta.memo}</textarea>
                </dd>
            </dl>
        </div>
        <!-- //.section -->
    </div>
    <!-- //.pop_mid -->
    <!-- .pop_btm -->
    <div class="pop_btm">
        <button type="button" class="btn_point" onclick="mod(${sttMeta.stt_meta_ser});">편집</button>
        <button type="button" onclick="closePopup();">닫기</button>
    </div>
    <!-- //.pop_btm -->
</div>

</body>
<script type="text/javascript">

    const $audio = document.getElementById('myAudio');
    let prev = 0;
    let sttList = new Array();
    let sttTimeVal = 0;

</script>
<script type="text/javascript">

    $(document).ready(function() {

        $('#page_loading').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });
        var sttTimeList = $("em[id^=stt]");
        for(var i=0; i<sttTimeList.length; i++){
            sttTimeVal = parseInt(sttTimeList[i].id.split("_")[1]);
            sttList.push(sttTimeVal);
        }

        $audio.addEventListener('loadedmetadata', function() {
            let duration = $audio.duration;
            $('#timeDisplay').text(secToTimeFormat(duration));
        });

        $audio.addEventListener('timeupdate', function() {
            let currentTime = $audio.currentTime;
            $('#timeDisplay').text(secToTimeFormat(currentTime));

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
            $('#timeDisplay').text(secToTimeFormat(currentTime));
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

    });


    function playAt(time) {
        $audio.currentTime = Number(time);
        if($audio.paused === true) {
            $audio.play();
            $('#state').html('<span class="stop">중지</span>');
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


    function closePopup(){
        self.close();
    }

    function mod(sttMetaSer){

        var popSize = "width=1300,height=960";
        var popOption = "titlebar=no,toolbar=no,menubar=no,location=no,directories=no,status=no,scrollbars=no";
        pop1 = window.open("/minutes/manage/recordEditScript?sttMetaSer="+sttMetaSer, "_self", popSize + "," + popOption);

    }

</script>

</html>
