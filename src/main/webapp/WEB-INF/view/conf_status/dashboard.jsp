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
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/font.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/all.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>" />
	
<title>회의현황 ll 회의록시스템</title>
</head>

<body>

<!-- layerPopup -->
<div id="goScriptLay" class="layerPop" style="display:none;">
	<!-- 실시간회의록 -->
	<div class="layerBox">
		<div class="layer_top">
			<h2>실시간 회의록</h2>
		</div>
		<div class="layer_mid">
			<div id="scLayReal" class="tbl_cell">
				<div class="tbl_cell_tit">
					<h3>실시간 회의록</h3>
				</div>
				<div class="tbl_cell_cont">
					<div class="btnBox">
						<button type="button" onclick="goRtScript('1');">
							<em class="ico_record"></em>
							<span>실시간 <br>녹음용</span>
						</button>
						<button type="button" onclick="goRtScript('2');">
							<em class="ico_scissors"></em>
							<span>실시간 <br>편집용</span>
						</button>
					</div>
				</div>
			</div>
			<div id="scLayRecord" class="tbl_cell">
				<div class="tbl_cell_tit">
					<h3>회의록 재생</h3>
				</div>
				<div class="tbl_cell_cont">
					<div class="btnBox">
						<button type="button" onclick="goRecScript('1');">
							<em class="ico_headset"></em>
							<span>재생 <br>청취용</span>
						</button>
						<button type="button" onclick="goRecScript('2');">
							<em class="ico_filmEdit"></em>
							<span>재생 <br>편집용</span>
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class="layer_btm">
			<button type="button" onclick="scLayCancel();">취소</button>
		</div>
	</div>
	<!-- //회의록재생 -->
</div>
<!-- //layerPopup -->


<!-- #wrap -->
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
				<li><a href="#">로그아웃</a></li>
			</ul>
		</div>
		<!-- //.etc -->
	</div>
	<!-- //#header -->
	<form name="mainFrm" method="post" onsubmit="return false;">
	<!-- #container -->
	<div id="container" class="div_normal">
		<%@ include file="../common/leftMenu.jsp" %>
		
		<!-- #contents -->
		<div id="contents">
			<!-- .content -->
			<div class="content">
				<!-- .titArea -->
				<div class="titArea">
					<h3>회의현황</h3>
				</div>
				<!-- //.titArea -->
				
				<!-- .section -->
<c:choose>
	<c:when test="${fn:length(mrList) gt 0}">
				<div class="stn">
					<div class="roomBox">
						<ul>
		<c:forEach items="${mrList}" var="mrList" varStatus="status">
							<li class="room_item">
								<span class="room">
									<em class="room_top">
										<strong>${mrList.meetingroom_name}</strong>
									</em>
									<em class="room_mid">
										<button type="button" onclick="confPop('${mrList.minutes_meetingroom_ser}', '${mrList.meetingroom_name}');">
											<strong class="fas fa-cog"></strong>회의실 설정
										</button>
										<button type="button" onclick="confDetail('${mrList.minutes_meetingroom_ser}');">
											<strong class="fas fa-info-circle"></strong>상세정보
										</button>
										<%--	<div style="display:table;height: 36px;overflow: hidden;width:100%;">
												<div style="display: table-cell;vertical-align: middle;text-align: center;width:100%;">
													<a href="javascript:void(0);" style="padding-top: 10px"  onclick="confDetail('${mrList.minutes_meetingroom_ser}');">
														<strong class="fas fa-info-circle"></strong>상세정보
													</a>
												</div>
											</div>--%>
									</em>
									<em class="room_btm">
											<%--<button type="button" onclick="confPop('${mrList.minutes_meetingroom_ser}', '${mrList.meetingroom_name}');">
											<strong class="far fa-calendar-check"></strong>
												예약
											</button>--%>
                            <c:choose>
								<c:when test="${mrList.ing_cnt gt 0}">
									<button type="button">
											<strong class="far fa-calendar-check"></strong>
												회의중
								</c:when>
								<c:when test="${mrList.res_cnt gt 0}">
									<button type="button">
											<strong class="far fa-calendar-check"></strong>
												예약
								</c:when>
								<c:otherwise>
									<button type="button" disabled>
											<strong class="far fa-calendar-check"></strong>
												예약
								</c:otherwise>
							</c:choose>
										</button>
									</em>
								</span>
							</li>
					<c:if test="${ (status.index + 1) % 5 eq 0 }">
						</ul>
						<ul>
					</c:if>
		</c:forEach>
						</ul>
					</div>
				</div>
	</c:when>
	<c:otherwise>
				<div class="stn">
					<div class="roomBox">
						<ul>사용 가능한 회의룸이 없습니다.</ul>
					</div>
				</div>
	</c:otherwise>
</c:choose>
				<!-- //.section -->
				
				<!-- .tblBox -->
				<div class="tblBox">
					<table class="tblType01">
						<caption class="hide">회의현황 목록</caption>
						<colgroup>
							<col><col><col><col><col>
							<col><col>
						</colgroup>
						<thead>
							<tr>
								<th scope="col">회의명</th>
								<th scope="col">회의룸</th>
								<th scope="col">참석인수</th>
								<th scope="col">시작시간</th>
								<th scope="col">종료시간</th>
								<th scope="col">상태</th>
								<th scope="col">시작/종료</th>
								<th scope="col">취소</th>
							</tr>
						</thead>
						<tbody>
				<c:forEach items="${sttMeta}" var="sttMeta" varStatus="status">
							<tr>
								<td scope="row">
									<a class="link" href="javascript:goScript('${sttMeta.stt_meta_ser}', '${sttMeta.minutes_status}', '${sttMeta.minutes_site_ser}');">${sttMeta.minutes_name}</a>
								</td>
								<td>${sttMeta.meetingroom_name}</td>
								<td>
									<span class="txt">${sttMeta.minutes_joined_cnt}</span>
									<span class="preveal">
										<em class="fas fa-search"></em>
										<em class="item">${sttMeta.minutes_joined_mem}</em>
									</span>
								</td>
								<td>${sttMeta.rec_start_time}</td>
								<td>${sttMeta.rec_end_time}</td>
								<td>${sttMeta.rec_status}</td>
								<td>
									<span class="btn">
						<c:choose>
							<c:when test="${sttMeta.minutes_status eq 1}">
										<button type="button" class="btn_tbl active" onclick="meetingStatus('${sttMeta.stt_meta_ser}', '1');"><span class="fas fa-play"></span>시작</button>
							</c:when>
							<c:otherwise>
										<button type="button" class="btn_tbl" disabled><span class="fas fa-play"></span>시작</button>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${sttMeta.minutes_status eq 2}">
										<button type="button" class="btn_tbl active" onclick="meetingStatus('${sttMeta.stt_meta_ser}', '2');"><span class="fas fa-stop"></span>종료</button>
							</c:when>
							<c:otherwise>
										<button type="button" class="btn_tbl" disabled><span class="fas fa-stop"></span>종료</button>
							</c:otherwise>
						</c:choose>
									</span>
								</td>
								<td>
									<span class="btn">
						<c:choose>
							<c:when test="${sttMeta.minutes_status eq 1}">
										<button type="button" class="btn_tbl active" onclick="meetingCancel('${sttMeta.stt_meta_ser}');"><span class="fas"></span>취소</button>
							</c:when>
							<c:otherwise>
										<button type="button" class="btn_tbl" disabled><span class="fas"></span>취소</button>
							</c:otherwise>
						</c:choose>
									</span>
								</td>
							</tr>
				</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- //.tblBox -->

				<div class="div_bottom">
					<div class="tbl_100">
						<div class="row">
							<div class="paging row">
								<%@ include file="../common/paging.jsp" %>
							</div>
						</div>
					</div>
				</div>


				<!-- hidden. paging -->
				<input type="hidden" id="currentPage" name="currentPage" value="${frontConfVO.currentPage}">

				<!-- hidden. for Layer -->
				<input type="hidden" id="site_ser" name="site_ser">
				<input type="hidden" id="meta_status" name="meta_status">
				<input type="hidden" id="meta_ser" name="meta_ser">

		</div>
	</div>
	<!-- //#container -->
	</form>
</div>
<!-- //#wrap -->	
</body>

<script type="text/javascript" src="<c:url value='/resources/js/jquery-3.4.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/all.js'/>"></script>
<script type="text/javascript">
var ws;

$(document).ready(function() {
	conn_ws();
});

//websocket main function
function conn_ws(){
	var cur_micId = "";
	var new_micId = "";

	// ws = new WebSocket( 'ws://127.0.0.1:34990' );
	ws = new WebSocket( 'ws://10.122.66.73:8200/callsocket' );
	ws.onmessage = function(e){
		var rcv_data = JSON.parse(e.data);
		console.log("### rcv_data:" + rcv_data.toString());
	};
	ws.onopen = function(){
		console.log("==> Socket Opened");
		var sendMsg = '{"EventType":"CONFERENCE", "Event":"subscribe"}';
		ws.send(sendMsg);
		console.log("==> Sent opening message : subscribe : sendMsg : " + sendMsg);
		// sendMsg = '{"EventType":"STT", "Event":"START", "Caller":"' + getd_cust_tel_no + '", "Agent":"' + getd_cust_op_id + '", "contractNo":"' + getd_contract_no + '", "campaignId":"' + getd_campaign_id + '"}';
		// sendMsgRestful(sendMsg);
	}
}

//회의룸 설정 pop up
function confPop(rser, mrnm){
	var popSize = "width=800,height=650";
	var popOption = "titlebar=no,toolbar=no,menubar=no,location=no,directories=no,status=no,scrollbars=no";
	pop1 = window.open("/setUpConf?site_ser=1&room_ser=" + rser, "pop1", popSize + "," + popOption);
}

//회의 상세정보
function confDetail(rser){
	location.href="detailView?room_ser=" + rser;
}

//실시간/녹음된 스크립트 보기 이동
function goScript(ser, status, sites){
	// location.href="sel_script?meta_ser=" + ser;

	if( status == '1'){
		$('#scLayReal').css('display', 'table-cell')
		$('#scLayRecord').css('display', 'none')
	}
	if( status == '2'){
		$('#scLayReal').css('display', 'none')
		$('#scLayRecord').css('display', 'table-cell')
	}

	$('#site_ser').val(sites);
	$('#meta_status').val(status);
	$('#meta_ser').val(ser);
	$('#goScriptLay').css("display", "block");
}

//조회
function goSch(){
	//mainFrm.method = "POST";
	mainFrm.method = "GET";
	mainFrm.action = "/dashboard";
	mainFrm.submit();
}

//페이지 이동
function goPage(num){
	$('#currentPage').val(num);

	goSch();
}

// 시작 / 종료 버튼 클릭
function meetingStatus(ser, status){
	$.ajax({
		url : "meetingStatusUpdate",
		data : {meta_ser:ser, meetStatus:status},
		type : "POST"
	}).done(function(data){
		console.log("### SUCC : " + data);

		var rcv_data = JSON.parse(data);

		var sendMsg = '';
		if( status == 1 ) {
			sendMsg = '{"EventType":"COMMAND", "Event":"start", "rec_id":"' + ser + '", "mic_ip":"' + rcv_data[0] + '", "mic_port1":"' + rcv_data[1] + '", "mic_port2":"' + rcv_data[2] + '", "mic_port3":"' + rcv_data[3] + '", "mic_port4":"' + rcv_data[4] + '", "mic_port5":"' + rcv_data[5] + '", "mic_port6":"' + rcv_data[6] + '", "mic_port7":"' + rcv_data[7] + '", "mic_port8":"' + rcv_data[8] + '"}';
		}else{
			sendMsg = '{"EventType":"COMMAND", "Event":"stop", "rec_id":"' + ser + '", "mic_ip":"' + rcv_data[0] + '", "mic_port1":"' + rcv_data[1] + '", "mic_port2":"' + rcv_data[2] + '", "mic_port3":"' + rcv_data[3] + '", "mic_port4":"' + rcv_data[4] + '", "mic_port5":"' + rcv_data[5] + '", "mic_port6":"' + rcv_data[6] + '", "mic_port7":"' + rcv_data[7] + '", "mic_port8":"' + rcv_data[8] + '"}';
		}
		ws.send(sendMsg);
		console.log("### sent message : " + sendMsg);
		location.reload();
	}).fail(function(data){
		console.log("### FAIL : " + data);
		location.reload();
	});
}

//취소 버튼 클릭
function meetingCancel(ser){
	var tf_check = confirm('취소하시겠습니까?');
	if( !tf_check ){
		return false;
	}

	$('#meta_ser').val(ser);

	mainFrm.action="meetingCancel";
	mainFrm.method="post";
	mainFrm.submit();
}


//실시간 회의록 선택 레이어 취소
function scLayCancel(){
	$('#goScriptLay').css("display", "none");
}

//실시간 구분.   실시간 : 1=녹음용, 2=편집용
function goRtScript(flag){
	if( flag == '1' ){
		//go 실시간 녹음
		mainFrm.action="rt_script";
	}
	if( flag == '2'){
		//go 실시간 편집
		mainFrm.action="rtEdit_script";
	}

	mainFrm.method="post";
	mainFrm.submit();
}

//재생용 구분.   재생 : 1=청취용, 2=편집용
function goRecScript(flag){
	if( flag == '1' ){
		mainFrm.action="rec_script";
	}
	if( flag == '2' ){
		mainFrm.action="recEdit_script";
	}
	mainFrm.method="post";
	mainFrm.submit();
}
</script>


</html>
