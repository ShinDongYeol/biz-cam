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
    <!-- css -->
    <link rel="shortcut icon" type="image/x-icon" href="${path}/resources/images/ico_favicon_60x60.png">

    <link rel="stylesheet" type="text/css" href="${path}/resources/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/font.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/all.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/common.css" />

    <script type="text/javascript" src="${path}/resources/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${path}/resources/js/all.js"></script>
    <script type="text/javascript" src="${path}/resources/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="${path}/resources/js/common.js"></script>
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
                    <h3>회의록관리</h3>
                </div>
                <!-- //.titArea -->

                <!-- .section -->
                <div class="stn">
                    <div class="srchBox">
                        <dl>
                            <dt>회의록 검색</dt>
                            <dd>
                                <input type="text" class="ipt_date fromDate" placeholder="시작일" id="sStartDate" name="sStartDate" value="${frontMinutesVO.searchStartDate}">
                                <span>-</span>
                                <input type="text" class="ipt_date toDate" placeholder="종료일" id="sEndDate" name="sEndDate" value="${frontMinutesVO.searchEndDate}">
                                <button type="button" class="btn_srch" onclick="goSch();"><span class="fas fa-search"></span>조회</button>
                            </dd>
                        </dl>
                    </div>
                </div>
                <!-- //.section -->
                <form  action="/minutes/manage/excelDown" method="POST" id="excelDownForm" name="excelDownForm">
                    <input type="hidden" name="sttMetaSer" value=""/>
                </form>

                <div class="tblTop">
                    <div class="srchNum">총 <span>${paging.totalCount}</span>건이 검색되었습니다.</div>
                </div>
                <form name="mainFrm" method="post" action="sel_script">
                    <input type="hidden" name="sttMetaSer" id="sttMetaSer" value="${frontMinutesVO.sttMetaSer}">
                    <input type="hidden" name="searchStartDate">
                    <input type="hidden" name="searchEndDate">
                <!-- .tblBox -->
                <div class="tblBox">
                    <table class="tblType01">
                        <caption class="hide">회의록 목록</caption>
                        <colgroup>
                            <col width="30"><col><col><col><col>
                            <col><col><col><col><col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">
                                <div class="ipt_check_only">
                                    <input type="checkbox" id="ipt_check_all" class="ipt_check">
                                </div>
                            </th>
                            <th scope="col">번호</th>
                            <th scope="col">회의명</th>
                            <th scope="col">사이트</th>
                            <th scope="col">회의실</th>
                            <th scope="col">작성자</th>
                            <th scope="col">작성일시</th>
                            <th scope="col">수정일시</th>
                            <th scope="col">파일</th>
                            <th scope="col">작성여부</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${fn:length(result) gt 0}">
                                <c:forEach items="${result}" var="result" varStatus="status">
                                    <tr>
                                        <td scope="row">
                                            <div class="ipt_check_only">
                                                <input type="checkbox" class="ipt_check" id="sttMetaSerChk_${status.index+1}" name="sttMetaSerChk" value="${result.stt_meta_ser}">
                                            </div>
                                        </td>
                                        <td>${result.stt_meta_ser}</td>
                                        <td>
                                            <a class="link" href="javascript:goRecordScript('${result.stt_meta_ser}');">${result.minutes_name}</a>
                                        </td>
                                        <td>${result.site_name}</td>
                                        <td>${result.minutes_meetingroom}</td>
                                        <td>${result.user_name}</td>
                                        <td>${result.create_time}</td>
                                        <td>${result.update_time}</td>
                                        <c:choose>
                                            <c:when test="${result.minutes_status eq 2}">
                                                <td>
                                                    <button type='button' class='btn_ico' onclick="excelDown('${result.stt_meta_ser}');">
                                                    <span class="fas fa-file-excel"></span>
                                                    <em>엑셀 다운로드</em>
                                                    </button>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td></td>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${result.minutes_status eq 1}">
                                                <td><span class="ico_circle_txt working">진행중</span></td>
                                            </c:when>
                                            <c:when test="${result.minutes_status eq 2}">
                                                <td><span class="ico_circle_txt complete">완료</span></td>
                                            </c:when>
                                            <c:when test="${result.minutes_status eq 3}">
                                                <td><span class="ico_circle_txt error">실패</span></td>
                                            </c:when>
                                            <c:otherwise>
                                                <td><span class="ico_circle_txt">미완료</span></td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="10" scope="row">데이터가 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
                <!-- //.tblBox -->

                <!-- .paging_wrap -->
                <div class="paging_wrap">
                    <div class="btnBox left">
                        <button type="button" class="btn_lyr_open btn_lyr_remove"><span class="fas fa-check"></span>선택삭제</button>
                    </div>
                    <div class="paging">
                        <a class="btn_paging_first" href="javascript:goPage('1')"><span class="fas fa-angle-double-left"><em>처음페이지</em></span> </a></a>
                        <a class="btn_paging_prev" href="javascript:goPage('${paging.prevPage}')"><span class="fas fa-angle-left"><em>이전페이지</em></span></a>

                        <c:forEach begin="${paging.pageRangeStart}" end="${paging.pageRangeEnd}" varStatus="loopIdx">
                            <c:choose>
                                <c:when test="${paging.currentPage eq loopIdx.index}">
                                    <strong>${loopIdx.index}</strong>
                                </c:when>
                                <c:otherwise>
                                    <a href="javascript:goPage('${loopIdx.index}')">${loopIdx.index}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <a class="btn_paging_next" href="javascript:goPage('${paging.nextPage}')"><span class="fas fa-angle-right"><em>다음페이지</em></span></a>
                        <a class="btn_paging_end" href="javascript:goPage('${paging.totalPage}')"><span class="fas fa-angle-double-right"><em>마지막페이지</em></span></a>
                    </div>
                    <div class="btnBox right">
                        <a class="point" href="/minutes/manage/minutesCreate"><span class="fas fa-edit"></span>회의록작성</a>
                    </div>
                </div>
                <!-- //.paging_wrap -->

                    <input type="hidden" id="currentPage" name="currentPage" value="${frontUploadVO.currentPage}">
                </form>
            </div>
            <!-- //.content -->

        </div>
        <!-- //#contents -->
    </div>
</div>
<!-- //#wrap -->
<!-- lyrWrap -->
<div class="lyrWrap">
    <div class="lyr_bg"></div>
    <!-- 선택삭제 -->
    <div class="lyrBox lyr_remove">
        <div class="lyr_top">
            <h3>삭제</h3>
            <button class="btn_lyr_close">닫기</button>
        </div>
        <div class="lyr_mid">
            <p class="txt al_c">선택된 모델을 삭제 합니다.</p>
        </div>
        <div class="lyr_btm">
            <div class="btnBox sz_small">
                <button class="btn_lyr_close" onclick="delMinutes();">확인</button>
                <button class="btn_lyr_close">취소</button>
            </div>
        </div>
    </div>
    <!-- //선택삭제 -->
</div>
<!-- //lyrWrap-->
</body>


<script type="text/javascript">
    jQuery.event.add(window,"load",function(){
        $(document).ready(function (){
            setActiveMenu();
            $('#page_loading').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });
            //체크박스(전체선택)
            $('#ipt_check_all').on('click',function(){
                var iptCheck01 = $(this).is(":checked");
                if ( iptCheck01 ) {
                    $('.tblType01 input:checkbox').prop('checked', true);
                } else {
                    $('.tblType01 input:checkbox').prop('checked', false);
                }
            });

            //datepicker
            $('.fromDate').datepicker({
                format : "yyyy-mm-dd",
                language : "ko",
                autoclose : true,
                todayHighlight : true,
            });

            $('.toDate').datepicker({
                format : "yyyy-mm-dd",
                language : "ko",
                autoclose : true,
                todayHighlight : true
            });

            setInterval(goSch,60000);


            $('.btn_lyr_open').on('click',function(){
                var sttMetaSerChkArr = $("input[name^='sttMetaSerChk']");

                var flag = false;
                for(var i=0; i<sttMetaSerChkArr.length; i++){
                    if(sttMetaSerChkArr[i].checked){
                        flag = true;
                        break;
                    }
                }
                if(!flag) {
                    $('.lyrWrap').hide();
                    $('.lyrBox').hide();
                    alert("삭제할 회의를 선택해주세요.");
                }else{
                    goDel();
                }
            });

        });

    });

    function goDel(){
        $('.lyr_remove').show();
    }

    function goRecordScript(stt_meta_ser){

        var popSize = "width=1300,height=960";
        var popOption = "titlebar=no,toolbar=no,menubar=no,location=no,directories=no,status=no,scrollbars=no";
        pop1 = window.open("/minutes/manage/recordScript?sttMetaSer="+stt_meta_ser, "pop1", popSize + "," + popOption);

    }

    //페이지 이동
    function goPage(num){
        $('#currentPage').val(num);
        goSch();
    }

    function goSch(){
        //mainFrm.method = "POST";
        var sStartDate = $("#sStartDate").val();
        var sEndDate = $("#sEndDate").val();
        $("form[name=mainFrm] input[name=searchStartDate]").val(sStartDate);
        $("form[name=mainFrm] input[name=searchEndDate]").val(sEndDate);

        var flag = true;

        if(sStartDate == "" && sEndDate != ""){
            flag = false;
            alert("시작일을 선택해주세요");
        }

        if(sStartDate != "" && sEndDate == ""){
            flag = false;
            alert("종료일을 선택해주세요");
        }

        if(sStartDate != "" && sEndDate != ""){
            var sStartDateArr = sStartDate.split("-");
            var sEndDateArr = sEndDate.split("-");
            var t1date = new Date(sStartDateArr[0], sStartDateArr[1], sStartDateArr[2]);
            var t2date = new Date(sEndDateArr[0], sEndDateArr[1], sEndDateArr[2]);
            var diff = t2date - t1date;

            if(diff <0){
                flag = false;
                alert("시작시간 설정이 잘못 되었습니다.");
            }
        }

        if(flag){
            mainFrm.method = "GET";
            mainFrm.action = "/minutes/manage/minutesList";
            mainFrm.submit();
        }
    }

    function delMinutes(){
        var sttMetaSerChkArr = $("input[name^='sttMetaSerChk']");
        var sttMetaDelArr = [];

        var flag = false;
        for(var i=0; i<sttMetaSerChkArr.length; i++){
            if(sttMetaSerChkArr[i].checked){
                flag = true;
                break;
            }
        }

        if(!flag){
            alert("삭제할 회의를 선택해주세요.");
            return false;
        }

        for(var i=0; i<sttMetaSerChkArr.length; i++){
            if(sttMetaSerChkArr[i].checked){
                sttMetaDelArr.push(sttMetaSerChkArr[i].value);
            }
        }

        $.ajax({
            url : "/minutes/manage/minutesDel",
            data : {sttMetaDelArr:sttMetaDelArr},
            traditional : true,
            type : "POST"
        }).done(function(data){
            //console.log("### SUCC : " + data);
            alert("삭제가 완료되었습니다.");
            location.reload();
        }).fail(function(data){
            console.log("### FAIL : " + data);
            alert("삭제 실패했습니다. 다시 시도해 보시기 바랍니다.");
            //location.reload();
        });

    }

    function excelDown(sttMetaSer){
        $("form[name=excelDownForm] input[name=sttMetaSer]").val(sttMetaSer);

        $('#excelDownForm').submit();
    }

</script>

</html>