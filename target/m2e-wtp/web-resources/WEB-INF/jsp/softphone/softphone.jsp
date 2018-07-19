<%--
 * file name : softphone.jsp
 * description : 소프트폰 조작, CTI연동
 * author : H.K.Lee
 * initial date : 2017.12.11
 * history
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<meta name="subject" content="KBIZ">
<meta name="author" content="KBIZ">
<meta name="keywords" content="KBIZ">
<meta name="description" content="KBIZ">
<jsp:include page="/WEB-INF/jsp/comm_top.jsp"/>
<title>KBIZ</title>
<script type="text/javascript">
var transferFlag = "N"; // 호전환 종결->인입과 일반 인입을 구분해서 soft_inbound()를 중복호출하지 않게 함
var popWin=""; // ADMIN팝업
var hold = true; // 대기버튼을 후처리->대기, 작업->대기 인지를 구분하기 위함
var callingYn = "N"; // 콜인입이 되었는지 여부(전화받기 활성화 등)
var custPop=""; // 고객조회 팝업
$(function() {
	$('.gnb > dd > a').on('click',function() {
		if(SCall.CtiAgentStateEx() != "B"){
			if(!$(this).parent().hasClass('on')){
				$(this).parent().siblings().removeClass('on');
				$(this).parent().addClass('on');
			}else{
				$(this).parent().siblings().removeClass('on');
				$(this).parent().removeClass('on');
			};
		}
	});

	// CI클릭 메인으로 이동
	$("h1").click(function(){
		parent.mainFrame.location.href="/main/main.do";
		$(".on", parent.leftFrame.document).removeClass("on");
		$("#main", parent.leftFrame.document).addClass("on");
	});

	$(".cti").hide();
	//CTI 로그인 여부 체크
	if($("#ctiYn").val() == "Y"){
		CTILogin();
	}

	// 작업 상태 변경
	$(".away ul li").click(function(){
		if(SCall.CtiAgentStateEx() != "B"){
			var text = $(this).text();
			$("#away").text(text);
			$(".softBtn").removeClass("on");
			var aindex = $(this).index();
			SCall.CtiBreak(aindex+1);
		}
	});

	// 작업버튼 클릭하면 바로 작업상태로
	$("#away").click(function(){
		if(SCall.CtiAgentStateEx() != "B"){
			SCall.CtiBreak(1);
		}else{
			alert("지금은 통화중입니다.");
		}
	});

	// 소프트폰 버튼 이벤트
	$(".softBtn").click(function(){
		// CTI로그인이 되어있지 않거나 로그인 오류인 경우 소프트폰 버튼 사용제한
		if($("#ctiYn").val() != "Y" || $("#ctiLoginYn").val() != "Y"){
			alert("CTI로그인을 해주세요.");
			return false;
		}else{
			var cindex = $(this).index();
			if(cindex == 1){ // 전화걸기
				if(SCall.CtiAgentStateEx() != "B"){
					var tell = $.trim(KBIZST.replaceTell($("#tellNum").val()));
					if(tell.length > 4){
						SCall.Device = "9" + tell;
					}else if(tell.length == 4){
						SCall.Device = tell;
					}else{
						alert("전화번호를 다시 입력해주세요.");
						return false;
					}
					$("#recUrl").val("");
					callingYn == "Y";
					if(typeof(parent.mainFrame.conFrame) != "undefined" && KBIZVA.isNullOrEmpty($("#callbackSeq", parent.mainFrame.conFrame.document).val())){
						parent.mainFrame.conFrame.document.getElementById("out").checked=true;
						parent.mainFrame.conFrame.fn_selLcode();
					}
					if(KBIZVA.isNullOrEmpty($("#callbackSeq", parent.mainFrame.conFrame.document).val())){
						$("#ioType").val("O");
					}
					SCall.CtiMakeCall();
					call_start(0);
				}else{
					return false;
				}
			}else if(cindex == 2){ // 전화받기
				if(callingYn == "Y"){
					$("#ioType").val("I");
					clearInterval(callInterval);
					SCall.CtiAnswer();
					call_start(1);
				}else{
					return false;
				}
			}else if(cindex == 3){ // 전화끊기
				SCall.CtiDisconnect();
				call_end();
				return false;
			}else if(cindex == 4){ // 보류
				console.log(hold);
				if("P,W,S".indexOf(SCall.CtiAgentStateEx()) == -1){
					if(hold == true){
						SCall.CtiHold();
						hold = false;
					}else{
						$(".softBtn").eq(3).removeClass("cus");
						$(".softBtn").eq(1).addClass("cus");
						SCall.CtiRetrieve();
						hold = true;
						return false;
					}
				}else{
					return false;
				}
			}else if(cindex == 5){ // 대기
				if(SCall.CtiAgentStateEx() != "B"){
					var state = CTIState();
					if(state=="P"){
						SCall.CtiBreak(0); // 작업(휴식,이석 등등) 상태일 때 -> 대기상태로 변경
					}else{
						SCall.CtiEndReady(); // 후처리상태일 때 -> 대기상태로 변경
					}
					/* $(".softBtn").removeClass("cus");
					$(".softBtn").eq(4).addClass("cus"); */
				}else{
					alert("지금은 통화중입니다.");
					return false;
				}
			}else if(cindex == 6){ // 후처리버튼 막기
				return false;
			}else if(cindex == 7){
				if(SCall.CtiAgentStateEx() == "B"){
					return false;
				}
			}
			$(".softBtn").eq(cindex-1).siblings().removeClass("cus");
			$(".softBtn").eq(cindex-1).addClass("cus");
		}
	});
	setInterval("updateTop()",60000);
});

// 상단 당일 현황 업데이트
function updateTop(){
	KBIZIO.requestParamAjax("/main/updateTop.json", fn_updateTop);
}
function fn_updateTop(ret){
	var r = ret.cc;
	$("#ccc").text(r.ccc);
	$("#tcc").text(r.tcc);
	$("#cbcc").text(r.cbcc);
}

var hh = 0;
var mm = 0;
var ss = 0;
var callInterval = null;
var setIn;
var curTime = "";

// 예약전화/이관 outbound
function manualCall(){
	var tell = $.trim(KBIZST.replaceTell($("#tellNum").val()));
	SCall.Device = "9" + tell;
	call_start(0);
	SCall.CtiMakeCall();
};

// 전화 걸기/받기
function call_start(e){
	if(e == 1 && callingYn == "Y"){
		callInterval = setInterval("timer_script()",1000);
		$("#callStartDate").val($.parseJSON(KBIZDT.getFormattedServerDateTime()).dateTime);
		$("#cnltDate").val($.parseJSON(KBIZDT.getFormattedServerDateTime()).dateTime);
		clearInterval(setIn);
		callingYn = "N";
		$("#ioType").val("I");
	}
	$(".softBtn").removeClass("cus");
	if(!$(".softBtn").eq(e).hasClass("cus")){
		$(".softBtn").eq(e).addClass("cus");
	}
};

// 전화끊기/고객이끊기
function call_end(){
	clearInterval(callInterval);
	clearInterval(setIn);
	ss = 0;
	hh = 0;
	mm = 0;
	$("#CallTime").text("00:00:00");
	$(".softBtn").removeClass("cus");
	$(".softBtn").removeClass("on");
	callingYn = "N";
	var state_tp = SCall.CtiAgentStateEx();
	if(state_tp == "W"){
		$(".softBtn").eq(4).addClass("cus");
	}else if(state_tp == "P"){
		$(".softBtn").eq(6).addClass("cus");
	}else{
		$(".softBtn").eq(5).addClass("cus");
	}
};

// 통화시간 타이머
function timer_script(){
	ss+=1;
	if(ss==60){
		mm+=1;
		ss=0;
	}
	if(ss<10){
		if(mm<10){
			curTime = "0"+hh+":0"+mm+":0"+ss;
		}else{
			curTime = "0"+hh+":"+mm+":0"+ss;
		}
	}else{
		if(mm<10){
			curTime = "0"+hh+":0"+mm+":"+ss;
		}else{
			curTime = "0"+hh+":"+mm+":"+ss;
		}
	}
	$("#CallTime").text(curTime);
};

// 콜 인입시 인입전화번호로 고객정보 조회
function soft_inbound(){
	console.log(SCall.CtiWhoIsCaller());
	var arr = (SCall.CtiWhoIsCaller()).split("|");
	if(arr.length > 1 && arr != null){
		var tlno = arr[1];
		$("#tellNum").val(tlno);
		KBIZIO.requestParamAjax("/inbound/customer/custInbound.json", fn_CustCallback, {params: {tlno: tlno}, async: false});
	}
};

// 조회된 고객 개수에 따라 각각 플로우
function fn_CustCallback(ret){
	var r = ret.totList;
	var len = r.length;
	var arr = (SCall.CtiWhoIsCaller()).split("|");
	if(len>1){
		parent.mainFrame.location.href = "/inbound/main.do?chnlCode="+arr[2].substring(0,1)+"&startCon=";
		custPop = window.open('/inbound/customer/custSearch.do?opener=softphone&tlno='+ $.trim(KBIZST.replaceTell($("#tellNum").val())),'custSearch','width=800,height=500,toolbar=no');
		custPop.focus();
	}else if(len==1){
		parent.mainFrame.location.href = "/inbound/main.do?chnlCode="+arr[2].substring(0,1)+"&startCon=Y";
	}else{
		parent.mainFrame.location.href = "/inbound/main.do?chnlCode="+arr[2].substring(0,1)+"&startCon=N";
	}
	$(".on",parent.leftFrame.document).removeClass("on");
	$("#in",parent.leftFrame.document).addClass("on");
};

// 전화번호 수동입력 후 조회
function soft_outbound(){
	var con=false;
	if(typeof(parent.mainFrame.conFrame) != "undefined"){
		if(!KBIZVA.isNullOrEmpty($("#callbackSeq", parent.mainFrame.conFrame.document).val())){
			con = confirm("**저장되지 않은 콜백 상담내역이 있습니다.**\n저장하지 않을 경우 콜백이 선점된 채 상담내역은 저장되지 않습니다.\n계속해서 조회하시겠습니까?\n상담내역을 저장하지 않고 계속해서 진행하시려면 '확인'버튼을 클릭하세요.");
		}else{
			var tlno = $.trim(KBIZST.replaceTell($("#tellNum").val()));
			KBIZIO.requestParamAjax("/inbound/customer/custInbound.json", fn_CustCallback2, {params: {tlno: tlno}, async: false});
		}
		if(con){
			var tlno = $.trim(KBIZST.replaceTell($("#tellNum").val()));
			KBIZIO.requestParamAjax("/inbound/customer/custInbound.json", fn_CustCallback2, {params: {tlno: tlno}, async: false});
		}
	}else{
		var tlno = $.trim(KBIZST.replaceTell($("#tellNum").val()));
		KBIZIO.requestParamAjax("/inbound/customer/custInbound.json", fn_CustCallback2, {params: {tlno: tlno}, async: false});
	}
};
function fn_CustCallback2(ret){
	var r = ret.totList;
	var len = r.length;
	var tlno = $.trim(KBIZST.replaceTell($("#tellNum").val()));
	if(len>1){
		parent.mainFrame.location.href = "/inbound/main.do?chnlCode=&startCon=";
		custPop = window.open('/inbound/customer/custSearch.do?opener=softphone2&tlno='+tlno,'custSearch','width=800,height=500,toolbar=no');
		custPop.focus();
	}else if(len==1){
		parent.mainFrame.location.href = "/inbound/main.do?chnlCode=&startCon=Y";
	}else{
		parent.mainFrame.location.href = "/inbound/main.do?chnlCode=&startCon=N";
	}
	$(".on",parent.leftFrame.document).removeClass("on");
	$("#in",parent.leftFrame.document).addClass("on");
};

// 전화번호 조회 Enter Key
function searchKeyEvent(){
	if(event.keyCode=="13"){
		soft_outbound();
	}
};

/*
”Z” = 로그인을 하지않은 초기화, 상담원 LOGOUT 중 상태
”L” = 상담원 LOGIN 시도중 상태
”W” = 상담원 전화대기중 상태
”B” = 상담원 통화연결중 상태
”S” = 상담원 저장중 상태
”P” = 상담원 휴식/중단중 상태
*/

// CTI 상태
function CTIState(){
	var state_tp = SCall.CtiAgentStateEx();
	if(state_tp=="S"){
		$(".softBtn").removeClass("cus");
		$(".softBtn").eq(5).addClass("cus");
	}
	return state_tp;
}

//CTI로그인
function CTILogin(){
	var ctiId = $("#ctiId").val();
	var ctiDevice = $("#ctiDevice").val();
	SCall.AgentID = ctiId;
    SCall.AgentDevice = ctiDevice;
    var nRet = SCall.CtiLogin();
    if(nRet == 0){
    	CTIState();  // 현재 상담원 상태값 받기
    	$("#ctiLoginYn").val("Y");
		$(".cti").show();
        $(".softBtn").eq(5).addClass("cus");
        SCall.OptionData = ctiDevice;
        SCall.CtiGetAgentsList(30);
        var temp = SCall.AgentsList();
        var groupId = RecIF.SubString(temp, 45, 5);
        console.log(SCall.AgentsList());
        console.log("groupID="+groupId);
        console.log("내선번호="+ctiDevice);
		$("#groupId").val(groupId);
		RecIF.RecIFStart("callrec.kbiz.or.kr",ctiDevice); // 녹취로그인
		RecIF.MntIFStart("172.30.2.37",groupId,5000); // IVR로그인
		KBIZIO.requestParamAjax("/main/recUpdate.json", "", {params: {groupId: groupId, callTelNum: ctiDevice}});
    }else{
        alert("올바르지 않은 내선번호 이거나 이미 로그인 되어있습니다. 오류가 반복될 경우 관리자에게 문의해주세요.");
    }
};

// CTI 로그아웃
function CTILogout(){
	if(SCall.hasOwnProperty("CtiLogout") == true){ // CtiLogout 기능이 있는지 여부를 판단
		SCall.CtiLogout();
	}
    //로그아웃 시 admin팝업창 닫기
    if($("#apGrade").val() != "03"){
	  	if(popWin){
        	popWin.close();
       	}
    }
    KBIZIO.requestParamAjax("/execLogout.json", null, {async: false});
};

// Call inbound -> 전화받기 버튼 깜빡임
function calling(){
	$("#ioType").val("I");
	callingYn = "Y";
	setIn = setInterval("call_in()",500);
	// 수정됨....
	//$("#ioType").val("I");
};
function call_in(){
	if($(".softBtn").eq(1).hasClass("cus")){
		$(".softBtn").eq(1).removeClass("cus");
	}else{
		$(".softBtn").eq(1).addClass("cus");
	}
};

// callback 고객 팝업
function consult_popUp(){
	var tellNum = $.trim(KBIZST.replaceTell($("#tellNum").val()));
	custPop = window.open('/inbound/customer/custSearch.do?opener=callback&tlno='+tellNum,'custSearch','width=800,height=500,toolbar=no');
	custPop.focus();
};

// AP로그아웃
function apLogout(){
	$("body").prop("onbeforeunload", "");
	CTILogout();
	var ssoLoginYn = '${ssoLoginYn}';
	if (ssoLoginYn == "Y") {
		parent.location.href = "${ssoServer}/sso/pmi-logout-url.jsp?returl=" + location.origin + "/login.do";
	} else {
	    parent.location.href = "/login.do";
	}
};

//ADMIN팝업
function fn_admin(){
	setTimeout("adminPop()",300);
    popWin = window.open('/admin/index.do','mypagePop','width=1570,height=800,resizable=yes,scrollbars=no,toolbar=no');
};
function adminPop(){
	popWin.focus();
};
</script>

<!-- CTI 팝업 메세지  -->
<script language="javascript" for="SCall" event="MessageArrive">
	var str = SCall.ArrivedMessage();
	console.log(str);
	if(str == "Caller Info Arrived"){ // 콜 정보
		if(transferFlag != "Y"){
			/* clearInterval(callInterval);
			SCall.CtiAnswer();
			call_start(1); */
			soft_inbound();
		}
	}else if(str == "Incoming Call"){ // 콜 인입
		calling();
	}else if(str == "Call Disconnected"){ // 콜 끊김
		var state_tp = SCall.CtiAgentStateEx();
		console.log(state_tp);
		if(state_tp != "B"){ // 2차인증 할때 콜이 끊겨 상담시간이 초기화 되는것을 막음
			call_end();
		}
		transferFlag="N";
		hold = true;
	}else if(str == "Call Connected"){ // 콜 연결
		callingYn = "Y";
		call_start(1);
		$(".softBtn").removeClass("cus");
		$(".softBtn").eq(1).addClass("cus");
	}else if(str == "Password Arrived"){ // 2차인증번호 도착
		if(SCall.CtiGetPassword().substring(0,2) == "00"){
			var pass = SCall.CtiGetPassword().substring(5,9);
			parent.mainFrame.custFrame.smsIdentify(pass);
		}else{
			alert("인증오류 입니다.");
		}
	}else if(str == "Call DisconnectHold"){ // 호전환 중 고객이 끊음
		alert("고객이 전화를 끊었습니다.");
		SCall.CtiDisconnect();
		call_end();
		transferFlag="N";
		hold = true;
	}else if(str == "Consult IncomingCall"){ // 호전환 들어옴
		transferFlag = "Y";
		calling();
	}else if(str == "Call Transferred"){ // 호전환 종결
		if(transferFlag == "Y"){ // Caller Info Arrived 이벤트와 같이 들어오기 때문에 soft_inbound()함수의 중복 호출을 막는다.
			/* clearInterval(callInterval);
			SCall.CtiAnswer();
			call_start(1); */
			soft_inbound();
			transferFlag="N";
		}
	}
</script>

<!-- 녹취파일명 -->
<script language="javascript" for="RecIF" event="EVTRecFileArrive(recpath)">
	console.log(recpath);
	var url = $("#recUrl").val();
	if(url != null && url.length > 0){
		$("#recUrl").val(url+"&"+recpath);
	}else{
		$("#recUrl").val(recpath);
	}
</script>

<!-- 대기호수, 응대율 -->
<script language="javascript" for="RecIF" event="EVTCTIInfo(para1,para2,para3)">
	$("#waitCall").text(para2);
	$("#callPer").text(para3+"%");
</script>

</head>
<body onbeforeunload="CTILogout()">
<form id="softphfrm" name="softphfrm">
<input type="hidden" name="hid_userid" id="hid_userid" value="" />
<input type="hidden" name="hid_state" id="hid_state" value="" />
<input type="hidden" name="groupId" id="groupId" value="" />
<input type="hidden" name="recUrl" id="recUrl" value="" />
<input type="hidden" id="ctiYn" value="${ctiYn}"/>
<input type="hidden" id="ctiId" value="${ctiId}"/>
<input type="hidden" id="ctiDevice" value="${ctiDevice}" />
<input type="hidden" id="cnltDate" name="cnltDate" value=""/>
<input type="hidden" id="callStartDate" name="callStartDate" value=""/>
<input type="hidden" id="callEndDate" name="callEndDate" value=""/>
<input type="hidden" id="apGrade" name="apGrade" value="${apGrade}"/>
<input type="hidden" id="ctiLoginYn" value="N"/>
<input type="hidden" id="ioType" name="ioType" value="I" />
<div class="gnb_wrap clfix">
	<dl class="gnb clfix fl">
		<dt><h1><a href="#"><img src="/img/index_type01_03.png" border="0"></a></h1></dt>
		<dd class="bgnone softBtn"><a href="#"><span><img src="/img/index_type01_05.png"></span>전화걸기</a></dd>
		<dd class="softBtn"><a href="#"><span><img src="/img/index_type01_07.png"></span>전화받기</a></dd>
		<dd class="softBtn"><a href="#"><span><img src="/img/index_type01_09.png"></span>전화끊기</a></dd>
		<dd class="softBtn"><a href="#"><span><img src="/img/index_type01_11.png"></span>보류</a></dd>
		<dd class="softBtn"><a href="#"><span><img src="/img/index_type01_15.png"></span>대기</a></dd>
		<dd class="softBtn"><a href="#"><span><img src="/img/index_type01_17.png"></span>후처리</a></dd>
		<dd class="softBtn"><a href="#"><span><img src="/img/index_type01_19.png"></span><span id="away">작업</span></a>
			<div class="away" id="inaway">
			    <ul>
                    <li><a href="#">작업</a></li>
                    <li><a href="#">이석</a></li>
                    <li><a href="#">식사</a></li>
                    <li><a href="#">휴식</a></li>
                    <li><a href="#">회의 </a></li>
                    <li><a href="#">교육 </a></li>
                </ul>
			</div>
		</dd>
		<dd class="on"><div class="cti">CTI로그인</div></dd>
	</dl>
    <div class="fr" style="padding:11px">
    	<!-- TODO 차세대 완료 후 주석 해제 -->
        <!-- <a class="btn small g_lightgray" href="http://dportal.9988.or.kr/ssoAgent/KbizSSORlnlPage.jsp" target="_blank" id="openPortal9988" style="cursor: hand;">KBIZ</a> -->
    	<c:if test="${apGrade == '01' || apGrade == '02'}">
       		<a class="btn small g_lightgray" onclick="fn_admin()" id="admin" style="cursor: hand;">ADMIN</a>
        </c:if>
        <a class="btn small g_lightgray" onclick="apLogout()" id="apLogout" style="cursor: hand;">LOGOUT</a>
    </div>
</div>
</form>
<form id="custfrm" name="custfrm" onsubmit="return false;">
<div class="status_wrap clfix">
    <ul class="tel_sch fl clfix">
        <li><strong>전화번호</strong></li>
        <li><input type="text" name="tellNum" id="tellNum" value="" onkeypress="searchKeyEvent()" style="width:120px;" /></li>
        <li><a href="#" class="btn_sch" onclick="soft_outbound()">조회</a></li>
    </ul>
    <ul class="status fl clfix mgr20">
        <li><span>통화시간</span><strong id="CallTime">00:00:00</strong></li>
        <li><span>일통화건</span><strong id="ccc">0</strong></li>
        <li><span>이관건수</span><strong id="tcc">0</strong></li>
    </ul>
    <ul class="status fl clfix mgl20">
        <li><span>당일응대율</span><strong id="callPer">0%</strong></li>
        <li><span>대기콜</span><strong id="waitCall">0</strong></li>
        <li><span>CallBack</span><strong id="cbcc">0</strong></li>
    </ul>
    <ul class="status fl clfix">
    	<li><span>${apUserNm}님(<c:if test="${ctiDevice ne null}">${ctiDevice},</c:if>
    	<c:if test="${apGrade == '01'}">시스템관리자</c:if>
    	<c:if test="${apGrade == '02'}">관리자</c:if>
    	<c:if test="${apGrade == '03'}">상담사</c:if>) 안녕하세요.</span></li>
    </ul>
</div>
</form>
<OBJECT ID="SCall" CLASSID="clsid:618CB2BC-2366-4FCE-91AB-BE38B451CABA" width="0" height="0" ></OBJECT>
<OBJECT ID="RecIF" CLASSID="clsid:c0f7c287-910d-48ca-b105-6c1dd5b13b26" width="0" height="0" ></OBJECT>
</body>
</html>
