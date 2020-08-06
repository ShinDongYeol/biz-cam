<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>Title</title>

    <link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/common.css" />
    <style>ol,ul,li {list-style:none;} </style>
</head>
<body>
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
  <div style="padding-top: 30px">
    go 회의록 관리 = <a href="/minutes/manage/minutesList">회의록 관리</a> page....
    <sec:authorize access="hasRole('ROLE_A')">
        <p>&nbsp;</p>
        go 사이트 관리 = <a href="/siteList">siteList</a> page...
        <p>&nbsp;</p>
        go 사용자관리 = <a href="/userList">userList</a> page...
        <p>&nbsp;</p>
        go 모델관리 = <a href="/modelList">modelList</a> page...
    </sec:authorize>
  </div>

</div>


</body>
</html>
