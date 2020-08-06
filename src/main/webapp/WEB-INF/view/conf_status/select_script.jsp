<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Title</title>
</head>
<body>

회의록 보기 선택
<p>&nbsp;</p>

<div class="div_normal">
    <div class="div_left">
        <p>&nbsp;</p>
        <a href="/dashboard">회의 현황</a>
        <p>&nbsp;</p>
        파일 업로드
        <p>&nbsp;</p>
        <a href="/confResult">회의 결과</a>
        <p>&nbsp;</p>
        사용자 설정
        <p>&nbsp;</p>
        관리자 설정
        <p>&nbsp;</p>
        시스템 관리
    </div>

    <div class="div_right">
        <div class="div_box_s_nl">

        <c:if test="${metaOne.minutes_status eq 1}">
            <div class="div_box_s_nc_30">
                <table>
                    <tr>
                        <td colspan="2">실시간 회의록</td>
                    </tr>
                    <tr>
                        <td>실시간 녹음용 <input type="button" value="GO" onclick="goRtScript('${metaOne.minutes_status}')"></td>
                        <td>실시간 편집용 <input type="button" value="GO" onclick="goRtEditScript('${metaOne.minutes_status}')"></td>
                    </tr>
                </table>
            </div>
            <div class="div_box_s_nc_30">
                <table>
                    <tr>
                        <td colspan="2">회의록 재생</td>
                    </tr>
                    <tr>
                        <td>재생 청취용 <input type="button" value="GO" onclick="goRecScript('${metaOne.minutes_status}')"></td>
                        <td>재생 편집용 <input type="button" value="GO" onclick="goRecEditScript('${metaOne.minutes_status}')"></td>
                    </tr>
                </table>
            </div>
        </c:if>
        <c:if test="${metaOne.minutes_status eq 2}">
            <div class="div_box_s_nc_30">
                <table>
                    <tr>
                        <td colspan="2">실시간 회의록</td>
                    </tr>
                    <tr>
                        <td>실시간 녹음용 <input type="button" value="GO" onclick="goRtScript('${metaOne.minutes_status}')"></td>
                        <td>실시간 편집용 <input type="button" value="GO" onclick="goRtEditScript('${metaOne.minutes_status}')"></td>
                    </tr>
                </table>
            </div>
        </c:if>
        <c:if test="${metaOne.minutes_status eq 3}">
            <div class="div_box_s_nc_30">
                <table>
                    <tr>
                        <td colspan="2">회의록 재생</td>
                    </tr>
                    <tr>
                        <td>재생 청취용 <input type="button" value="GO" onclick="goRecScript('${metaOne.minutes_status}')"></td>
                        <td>재생 편집용 <input type="button" value="GO" onclick="goRecEditScript('${metaOne.minutes_status}')"></td>
                    </tr>
                </table>
            </div>
        </c:if>

        </div>
    </div>
</div>

<form name="valueForm">
    <input type="hidden" name="site_ser" value="${frontConfVO.site_ser}">
    <input type="hidden" name="meta_ser" value="${frontConfVO.meta_ser}">
</form>

</body>

<script type="text/javascript">
//실시간 보기
function goRtScript(){
    valueForm.method="post";
    valueForm.action="rt_script";
    valueForm.submit();
}

//실시간 편집
function goRtEditScript(){
    valueForm.method="post";
    valueForm.action="rtEdit_script";
    valueForm.submit();
}

//녹음 보기
function goRecScript(){
    valueForm.method="post";
    valueForm.action="rec_script";
    valueForm.submit();
}

//녹음 편집
function goRecEditScript(){
    valueForm.method="post";
    valueForm.action="recEdit_script";
    valueForm.submit();
}
</script>

<style type="text/css">
.div_normal{
    position: absolute;
    width: 95%;
    height: 1000px;
    margin: 20px 20px 20px 20px;
}
.div_left{
    position: absolute;
    width: 10%;
    left:0;
    margin: 0px;
}
.div_right{
    position: absolute;
    width: 90%;
    height: 500px;
    right: 0;
    margin: 5px 5px 5px 0px;
}
.div_box_s_nl{
    width: 100%;
    height: 500px;
    border: 1px solid black;
}

.div_box_s_nc_30{
    float: left;
    width: 40%;
    margin-top: 15%;
    margin-left: 5%;
}

.div_box_s_nc_30 table{
    position: relative;
    display: table;
    width: 100%;
    margin-bottom: 20px;
    text-align: center;
    border: 1px solid black;
    border-collapse: collapse;
}

.div_box_s_nc_30 table tr, td{
    /*text-align: center;*/
    border: 1px solid black;
    padding-right: 10px;
    padding-top: 10px;
    padding-bottom: 10px;
}
</style>

</html>
