<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

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
    <c:set var="path"  value="${pageContext.request.contextPath}" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/font.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/bootstrap-datetimepicker.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/all.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/popup.css" />
    <script type="text/javascript" src="${path}/resources/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="${path}/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${path}/resources/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="${path}/resources/js/moment.min.js"></script>
    <script type="text/javascript" src="${path}/resources/js/ko.js"></script>
    <script type="text/javascript" src="${path}/resources/js/all.js"></script>
    <script type="text/javascript" src="${path}/resources/js/common.js"></script>
    <title>회의록 재생 청취 ll 회의록시스템</title>
    <style>
        dl.memo {clear:both; overflow:hidden;}
        dl.memo dt {display:block; position:relative; padding:0 0 10px 0; color:#304c75; font-size:15px; font-weight:600; text-align:left;}
        dl.memo dd {display:block; position:relative; overflow:hidden; border:1px solid #6a74a7; border-radius:10px; background:#fff;}
        dl.memo dd .textArea {float:left; width:calc(100% - 75px); height:75px; padding:10px; color:#304c75; font-size:13px; line-height:18px; word-break:keep-all; border:none;  background:#f5f6fa; transition:all 0.3s ease-out;}
        dl.memo dd button {float:right; width:75px; height:75px; color:#fff; font-weight:600; border:none; border-radius:0 10px 10px 0; background:#5cb85c; border-color:#4cae4c; transition:all 0.3s ease-out;}
        dl.memo dd button:hover, dl.memo dd button:focus {opacity:1.0; transition:all 0.3s ease-out;}
    </style>
</head>
<body>
<!-- #pop_wrap -->
<div id="pop_wrap">
    <!-- .pop_top -->
    <div class="pop_top">
        <h1>회의록 재생 청취</h1>
        <%--<button type="button" class="pop_close">닫기</button>--%>
    </div>
    <!-- //.pop_top -->
    <!-- .pop_mid -->
    <div class="pop_mid">
        <!-- .section -->
        <form name="updateMinutesMetaForm" id="updateMinutesMetaForm" onsubmit="return false;">
            <input type="hidden" name="minutesJoinedMem" id="minutesJoinedMem">
        <div class="stn meetingInfo">
            <div class="meeting">
                <div class="leftBox">
                    <dl>
                        <dt>회의명</dt>
                        <dd>
                            <input type="text" class="ipt_txt" id="minutesName" name="minutesName" value="${sttMeta.minutes_name}">
                        </dd>
                    </dl>
                    <dl>
                        <dt>회의실</dt>
                        <dd><input type="text" class="ipt_txt" id="minutesMeetingroom" name="minutesMeetingroom" value="${sttMeta.minutes_meetingroom}"></dd>
                    </dl>
                    <dl>
                        <dt>시간</dt>
                        <dd>
                            <input type="text" class="ipt_date fromDate" data-date-format="yyyy-mm-dd hh:ii:00" id="startTime" name="startTime" value="${sttMeta.start_time}">
                            <span>-</span>
                            <input type="text" class="ipt_date toDate" data-date-format="yyyy-mm-dd hh:ii:00" id="endTime" name="endTime" value="${sttMeta.end_time}">
                        </dd>
                    </dl>
                    <dl>
                        <dt>안건</dt>
                        <dd><input type="text" class="ipt_txt" id="minutesTopic" name="minutesTopic" value="${sttMeta.minutes_topic}"></dd>
                    </dl>
                    <dl>
                        <dt>참석인</dt>
                        <dd>
                        <c:set var="memberLength"  value="${fn:length(sttMeta.minutes_joined_mem_arr)}" />
                        <c:set var="memLengthMod" value="${memberLength <5 ? (5- memberLength) : (5-(memberLength % 5)) }"/>
                        <c:set var="statusCount" value="0"/>
                        <c:forEach items="${sttMeta.minutes_joined_mem_arr}" var="minutesJoinedMemArr" varStatus="status">
                            <c:set var="statusCount" value="${status.count}"/>
                            <input type="text" class="ipt_txt inline" name="joinMember${status.count}" id="joinMember${status.count}" value="${minutesJoinedMemArr}">
                        </c:forEach>
                            <c:if test="${memLengthMod != 0}">
                                <c:forEach begin="1" end="${memLengthMod}">
                                    <input type="text" class="ipt_txt inline" name="joinMember${statusCount}" id="joinMember${statusCount}">
                                </c:forEach>
                            </c:if>

                            <button type="button" class="btn_ico" name="joinMemAdd" id="joinMemAdd" onclick="addJoinMember();"><span class="fas fa-plus" aria-hidden="true"></span><em>추가</em></button>
                        </dd>
                    </dl>
                    <dl>
                        <dt></dt>
                        <dd style="text-align: right;">
                            <button type="button" class="btn btn-success" style="margin-top: 5px;" onclick="updateMinutesMeta();">수정</button>
                        </dd>
                    </dl>
                </div>
                <div class="rightBox">
                    <div class="stateBox">
                        <p id="state" class="state">
                            <span class="play">재생</span>
                            <!-- <span class="record">녹음중</span> -->
                            <%--<span class="stop">중지</span>--%>
                        </p>
                        <p id="timeDisplay" class="time">00:10:12</p>
                        <audio id="myAudio">
                            <source src="${sttMeta.file_url}" type="audio/wav">
                            Your browser does not support the audio tag.
                        </audio>
                    </div>
                    <input type="hidden" id="sttMetaSer" name="sttMetaSer" value="${sttMeta.stt_meta_ser}">
                    <div class="lst_mic" id="lst_mic">
                        <c:choose>
                            <c:when test="${fn:length(employee) gt 0}">
                                <ul>
                                <c:forEach items="${employee}" var="employee" varStatus="status">
                                    <li>
                                    <span>
                                        <em class="name">
                                            <input type="text" class="ipt_txt inline" name="employeeAll_${status.count}" id="employeeAll_${status.count}" value="${employee.minutes_employee}">
                                            <button type="button" class="btn btn-success" style="margin-top: 5px;" onclick="updateMinutesAllEmployee('${employee.minutes_employee}',${status.count});">수정</button>
                                        </em>
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
        </form>
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
                                            <em>
                                                <input type="text" class="ipt_txt" name="employee_${lpList.stt_result_ser}" id="employee_${lpList.stt_result_ser}" value="${lpList.minutes_employee}">
                                            </em>
                                    </span>
                                    <span class="txt">
                                    <em id="stt_${lpList.stt_diff_time}">
                                      <c:choose>
                                          <c:when test="${lpList.stt_chg_result ne null}">
                                              <textarea type="text" class="textarea1" name="sttChgResult_${lpList.stt_result_ser}" id="sttChgResult_${lpList.stt_result_ser}">${lpList.stt_chg_result}</textarea>
                                          </c:when>
                                          <c:otherwise>
                                              <textarea type="text" class="textarea1" name="sttChgResult_${lpList.stt_result_ser}" id="sttChgResult_${lpList.stt_result_ser}">${lpList.stt_org_result}</textarea>
                                          </c:otherwise>
                                      </c:choose>
                                    </em>
                                    </span>
                                    <button type="button" class="btn_ico" title="편집" onclick="updateSttResult(${lpList.stt_result_ser});">
                                        <span class="fas fa-edit"></span><em>편집</em>
                                    </button>
                                    <button type="button" class="btn_ico" title="편집" onclick="updateEmptyToNullBySttChgResult('${lpList.stt_result_ser}');">
                                        <span class="fas fa-times"></span><em>편집</em>
                                    </button>
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
                    <textarea id="memo" name="memo" class="textArea">${sttMeta.memo}</textarea>
                    <button type="button" onclick="memoSave()">수정</button>
                </dd>
            </dl>
        </div>
        <!-- //.section -->
    </div>
    <!-- //.pop_mid -->
    <!-- .pop_btm -->
    <div class="pop_btm">
        <button type="button" onclick="closePopup();">닫기</button>
    </div>
    <!-- //.pop_btm -->
</div>
<!-- //#pop_wrap -->
</body>
<script type="text/javascript">

    const $audio = document.getElementById('myAudio');
    let prev = 0;
    let sttList = new Array();
    let sttTimeVal = 0;

</script>
<script type="text/javascript">
    $(document).ready(function (){

        $('.fromDate').datetimepicker({
            language : 'ko', // 화면에 출력될 언어를 한국어로 설정한다.
            pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략한다.
            //defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력한다. 기본값을 해제하려면 defaultDate 옵션을 생략한다.
            autoclose: 1,
        });

        $('.toDate').datetimepicker({
            language : 'ko',
            pickTime : false,
            //defalutDate : new Date(),
            autoclose: 1,
        });

        // DateTimePicker 위젯은 기본적으로 TextBox이므로 아래와 같은 일반적인 방법으로 사용자가 입력한 날짜를 획득할 수 있다.
        var fromDate = $('.fromDate').val(); // '2014.01.01'
        var toDate = $('.toDate').val(); // '2014.12.31'


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
            //$audio.play();
            //$('#state').html('<span class="stop">중지</span>');
        }else{
            $audio.pause();
            $('#state').html('<span class="play">재생</span>');
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

    function updateMinutesAllEmployee(minutesEmployee,index){

        var sttMetaSer = $("#sttMetaSer").val();
        var beforeMinutesEmployee = minutesEmployee;
        var afterMinutesEmployee = $("#employeeAll_"+index).val();

        if( isEmpty(afterMinutesEmployee) ){
            alert("사원명을 입력해 주시기 바랍니다.");
            return false;
        }

        var param={
            sttMetaSer :sttMetaSer,
            beforeMinutesEmployee : beforeMinutesEmployee,
            afterMinutesEmployee : afterMinutesEmployee
        };

        $.ajax({
            url : "/minutes/manage/updateMinutesAllEmployee",
            data : param,
            type : "POST",
            success : function (data) {
                alert(data);
                if(data=="SUCCESS"){

                    var employeeArr = $("input[name^='employee_']");
                    for(var i=0; i<employeeArr.length; i++){

                        if(employeeArr[i].value == beforeMinutesEmployee){
                            $("input[name^='employee_']")[i].value = afterMinutesEmployee;
                        }

                    }

                    getsEmployee();
                }
            },
            fail:function(data){
                //console.log(data)
            },
            error: function(data, status, error){
                console.log(error);
            }
        });

    }

    function updateMinutesMeta(){

        var flag = validationForm();

        if(flag){
            updateMinutesMetaOK();
        }

    }

    function updateMinutesMetaOK(){

        var minutesJoinedMem = "";

        var joinMemberArr = $("input[name^='joinMember']");
        var memberNm = "";
        var division = ",";
        for(var i=0; i<joinMemberArr.length; i++){
            memberNm = joinMemberArr[i].value;

            if(memberNm!=''){
                minutesJoinedMem += memberNm + division;
            }

        }

        minutesJoinedMem = minutesJoinedMem.substring(0,minutesJoinedMem.length-1);
        $("#minutesJoinedMem").val(minutesJoinedMem);

        var minutesInfoModForm = document.getElementById('updateMinutesMetaForm');
        var formData = new FormData(minutesInfoModForm);

        $.ajax({
            url : "/minutes/manage/updateMinutesMeta",
            data : formData,
            type : "POST",
            cache : false,
            contentType : false,
            enctype : 'multipart/form-data',
            processData : false,
            async: true,
            success : function (data) {
                alert(data);
                if(data=="SUCCESS"){
                    //location.href = "/minutes/manage/minutesList";
                }
            },
            fail:function(data){
                //console.log(data)
            },
            error: function(data, status, error){
                console.log(error);
            }
        });

    }

    function updateSttResult(sttResultSer){

        var minutesEmployee = $("#employee_"+sttResultSer).val();
        var sttChgResult = $("#sttChgResult_"+sttResultSer).val();

        if( isEmpty(minutesEmployee) ){
            alert("사원명을 입력해 주시기 바랍니다.");
            return false;
        }

        var param={
            sttResultSer :sttResultSer,
            minutesEmployee : minutesEmployee,
            sttChgResult : sttChgResult
        };

        $.ajax({
            url : "/minutes/manage/updateSttResult",
            data : param,
            type : "POST",
            success : function (data) {
                alert(data);
                if(data=="SUCCESS"){

                    getsEmployee();

                }
            },
            fail:function(data){
                //console.log(data)
            },
            error: function(data, status, error){
                console.log(error);
            }
        });

    }

    function updateEmptyToNullBySttChgResult(sttResultSer){

        if( isEmpty(sttResultSer) ){
            alert("잘못된 접근입니다.");
            return false;
        }

        var param={
            sttResultSer :sttResultSer
        };

        $.ajax({
            url : "/minutes/manage/updateEmptyToNullBySttChgResult",
            data : param,
            type : "POST",
            success : function (data) {
                alert(data);
                if(data=="SUCCESS"){
                    $("textarea[name='sttChgResult_" + sttResultSer +"']").text('');
                }
            },
            fail:function(data){
                //console.log(data)
            },
            error: function(data, status, error){
                console.log(error);
            }
        });

    }

    function memoSave(){

        var sttMetaSer = $("#sttMetaSer").val();
        var memo = $("#memo").val();

        if( isEmpty(sttMetaSer) ){
            alert("잘못된 접근입니다.");
            return false;
        }

        var param={
            sttMetaSer : sttMetaSer,
            memo : memo
        };

        $.ajax({
            url : "/minutes/manage/updateMemo",
            data : param,
            type : "POST",
            success : function (data) {
                alert(data);
                if(data=="SUCCESS"){
                }
            },
            fail:function(data){
                //console.log(data)
            },
            error: function(data, status, error){
                console.log(error);
            }
        });

    }

    function getsEmployee(){

        var sttMetaSer = $("#sttMetaSer").val();

        if( isEmpty(sttMetaSer) ){
            alert("잘못된 접근입니다.");
            return false;
        }

        var param={
            sttMetaSer : sttMetaSer
        };

        $.ajax({
            url : "/minutes/manage/getsEmployee",
            data :param,
            type : "POST",
            dataType: "json",
            success : function (data) {

                var result = data.employee;
                if(data != null && result.length > 0){

                    var html = "";
                    html += "<ul>";
                    for(var i=0; i<result.length; i++){
                        html+= "<li>";
                        html+= "    <span>";
                        html+= "        <em class='name'>";
                        html+="             <input text='text' class='ipt_txt inline' name='employeeAll_"+(i+1)+ "' id='employeeAll_"+(i+1)+"' value="+result[i].minutes_employee+">";
                        html+="             <button type='button' class='btn btn-success' style='margin-top:5px;' onclick='updateMinutesAllEmployee(\""+ result[i].minutes_employee +"\",\""+ (i+1) +"\");' >수정</button>";
                        html+="         </em>";
                        html+="     </span>";
                        html+="</li>";
                    }
                    html+="</ul>";

                    $("#lst_mic").html(html);

                }
            },
            fail:function(data){
                //console.log(data)
            },
            error: function(data, status, error){
                console.log(error);
            }
        });


    }

    function addJoinMember(){

        var inputLenth = $("input[name^='joinMember']").length+1;
        var html = "<br/>";
        for(var i=0; i<5; i++){
            html += "<input type='text' class='ipt_txt inline' style='margin:2px 3px 4px 0px;' name='joinMember"+ (inputLenth+i)+"' id='joinMember"+(inputLenth+i)+"'>";

        }
        $("#joinMemAdd").before(html);
    }


    function closePopup(){
        self.close();
    }

    function validationForm() {

        var minutesName = $('#minutesName').val();
        var minutesMeetingroom = $("#minutesMeetingroom").val();
        var startTime = $('#startTime').val();
        var endTime = $("#endTime").val();
        var minutesTopic = $('#minutesTopic').val();
        var joinMember = $("input[name^='joinMember']")[0].value;

        var startTimeGetDate = $("#startTime").datetimepicker("getDate");
        var endTimeGetDate = $("#endTime").datetimepicker("getDate");

        if( isEmpty(minutesName) ){
            alert("회의명을 입력해 주시기 바랍니다.");
            return false;
        }

        if( isEmpty(minutesMeetingroom) ){
            alert("회의실을 입력해 주시기 바랍니다.");
            return false;
        }

        if( isEmpty(startTime) ){
            alert("회의시작을 지정해 주시기 바랍니다.");
            return false;
        }

        if( !isEmpty(endTime) &&  0>= endTimeGetDate - startTimeGetDate ){
            alert("회의종료시간 설정이 잘못 되었습니다.");
            return false;
        }

        if( isEmpty(minutesTopic) ){
            alert("회의 안건을 입력해 주시기 바랍니다.");
            return false;
        }
        if( isEmpty(joinMember) ){
            alert("회의 참석자를 한명 이상 지정해주세요");
            return false;
        }

        return true;
    }

</script>
</html>
