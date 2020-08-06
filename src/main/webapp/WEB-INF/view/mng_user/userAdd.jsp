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

    <link rel="stylesheet" type="text/css" href="${path}/resources/css/popup.css" />


    <title>사용자등록 ll 회의록시스템</title>
</head>
<body>
<!-- #pop_wrap -->
<div id="pop_wrap">
    <!-- .pop_top -->
    <div class="pop_top">
        <h1>사용자 등록</h1>
        <button type="button" class="pop_close" onclick="doCancel();">닫기</button>
    </div>
    <!-- //.pop_top -->
    <!-- .pop_mid -->
    <div class="pop_mid">
        <!-- .pop_stn -->
        <div class="pop_stn">
            <!-- .pop_stn_cont -->
            <div class="pop_stn_cont">
                <dl class="dlBox">
                    <dt>사이트</dt>
                    <dd>
                        <select class="select" id="add_siteName" name="add_siteName">
                            <option value="0">--선택--</option>
                            ${siteListTag}
                        </select>
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>사용자 ID</dt>
                    <dd>
                        <input type="text" class="ipt_txt" id="add_userId" name="add_userId">
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>사용자 이름</dt>
                    <dd>
                        <input type="text" class="ipt_txt" id="add_userName" name="add_userName">
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>비밀번호</dt>
                    <dd> <input type="password" class="ipt_txt" id="add_password" name="add_password"></dd>
                </dl>
                <dl class="dlBox">
                    <dt>비밀번호 확인</dt>
                    <dd> <input type="password" class="ipt_txt" id="add_password_re" name="add_password_re"></dd>
                </dl>
                <dl class="dlBox">
                    <dt>휴대폰번호</dt>
                    <dd><input type="text"  class="ipt_txt"  id="add_cellphone" name="add_cellphone"></dd>
                </dl>

                <dl class="dlBox">
                    <dt>사용자 권한</dt>
                    <dd>
                        <select class="select" id="add_right" name="add_right">
                            <option value="0">--선택--</option>
                            ${userRightTag}
                        </select>
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>활성화여부</dt>
                    <dd>
                        <select class="select" id="add_useYn" name="add_useYn">
                            <option value="0">--선택--</option>
                            <option value="Y">Y</option>
                            <option value="N">N</option>
                        </select>
                    </dd>
                </dl>
            </div>
            <!-- //.pop_stn_cont -->
        </div>
        <!-- //.pop_stn -->
    </div>
    <!-- //.pop_mid -->
    <!-- .pop_btm -->
    <div class="pop_btm">
        <button type="button" class="btn_point" onclick="doOk();">등록</button>
        <button type="button" onclick="doCancel();">취소</button>
    </div>
    <!-- //.pop_btm -->
</div>
<!-- //#pop_wrap -->
</body>
<script type="text/javascript">
    $(document).ready(function () {
        init();
    });

    function init() {
        //권한이 admin이면 사이트 무시
        $('#add_right').on('change', function(e){
            var value = Number(e.target.value);

            if(value == 1) {
                $('#add_siteName').val('0');
                $('#add_siteName').attr('disabled', 'true');
            }else{
                $('#add_siteName').removeAttr('disabled');
            }
        });
    }

    function doOk(){
        var siteName = $('#add_siteName').val();
        var userId = $('#add_userId').val();
        var userName = $('#add_userName').val();
        var password = $('#add_password').val();
        var passwordRe = $('#add_password_re').val();
        var cellPhone = $('#add_cellphone').val();
        var userRight = $('#add_right').val();
        var useYn = $('#add_useYn').val();

        if( siteName === '0' && userRight !== '1' ) {
            alert("사이트명을 선택하시기 바랍니다.");
            $('#modi_siteName').focus();
            return false;
        }

        if( userId.length < 3 ){
            alert("사용자ID를 최소 3자 이상 입력하시기 바랍니다.");
            $('#add_userId').focus();

            return false;
        }
        if( userName.length < 3){
            alert("사용자명을 최소 3자 이상 입력하시기 바랍니다.");
            $('#add_userName').focus();

            return false;
        }
        if( password.length < 3 ){
            alert("비밀번호를 3자 이상 입력하시기 바랍니다.");
            $('#add_password').focus();
            return false;
        }

        if( passwordRe.length < 3 ){
            alert("비밀번호확인을 입력하시기 바랍니다.");
            $('#add_password_re').focus();
            return false;
        }

        if( password !== passwordRe ){
            alert("비밀번호와 비밀번호 확인이 다릅니다.");
            $('#add_password').focus();

            return false;
        }

        var cellPhonRegExp = /^\d{3}-\d{3,4}-\d{4}$/;

        if($.trim(cellPhone).length === 0 ) {
            alert("핸드폰번호를 입력해주시기 바랍니다.");
            $('#add_cellphone').focus();
            return false;
        }else if(!cellPhonRegExp.test(cellPhone) ) {
            alert("핸드폰번호 양식이 틀립니다.");
            $('#add_cellphone').focus();
            return false;
        }

        if( userRight === '0' ){
            alert("권한을 선택해 주시기 바랍니다.");
            $('#add_right').focus();

            return false;
        }
        if( useYn === '0' ){
            alert("활성여부를 선택하시기 바랍니다.");
            $('#add_useYn').focus();

            return false;
        }

        $.ajax({
            url : "/addUserOk",
            data : {
                add_siteName:siteName
                , add_userId:userId
                , add_userName:userName
                , add_password:password
                ,add_cellphone:cellPhone
                , add_userRight:userRight
                , add_useYn:useYn
            },
            type : "POST"
        }).done(function(data){
            if(data === '200'){
                alert("저장되었습니다");
                opener.location.reload();
                self.close();
            }else if(data ==='400') {
                alert('이미 존재하는 id 입니다.');
                return false;
            }

        }).fail(function(data){
            console.log("### FAIL : " + data);
            alert("저장 실패했습니다. 다시 시도해 보시기 바랍니다.");
            return false;
        });
    }

    function doCancel(){
        self.close();
    }
</script>
</html>
