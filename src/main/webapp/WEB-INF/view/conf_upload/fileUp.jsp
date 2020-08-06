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
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reset.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/font.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/all.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>" />
    <title>회의현황 ll 회의록시스템</title>
    <style>
        .btn-file {
            position: relative;
            overflow: hidden;
        }
        .btn-file input[type=file] {
            position: absolute;
            top: 0;
            right: 0;
            min-width: 100%;
            min-height: 100%;
            font-size: 100px;
            text-align: right;
            filter: alpha(opacity=0);
            opacity: 0;
            outline: none;
            background: white;
            cursor: inherit;
            display: block;
        }
    </style>
</head>

<body>
<!-- layerPopup -->
<!-- //layerPopup -->
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
    <!-- #container -->
    <div id="container" class="div_normal">
        <%@ include file="../common/leftMenu.jsp" %>

        <!-- #contents -->
        <div id="contents">
            <!-- .content -->
            <div class="content">
                <!-- .titArea -->
                <div class="titArea">
                    <h3>파일 업로드 변환</h3>
                </div>

                <div class="stn">
                    <form name="fileUploadForm" id="fileUploadForm" action="javascript:fileUpload();" onsubmit="return false;">
                    <div class="roomBox form-group">
                            <ul>
                                <li class="room_item">
                                    <span class="room">
                                        <em class="room_top"></em>
                                        <em class="room_btm">
                                        <button type="button">
                                                <%--<strong class="far fa-calendar-check"></strong>--%>
                                        <label class="btn btn-primary btn-file">
                                            내 PC에서 찾기 <input type="file" multiple="multiple" name="files" id="files" style="display: none;">
                                        </label>
                                            </button>
                                        </em>
                                    </span>
                                </li>
                                <li style="overflow:auto;height: 200px;">
                                    <%--<div class="tblBox">--%>
                                        <table class="tblType01" name="fileList" id="fileList">
                                            <colgroup>
                                                <col><col><col>
                                            </colgroup>
                                            <thead>
                                            <tr>
                                                <th scope="col">check</th>
                                                <th scope="col">파일명</th>
                                                <th scope="col">작성</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td colspan="3">등록된 파일이 없습니다</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    <%--</div>--%>
                                    <span>
                                        <button onclick="delCheckList();">삭제</button>
                                    </span>
                                </li>
                                <li>
                                    <div>
                                        <div>
                                        </div>

                                        <div>
                                        </div>
                                    </div>
                                </li>
                                <li class="room_item">
                        <span class="room">
                            <em class="room_top"></em>
                            <em class="room_btm">
                            <button type="button" onclick="fileUpload();">
                                    <strong class="far fa-calendar-check"></strong>
                                        회의록 변환
                                </button>
                            </em>
                        </span>
                                </li>
                            </ul>
                    </div>
                    </form>
                </div>
                <!-- //.titArea -->
                <!-- .section -->
                <!-- //.section -->
                <form  action="/fileUpExcelDown" method="POST" id="excelDownForm">
                    <input type="hidden" id="sttMetaSer" name="sttMetaSer" value=""/>
                </form>

                <form name="mainFrm" method="post" action="sel_script">
                    <!-- .tblBox -->
                    <div class="tblBox">
                        <table class="tblType01">
                            <caption class="hide">회의현황 목록</caption>
                            <colgroup>
                                <col><col><col><col>
                                <col><col><col><col><col>
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">파일명</th>
                                <th scope="col">파일길이</th>
                                <th scope="col">처리상태</th>
                                <th scope="col">Site Name</th>
                                <th scope="col">회의룸</th>
                                <th scope="col">회의명</th>
                                <th scope="col">회의일자</th>
                                <th scope="col">시작시간</th>
                                <th scope="col">종료시간</th>
                                <th scope="col">엑셀 다운로드</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${result}" var="result" varStatus="status">
                                <tr>
                                    <td>${result.file_name}</td>
                                    <td>${result.rec_time}</td>
                                    <td>${result.minutes_status_name}</td>
                                    <td>${result.site_name}</td>
                                    <td>${result.minutes_meetingroom}</td>
                                    <td>${result.minutes_name}</td>
                                    <td>${result.minutes_date}</td>
                                    <td>${result.start_time}</td>
                                    <td>${result.end_time}</td>
                                    <c:choose>
                                        <c:when test="${result.minutes_status eq 2}">
                                            <td><button type='button' class='btn_tbl' onclick="excelDown('${result.stt_meta_ser}');">다운로드</button> </td>
                                        </c:when>
                                        <c:otherwise>
                                            <td></td>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <!-- //.tblBox -->

                    <div class="div_bottom">
                        <div class="tbl_100">
                            <div class="row">
                                <div class="paging row">
                                    <%@ include file="../common/paging.jsp" %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- hidden. paging -->
                    <input type="hidden" id="currentPage" name="currentPage" value="${frontUploadVO.currentPage}">
                </form>
            </div>
        </div>
        <!-- //#container -->
    </div>
</div>
<!-- //#wrap -->
</body>

<script type="text/javascript" src="<c:url value='/resources/js/jquery-3.4.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/all.js'/>"></script>
<script type="text/javascript">

    $(document).ready(function() {
        $("input[type=file]").change(function () {

            var fileInput = document.getElementById("files");

            var files = fileInput.files;

            var html = "";
            for (var i = 0; i < files.length; i++) {

                html += "<tr id='"+ files[i].name +"'>";
                html +=     "<td><input type='checkbox' name='fileCheck' value="+ files[i].name+"></td>";
                html +=     "<td>" + files[i].name + "</td>";
                html +=     "<input type='hidden' name='fileName' value='"+ files[i].name +"'>";
                html +=     "<input type='hidden' name='minutesMeetingroom'>";
                html +=     "<input type='hidden' name='minutesName'>";
                html +=     "<input type='hidden' name='minutesMachine'>";
                html +=     "<input type='hidden' name='startTime'>";
                html +=     "<input type='hidden' name='minutesTopic'>";
                html +=     "<input type='hidden' name='confJoinedEmpName'>";
                html +=     "<input type='hidden' name='confJoinedEmpId'>";
                html +=     "<input type='hidden' name='confJoinedCnt'>";
                html +=     "<td><button type='button' class='btn_tbl' onclick='addInfo(\""+ files[i].name+"\");'>작성</button></td>";
                html += "</tr>";
            }
            $("#fileList tbody").html(html);

        });

    });

    function goSch(){
        //mainFrm.method = "POST";
        mainFrm.method = "GET";
        mainFrm.action = "/fileUp";
        mainFrm.submit();

    }
    //페이지 이동
    function goPage(num){

        $('#currentPage').val(num);
        goSch();

    }

    function fileUpload(){

        var fileUploadForm = document.getElementById('fileUploadForm');
        var formData = new FormData(fileUploadForm);

        var flag = true;

        let formDataKey = "";
        let formDataVal = "";
        let formDataLength = 0;
        let message = "";
        for(var form of formData.entries()){
            formDataKey = form[0];
            formDataVal = form[1];

            if(formDataKey == "files" && formDataVal.name == ""){
                message = "파일을 등록해주세요";
                flag = false;
                break;
            }
            if(formDataVal == ""){
                message = "파일에 대한 작성이 완료 되지 않았습니다.";
                flag = false;
                break;
            }

            formDataLength++;
        }

        if(!flag || formDataLength == 0){
            alert(message);
            return false;
        }

        if(flag){

            //startLoading();

            $.ajax({
                url : "fileUpOk",
                data : formData,
                type : "POST",
                cache : false,
                contentType : false,
                enctype : 'multipart/form-data',
                processData : false,
                async: true
            }).done(function(data){
                //endLoading();
                alert(data);
                if(data=="SUCCESS"){
                    location.reload();
                }
                //console.log("### SUCC : " + data);
            }).fail(function(data){
                //endLoading();
                console.log("### FAIL : " + data);
            });
        }


    }

    function addInfo(fileName){
        var popSize = "width=800,height=650";
        var popOption = "titlebar=no,toolbar=no,menubar=no,location=no,directories=no,status=no,scrollbars=no";
        pop1 = window.open("/fileSetUpConf?site_ser=1&file_name=" + fileName, "pop1", popSize + "," + popOption);
        console.log(file);

    }

    function delCheckList(){

        $("input[name=fileCheck]:checked").each(function() {

            var val = $(this).val();

            var fileList = $("#fileList tbody tr");
            for(var i=0; i<fileList.length; i++){
                if(fileList[i].id == val){
                    fileList[i].remove();
                }
            }

            var html = "";
            if($("#fileList tbody tr").length == 0){
                html += "<tr>";
                html += "   <td colspan='3'>등록된 파일이 없습니다</td>";
                html += "</tr>";
                $("#fileList tbody").html(html);
            }
        });

    }

    function excelDown(stt_meta_ser){
        $('#sttMetaSer').val(stt_meta_ser);

        $('#excelDownForm').submit();
    }


</script>

</html>