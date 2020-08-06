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

    <c:set var="path"  value="${pageContext.request.contextPath}" />

    <link rel="stylesheet" type="text/css" href="${path}/resources/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/font.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/all.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/bootstrap-datetimepicker.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/common.css" />
    <link rel="shortcut icon" type="image/x-icon" href="${path}/resources/images/ico_favicon_60x60.png"><!-- 윈도우즈 사이트 아이콘, HiDPI/Retina 에서 Safari 나중에 읽기 사이드바 -->

    <script type="text/javascript" src="${path}/resources/js/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript" src="${path}/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${path}/resources/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="${path}/resources/js/moment.min.js"></script>
    <script type="text/javascript" src="${path}/resources/js/ko.js"></script>
    <script type="text/javascript" src="${path}/resources/js/all.js"></script>
    <script type="text/javascript" src="${path}/resources/js/common.js"></script>


    <style>
        .iptBox .ipt_date{
            width: 170px;
        }
    </style>
    <title>회의록작성 ll 회의록시스템</title>
</head>
<body>
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
                <li><a href="/logout">로그아웃</a></li>
            </ul>
        </div>
        <!-- //.etc -->
    </div>
    <!-- //#header -->
    <!-- #container -->
    <div id="container" class="div_normal">
        <%@ include file="../../common/leftMenu.jsp" %>

        <!-- #contents -->
        <div id="contents">
            <!-- .content -->
            <div class="content">
                <!-- .titArea -->
                <div class="titArea">
                    <h3>회의록작성</h3>
                </div>
                <!-- //.titArea -->
                <!-- .stn -->
                <div class="stn">
                    <form name="file-upload-form" id="file-upload-form" onsubmit="return false;">
                        <input type="hidden" name="minutesJoinedMem" id="minutesJoinedMem">
                        <input type="hidden" name="minutesMachine" id="minutesMachine" value="">
                        <table class="tbl_line_view" summary="회의명/회의실/상품명/고객관리번호/주민번호/모니터링종류/과일/사용여부/URL로 구성됨">
                            <caption class="hide">테이블 제목</caption>
                            <colgroup>
                                <col width="120"><col><col width="120"><col>
                                <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                            </colgroup>
                            <tbody>
                            <tr>
                                <th scope="row">회의명</th>
                                <td>
                                    <div class="iptBox">
                                        <input type="text" class="ipt_txt" id="minutesName" name="minutesName">
                                    </div>
                                </td>
                                <th>회의실</th>
                                <td>
                                    <div class="iptBox">
                                        <input type="text" class="ipt_txt" id="minutesMeetingroom" name="minutesMeetingroom">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">회의시작</th>
                                <td>
                                    <div class="iptBox">
                                        <input type="text" class="ipt_date fromDate" data-date-format="yyyy-mm-dd hh:ii:00" id="startTime" name="startTime" readonly="readonly">
                                    </div>
                                </td>
                                <th>회의종료</th>
                                <td>
                                    <div class="iptBox">
                                        <input type="text" class="ipt_date toDate" data-date-format="yyyy-mm-dd hh:ii:00" id="endTime" name="endTime"  readonly="readonly">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">회의안건</th>
                                <td colspan="3">
                                    <div class="iptBox">
                                        <input type="text" class="ipt_txt" id="minutesTopic" name="minutesTopic">
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th scope="row">회의참석자</th>
                                <td colspan="3">
                                    <div class="iptBox inline">
                                        <input type="text" class="ipt_txt" name="joinMember1">
                                        <input type="text" class="ipt_txt" name="joinMember2">
                                        <input type="text" class="ipt_txt" name="joinMember3">
                                        <input type="text" class="ipt_txt" name="joinMember4">
                                        <input type="text" class="ipt_txt" name="joinMember5">
                                        <button type="button" class="btn_ico" name="joinMemAdd" id="joinMemAdd" onclick="addJoinMember();"><span class="fas fa-plus"></span><em>추가</em></button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">회의록 음성파일 UPLOAD</th>
                                <td colspan="3" class="tdFiles">
                                <input id="uploadFile" type="file" name="uploadFile" class="addFile" style="display: none;"/>
                                <label for="uploadFile" id="file-drag">
                                    <p class="txt">마우스로 파일을 끌어 넣으세요.</p>
                                    <span id="file-upload-btn" class="button">파일선택</span>
                                </label>

                                <progress id="file-progress" value="0">
                                    <span>0</span>
                                </progress>

                                <output for="file-upload" id="messages"></output>

                                </td>
                            </tr>
                            <tr>
                                <th scope="row">메모</th>
                                <td colspan="3">
                                    <div class="textareaBox">
                                        <textarea placeholder="내용을 입력해 주세요." id="memo" name="memo"></textarea>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
                <!-- //.stn -->
                <!-- .paging_wrap -->
                <div class="paging_wrap">
                    <div class="btnBox right">
                        <button type="button" class="point" onclick="doConfSave();"><span class="fas fa-edit"></span>작성완료</button>
                    </div>
                </div>
                <!-- //.paging_wrap -->
            </div>
            <!-- //.content -->
        </div>
        <!-- //#contents -->

    </div>
</div>
<script>
    $(document).ready(function (){
        setActiveMenu();
        $('.fromDate').datetimepicker({
            language : 'ko', // 화면에 출력될 언어를 한국어로 설정한다.
            pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략한다.
            defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력한다. 기본값을 해제하려면 defaultDate 옵션을 생략한다.
            autoclose: 1,
        });

        $('.toDate').datetimepicker({
            language : 'ko',
            pickTime : false,
            defalutDate : new Date(),
            autoclose: 1,
        });

        // DateTimePicker 위젯은 기본적으로 TextBox이므로 아래와 같은 일반적인 방법으로 사용자가 입력한 날짜를 획득할 수 있다.
        var fromDate = $('.fromDate').val(); // '2014.01.01'
        var toDate = $('.toDate').val(); // '2014.12.31'

    });
    (function() {
        function Init() {
            var fileSelect = document.getElementById('uploadFile'),
                fileDrag = document.getElementById('file-drag'),
                submitButton = document.getElementById('submit-button');

            fileSelect.addEventListener('change', fileSelectHandler, false);

            // Is XHR2 available?
            var xhr = new XMLHttpRequest();
            if (xhr.upload) {
                // File Drop
                fileDrag.addEventListener('dragover', fileDragHover, false);
                fileDrag.addEventListener('dragleave', fileDragHover, false);
                fileDrag.addEventListener('drop', fileSelectHandler, false);
            }
        }

        function fileDragHover(e) {
            var fileDrag = document.getElementById('file-drag');

            e.stopPropagation();
            e.preventDefault();

            fileDrag.className = (e.type === 'dragover' ? 'hover' : 'modal-body file-upload');
        }

        function fileSelectHandler(e) {
            // Fetch FileList object
            var files = e.target.files || e.dataTransfer.files;
            addFileInfo(files);
            // Cancel event and hover styling
            fileDragHover(e);

            // Process all File objects
            for (var i = 0, f; f = files[i]; i++) {
                parseFile(f);
                uploadFile(f);
            }
        }

        function output(msg) {
            var m = document.getElementById('messages');
            m.innerHTML = msg;
        }

        function parseFile(file) {
            output(
                '<table class="tblType01">'
                +	'<colgroup>'
                +		'<col><col><col>'
                +	'</colgroup>'
                +	'<thead>'
                +		'<tr>'
                +			'<th scope="col">파일이름</th>'
                +			'<th scope="col">파일종류</th>'
                +			'<th scope="col">파일크기</th>'
                +		'</tr>'
                +	'</thead>'
                +	'<tbody>'
                +		'<tr>'
                +			'<td scope="row">' + encodeURI(file.name) +'</td>'
                +			'<td>' + file.type + '</td>'
                +			'<td>' + (file.size / (1024 * 1024)).toFixed(2) + 'MB</td>'
                +		'</tr>'
                +	'</tbody>'
                +'</table>'
            );
        }

        function setProgressMaxValue(e) {
            var pBar = document.getElementById('file-progress');

            if (e.lengthComputable) {
                pBar.max = e.total;
            }
        }

        function updateFileProgress(e) {
            var pBar = document.getElementById('file-progress');

            if (e.lengthComputable) {
                pBar.value = e.loaded;
            }
        }

        function uploadFile(file) {

            var xhr = new XMLHttpRequest(),
                fileInput = document.getElementById('class-roster-file'),
                pBar = document.getElementById('file-progress'),
                fileSizeLimit = 1024;	// In MB
            if (xhr.upload) {
                // Check if file is less than x MB
                if (file.size <= fileSizeLimit * 1024 * 1024) {
                    // Progress bar
                    pBar.style.display = 'block';
                    xhr.upload.addEventListener('loadstart', setProgressMaxValue, false);
                    xhr.upload.addEventListener('progress', updateFileProgress, false);

                    // File received / failed
                    xhr.onreadystatechange = function(e) {
                        if (xhr.readyState == 4) {
                            // Everything is good!

                            // progress.className = (xhr.status == 200 ? "success" : "failure");
                            // document.location.reload(true);
                        }
                    };

                } else {
                    output('Please upload a smaller file (< ' + fileSizeLimit + ' MB).');
                }
            }
        }

        // Check for the various File API support.
        if (window.File && window.FileList && window.FileReader) {
            Init();
        } else {
            document.getElementById('file-drag').style.display = 'none';
        }
    })();

    function doConfSave(){

        var flag = validationForm();

        if(flag){
            save();
        }
    }

    function addJoinMember(){

        var inputLenth = $("input[name^='joinMember']").length+1;
        var html = "<br/>";

        for(var i=0; i<5; i++){
            html += "<input type='text' class='ipt_txt' style='margin:2px 2.5px 0px 0px;' name='joinMember"+ (inputLenth+i)+"'>";

        }
        $("#joinMemAdd").before(html);
    }

    function validationForm() {

        var minutesName = $('#minutesName').val();
        var minutesMeetingroom = $("#minutesMeetingroom").val();
        var startTime = $('#startTime').val();
        var endTime = $("#endTime").val();
        var minutesTopic = $('#minutesTopic').val();
        var joinMember = $("input[name^='joinMember']")[0].value;
        var file = $("#uploadFile").val();
        var fileInfo = $("#uploadFile")[0].files[0];

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
        if(file == ''){
            alert("등록된 회의록 음성파일이 없습니다.");
            return false;
        }

        if(fileInfo== undefined){
            alert("등록된 회의록 음성파일이 없습니다.");
            return false;
        }

        var lastDot = fileInfo.name.lastIndexOf('.');
        var fileLength = fileInfo.name.length;

        // 확장자 명만 추출한 후 소문자로 변경
        var fileExt = fileInfo.name.substring(lastDot, fileLength).toLowerCase();

        if(fileExt != '.wav'){
            alert("wav 파일만 업로드가 가능합니다.");
            return false;
        }

        return true;
    }

    function save(){

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

        var fileUploadForm = document.getElementById('file-upload-form');
        var formData = new FormData(fileUploadForm);

        $.ajax({
            url : "/minutes/manage/minutesReg",
            data : formData,
            type : "POST",
            cache : false,
            contentType : false,
            enctype : 'multipart/form-data',
            processData : false,
            async: true
        }).done(function(data){
            alert(data);
            if(data=="SUCCESS"){
                location.href = "/minutes/manage/minutesList";
            }
            //console.log("### SUCC : " + data);
        }).fail(function(data){
            console.log("### FAIL : " + data);
        });

    }

    function addFileInfo(file){
        var a = $('input#uploadFile.addFile');
        a[0].files = file;

        return 0;
    }

</script>
</body>
</html>
