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


    <title>사이트관리 ll 회의록시스템</title>
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
                <li><a href="/logout">로그아웃</a></li>
            </ul>
        </div>
        <!-- //.etc -->
    </div>
    <!-- //#header -->
    <form name="mainFrm" class="mainFrm" method="post" onsubmit="return false;">
        <!-- #container -->
        <div id="container" class="div_normal">
            <%@ include file="../common/leftMenu.jsp" %>

            <!-- #contents -->
            <div id="contents">
                <!-- .content -->
                <div class="content">
                    <!-- .titArea -->
                    <div class="titArea">
                        <h3>사이트 관리</h3>
                    </div>
                    <!-- //.titArea -->

                    <!-- .section -->
                    <div class="stn">
                        <div class="srchBox">
                            <dl>
                                <dt>사이트검색</dt>
                                <dd>
                                    <input type="text" class="ipt_txt" id="sch_site_name" name="sch_site_name" value="${mngSiteVO.sch_site_name}" placeholder="회사이름">
                                    <button type="button" class="btn_srch"  onclick="goSch();"><span class="fas fa-search"></span>조회</button>
                                </dd>
                            </dl>
                        </div>
                    </div>
                    <!-- //.section -->
                    <div class="tblTop">
                        <div class="srchNum">총 <span>${paging.totalCount}</span>건이 검색되었습니다.</div>
                    </div>
                    <!-- .tblBox -->
                    <div class="tblBox">
                        <table class="tblType01">
                            <caption class="hide">사이트 목록</caption>
                            <colgroup>
                                <col><col><col><col><col>
                                <col><col>
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">
                                    <div class="ipt_check_only">
                                        <input type="checkbox" id="ipt_check_all" class="ipt_check">
                                    </div>
                                </th>
                                <th scope="col">번호</th>
                                <th scope="col">사이트 이름</th>
                                <th scope="col">최대 미팅룸</th>
                                <th scope="col">최대 마이크</th>
                                <th scope="col">모델정보 설명</th>
                                <th scope="col">등록일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${fn:length(list) gt 0}">
                                    <c:forEach items="${list}" var="mainList" varStatus="status">
                                        <tr>
                                            <td>
                                                <div class="ipt_check_only">
                                                    <input type="checkbox" class="ipt_check" name="siteCheck" value="${mainList.minutes_site_ser}"/>
                                                </div>
                                            </td>
                                            <td>${mainList.minutes_site_ser}</td>
                                            <td><a class="btn_lyr_view link"  href="javascript:void(0)" onclick="editSite('${mainList.minutes_site_ser}')">${mainList.site_name}</a></td>
                                            <td>${mainList.max_meeting_room_cnt}</td>
                                            <td>${mainList.max_mic_cnt}</td>
                                            <td>${mainList.model_desc}</td>
                                            <td>${mainList.create_time}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td scope="row" colspan="7">데이터가 없습니다.</td>
                                    </tr>
                                </c:otherwise>
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
                                    <div class="paging_wrap">
                                        <div class="btnBox left">
                                            <button type="button" class="btn_lyr_remove"><span class="fas fa-check"></span>선택삭제</button>
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
                                            <button type="button" class="point"  onclick="addSite()"><span class="fas fa-plus"></span>사이트 등록</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- //.paging_wrap -->
                    <input type="hidden" id="currentPage" name="currentPage" value="${siteVO.currentPage}">
                </div>
                <!-- //.content -->
            </div>
            <!-- //#contents -->
        </div>
        <!-- //#container -->
    </form>
</div>
<!-- //#wrap -->

<!-- lyrWrap -->
<div class="lyrWrap">
    <div class="lyr_bg"></div>
    <!-- 상세보기 -->
    <div class="lyrBox lyr_view">
        <div class="lyr_top">
            <h3>사이트 이름</h3>
            <button class="btn_lyr_close">닫기</button>
        </div>
        <div class="lyr_mid">
            <dl class="dlBox">
                <dt>등록일</dt>
                <dd></dd>
            </dl>
            <dl class="dlBox">
                <dt>최대 미팅룸</dt>
                <dd>
                    <div class="iptBox">
                        <input type="text" class="ipt_txt">
                    </div>
                </dd>
            </dl>
            <dl class="dlBox">
                <dt>최대마이크</dt>
                <dd>
                    <div class="iptBox">
                        <input type="text" class="ipt_txt">
                    </div>
                </dd>
            </dl>
            <dl class="dlBox">
                <dt>모델정보 설명</dt>
                <dd>
                    <select class="select">
                        <option>1111</option>
                    </select>
                </dd>
            </dl>
            <dl class="dlBox">
                <dt>휴대폰번호</dt>
                <dd>
                    <div class="iptBox">
                        <input type="text" class="ipt_txt">
                    </div>
                </dd>
            </dl>
        </div>
        <div class="lyr_btm">
            <div class="btnBox sz_small">
                <button class="btn_lyr_close">수정</button>
                <button class="btn_lyr_close">취소</button>
            </div>
        </div>
    </div>
    <!-- //상세보기 -->
    <!-- 선택삭제 -->
    <div class="lyrBox lyr_remove">
        <div class="lyr_top">
            <h3>삭제</h3>
            <button class="btn_lyr_close">닫기</button>
        </div>
        <div class="lyr_mid">
            <p class="txt al_c">선택된 사이트를 삭제 합니다.</p>
        </div>
        <div class="lyr_btm">
            <div class="btnBox sz_small">
                <button class="btn_lyr_close"  onclick="delModel()">확인</button>
                <button class="btn_lyr_close">취소</button>
            </div>
        </div>
    </div>
    <!-- //선택삭제 -->
</div>
<!-- //lyrWrap-->

</body>
<script type="text/javascript">

    $(document).ready(function (){
        $('#page_loading').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });

        setActiveMenu();

        //선택삭제
        $('.btn_lyr_remove').on('click',function(){
            confirmDelModel();
        });

        //체크박스(전체선택)
        $('#ipt_check_all').on('click',function(){
            var iptCheck01 = $(this).is(":checked");
            if ( iptCheck01 ) {
                $('.tblType01 input:checkbox').prop('checked', true);
            } else {
                $('.tblType01 input:checkbox').prop('checked', false);
            }
        });
    });

    function doInit() {
        $('#sch_site_name').val('');
    }

    function goSch() {
        mainFrm.method = "GET";
        mainFrm.action = "/siteList";
        mainFrm.submit();
    }

    //페이지 이동
    function goPage(num){
        $('#currentPage').val(num);
        goSch();
    }


    function addSite() {

        var popSize = "width=600,height=450";
        var popOption = "titlebar=no,toolbar=no,menubar=no,location=no,directories=no,status=no,scrollbars=no";
        var pop1 = window.open("/siteAddView", "pop1", popSize + "," + popOption);

    }

    function editSite(siteNum) {
        var popSize = "width=600,height=450";
        var popOption = "titlebar=no,toolbar=no,menubar=no,location=no,directories=no,status=no,scrollbars=no";
        var popE = window.open("/siteModifyView?siteNum=" + siteNum, "pop1", popSize + "," + popOption);
    }


    function confirmDelModel() {
        var target = checkDelTarget();

        if(target.length === 0 ) {
            return false;
        }else{
            $('.lyrWrap').show();
            $('.lyr_remove').show();
        }
    }

    function delModel() {

        var delTarget = checkDelTarget();

        $.ajax({
            url : "/delSites",
            data : {
                delSiteSer:delTarget.join(',')
            },
            dataType: 'json',
            type : "POST"
        }).done(function(data){
            //console.log(data);
            if(data.resultCode === 200){
                alert("삭제되었습니다");
                goSch();
            }else if(data.resultCode === 300){
                alert("해당 사이트에 등록된 사용자가 있습니다.");
                return false;
            }else {
                alert('삭제가 실패하였습니다.');
                return false;
            }

        }).fail(function(data){
            alert("삭제 실패했습니다. 다시 시도해 보시기 바랍니다.");
            return false;
        });

    }


    function checkDelTarget() {
        var delTarget = [];
        $('input[name="siteCheck"]').each(function(index, obj){
            if(obj.checked) {
                delTarget.push(obj.value);
            }
        });
        return delTarget;
    }

</script>


</html>
