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
                        <select class="select" id="modi_siteName" name="modi_siteName">
                            <option value="0">--선택--</option>
                            ${siteListTag}
                        </select>
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>사용자 ID</dt>
                    <dd>
                        <input type="text" class="ipt_txt" id="modi_userId" name="modi_userId"  value="${userInfo.user_id}" readonly>
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>사용자 이름</dt>
                    <dd>
                        <input type="text" class="ipt_txt" id="modi_userName" name="modi_userName" value="${userInfo.user_name}">
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>비밀번호</dt>
                    <dd> <input type="password" class="ipt_txt" id="modi_password" name="modi_password"></dd>
                </dl>
                <dl class="dlBox">
                    <dt>휴대폰번호</dt>
                    <dd>  <input type="text" class="ipt_txt"  id="modi_cellphone" name="modi_cellphone" value="${userInfo.cellphone_num}"></dd>
                </dl>

                <dl class="dlBox">
                    <dt>사용자 권한</dt>
                    <dd>
                        <select class="select" id="modi_right" name="modi_right">
                            <option value="0">--선택--</option>
                            ${userRightTag}
                        </select>
                    </dd>
                </dl>
                <dl class="dlBox">
                    <dt>활성화여부</dt>
                    <dd>
                        <select class="select" id="modi_useYn" name="modi_useYn">
                            <option value="0">--선택--</option>
                            <option value="Y">Y</option>
                            <option value="N">N</option>
                        </select>
                    </dd>
                </dl>
            </div>
            <!-- //.pop_stn_cont -->
            <input type="text" hidden id="unum" name="unum" value="${userVO.unum}">
        </div>
        <!-- //.pop_stn -->
    </div>
    <!-- //.pop_mid -->
    <!-- .pop_btm -->
    <div class="pop_btm">
        <button type="button" class="btn_point" onclick="doOk();">수정</button>
        <button type="button" onclick="doCancel();">취소</button>
    </div>
    <!-- //.pop_btm -->
</div>
<!-- //#pop_wrap -->
</body>
<script type="text/javascript">
    $(document).ready(function () {
        var useYn = '<c:out value="${userInfo.user_use_yn}" />';
        $('#modi_useYn').val(useYn);
        init();
    });

    function init() {
        //권한이 admin이면 사이트 무시
        $('#modi_right').on('change', function(e){
            var value = Number(e.target.value);

            if(value == 1) {
                $('#modi_siteName').val('0');
                $('#modi_siteName').attr('disabled', 'true');
            }else{
                $('#modi_siteName').removeAttr('disabled');
            }
        });
    }

    function doOk(){

        var unum = $('#unum').val();
        var siteName = $('#modi_siteName').val();
        var userId = $('#modi_userId').val();
        var userName = $('#modi_userName').val();
        var password = $('#modi_password').val();
        var cellPhone = $('#modi_cellphone').val();
        var userRight = $('#modi_right').val();
        var useYn = $('#modi_useYn').val();


        if( siteName === '0' && userRight !== '1' ) {
            alert("사이트명을 선택하시기 바랍니다.");
            $('#modi_siteName').focus();
            return false;
        }

        if( userId.length < 3 ){
            alert("사용자ID를 최소 3자 이상 입력하시기 바랍니다.");
            $('#modi_userId').focus();

            return false;
        }
        if( userName.length < 3){
            alert("사용자명을 최소 3자 이상 입력하시기 바랍니다.");
            $('#modi_userName').focus();

            return false;
        }
        /*if( password.length < 3 ){
            alert("비밀번호를 3자 이상 입력하시기 바랍니다.");
            $('#modi_password').focus();

            return false;
        }*/

        var cellPhonRegExp = /^\d{3}-\d{3,4}-\d{4}$/;

        if($.trim(cellPhone).length === 0 ) {
            alert("핸드폰번호를 입력해주시기 바랍니다.");
            $('#modi_cellphone').focus();
            return false;
        }else if(!cellPhonRegExp.test(cellPhone) ) {
            alert("핸드폰번호 양식이 틀립니다.");
            $('#modi_cellphone').focus();
            return false;
        }


        if( userRight === '0' ){
            alert("권한을 선택해 주시기 바랍니다.");
            $('#modi_right').focus();

            return false;
        }
        if( useYn === '0' ){
            alert("활성여부를 선택하시기 바랍니다.");
            $('#modi_useYn').focus();
            return false;
        }

        console.log('test');
        $.ajax({
            url : "/modifyUserOk",
            data : {
                unum: unum
                , modi_siteName:siteName
                , modi_userId:userId
                , modi_userName:userName
                , modi_password:password
                ,modi_cellphone: cellPhone
                , modi_userRight:userRight
                , modi_useYn:useYn
            },
            dataType:'json',
            type : "POST"
        }).done(function(data){
            if(data.resultCode === 200){
                alert("수정되었습니다.");
                opener.location.reload();
                self.close();
            }else{
                alert("수정이 실패하였습니다.");
                return false;
            }
        }).fail(function(data){
            alert("수정 실패했습니다. 다시 시도해 보시기 바랍니다.");
            return false;
        });
    }

    function doCancel(){
        self.close();
    }
</script>
</html>
