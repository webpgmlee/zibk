<%--
 * file name    : consult.jsp
 * description  : 상담내용 조회/저장
 * author       : H.K.Lee
 * initial date : 2017.11.01
 * history
  수정일자      수정자 수정내용
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<jsp:include page="/WEB-INF/jsp/comm_top.jsp"/>
<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<meta name="subject" content="KBIZ">
<meta name="author" content="KBIZ">
<meta name="keywords" content="KBIZ">
<meta name="description" content="KBIZ">
<title>KBIZ</title>
<script type="text/javascript">
$(function(){
	var CallWait = false; // 호전환을 클릭하여 호전환 하였는지 여부 판단
	var startCon = $("#startCon").val(); // Y=1건고객, N=미확인고객
	var tlno = $.trim(KBIZST.replaceTell($("#tellNum",parent.parent.topFrame.document).val()));
	$("#tellNum").val(tlno);
	if(startCon == "Y"){ // 1건고객
		KBIZIO.requestParamAjax("/inbound/customer/custSearch.json", fn_CustCallback, {params: {tlno: tlno}});
	}else if(startCon == "N"){ // 0건고객
		$("#custNm").val("미확인");
	}

	if($("#ioType", parent.parent.topFrame.document).val() == "I"){
		document.getElementById("in").checked=true;
	}else if($("#ioType", parent.parent.topFrame.document).val() == "O"){
		document.getElementById("out").checked=true;
	}else{
		document.getElementById("callback").checked=true;
	}

	fn_selLcode();
	/* 달력 */
	KBIZDT.setDatepicker("dates");
    KBIZDT.datepicker();

    var now = new Date();
    var year= now.getFullYear();
    var mon = now.getMonth()+1;
    var day = now.getDate();
	$("#dates").val(KBIZDT.addFormattedDate(year+''+mon+''+day,'m',0));

    /* 처리구분 케이스 초기상태 */
    $(".case").hide();
	$(".case1").show();

	/* 상담 내용 초기화 */
	$("#init").click(function(){
		var con = confirm("초기화하시겠습니까?");
		if(con){
			$(".init").val("");
			$(".init2").val("");
			$("#tellNum",parent.parent.topFrame.document).val("");
			$(".init", parent.custFrame.document).val("");
			$("#lcode").html("<option value=''>선택</option>");
			$("#mcode").html("<option value=''>선택</option>");
			$("#scode").html("<option value=''>선택</option>");
			$(".case").hide();
			$(".case1").show();
			$("#callTellNum", parent.conInfoFrame.document).val("");
			$("#untyCsno", parent.conInfoFrame.document).val("");
			$("#untyCntrNo", parent.conInfoFrame.document).val("");
			parent.conInfoFrame.fn_searchConsult2();
			parent.conInfoFrame.fn_searchConsult();
		}
	});

	/* 상담 내용 저장 */
	$("#conSave").click(function(){
		var valid = fn_validation(); // 저장될 값 유효성 검사
		if(valid){
			$("#recUrl").val($("#recUrl",parent.parent.topFrame.document).val());
			$("#cnltDate").val($("#cnltDate",parent.parent.topFrame.document).val());
			$("#callStartDate").val($("#callStartDate",parent.parent.topFrame.document).val());
			$("#callEndDate").val($.parseJSON(KBIZDT.getFormattedServerDateTime()).dateTime);
			if(!KBIZVA.isNullOrEmpty($("#callbackSeq").val())){
				$("#ioType").val("C");
			}else{
				$("#ioType").val($("#ioType", parent.parent.topFrame.document).val());
			}
			if($("#cnltProcCd").val()=="02"){
				var rdate = $(".times").eq(0).val()+" ";
				if($(".times").eq(1).val().length>1) {
					rdate += $(".times").eq(1).val()+":";
				}else{
					rdate += "0"+$(".times").eq(1).val()+":";
				}
				rdate += $(".times").eq(2).val()+":00";
				var date = KBIZDT.getFormattedDate($(".times").eq(0).val(),"yyyyMMdd");
				var cdate = $.parseJSON(KBIZDT.getServerDate()).dateTime;
				if(date<cdate){
					alert("예약일시를 현재보다 뒤로 설정해주세요.");
					return false;
				}
				if(date == cdate){
					var time="";
					if($(".times").eq(1).val().length > 1){
						time += $(".times").eq(1).val();
					}else{
						time += "0"+$(".times").eq(1).val();
					}
					if($(".times").eq(2).val().length > 1){
						time += $(".times").eq(2).val();
					}else{
						time += "0"+$(".times").eq(2).val();
					}
					var ctime = $.parseJSON(KBIZDT.getServerTime()).dateTime.substring(0,4);
					if(time<=ctime){
						alert("예약일시를 현재보다 뒤로 설정해주세요.");
						return false;
					}
				}
				$("#rsrvDate").val(rdate);
			}

			var con = confirm("저장하시겠습니까?");
			var callback = "";
			if(con){
				if($("#cnltProcCd").val() == "04"){
					KBIZIO.requestJsonAjax("consultInsert",fn_vocReg);
				}else{
					KBIZIO.requestJsonAjax("consultInsert","");
				}
				$(".init").val("");
				$(".init2").val("");
				$(".init", parent.custFrame.document).val("");
				$("#recUrl", parent.parent.topFrame.document).val("");
				$("#cnltDate").val("");
				$("#callStartDate").val("");
				$("#callEndDate").val("");
				$("#cnltDate", parent.parent.topFrame.document).val("");
				$("#callStartDate", parent.parent.topFrame.document).val("");
				$("#callEndDate", parent.parent.topFrame.document).val("");
				$("#untyCsno", parent.conInfoFrame.document).val("");
				$("#untyCntrNo", parent.conInfoFrame.document).val("");
				$("#callTellNum", parent.conInfoFrame.document).val("");
				$("#callbackSeq").val("");
				$("#cnltSeq").val("");
				$("#cnltDetailNo").val("");
				$("#cnltProcCd").val("01");
				parent.conInfoFrame.fn_searchConsult2();
				parent.conInfoFrame.fn_searchConsult();
				alert("저장되었습니다.");
				$("#custSpecial", parent.custFrame.document).hide();
				$(".case").hide();
				$(".case1").show();
			}
		}
	});

	/* 호전환 종결 */
	$("#transferEnd").click(function(){
		if(CallWait){ // 호전환 상태
			var con = confirm("호전환을 종결 하시겠습니까");
			if(con){
				parent.parent.topFrame.call_end();
				var incall = ($("#userTell").val()).split("|");
				var nRet = parent.parent.topFrame.SCall.CtiTransfer();
			 	if(nRet != 0){
			 		var msg = parent.parent.topFrame.SCall.CtiErrorMessage();
			 		parent.parent.topFrame.SCall.CtiReconnect(); // 다시받기
			 		CallWait = false;
			 		alert(msg);
			 	}
			 	alert("종결되었습니다.");
			}
		}else{
			alert("호전환 상태가 아닙니다.");
			return false;
		}
	});

	/* 호전환 내선번호 선택, 호전환가능여부 확인 */
	$("#userTell").change(function(){
		 var incall = ($("#userTell").val()).split("|");
		 parent.parent.topFrame.SCall.OptionData = incall[0];
		 parent.parent.topFrame.SCall.CtiGetAgentsList(30);
	     var temp = parent.parent.topFrame.SCall.AgentsList();
	     console.log(temp);
	     if($("#userTell").val() != ""){
		     if(temp.length > 5){
		    	 var state = parent.parent.topFrame.RecIF.SubString(temp, 33, 1); // 호전환 받을 상담사의 현재 상태값
				 console.log(state);
			     if(state != "W"){
			    	 alert("상담원이 호전환 받을 수 없는 상태입니다.");
			    	 $("#userTell").val("");
			     }
		     }
		}else{
			alert("내선번호를 선택해 주세요.");
		}
	});

	/* 호전환 */
	$("#CallWait").click(function(){
		$("#transferEnd").show();
		var incall = ($("#userTell").val()).split("|");
		var kbizTell = $("#kbizTell").val();
		if(incall[0] != null && incall[0].length == 4 && kbizTell == ""){
			parent.parent.topFrame.SCall.Destination(incall[0]); // 전환할 내선번호
		}else if(kbizTell != "" && $("#userTell").val() == ""){
			if(kbizTell.length == 4){
				parent.parent.topFrame.SCall.Destination("7"+kbizTell);
			}else{
				parent.parent.topFrame.SCall.Destination("9"+kbizTell);
			}
		}else{
			alert("호전환 번호를 입력해주세요.(내선, 중앙회내부/외부 는 중복입력은 되지 않습니다)");
			return false;
		}
		parent.parent.topFrame.SCall.SVCName("");
		parent.parent.topFrame.SCall.ReservedData("temp|"+$("#tellNum").val()+"|"+$("#chnlCode").val());
		parent.parent.topFrame.SCall.CtiConsultEx();
	 	CallWait = true;
	 	$("#callEndDate").val($.parseJSON(KBIZDT.getFormattedServerDateTime()).dateTime);
	});

	/* 호전환중인 콜 회수 */
	$("#ReCall").click(function(){
		var con = confirm("회수 하시겠습니까?");
		if(con){
			if(CallWait){
				parent.parent.topFrame.SCall.CtiReconnect();
				$("#transferEnd").hide();
				CallWait = false;
			}else{
				alert("호전환 상태가 아닙니다.");
			}
		}else{
			return false;
		}
	});

	/* 처리구분 케이스 처리 */
	$("#cnltProcCd").change(function(){
		$(".case").hide();
		var gubun = $(this).val();
		if(gubun == "02"){
			$(".case2").show();
			$(".times").attr("disabled",false);
			$("#rsrvTellNum").attr("disabled",false);
		}else{
			$(".times").attr("disabled","disabled");
			$("#rsrvTellNum").attr("disabled","disabled");
		}
		if(gubun == "03"){
			$(".case3").show();
			$("#tranId").attr("disabled",false);
		}else{
			$("#tranId").attr("disabled","disabled");
		}
		if(gubun == "04"){
			$(".case4").show();
			$("#kbizId").attr("disabled",false);
			window.open('/inbound/consult/vocPop.do','','width=600,height=300,resizable=no,scrollbars=no,toolbar=no');
		}else{
			$("#kbizId").attr("disabled","disabled");
		}
		if(gubun == "05"){
			$(".case5").show();
			$("#userTell").attr("disabled",false);
		}else{
			$("#userTell").attr("disabled","disabled");
		}
		if(gubun == "07"){
			$(".case6").show();
			$("#tranId2").attr("disabled",false);
		}else{
			$("#tranId2").attr("disabled","disabled");
		}
		if("00,01,06".indexOf(gubun) != -1){
			$(".case1").show();
		}
	});

	 // 조직도 팝업
    $("#organization").click(function(){
    	window.open('/inbound/consult/organization.do?','custSpecial','width=815,height=635,resizable=no,toolbar=no,scrollbars=no');
    });
});
var wrkDvn2 = "";
var cstNo2 ="";
var contNo2 ="";
var csRnno2 ="";
var custNm2 = "";
var receUserId2 = "";
var telno2 = "";
var callSeq2 = "";
var callDtlSeq2 = "";
var vocRstlCode = "";
/* 상담내역 유효성 체크 */
function fn_validation(){
	 // 처리구분이 예약, 부재중일 때는 대,중,소 분류가 필수값이 아님.
	if($("#cnltProcCd").val() != "02" && $("#cnltProcCd").val() != "06"){
		if(KBIZVA.isNullOrEmpty($("#chnlCode").val())){
			alert("인입채널을 입력해 주세요.");
			return false;
		}
		if(KBIZVA.isNullOrEmpty($("#lcode").val())){
			alert("대분류를 입력해 주세요.");
			return false;
		}
		if(KBIZVA.isNullOrEmpty($("#mcode").val())){
			alert("중분류를 입력해 주세요.");
			return false;
		}
		if(KBIZVA.isNullOrEmpty($("#scode").val())){
			alert("소분류를 입력해 주세요.");
			return false;
		}
	}
	if(!KBIZVA.valCheck("custNm",true)){ return false; } // 고객명
	$("#tellNum").val(KBIZST.replaceTell($("#tellNum").val()));
	if(isNaN($("#tellNum").val())){
		alert("전화번호는 숫자와 -만 입력이 가능합니다.");
		return false;
	}
	if(!KBIZVA.valCheck("tellNum",true)){ return false; } // 전화번호
	if(!KBIZVA.valCheck("recvNote",true)){ return false; } // 문의
	if(!KBIZVA.valCheck("procNote",true)){ return false; } // 답변
	if(KBIZVA.isNullOrEmpty($("#cnltProcCd").val())){
		alert("처리구분을 입력해 주세요.");
		return false;
	}
	// 처리구분이 예약 일경우
	 if($("#cnltProcCd").val() == "02"){
		if(KBIZVA.isNullOrEmpty($("#dates").val())){
			alert("예약일시를 입력해 주세요.");
			return false;
		}
		if(KBIZVA.isNullOrEmpty($(".times").eq(1).val())){
			alert("예약(시간)을 입력해주세요");
			return false;
		}
		if(KBIZVA.isNullOrEmpty($(".times").eq(2).val())){
			alert("예약(분)을 입력해주세요");
			return false;
		}
		if(KBIZVA.isNullOrEmpty($("#rsrvTellNum").val())){
			alert("예약전화번호를 입력해 주세요.");
			return false;
		}
		$("#rsrvTellNum").val(KBIZST.replaceTell($("#rsrvTellNum").val()));
		if(isNaN($("#rsrvTellNum").val())){
			alert("예약전화번호는 숫자와 -만 입력이 가능합니다.");
			return false;
		}
		 if(!KBIZVA.valCheck("rsrvTellNum",true)){ return false; }
	}
	// 처리구분이 이관- 일경우
	if($("#cnltProcCd").val() == "03"){
		if(KBIZVA.isNullOrEmpty($("#tranId").val())){
			alert("이관자를 선택해 주세요.");
			return false;
		}
	}
	if($("#cnltProcCd").val() == "07"){
		if(KBIZVA.isNullOrEmpty($("#tranId2").val())){
			alert("이관자를 선택해 주세요.");
			return false;
		}
	}
	if($("#cnltProcCd").val() == "04"){
		if(KBIZVA.isNullOrEmpty($("#needsType").val())){
			alert("VOC 이관 데이터를 입력해주세요.");
			return false;
		}
	}
	return true;
};

function fn_CustCallback(ret){
	var r = ret.totList;
	inbound(r);
};

/* 상담고객정보, 상담시작시간, 콜시작시간 세팅(inbound가 들어왔을 때) */
function inbound(r){
	// 상담내용 입력 세팅
	if(r != null){
		$("#custNo").val(r.untyCsno);
		$("#untyCntrNo").val(r.untyCntrNo);
		$("#cntrNo").val(r.cntrNo);
		$("#custNm").val(r.csKrnNm);
		if(KBIZVA.isNullOrEmpty($("#tellNum").val())){
			$("#tellNum").val(r.tlno);
		}
		$("#juminTemp").val(r.csSrchNo);
	}
	$("#cnltDate").val($.parseJSON(KBIZDT.getFormattedServerDateTime()).dateTime);
	$("#callStartDate").val($.parseJSON(KBIZDT.getFormattedServerDateTime()).dateTime);
	fn_selLcode();
};

/* 인입채널 -> 대분류조회 */
function fn_selLcode(){
	$("#mcode").html("<option value=''>선택</option>");
	$("#scode").html("<option value=''>선택</option>");
	var chnlCode = $("#chnlCode").val();
	if(document.getElementById("in").checked == true){
		KBIZIO.requestParamAjax("/inbound/consult/selectLcode.json", fn_lcodeCallback, {params: {chnlCode: chnlCode, callGbCd: "i"}, async: false});
	}else if(document.getElementById("out").checked == true){
		KBIZIO.requestParamAjax("/inbound/consult/selectLcode.json", fn_lcodeCallback, {params: {chnlCode: chnlCode, callGbCd: "o"}, async: false});
	}else{
		KBIZIO.requestParamAjax("/inbound/consult/selectLcode.json", fn_lcodeCallback, {params: {chnlCode: chnlCode, callGbCd: "c"}, async: false});
	}
};
function fn_lcodeCallback(ret){
	var r = ret.lcode;
	var option = "<option value=''>선택</option>";
	var len = r.length;
	for(var l=0;l<len;l++){
		option += "<option value='"+r[l].lcode+"'>"+r[l].codeName+"</option>";
		if(len == 1){
			$("#lcode").html(option);
			$("#lcode").val(r[l].lcode);
			fn_selMcode();
			return;
		}
	}
	$("#lcode").html(option);
};

/* 대분류 -> 중분류조회 */
function fn_selMcode(){
	$("#scode").html("<option value=''>선택</option>");
	var chnlCode = $("#chnlCode").val();
	var lcode = $("#lcode").val();
	if(document.getElementById("in").checked == true){
		KBIZIO.requestParamAjax("/inbound/consult/selectMcode.json", fn_mcodeCallback, {params: {chnlCode: chnlCode, lcode: lcode, callGbCd: "i"}, async: false});
	}else if(document.getElementById("out").checked == true){
		KBIZIO.requestParamAjax("/inbound/consult/selectMcode.json", fn_mcodeCallback, {params: {chnlCode: chnlCode, lcode: lcode, callGbCd: "o"}, async: false});
	}else{
		KBIZIO.requestParamAjax("/inbound/consult/selectMcode.json", fn_mcodeCallback, {params: {chnlCode: chnlCode, lcode: lcode, callGbCd: "c"}, async: false});
	}
};
function fn_mcodeCallback(ret){
	var r = ret.mcode;
	var option = "<option value=''>선택</option>";
	var len = r.length;
	for(var m=0;m<len;m++){
		option += "<option value='"+r[m].mcode+"'>"+r[m].codeName+"</option>";
		if(len == 1){
			$("#mcode").html(option);
			$("#mcode").val(r[m].mcode);
			fn_selScode();
			return;
		}
	}
	$("#mcode").html(option);
};

/* 중분류 -> 소분류조회 */
function fn_selScode(){
	var chnlCode = $("#chnlCode").val();
	var lcode = $("#lcode").val();
	var mcode = $("#mcode").val();
	if(document.getElementById("in").checked == true){
		KBIZIO.requestParamAjax("/inbound/consult/selectScode.json", fn_scodeCallback, {params: {chnlCode: chnlCode, lcode: lcode, mcode: mcode, callGbCd: "i"}, async: false});
	}else if(document.getElementById("out").checked == true){
		KBIZIO.requestParamAjax("/inbound/consult/selectScode.json", fn_scodeCallback, {params: {chnlCode: chnlCode, lcode: lcode, mcode: mcode, callGbCd: "o"}, async: false});
	}else{
		KBIZIO.requestParamAjax("/inbound/consult/selectScode.json", fn_scodeCallback, {params: {chnlCode: chnlCode, lcode: lcode, mcode: mcode, callGbCd: "c"}, async: false});
	}
};
function fn_scodeCallback(ret){
	var r = ret.scode;
	var option = "<option value=''>선택</option>";
	var len = r.length;
	for(var s=0;s<len;s++){
		option += "<option value='"+r[s].scode+"'>"+r[s].codeName+"</option>";
		if(len == 1){
			$("#scode").html(option);
			$("#scode").val(r[s].scode);
			return;
		}
	}
	$("#scode").html(option);
};
// VOC 이관등록
function fn_vocReg(ret){
	var r = ret.cDetail;
	var wrkDvn = "";
	if(r.chnlCode == "A"){
		wrkDvn = "001";
		wrkDvn2 = "001";
	}else if(r.chnlCode == "B"){
		wrkDvn = "002";
		wrkDvn2 = "002";
	}else{
		wrkDvn = "000";
		wrkDvn2 = "000";
	}
	var cstNo="";
	var contNo="";
	var csRnno="";
	if(r.custNo != null && r.custNo.length > 0){
		cstNo = r.custNo;
		cstNo2 = r.custNo;
	}
	if(r.cntrNo != null && r.cntrNo.length > 0){
		contNo = r.cntrNo;
		contNo2 = r.cntrNo;
	}
	if(r.juminTemp != null && r.juminTemp.length > 0){
		csRnno = r.juminTemp;
		csRnno2 = r.juminTemp;
	}
	cstNm2 = r.custNm;
	receUserId2 = r.userId;
	telno2 = r.tellNum;
	callSeq2 = r.cnltSeq;
	callDtlSeq2 = r.cnltDetailNo;
	var protocol = location.protocol;
	KBIZIO.requestParamAjax(protocol+"//vocapi.kbiz.or.kr/api/call/vocReg", fn_vocCallback,{
		params: {
			cstNm: r.custNm,
			needsType: $("#needsType").val(),
			receUserId: r.userId,
			cstNo: cstNo,
			telno: r.tellNum,
			tit: $("#vocTitle").val(),
			qstnCntn: $("#vocContent").val(),
			contNo: contNo,
			callSeq: r.cnltSeq,
			callDtlSeq: r.cnltDetailNo,
			wrkDvn: wrkDvn,
			takeManOpi: $("#vocOpinion").val(),
			chrgUserId: $("#kbizId").val(),
			chrgDepCd: $("#deptCd").val(),
			csRnno: csRnno
		},
		isForcExeCbFn: true
	});
};

function fn_vocCallback(result){
	var r = result.ex_code;
	if(r != null && r == "SYSERRO"){
		console.log("VOC시스템 에러입니다.");
	}else{
		vocRstlCode = result.RESULT_CODE;
	}
	KBIZIO.requestParamAjax("/inbound/consult/vocReg.json", fn_vocCallback2, {params: {
		cstNm: cstNm2,
		needsType: $("#needsType").val(),
		receUserId: receUserId2,
		cstNo: cstNo2,
		telno: telno2,
		tit: $("#vocTitle").val(),
		qstnCntn: $("#vocContent").val(),
		contNo: contNo2,
		callSeq: callSeq2,
		callDtlSeq: callDtlSeq2,
		wrkDvn: wrkDvn2,
		takeManOpi: $("#vocOpinion").val(),
		chrgUserId: $("#kbizId").val(),
		chrgDepCd: $("#deptCd").val(),
		csRnno: csRnno2,
		vocRstlCode: vocRstlCode,
		regId: receUserId2
	}, isForcExeCbFn: true}); // AJAX 호출 오류 옵션
};
function fn_vocCallback2(ret){
	console.log(ret);
	var r = ret.resultCode;
	var r2 = ret.ex_code;
	if(r2 != null && r2 == "SYSERRO"){
		console.log("APP시스템 오류입니다.");
	}
	if(r == "00"){
		alert("[VOC이관 성공]VOC로 이관되었습니다.");
	}else if(r == "01"){
		alert("[VOC이관 실패]이미등록된 VOC입니다.");
	}else if(r == "99"){
		alert("[VOC이관 실패]VOC서버 오류입니다.");
	}else{
		alert("[VOC이관 실패]시스템오류입니다.");
	}
	$("#needsType").val("");
	$("#vocTitle").val("");
	$("#vocContent").val("");
	$("#vocOpinion").val("");
	$("#kbizId").val("mrcmh");
	$("#deptCd").val("000514");
	$("#kbizNm").val("추민호");
	wrkDvn2 = "";
	cstNo2 ="";
	contNo2 ="";
	csRnno2 ="";
	custNm2 = "";
	receUserId2 = "";
	telno2 = "";
	callSeq2 = "";
	callDtlSeq2 = "";
};

</script>
</head>
<body>
<form id="consultInsert" action="/inbound/consult/consultDetailInsert.do" method="post">
<input type="hidden" id="cnltDate" name="cnltDate" value=""/>
<input type="hidden" id="callStartDate" name="callStartDate" value=""/>
<input type="hidden" id="callEndDate" name="callEndDate" value=""/>
<input type="hidden" id="userId" name="userId" value="${LoginUserId}"/>
<input type="hidden" id="custNo" class="init"  name="custNo" value=""/>
<input type="hidden" id="untyCntrNo" name="untyCntrNo"  value="" class="init"/>
<input type="hidden" id="regId" name="regId" value="${LoginUserId}"/>
<input type="hidden" id="modId" name="modId" value="${LoginUserId}"/>
<input type="hidden" id="rsrvDate" class="init"  name="rsrvDate" value=""/>
<input type="hidden" id="cnltSeq" class="init"  name="cnltSeq" value=""/>
<input type="hidden" id="cnltDetailNo" class="init"  name="cnltDetailNo" value=""/>
<input type="hidden" id="recUrl" class="init" name="recUrl" value=""/>
<input type="hidden" id="startCon" value="${startCon}" disabled="disabled"/>
<input type="hidden" id="callbackSeq" class="init"  name="callbackSeq" value=""/>
<input type="hidden" id="needsType" name="needsType" value="" />
<input type="hidden" id="vocTitle" name="vocTitle" value="" />
<input type="hidden" id="vocContent" name="vocContent" value="" />
<input type="hidden" id="vocOpinion" name="vocOpinion" value="" />
<input type="hidden" id="juminTemp" name="juminTemp" value="" />
<input type="hidden" id="ioType" name="ioType" value="" />

<div class="section pdt03">
<h3>
	<span class="sec_tit">상담상세</span>
	<span class="mgl20">
		In<input type="radio" name="callGbCd" value="i" id="in" class="mgr05" onclick="fn_selLcode()" checked="checked">
		Out<input type="radio" name="callGbCd" value="o" id="out" class="mgr05" onclick="fn_selLcode()">
		Callback<input type="radio" name="callGbCd" value="c" id="callback" class="mgr05" onclick="fn_selLcode()" >
	</span>
	<span style="float:right;">
	<a href="#" class="btn small g_blue fs12 case5 case" id="transferEnd" title="호전환종결">호전환종결</a>
	<a href="#" class="btn small g_blue fs12 mgl03" id="conSave" title="저장">저장</a>
	<a href="#" class="btn small g_blue fs12 mgl03" id="init" title="초기화">초기화</a>
	</span>
</h3>
<table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch">
	<colgroup>
		<col style="width:10%">
		<col style="width:15%">
		<col style="width:10%">
		<col style="width:15%">
		<col style="width:10%">
		<col style="width:15%">
		<col style="width:10%">
		<col style="width:15%">
	</colgroup>
	<tr>
		<th><label for="chnlCode">인입채널</label></th>
		<td class="ac">
			<select id="chnlCode" name="chnlCode" class="init2 min_width110" onchange="fn_selLcode()">
				<option value="">선택</option>
				<c:forEach items="${chCode}" var="ch">
					<c:if test="${ch.lcode eq '00'}">
						<c:if test="${chnlCode eq ch.chnlCode}">
							<option value="${ch.chnlCode}" selected="selected">${ch.codeName}</option>
						</c:if>
						<c:if test="${chnlCode ne ch.chnlCode}">
							<option value="${ch.chnlCode}">${ch.codeName}</option>
						</c:if>
					</c:if>
				</c:forEach>
			</select>
		</td>
		<th><label for="lcode">대분류</label></th>
		<td>
			<select class="init min_width110" id="lcode" name="lcode" onchange="fn_selMcode()">
				<option value="">선택</option>
			</select>
		</td>
		<th><label for="mcode">중분류</label></th>
		<td>
			<select class="init min_width110" id="mcode" name="mcode" onchange="fn_selScode()">
				<option value="">선택</option>
			</select>
		</td>
		<th><label for="scode min_width110">소분류</label></th>
		<td>
			<select class="init min_width110" id="scode" name="scode">
				<option value="">선택</option>
			</select>
		</td>
	</tr>
	<tr>
		<th><label for="cntrNo">계약번호</label></th>
		<td>
		<input type="text" id="cntrNo" name="cntrNo" class="init2" value="" maxlength="20" readonly="readonly" title="계약번호"/>
		</td>
		<th><label for="custNm">고객명</label></th>
		<td><input type="text" name="custNm" id="custNm" value="" class="init" maxlength="100" title="고객명"/></td>
		<th><label for="tellNum">연락처</label></th>
		<td><input type="text" name="tellNum" id="tellNum" value="" class="init" maxlength="12" title="연락처"/></td>
		<th><label for="userNm">상담사명</label></th>
		<td><input type="text" name="userNm" id="userNm" value="${LoginUserNm}" maxlength="10" readonly="readonly" title="상담사명"/></td>
	</tr>
	<tr>
		<th><label for="recvNote">문의</label></th>
		<td colspan="7">
			<textarea rows="2" cols="100%" name="recvNote" id="recvNote" class="init" maxlength="3000" title="문의"></textarea>
		</td>
	</tr>
	<tr>
		<th><label for="procNote">답변</label></th>
		<td colspan="7">
			<textarea rows="2" cols="100%" name="procNote" id="procNote" class="init" maxlength="3000" title="답변"></textarea>
		</td>
	</tr>
	<tr>
		<th>특이성향</th><td colspan="7"><input type="text" name="spclCont" id="spclCont" class="init" maxlength="50"/></td>
	</tr>
	<tr>
		<th><label for="cnltProcCd">처리구분</label></th>
		<td>
			<select name="cnltProcCd" id="cnltProcCd">
				<c:forEach items="${code}" var="c">
					<c:if test="${c.lcode == '001'}">
						<c:if test="${c.mcode != '00'}">
							<c:if test="${c.mcode != '04'}">
								<option value="${c.mcode}">${c.codeName}</option>
							</c:if>
							<c:if test="${c.mcode == '04'}">
								<c:if test="${LoginCallApGrade != '03'}">
									<option value="${c.mcode}">${c.codeName}</option>
								</c:if>
							</c:if>
						</c:if>
					</c:if>
				</c:forEach>
			</select>
		</td>
		<th colspan="6" class="case1 case"></th>
		<th class="case2 case"><label for="dates">예약일시</label></th>
		<td class="case2 case">
		<input type="text" class="times mgb02" id="dates" style="height:28px;width:100%;" disabled="disabled" placeholder="날짜 선택" title="예약일시"/>
		</td>
		<td class="case2 case" colspan="2">
		<select style="width:48% !important" disabled="disabled" class="times init">
			<option value="">시간</option>
			<c:forEach begin="9" end="18" step="1" var="h">
				<option value="${h}">${h}시</option>
			</c:forEach>
			</select>
			<select style="width:48% !important" disabled="disabled" class="times init">
				<option value="">분</option>
				<c:forEach begin="0" end="55" step="5" var="m">
					<option value="${m}">${m}분</option>
				</c:forEach>
			</select>
		</td>
		<th class="case2 case"><label for="rsrvTellNum">예약전화번호</label></th>
		<td class="case2 case"><input type="text" id="rsrvTellNum" class="init" name="rsrvTellNum" maxlength="12" placeholder="ex) 01011112222" disabled="disabled" title="예약전화번호"/></td>

		<th class="case3 case"><label for="tranUser">이관자</label></th>
		<td class="case3 case">
			<select class="init" id="tranId" name="tranId" disabled="disabled">
				<option value="">선택</option>
				<c:forEach items="${adminList}" var="a">
					<option value="${a.userId}">${a.userNm}|${a.userId}|${a.callTelNum}</option>
				</c:forEach>
			</select>
		</td>
		<th class="case3 case al" colspan="4"></th>
		<th class="case4 case">이관자</th>
		<td class="case4 case">
		<input type="text" id="kbizNm" name="kbizNm" value="추민호"/>
		<input type="hidden" id="kbizId" name="tranId" value="mrcmh" disabled="disabled"/>
		<input type="hidden" id="deptCd" name="deptCd" value="000514"/></td>
		<th class="case4 case al" colspan="4"><a href="#" class="btn small g_blue mgl05" id="organization" title="조직도">조직도</a></th>
		<th class="case5 case">내선번호</th>
		<td class="case5 case" colspan="2">
			<select id="userTell" class="init" name="userTell" title="내선번호" style="overflow: auto;">
				<option value="">선택</option>
				<c:forEach items="${userList}" var="u">
					<option value="${u.callTelNum}|${u.userId}">${u.userNm}|${u.userId}|${u.callTelNum}</option>
				</c:forEach>
			</select>
		</td>
		<td class="case5 case"><input type="text" id="kbizTell" value="" placeholder="중앙회내선/외부"/></td>
		<th class="case5 case al" colspan="2">
			<a href="#" class="btn small g_blue mgl05" id="CallWait" title="호전환">호전환</a>
			<a href="#" class="btn small g_blue" id="ReCall" title="회수">회수</a>
		</th>
		<th class="case6 case"><label for="tranUser">이관자</label></th>
		<td class="case6 case">
			<select class="init" id="tranId2" name="tranId" disabled="disabled">
				<option value="">선택</option>
				<c:forEach items="${userList}" var="u2">
						<option value="${u2.userId}">${u2.userNm}|${u2.userId}</option>
				</c:forEach>
			</select>
		</td>
		<th class="case6 case al" colspan="4"></th>
	</tr>
</table>
</div>
</form>
</body>
</html>