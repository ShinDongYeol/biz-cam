<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Title</title>
</head>

<body>

<form id="mainFrm" name="mainFrm">

    <div class="div_normal">

        <%@ include file="../common/leftMenu.jsp" %>

        <div class="div_right">
            <div class="div_middle">
                <div class="tbl">
                    <div class="row">
                        <div class="head_cell">장비명</div>
                        <div class="head_cell">IP</div>
                        <div class="head_cell">CPU(%)</div>
                        <div class="head_cell">RAM(%)</div>
                        <div class="head_cell">HDD(%)</div>
                        <div class="head_cell">Server Status</div>
                    </div>

        <c:choose>
            <c:when test="${fn:length(svrList) gt 0}">
                <c:forEach items="${svrList}" var="svrList" varStatus="status">
                    <div class="row">
                        <div class="cell">${svrList.server_name}</div>
                        <div class="cell">${svrList.server_ipaddr}</div>
                        <div class="cell">${svrList.server_cpu_rate}</div>
                        <div class="cell">${svrList.server_ram_rate}</div>
                        <div class="cell">${svrList.server_hdd_rate}</div>
                        <div class="cell">server status icon</div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="row">
                    등록된 서버 상태가 없습니다.
                </div>
            </c:otherwise>
        </c:choose>
                </div>
            </div>

            <div class="div_bottom">
                <div class="tbl">
                    <div class="row">
                        시스템 이용 통계 :
                        <select id="sch_siteName" name="sch_siteName">
                            <option value="0">--선택--</option>
                            <option value="1">서울지점</option>
                            <option value="2">분당지점</option>
                            <option value="3">대전지점</option>
                            <option value="4">부산지점</option>
                            <option value="5">광주지점</option>
                        </select>
                    </div>
                </div>
            </div>

        </div>
    </div>

</form>

</body>

<style type="text/css">

    .div_search{
        position: relative;
        display: table;
        width: 95%;
        vertical-align: middle;
        text-align: center;
        margin-bottom: 20px;
    }

    .div_normal{
        position: absolute;
        width: 95%;
        height: 950px;
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
        right: 0;
        margin: 5px 5px 5px 0px;
    }
    .div_box_s{
        position: relative;
        display: table;
        width: 95%;
        margin-top: 20px;
        margin-bottom: 20px;
        vertical-align: middle;
        text-align: center;
        border: 1px solid black;
    }

    .div_middle {
        display: table;
        width: 95%;
        vertical-align: middle;
        text-align: center;
        margin-bottom: 20px;
    }

    .div_bottom{
        display: table;
        width: 95%;
        vertical-align: middle;
    }

    .tbl{
        display: table;
        width: 95%;
    }

    .row{
        display: table-row;
    }

    .head_cell{
        display: table-cell;
        padding: 0px 5px;
        height: 50px;
        border: 1px solid black;
        vertical-align: middle;
        text-align: center;
        font-weight: bold;
    }

    .cell{
        display: table-cell;
        padding: 0px 5px;
        height: 50px;
        border: 1px solid black;
        vertical-align: middle;
        text-align: center;
    }

    .cell.rowspan{
        display: block;
        vertical-align: middle;
        text-align: center;
        height: 95%;
    }

    .row.btn{
        display: inline-block;
        float: right;
    }

    .row.paging{
        display: inline-block;
        width: 95%;
        text-align: center;
        margin-bottom: 20px;
    }
</style>

</html>
