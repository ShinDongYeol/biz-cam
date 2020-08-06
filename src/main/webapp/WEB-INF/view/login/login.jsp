<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

    <!-- icon_favicon -->
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/login.css">

    <div class="lyrWrap">
        <div class="lyr_bg ie9"></div>
        <div class="lyrBox">
            <div class="lyr_top">
                <h3>브라우저 업데이트 안내</h3>
            </div>
            <div class="lyr_mid">
                <div class="legacy-browser">
                    현재 사용중인 브라우저는 지원이 중단된 브라우저입니다.<br>
                    원활한 온라인 서비스를 위해 브라우저를 <a href="http://windows.microsoft.com/ko-kr/internet-explorer/ie-11-worldwide-languages" target="_blank">최신 버전</a>으로 업그레이드 해주세요.
                </div>
            </div>
            <div class="lyr_btm">
                <div class="btnBox sz_small">
                    <button class="btn_win_close">창 닫기</button>
                </div>
            </div>
        </div>
    </div>
    <![endif]-->
    <title>로그인 &gt; AICC</title>
</head>

<body class="gcsLoginWrap">

<div class="main_tit">
    <h1>회의록시스템</h1>
</div>
<div class="loginContainer">
    <form id="loginFrm" method="post" action="">
        <input type="hidden" name="securedUsername" id="securedUsername" value="" />
        <input type="hidden" name="securedPassword" id="securedPassword" value="" />
    </form>
    <form name="rsafrm" id="rsafrm">
        <input type="hidden" id="rsaPublicKeyModulus" name="rsaPublicKeyModulus"  />
        <input type="hidden" id="rsaPpublicKeyExponent" name="rsaPpublicKeyExponent" />
    </form>
    <form class="loginWrap" name="form-login">
        <fieldset>
            <legend>Login</legend>
            <div class="loginBox">
                <div class="fl"><img src="resources/images/ico_login.png" alt="login"></div>
                <div class="fr">
					<span>
						<input type="text" name="userId" id="ipt_id" class="ipt_txt" placeholder="E-mail" autocomplete="off">
					</span>
                    <span>
						<input type="password" name="passwd" id="ipt_pw" class="ipt_txt" placeholder="Password" autocomplete="off">
					</span>
                    <span class="checkBox">
						<input type="checkbox" name="ipt_check" id="ipt_check" class="ipt_check">
                    	<label for="ipt_check" id="saveId">아이디 저장</label>
					</span>
                    <span>
						<em class="txt_error">아이디 또는 비밀번호가 일치하지 않습니다.<br>오류 시 관리자에게 문의 하세요.</em>
						<button type="button" name="btn_login" id="btn_login" class="btn_login">Login</button>
					</span>
                    <span>
						<button type="button" class="btn_pw_inquire btn_lyr_open">비밀번호 요청</button>
					</span>
                </div>
            </div>
        </fieldset>
    </form>
</div>
<div class="copyRight"><span>MINDsLab &copy; 2019</span></div>

<!-- lyrWrap -->
<div class="lyrWrap">
    <div class="lyr_bg"></div>
    <!-- 사용자 프로필 -->
    <div class="lyrBox lyr_profile">
        <div class="lyr_top">
            <h3>비밀번호 요청</h3>
            <button class="btn_lyr_close">닫기</button>
        </div>
        <div class="lyr_mid">
            아이디 또는 비밀번호를 잃어버리셨나요?<br>
            관리자에게 ID/PW 변경 요청 부탁드립니다.
        </div>
        <div class="lyr_btm">
            <div class="btnBox sz_small">
                <button class="btn_lyr_close">확인</button>
            </div>
        </div>
    </div>
    <!-- //사용자 프로필 -->
</div>
<!-- //lyrWrap-->

<!-- 공통 script -->
<script type="text/javascript" src="${path}/resources/js/security/jsbn.js"></script>
<script type="text/javascript" src="${path}/resources/js/security/rsa.js"></script>
<script type="text/javascript" src="${path}/resources/js/security/prng4.js"></script>
<script type="text/javascript" src="${path}/resources/js/security/rng.js"></script>
<!-- cookie js -->
<script src="${path}/webjars/jquery-cookie/1.4.1-1/jquery.cookie.js"></script>

<script type="text/javascript">

    $(document).ready(function (){
        $('.btn_lyr_open').on('click',function(){
            $('.lyr_profile').show();
        });

        initUserId();
        initLoginForm();
        getRSAKeys();
    });

    //사용자 아이디 쿠키 저장
    // 화면 로드시 쿠키에 아이디있으면 표시
    function initUserId() {

        $('#ipt_check').on('click', function (e) {
            if(e.target.checked) {
                var userId = $('#ipt_id').val();

                if($.trim(userId).length > 0) {
                    $.cookie('userid',userId, {
                        "expires" : 365
                    });
                }
            }else{
                $.removeCookie("userid");
            }
        });

        var c_user_id = $.cookie("userid");
        if( c_user_id) {
            $("#ipt_id").val(c_user_id);
            $("#ipt_check").prop("checked", true);
        }
    }

    function initLoginForm(){
        console.log('init login');

        $('.ipt_id, ipt_pw').each(function(){
            $(this).val('');
        });

        $('.ipt_txt').on('change keyup paste click', function(e) {
            var idValLth = $('#ipt_id').val().length;
            var pwValLth = $('#ipt_pw').val().length;

            if ( idValLth > 0 && pwValLth > 0) {
                $('.btn_login').removeClass('disabled');
                $('.btn_login').removeAttr('disabled');
                $('.disbBox').remove();
                //버튼이 활성화 될때만 엔터키 허용
                if(e.keyCode == 13){
                    login();
                }

            } else {
                $('.btn_login').addClass('disabled');
                $('.btn_login').attr('disabled');
            }

        });

        $('#btn_login').on('click', function(e){
            login();
        });
    }

    function login(){
        var   id  = $("#ipt_id").val();
        var   pw  =  $("#ipt_pw").val();

        if(checkValidate(id, pw)){
            submitEncryptedForm(); // rsa 로 id / passwd 암호화

            var   userName  =    $("#loginFrm").find("#securedUsername").val();
            var   userPasswd  =  $("#loginFrm").find("#securedPassword").val();

            var param={
                userId :userName,
                userKey : userPasswd
            };

            $.ajax({
                type : "post",
                dataType: "json",
                url : "/loginajax",
                data : param,
                success : function (data) {
                    console.log(data);
                    if(data.resultCode == 200){
                        console.log('성공');
                        location.href ="/";
                    }else{
                        alert("아이디 또는 비밀번호가 일치하지 않습니다\n오류시 관리자에게 문의하세요.");
                        return false;
                    }
                },
                fail:function(data){console.log(data)},
                error: function(data, status, error){
                    console.log(error);
                }
            });
        }

    }


    function submitEncryptedForm() {


        var securedLoginForm = document.getElementById('loginFrm');
        var rsa = new RSAKey();
        var rsaF = document.rsafrm;

        rsa.setPublic(rsaF.rsaPublicKeyModulus.value, rsaF.rsaPpublicKeyExponent.value);
        // 사용자ID와 비밀번호를 RSA로 암호화한다.
        securedLoginForm.securedUsername.value = rsa.encrypt($("#ipt_id").val());  // id 암호화
        securedLoginForm.securedPassword.value = rsa.encrypt($("#ipt_pw").val());  // passwd 암호화
    }


    function checkValidate(userName, userPasswd){

        if(userName =='' && userPasswd ==''){
            alert("아이디와 암호를 모두 입력하시오");
            return false;
        }else if(userName ==''){
            alert("아이디를 입력하시오");
            return false;
        }else  if(userPasswd ==''){
            alert("암호를 입력 입력하시오");
            return false;
        }
        return true;
    }


    function getRSAKeys() {

        $.ajax({
            type : "post",
            dataType: "json",
            url : "/getRSAKeyValue",
            async: false,
            success : function (data) {
                $('#rsaPublicKeyModulus').val(data.publicKeyModulus);
                $('#rsaPpublicKeyExponent').val(data.publicKeyExponent);
            },
            fail:function(data){console.log(data)},
            error: function(data, status, error){
                console.log(error);
            }
        });

    }


</script>
</body>
</html>
