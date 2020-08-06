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
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap.css'/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reset.css'/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/font.css'/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/all.css'/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap-datetimepicker.css'/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>" />

        <title>직원 관리 ll 회의록시스템</title>
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
                                <h3>직원 관리</h3>
                            </div>
                            <!-- //.titArea -->

                            <!-- .section -->
                            <div class="stn">
                                <div class="srchBox">
<%--
                                    <dl>
                                        <dt>사이트명</dt>
                                        <dd>
                                            <div class="selType01">
                                                <label for="sch_siteName">서울지점</label>
                                                <select id="sch_siteName" name="sch_siteName">
                                                    <option value="0">-- 선택 --</option>
                                                    <option value="1">서울지점</option>
                                                    <option value="2">분당지점</option>
                                                    <option value="3">대전지점</option>
                                                    <option value="4">부산지점</option>
                                                    <option value="5">광주지점</option>
                                                </select>
                                            </div>
                                        </dd>
                                    </dl>
--%>
                                    <dl>
                                        <dt>이름</dt>
                                        <dd><input type="text" class="ipt_txt" id="sch_empName" name="sch_empName" value="${frontMngVO.sch_empName}"></dd>
                                    </dl>
                                    <dl>
                                        <dt>부서</dt>
                                        <dd>
                                            <div class="selType01">
                                                <label for="sch_part">선택</label>
                                                <select id="sch_part" name="sch_part">
                                                    <option value="">-- 선택 --</option>
                                                    ${empPartTag}
                                                </select>
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>직급</dt>
                                        <dd>
                                            <div class="selType01">
                                                <label for="sch_posi">선택</label>
                                                <select id="sch_posi" name="sch_posi">
                                                    <option value="">-- 선택 --</option>
                                                    ${empPositionTag}
                                                </select>
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>활성여부</dt>
                                        <dd>
                                            <div class="selType01">
                                                <label for="sch_useYn">선택</label>
                                                <select id="sch_useYn" name="sch_useYn">
                                                    <option value="">-- 선택 --</option>
                                                    <option value="Y">Y</option>
                                                    <option value="N">N</option>
                                                </select>
                                            </div>
                                        </dd>
                                    </dl>
                                    <p>
                                        <button type="button" onclick="goSch();"><span class="fas fa-search"></span>검색</button>
                                        &emsp;&emsp;&emsp;&emsp;
                                        <button type="button" onclick="doInit();"><span class="fas fa-search"></span>초기화 검색</button>
                                    </p>
                                </div>
                            </div>
                            <!-- //.section -->

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
                                            <%--<th scope="col">사이트명</th>--%>
                                            <th scope="col">이름</th>
                                            <th scope="col">부서</th>
                                            <th scope="col">직급</th>
                                            <th scope="col">활성여부</th>
                                            <th scope="col">등록일</th>
                                            <th scope="col">수정일</th>
                                            <th scope="col">수정</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${fn:length(list) gt 0}">
                                            <c:forEach items="${list}" var="mainList" varStatus="status">
                                                <tr>
                                                    <%--<td scope="row"><a class="link" href="#">${mainList.site_name}</a></td>--%>
                                                    <td>${mainList.name}</td>
                                                    <td>${mainList.desc_part}</td>
                                                    <td>${mainList.desc_position}</td>
                                                    <td>${mainList.useYn}</td>
                                                    <td>${mainList.create_time}</td>
                                                    <td>${mainList.update_time}</td>
                                                    <td>
                                                        <span class="btn">
                                                            <button type="button" class="btn_tbl" onclick="empModify('${mainList.minutes_employee_ser}')">
                                                                <span class="fas fa-edit"></span>수정
                                                            </button>
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8" scope="row">등록된 직원이 없습니다.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            <!-- //.tblBox -->

                            <!-- .paging_wrap -->
                            <div class="paging_wrap">
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
                                    <button type="button" onclick="addEmp()"><span class="fas fa-plus"></span>추가</button>
                                </div>
                            </div>
                            <!-- //.paging_wrap -->
                        </div>

                        <%--<input type="hidden" id="rcv_sch_siteName" name="rcv_sch_siteName" value="${frontMngVO.sch_siteName}">--%>
                        <input type="hidden" id="rcv_sch_part" name="rcv_sch_part" value="${frontMngVO.sch_part}">
                        <input type="hidden" id="rcv_sch_posi" name="rcv_sch_posi" value="${frontMngVO.sch_posi}">
                        <input type="hidden" id="currentPage" name="currentPage" value="${frontMngVO.currentPage}">

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
    <script type="text/javascript" src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/all.js'/>"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            setActiveMenu();
            $('#page_loading').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });

            // var rcv_sch_siteName = $('#rcv_sch_siteName').val();
            var rcv_sch_part = $('#rcv_sch_part').val();
            var rcv_sch_posi = $('#rcv_sch_posi').val();

            // if( rcv_sch_siteName.length > 0 ) {
            //     $('#sch_siteName').val(rcv_sch_siteName);
            // }
            if(rcv_sch_part) {
                $('#sch_part').val(rcv_sch_part);
            }
            if(rcv_sch_posi) {
                $('#sch_posi').val(rcv_sch_posi);
            }
        });

        //조회
        function goSch(){
            //mainFrm.method = "POST";
            mainFrm.method = "GET";
            mainFrm.action = "/empList";
            mainFrm.submit();
        }

        //초기화
        function doInit(){
            $('#sch_siteName').val(0);
            $('#sch_empName').val('');
            $('#sch_part').val('');
            $('#sch_posi').val('');
            $('#sch_useYn').val('');

            goSch();
        }

        //페이지 이동
        function goPage(num){
            $('#currentPage').val(num);

            goSch();
        }

        //추가
        function addEmp(){
            let popSize = "width=600,height=450";
            let popOption = "titlebar=no,toolbar=no,menubar=no,location=no,directories=no,status=no,scrollbars=no";
            pop1 = window.open("/empAdd", "pop1", popSize + "," + popOption);
        }

        //편집
        function empModify(num){
            let popSize = "width=600,height=450";
            let popOption = "titlebar=no,toolbar=no,menubar=no,location=no,directories=no,status=no,scrollbars=no";
            popE = window.open("/empModify?emp_ser=" + num, "pop9", popSize + "," + popOption);
        }
    </script>
</html>

