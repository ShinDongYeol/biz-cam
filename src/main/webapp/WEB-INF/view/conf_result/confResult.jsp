<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
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
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/webjars/jquery-ui/1.12.1/jquery-ui.css'/>">

    <title>상세보기</title>
</head>
<body>
<form name="mainFrm" method="post" action="sel_script">
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
        <form name="mainFrm" class="mainFrm" method="post" action="sel_script">
            <!-- #container -->
            <div id="container" class="div_normal">
                <%@ include file="../common/leftMenu.jsp" %>

                <!-- #contents -->
                <div id="contents">
                    <!-- .content -->
                    <div class="content">
                        <!-- .titArea -->
                        <div class="titArea">
                            <h3>회의룸  : ${frontConfVO.room_ser}</h3>
                        </div>
                        <!-- //.titArea -->

                        <!-- .section -->
                        <div class="stn">
                            <div class="srchBox">
                                <dl>
                                    <dt>회의명</dt>
                                    <dd><input type="text" class="ipt_txt" id="confName" name="confName" value="${frontConfVO.confName}"></dd>
                                </dl>
                                <%-- <dl>
                                     <dt>회의룸</dt>
                                     <dd><input type="text" class="ipt_txt" id="confRoom" name="confRoom"></dd>
                                 </dl>--%>
                                <dl>
                                    <dt>회의일자</dt>
                                    <dd>
                                        <input type="text" class="ipt_date fromDate" id="confDateStart" name="confDateStart">
                                        <input type="hidden" id="startDate" value="${frontConfVO.confDateStart}">
                                        <span>-</span>
                                        <input type="text" class="ipt_date toDate" id="confDateEnd" name="confDateEnd">
                                        <input type="hidden" id="endDate" value="${frontConfVO.confDateEnd}">
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>참석자</dt>
                                    <dd><input type="text" class="ipt_txt" id="joinedMem" name="joinedMem" value="${frontConfVO.joinedMem}"></dd>
                                </dl>
                                <dl>
                                    <dt>메모내용</dt>
                                    <dd><input type="text" class="ipt_txt" id="confMemo" name="confMemo" value="${frontConfVO.confMemo}"></dd>
                                </dl>
                                <dl>
                                    <dt>선택추가</dt>
                                    <dd><input type="text" class="ipt_txt" id="other" name="other" value="${frontConfVO.other}"></dd>
                                </dl>
                                <p>
                                    <button type="button" onclick="goSch();"><span class="fas fa-search" ></span>조회</button>
                                </p>
                            </div>
                        </div>
                        <!-- //.section -->

                        <!-- .tblBox -->
                        <div class="tblBox">
                            <table class="tblType01">
                                <caption class="hide">회의결과 목록</caption>
                                <colgroup>
                                    <col><col><col><col><col>
                                    <col><col><col>
                                </colgroup>
                                <thead>
                                <tr>
                                    <th scope="col">회의명</th>
                                    <th scope="col">회의룸</th>
                                    <th scope="col">참석인수</th>
                                    <th scope="col">회의일</th>
                                    <th scope="col">예약시간</th>
                                    <th scope="col">녹음시간</th>
                                    <th scope="col">녹음길이</th>
                                    <th scope="col">회의록 내용</th>
                                </tr>
                                </thead>
                                <tbody id="confTable">
                                <c:choose>
                                    <c:when test="${fn:length(resultList) gt 0}">
                                        <c:forEach items="${resultList}" var="dvList" varStatus="status">
                                            <tr>
                                                <td scope="row"><a class="link" href="#">
                                                        ${dvList.minutes_name}
                                                </td>
                                                <td>${dvList.meetingroom_name}</td>
                                                <td>
                                                    <span class="txt">${dvList.minutes_joined_cnt}</span>
                                                    <span class="preveal">
                                                            <em class="fas fa-search"></em>
                                                            <em class="item">${dvList.minutes_joined_mem}</em>
                                                        </span>
                                                </td>
                                                <td>${dvList.minutes_start_date}</td>
                                                <td>${dvList.rec_start_time}</td>
                                                <td>${dvList.rec_end_time}</td>
                                                <td>${dvList.rec_time}</td>
                                                <td>
                                                        <span class="btn">
                                                            <button type="button" class="btn_tbl"  onclick="goScriptView('${dvList.stt_meta_ser}', 'RT');"><span class="fas fa-play"></span>시작</button>
                                                            <button type="button" class="btn_tbl"  onclick="goScriptView('${dvList.stt_meta_ser}', 'REC');"><span class="fas fa-edit"></span>편집</button>
                                                        </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                        <!-- //.tblBox -->
                        <!-- .paging_wrap -->
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
                        <input type="hidden" id="currentPage" name="currentPage" value="${frontConfVO.currentPage}">
                        <input type="hidden" id="meta_ser" name="meta_ser">
                        <input type="hidden" id="room_ser" name="room_ser" value="${frontConfVO.room_ser}">
                        <!-- //.paging_wrap -->
                    </div>
                    <!-- //.content -->
                </div>
                <!-- //#contents -->
            </div>
            <!-- //#container -->
        </form>
    </div>
    <!-- //#wrap -->
</form>
</body>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-3.4.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/bootstrap-datetimepicker.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/moment.min.js'/>"></script>
<script src="<c:url value='/webjars/jquery-ui/1.12.1/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/ko.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/all.js'/>"></script>
]
<script type="text/javascript">

    $(document).ready(function (){
        $('#page_loading').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });
        setActiveMenu();

        init();
    });

    function init() {
        initDate();
    }

    function doInit(){
        $('#confName').val("");
        $('#confRoom').val("");
        $('#confDateStart').val("");
        $('#confDateEnd').val("");
        $('#joinedMem').val("");
        $('#confMemo').val("");
        $('#other').val("");
    }

    function initDate() {
        var fromDateObj = $('.fromDate');
        var toDateObj =  $( ".toDate" );

        var startDate = new Date();
        var endDate = new Date();

        fromDateObj.datepicker({
            dateFormat: 'yy-mm-dd',
            onSelect: function(d,i){
                $('.toDate').datepicker("option", "minDate", d);
            }
        });

        toDateObj.datepicker({
            dateFormat: 'yy-mm-dd',
            maxDate: 0 // 오늘 이후 날짜 선택 불가
        });

        startDate.setDate(startDate.getDate() - 1);

        var selectedSdate = $('#startDate').val();
        var selectedEdate = $('#endDate').val();

        //검색에 의한 설정이라면...
        if($.trim(selectedSdate).length > 0 ) {
            startDate = selectedSdate;
            endDate = selectedEdate;
        }
        fromDateObj.datepicker('setDate', startDate);
        toDateObj.datepicker('setDate', endDate);
        toDateObj.datepicker("option", "minDate", startDate);
    }

    //조회 버튼


    function goSch() {
        //mainFrm.method = "POST";
        mainFrm.method = "GET";
        mainFrm.action = "/confResult";
        mainFrm.submit();
    }

    //페이지 이동
    function goPage(num){
        $('#currentPage').val(num);
        goSch();
    }

    function goScriptView(ser, part){
        console.log("### ser:" + ser + ",   part:" + part);
        var url = "rt_script";

        if( part == 'REC'){
            url = "recEdit_script";
        }

        $('#meta_ser').val(ser);

        mainFrm.method = "POST";
        mainFrm.action = url;
        mainFrm.submit();
    }


</script>


</html>
