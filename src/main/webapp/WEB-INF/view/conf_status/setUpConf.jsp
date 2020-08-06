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
    <link rel="stylesheet" type="text/css" href="<c:url value='/webjars/jquery-ui/1.12.1/jquery-ui.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reset.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/font.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/all.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap-datetimepicker.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/popup.css'/>" />


    <title>회의설정 ll 회의록시스템</title>
</head>
<body>
<!-- #pop_wrap -->
<div id="pop_wrap">
    <!-- .pop_top -->
    <div class="pop_top">
        <h1>회의실 예약</h1>
        <button type="button" class="pop_close">닫기</button>
    </div>
    <!-- //.pop_top -->
    <!-- .pop_mid -->
    <div class="pop_mid">
        <!-- .pop_stn -->
        <div class="pop_stn">
            <div class="pop_stn_tit">
                <h2>예약정보</h2>
            </div>
            <!-- .pop_stn_cont -->
            <div class="pop_stn_cont">
                <dl>
                    <dt>회의명</dt>
                    <dd><input type="text" class="ipt_txt" id="confName" name="confName"></dd>
                </dl>
                <dl>
                    <dt>회의시간</dt>
                    <dd><input type="text" class="ipt_date fromDate" id="confTime" name="confTime"></dd>
                </dl>
                <dl>
                    <dt>안건</dt>
                    <dd><input type="text" class="ipt_txt" id="confTopic" name="confTopic"></dd>
                </dl>
                <dl>
                    <dt>참석자</dt>
                    <dd>
                        <input type="text" class="ipt_txt" id="confJoinedEmpName" name="confJoinedEmpName" readonly>
                        <div class="personSrch">
                            <div class="srchSetting">
                                <div class="selType01">
                                    <label for="position">선택</label>
                                    <select id="position">
                                        <option value="1">영업</option>
                                        <option value="2">관리</option>
                                        <option value="3">기획</option>
                                        <option value="4">R&nbsp;D</option>
                                    </select>
                                </div>
                                <input type="text" class="ipt_txt" id="userName">
                                <button type="button" class="btn_tbl" id="schUser" name="schUser">검색</button>
                                <button type="button" class="btn_tbl" id="commitUser" name="commitUser">추가</button>
                            </div>
                            <div class="tblBox">
                                <table class="tblType01">
                                    <caption class="hide">직원 목록</caption>
                                    <colgroup>
                                        <col><col><col><col><col>
                                    </colgroup>
                                    <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col">이름</th>
                                        <th scope="col">부서</th>
                                        <th scope="col">직급</th>
                                        <th scope="col">사번</th>
                                    </tr>
                                    </thead>
                                    <tbody id="userTable"></tbody>
                                </table>
                            </div>
                            <!-- .paging_wrap -->
                            <div class="div_bottom">
                                <div class="tbl_100">
                                    <div class="row">
                                        <div class="paging row">
                                            ${paging.getpaging()}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" id="currentPage" name="currentPage" value="${frontConfVO.currentPage}">
                            <!-- //.paging_wrap -->
                            <div class="div_bottom">
                                <div class="tbl_100">
                                    <div class="row">
                                        <div class="paging row" id="pager">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </dd>
                </dl>
            </div>
            <!-- .pop_stn_cont -->
            <div class="btnBox">
                <button type="button" id="confBtnCancel" onclick="cancel();">취소</button>
                <button type="button" onclick="doConfSave();">완료</button>
            </div>
        </div>
        <!-- //.pop_stn -->

        <!-- .pop_stn -->
        <div class="pop_stn" style="display:block;">
            <div class="pop_stn_tit">
                <h2>마이크 사용자<span>마이크 사용자 및 마이크 활성화 여부를 설정해 주세요.</span></h2>
            </div>
            <!-- .pop_stn_cont -->
            <div class="pop_stn_cont">
                <div class="lst_mic">

                        <c:forEach items="${micList}" var="micList" varStatus="status">
                         <c:if test="${ (status.index == 0) || ((status.index + 1) % 5 eq 0 ) }">
                            <ul>
                          </c:if>
                            <li>
							<span>
								<div class="selType02">
									<label for="slt_mic0${status.index+1}">${status.index+1}번 마이크</label>
									<select id="slt_mic0${status.index+1}" name="slt_mic">
										<%--<option value="">${status.index+1}번 마이크</option>--%>
                                        <option value="-1">-- 선택 --</option>
									</select>
								</div>
								<div class="switchBox">
									<input type="checkbox" id="switch0${status.index+1}" name="switchMic" value="${micList.minutes_mic_ser}">
									<label for="switch0${status.index+1}"></label>
								</div>
							</span>
                            </li>
                              <c:if test="${ (status.index + 1) % 4 eq 0 }">
                               </ul>
                             </c:if>
                              </c:forEach>

                </div>
            </div>
            <!-- .pop_stn_cont -->
        </div>
        <!-- //.pop_stn -->

    </div>
    <!-- //.pop_mid -->
    <!-- .pop_btm -->
    <div class="pop_btm">
        <button type="button" class="btn_point">예약</button>
        <button type="button">취소</button>
    </div>
    <!-- //.pop_btm -->
</div>
<!-- //#pop_wrap -->

<!-- hidden. -->
<input type="hidden" id="site_ser" name="site_ser" value="${frontConfVO.site_ser}">
<input type="hidden" id="room_ser" name="room_ser" value="${frontConfVO.room_ser}">

<input type="hidden" id="confJoinedEmpId" name="confJoinedEmpId">

<input type="hidden" id="confSetUpYN" name="confSetUpYN" value="0">
<input type="hidden" id="minutes_id" name="minutes_id" value="">

</body>

<script type="text/javascript" src="<c:url value='/resources/js/jquery-3.4.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/bootstrap-datetimepicker.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/moment.min.js'/>"></script>
<script src="<c:url value='/webjars/jquery-ui/1.12.1/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/ko.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/all.js'/>"></script>

<script type="text/javascript">
    $(document).ready(function (){
        init();

    });

    function init() {
        initDate();
        initBtnEvent();
    }


    function initDate() {
        var fromDateObj = $('#confTime');

        var startDate = new Date();

        fromDateObj.datetimepicker({
            language : 'ko', // 화면에 출력될 언어를 한국어로 설정한다.
            pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략한다.
            defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력한다. 기본값을 해제하려면 defaultDate 옵션을 생략한다.
            autoclose: true
        });
    }

    function  initBtnEvent () {
        $('#schUser').on('click', function (e) {
            searchUser();
        });

        $('#commitUser').on('click', function (e) {
            commitUser();
        });

        $('input[name="switchMic"]').on('change', function(e){
            var confSetUpYN = $('#confSetUpYN').val(); // 회의실 등록 여부.

            if(Number(confSetUpYN) == 0) {
                alert("회의실을 먼저 설정하여 주십시오.");
                this.checked = false;
                return false;
            }
            setMic(this);
        });
    }

    function searchUser() {
        var param = {
            part : $('#position option:selected').val(),
            name : $('#userName').val(),
            currentPage: $('#currentPage').val()
        };

        $.ajax({
            type: 'POST',
            url : "/searchUser",
            dataType: "json",
            data: param,
            success: function(data){
                drawUserTable(data);
                drawPager(data);
            },
            fail:function(data){console.log(data)},
            error: function(data, status, error){
                console.log(error);
            }
        });
    }

    var checkUser = '';
    var joinMemberNum  ='';
    function drawUserTable(data) {

        var userList = data.userData;
        var tbody = $('#userTable');

        tbody.empty();
        var table ='';
        if(userList == null || typeof userList =='undefined' || userList.length === 0) {
            table ='';
            table = '<tr> <td scope="row" colspan="5">데이터가 없습니다.</td></tr>';
            tbody.append(table);
        }else{
            $.each(userList, function(index, obj){
                console.log(obj);
                table +='' +
                    '<tr>' +
                    '  <td scope="row">' +
                    '    <div class="checkBox">' +
                    '       <input type="checkbox" id="'+obj.minutes_employee_ser+'" name="userCheck" value="'+obj.minutes_employee_ser+'">' +
                    '       <label for="'+obj.minutes_employee_ser+'"></label>' +
                    '    </div>' +
                    '  </td>' +
                    '  <td>'+obj.name+'</td>' +
                    '  <td>'+obj.part+'</td>' +
                    '  <td>'+obj.position+'</td>' +
                    '  <td>' + obj.minutes_employee_ser+'</td>' +
                    '</tr>';

                tbody.append(table);
                table ='';
            });
        }
    }

    //체크박스 선택유저 넣기.
    function commitUser() {

        var checkArray = $('input[name="userCheck"]:checked');

        checkArray.each(function(index) {
            var tr = checkArray.parent().parent().parent().eq(index);
            var td = tr.children();

            checkUser += td.eq(1).text() +",";
            joinMemberNum += checkArray.eq(index)[0].value+",";

        });

        checkUser = checkUser.substring(0, checkUser.length - 1);
        joinMemberNum  = joinMemberNum.substring(0, joinMemberNum.length - 1);


        $('#confJoinedEmpName').val(checkUser);
        $('#confJoinedEmpId').val(joinMemberNum);

        makeMicOption();

    }


    //페이징 그리는걸 따로 둠.
    function drawPager(data) {
        console.log(data);
        var pager = $('#pager');
        pager.empty();
        pager.append(data.pager);
    }

    //페이지 이동
    function goPage(num){
        $('#currentPage').val(num);
        searchUser();
    }


    //회의실 설정 저장
    function doConfSave(){
        var site_ser = $('#site_ser').val();
        var room_ser = $('#room_ser').val();
        var confName = $('#confName').val();
        var confTime = $('#confTime').val();
        var confTopic = $('#confTopic').val();
        var confJoinedEmpName = $('#confJoinedEmpName').val();
        var confJoinedEmpId = $('#confJoinedEmpId').val();
        var joinedCnt = confJoinedEmpName.split(',').length;

        var  param = {
            site_ser:site_ser,
                room_ser:room_ser,
                confName:confName,
                confTime:confTime,
                confTopic:confTopic,
                confJoinedEmpName:confJoinedEmpName,
                confJoinedEmpId:confJoinedEmpId,
                confJoinedCnt:joinedCnt
            };


        var confSetUpYN = $('#confSetUpYN').val();



        if(validation() && confSetUpYN == 0) {
            console.log(confSetUpYN);
            $.ajax({
                url : "/confSetUpSave",
                data :param,
                type : "POST",
                dataType: "json",
                success: function(data){

                    console.log(data);
                    if(data.confSaved === 0){
                        alert("회의중이거나 이미 예약된 회의가 존재합니다.");
                        return false;
                    }else{
                        $('#confSetUpYN').val("1");
                        $('#minutes_id').val(data.minutes_id);
                        alert("회의실 설정이 완료되었습니다\n마이크 설정을 해주시기 바랍니다.");
                        makeMicOption();
                    }
                },
                fail:function(data){console.log(data)},
                error: function(data, status, error){
                    console.log(error);
                }
            });
        }
    }

    function validation() {

        var confName = $('#confName').val();
        var confTime = $('#confTime').val();
        var confTopic = $('#confTopic').val();
        var confJoinedEmpName = $('#confJoinedEmpName').val();
        var confJoinedEmpId = $('#confJoinedEmpId').val();

        if( confName.length < 2 ){
            alert("회의명을 2자 이상 입력해 주시기 바랍니다.");
            $('#confName').focus();
            return false;
        }
        if( confTime.length < 2 ){
            alert("회의시간을 지정해 주시기 바랍니다.");
            $('#picker').focus();
            return false;
        }
        if( confTopic.length < 2 ){
            alert("회의 안건을 입력해 주시기 바랍니다.");
            $('#confTopic').focus();
            return false;
        }
        if( confJoinedEmpName.length < 2 ){
            alert("참석자를 입력해 주시기 바랍니다.");
            $('#confJoinedEmpName').focus();
            return false;
        }

        return true;
    }


    function makeMicOption(){

        console.log('mic');

        var confJoinedEmpName = $('#confJoinedEmpName').val();
        var confJoinedEmpId = $('#confJoinedEmpId').val();

        var joinMemArray = confJoinedEmpName.split(',');
        var joinMemSerArray = confJoinedEmpId.split(',');

        console.log(joinMemArray);

        var selectMic = $('select[name="slt_mic"]');

        $.each(selectMic, function (index, obj) {
            $.each(joinMemArray, function (int, join) {
                var option = $('<option>');
                option.val(joinMemSerArray[int]);
                option.text(join);
                $(obj).append(option);
            });
        });
    }

    // 이전 선택 참가자.. 겹침 방지
    var preSelectedUser = [];

    function setMic(micData) {

        var select = micData.parentNode.parentNode.querySelector('select'); // 체크된 selectbox
        var options = micData.parentNode.parentNode.querySelector('select').options;  //selectBOx 옵션
        var isSelected = false;  //중복 플래그
        var micChecked  = micData.checked;  // 마이크 on/off
        var index = 0;  //중복체크용 index 변수

        var userName = options[select.selectedIndex].text; //선택된 사용자 이름
        var userSer = options[select.selectedIndex].value; // 선택된 사용자 id.




        if(micChecked && userSer =='-1') {
            alert('사용자를 먼저 선택해주십시오.');
            micData.checked = false;
            return false;
        }

        var mic ={
            room_ser : $('#room_ser').val(),
            site_ser : $('#site_ser').val(),
            minutes_mic_ser : micData.value,
            minutes_id : $('#minutes_id').val(),
            micUseYn :  '',
            minutes_joined_ser :userSer ,
            minutes_joined_name : userName
        };


        for(var user of preSelectedUser) {
            if(user ==  userName) {
                isSelected = true;
                break;
            }
        }

        if(!micChecked) {
            select.disabled = false;
            index = preSelectedUser.indexOf(mic.minutes_joined_name);
            console.log(index);
            if(index > -1) {
                preSelectedUser.splice(index, 1);
                console.log(preSelectedUser);
            }
        } else{
            if(isSelected) {
                alert('이미 설정된 참가자입니다.');
                micData.checked = false;
                return false;
            }else{
                preSelectedUser.push(mic.minutes_joined_name);
            }
        }

    }

    function cancel(){
        self.close();
    }

</script>
</html>
