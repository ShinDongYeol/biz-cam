<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="path"  value="${pageContext.request.contextPath}" />

<script type="text/javascript" src="${path}/resources/js/jquery-3.4.1.min.js"></script>
<html>
<head>
    <title>Title</title>

</head>
<body>
 <script>
     $(document).ready(function () {
        location.href = '/minutes/manage/minutesList' ;
     });
 </script>
</body>
</html>
