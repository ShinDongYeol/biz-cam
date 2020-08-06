<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<%
    String path = request.getContextPath();
%>
<html>
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
    <link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/login.css" />
    <link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/bootstrap.css" />


    <title>상세보기</title>
</head>
<body class="hold-transition skin-blue sidebar-mini">

<div class="login-content-container">
    <div class="main_tit">
        <h1></h1>
    </div>
    <form id="loginFrm" method="post" action="">
        <input type="hidden" name="securedUsername" id="securedUsername" value="" />
        <input type="hidden" name="securedPassword" id="securedPassword" value="" />
    </form>
    <form name="rsafrm" id="rsafrm">
        <input type="hidden" id="rsaPublicKeyModulus" name="rsaPublicKeyModulus"  />
        <input type="hidden" id="rsaPpublicKeyExponent" name="rsaPpublicKeyExponent" />
    </form>
    <form class="loginWrap" method="get" action="">
        <fieldset>
            <legend>Login</legend>
            <div class="loginBox">
                <div class="fr">
                        <span>
                            <!-- [D] ID값 에러일 경우 input에 클래스 error를 선언해주세요. -->
                            <input type="text" name="ipt_id" id="ipt_id" class="ipt_txt chatbot_txt" placeholder="User ID" >
                        </span>
                    <span>
                            <!-- [D] pw값 에러일 경우 input에 클래스 error를 선언해주세요. -->
                            <input type="password" name="ipt_pw" id="ipt_pw"  class="ipt_txt chatbot_txt" title="Password" placeholder="Password">
                        </span>
                    <span>
                          <input type="button" name="btn_login" id="btn_login"  class="btn btn-primary btn-lg" title="Login" value="Login"  />
                         <input type="button" name="btn_login"  id="find_pass"  class="btn btn-info btn-lg" title="비밀번호찾기" value="비번찾기"  />
                        </span>
                    <!-- <a class="btn_forgot">Forgot your password?</a> -->
                </div>
            </div>
        </fieldset>
    </form>
    <!-- //loginBox -->
</div>

</body>
<script type="text/javascript" src="<%=path%>/resources/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/all.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/security/jsbn.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/security/rsa.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/security/prng4.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/security/rng.js"></script>

<script>
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

        $('#find_pass').on('click', function (e) {
           alert('아이디 또는 비밀번호를 잃어버리셨군요.\n' +
               'ID/PW 변경 요청 부탁드립니다.\n');
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

    $(document).ready(function (){
        initLoginForm();
        getRSAKeys();
    });


</script>
</html>
