<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
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
    <link rel="stylesheet" type="text/css" href="<c:url value='/webjars/jquery-ui/1.12.1/jquery-ui.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reset.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/font.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/all.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap-datetimepicker.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/popup.css'/>" />


    <title>회의설정 ll 회의록시스템</title>
</head>
<body>
<!-- #pop_wrap -->
<div id="pop_wrap">
    <!-- .pop_top -->
    <div class="pop_top">
        <h1>회의록 작성</h1>
        <button type="button" class="pop_close">닫기</button>
    </div>
    <!-- //.pop_top -->
    <!-- .pop_mid -->
    <div class="pop_mid">
        <!-- .pop_stn -->
        <div class="pop_stn">
            <div class="pop_stn_tit">
                <h2>예약정보</h2>
            </div>
            <!-- .pop_stn_cont -->
            <div class="pop_stn_cont">
                <dl>
                    <dt>회의명</dt>
                    <dd><input type="text" class="ipt_txt" id="confName" name="confName"></dd>
                </dl>
                <dl>
                    <dt>회의실</dt>
                    <dd>
                        <input type="text" class="ipt_txt" id="minutesMeetingroom" name="minutesMeetingroom">
                    </dd>
                </dl>
                <dl>
                    <dt>회의시작</dt>
                    <dd><input type="text" class="ipt_date fromDate" id="confStartTime" name="confStartTime"></dd>
                </dl>
                <dl>
                    <dt>회의종료</dt>
                    <dd><input type="text" class="ipt_date fromDate" id="confEndTime" name="confEndTime"></dd>
                </dl>
                <dl>
                    <dt>회의안건</dt>
                    <dd><input type="text" class="ipt_txt" id="confTopic" name="confTopic"></dd>
                </dl>
                <dl>
                    <dt>회의참석자</dt>
                    <dd>
                        <input type="text" name="joinMember1">
                        <input type="text" name="joinMember2">
                        <input type="text" name="joinMember3">
                        <input type="text" name="joinMember4">
                        <input type="text" name="joinMember5">
                        <button class="btn_tbl" type="button" name="joinMemAdd" id="joinMemAdd" onclick="addJoinMember();">추가</button>
                    </dd>
                </dl>
            </div>
            <!-- .pop_stn_cont -->
            <div class="btnBox">
                <button type="button" id="confBtnCancel" onclick="cancel();">취소</button>
                <button type="button" onclick="doConfSave();">완료</button>
            </div>
        </div>
        <!-- //.pop_stn -->


    </div>
    <!-- //.pop_mid -->
    <!-- .pop_btm -->

    <!-- //.pop_btm -->
</div>
<!-- //#pop_wrap -->

<!-- hidden. -->
<input type="hidden" id="site_ser" name="site_ser" value="${frontConfVO.site_ser}">
<input type="hidden" id="fileName" name="fileName" value="${frontConfVO.file_name}">
<input type="hidden" id="confJoinedEmpId" name="confJoinedEmpId">

<input type="hidden" id="confSetUpYN" name="confSetUpYN" value="0">
<input type="hidden" id="minutes_id" name="minutes_id" value="">

</body>

<script type="text/javascript" src="<c:url value='/resources/js/jquery-3.4.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/bootstrap-datetimepicker.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/moment.min.js'/>"></script>
<script src="<c:url value='/webjars/jquery-ui/1.12.1/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/ko.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/all.js'/>"></script>

<script type="text/javascript">
    $(document).ready(function (){
        init();

    });

    function init() {
        initDate();
        initBtnEvent();
    }


    function initDate() {
        var fromDateObj = $('#confTime');

        var startDate = new Date();

        fromDateObj.datetimepicker({
            language : 'ko', // 화면에 출력될 언어를 한국어로 설정한다.
            pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략한다.
            defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력한다. 기본값을 해제하려면 defaultDate 옵션을 생략한다.
            autoclose: true
        });
    }

    function  initBtnEvent () {
        $('#schUser').on('click', function (e) {
            searchUser();
        });

        $('#commitUser').on('click', function (e) {
            commitUser();
        });

        $('input[name="switchMic"]').on('change', function(e){
            var confSetUpYN = $('#confSetUpYN').val(); // 회의실 등록 여부.

            if(Number(confSetUpYN) == 0) {
                alert("회의실을 먼저 설정하여 주십시오.");
                this.checked = false;
                return false;
            }
            //setMic(this);
        });
    }

    function searchUser() {
        var param = {
            part : $('#position option:selected').val(),
            name : $('#userName').val(),
            currentPage: $('#currentPage').val()
        };

        $.ajax({
            type: 'POST',
            url : "/searchUser",
            dataType: "json",
            data: param,
            success: function(data){
                drawUserTable(data);
                drawPager(data);
            },
            fail:function(data){console.log(data)},
            error: function(data, status, error){
                console.log(error);
            }
        });
    }

    var checkUser = '';
    var joinMemberNum  ='';
    function drawUserTable(data) {

        var userList = data.userData;
        var tbody = $('#userTable');

        tbody.empty();
        var table ='';
        if(userList == null || typeof userList =='undefined' || userList.length === 0) {
            table ='';
            table = '<tr> <td scope="row" colspan="5">데이터가 없습니다.</td></tr>';
            tbody.append(table);
        }else{
            $.each(userList, function(index, obj){
                console.log(obj);
                table +='' +
                    '<tr>' +
                    '  <td scope="row">' +
                    '    <div class="checkBox">' +
                    '       <input type="checkbox" id="'+obj.minutes_employee_ser+'" name="userCheck" value="'+obj.minutes_employee_ser+'">' +
                    '       <label for="'+obj.minutes_employee_ser+'"></label>' +
                    '    </div>' +
                    '  </td>' +
                    '  <td>'+obj.name+'</td>' +
                    '  <td>'+obj.part+'</td>' +
                    '  <td>'+obj.position+'</td>' +
                    '  <td>' + obj.minutes_employee_ser+'</td>' +
                    '</tr>';

                tbody.append(table);
                table ='';
            });
        }
    }

    //체크박스 선택유저 넣기.
    function commitUser() {

        var checkArray = $('input[name="userCheck"]:checked');

        if(checkUser != ''){
            checkUser += "/";
            joinMemberNum += "/";
        }

        var tempCheckArray = checkUser.split("/");
        var tempJoinMemberNum = joinMemberNum.split("/");
        var isExist = false;

        checkArray.each(function(index) {
            var tr = checkArray.parent().parent().parent().eq(index);
            var td = tr.children();

            var userNo = checkArray.eq(index)[0].value;

            for(var i=0; i<tempJoinMemberNum.length;i++){

                if(userNo == tempJoinMemberNum[i] ){
                    isExist = true;
                    break;
                }
            }

            if(!isExist){
                checkUser += td.eq(1).text() +"/";
                joinMemberNum += checkArray.eq(index)[0].value+"/";
            }

            isExist = false;

        });

        checkUser = checkUser.substring(0, checkUser.length - 1);
        joinMemberNum  = joinMemberNum.substring(0, joinMemberNum.length - 1);


        $('#confJoinedEmpName').val(checkUser);
        $('#confJoinedEmpId').val(joinMemberNum);

    }


    //페이징 그리는걸 따로 둠.
    function drawPager(data) {
        console.log(data);
        var pager = $('#pager');
        pager.empty();
        pager.append(data.pager);
    }

    //페이지 이동
    function goPage(num){
        $('#currentPage').val(num);
        searchUser();
    }


    //회의실 설정 저장
    function doConfSave(){

        var fileName = $("#fileName").val();
        var site_ser = $('#site_ser').val();
        var roomName = $('#minutesMeetingroom').val();
        var minutesMachine = $("#minutesMachine").val();
        var confName = $('#confName').val();
        var confTime = $('#confTime').val();
        var confTopic = $('#confTopic').val();
        var confJoinedEmpName = $('#confJoinedEmpName').val();
        var confJoinedEmpId = $('#confJoinedEmpId').val();
        var joinedCnt = confJoinedEmpName.split(',').length;

        var  param = {
            site_ser:site_ser,
            confName:confName,
            confTime:confTime,
            confTopic:confTopic,
            confJoinedEmpName:confJoinedEmpName,
            confJoinedEmpId:confJoinedEmpId,
            confJoinedCnt:joinedCnt
        };


        var confSetUpYN = $('#confSetUpYN').val();

        if(validation() && confSetUpYN == 0) {
            console.log(confSetUpYN);

            var val = -1;
            var fileList = $("#fileList tbody tr",opener.document);

            for(var i=0; i<fileList.length; i++){
                if(fileList[i].id == fileName){
                    val = i;
                    break;
                }
            }

            $("#fileList tbody tr input[name=minutesMeetingroom]",opener.document)[val].value = roomName; //회의룸 명
            $("#fileList tbody tr input[name=minutesName]",opener.document)[val].value = confName; //회의명
            $("#fileList tbody tr input[name=startTime]",opener.document)[val].value = confTime; //회의시간
            $("#fileList tbody tr input[name=minutesMachine]",opener.document)[val].value = minutesMachine; //회의장비
            $("#fileList tbody tr input[name=minutesTopic]",opener.document)[val].value = confTopic; //안건
            $("#fileList tbody tr input[name=confJoinedEmpName]",opener.document)[val].value = confJoinedEmpName; //참석자명
            $("#fileList tbody tr input[name=confJoinedEmpId]",opener.document)[val].value = confJoinedEmpId; //참석자사번
            $("#fileList tbody tr input[name=confJoinedCnt]",opener.document)[val].value = joinedCnt; //참석자수

            self.close();
        }
    }

    function validation() {

        var confName = $('#confName').val();
        var confTime = $('#confTime').val();
        var confTopic = $('#confTopic').val();
        var confJoinedEmpName = $('#confJoinedEmpName').val();
        var confJoinedEmpId = $('#confJoinedEmpId').val();

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

        return true;
    }

    // 이전 선택 참가자.. 겹침 방지
    var preSelectedUser = [];

    function cancel(){
        self.close();
    }

    function addJoinMember(){

        var inputLenth = $("input[name^='joinMember']").length;
        var html = "";

        for(var i=0; i<5; i++){
            html = "<input type='text' name='joinMember"+ (inputLenth+i)+"'>";
            $("#joinMemAdd").before(html);
        }

    }

</script>
</html>
