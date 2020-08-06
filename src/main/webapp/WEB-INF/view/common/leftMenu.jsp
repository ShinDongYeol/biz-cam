<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div id="gnb" class="div_left">
    <ul class="nav">
        <li id="minutesList"><a href="/minutes/manage/minutesList"><span class="fas fa-upload"></span>회의록 관리</a></li>
        <li id="minutesCreate"><a href="/minutes/manage/minutesCreate"><span class="fas fa-upload"></span>회의록 작성</a></li>
        <sec:authorize access="hasRole('ROLE_A')">
        <li id="system"><a href="#none" onclick="isOpen(this)" ><span class="fas fa-cog"></span>시스템 관리</a>
            <ul class="sub">
                <li id="userList"><a href="/userList"><span class="fas fa-user"></span>사용자 관리</a></li>
                <li id="siteList"><a href="/siteList"><span class="fas fa-user"></span>사이트 관리</a></li>
                <li id="modelList"><a href="/modelList"><span class="fas fa-shield-alt"></span>모델 관리</a></li>
            </ul>

        </li>
        </sec:authorize>
      <%--  <li id="dashboard"><a href="/dashboard"><span class="fas fa-calendar-alt"></span>회의 현황</a></li>--%>
    </ul>
</div>
<script>

    function isOpen(data) {

        $('.nav li').each(function (index, obj) {
            $(obj).removeClass('active');
        });

        if($(data).parent().hasClass('active')){
            $(data).parent().removeClass('active');
        }else{
            $(data).parent().addClass('active');
        }
    }

    function setActiveMenu() {
        var path = location.pathname;
        var paths = path.split('/');


        for(var i=1; i<paths.length; i++) {
            var $this = $('#' + paths[i]);
            if($this.length) {
                if(paths[i] =='userList' || paths[i] =='siteList' || paths[i] =='modelList' ){
                    $('#system').addClass('active');
                }else{
                    $('#system').removeClass('active');
                }
                $this.addClass('active');
                break;
            }
        }
    }
</script>