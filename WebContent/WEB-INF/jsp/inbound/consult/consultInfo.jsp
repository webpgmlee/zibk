<%--
 * file name    : consultInfo.jsp
 * description  : 상담이력, CallBack, 예약전화, 이관내역
 * author       : H.K.Lee
 * initial date : 2017.11.01
 * history
  수정일자      수정자 수정내용
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld" %>
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
<title>상담이력 </title>
<script type="text/javascript">
$(function(){
	// 상담이력 검색 달력
	KBIZDT.setDatepicker("startDate2");
	KBIZDT.setDatepicker("endDate2");
    KBIZDT.datepicker();

    var now = new Date();
    var year= now.getFullYear();
    var mon = now.getMonth()+1;
    var day = now.getDate();

    $("#startDate2").val(KBIZDT.addFormattedDate(year+''+mon+''+day,'d',(1-day)));
    $("#endDate2").val(KBIZDT.addFormattedDate(year+''+mon+''+day,'m',0));

    fn_searchConsult2();
	fn_searchConsult();

	// 탭 이동 스크립트
	$(".tab_content").hide();
    $(".tab_content:first").show();

    $("ul.tabs li").click(function () {
       $("ul.tabs li").removeClass("active");
       $(this).addClass("active");
       $(".tab_content").hide();
       var activeTab = $(this).attr("rel");
       $("#" + activeTab).fadeIn(0);
    });

   // 상담이력 조회버튼클릭
	$("#consultInfoSearch").click(function(){
		fn_searchConsult();
	});

	$("#consultInfoSearch2").click(function(){
		fn_searchConsult2();
	});

	$("#callbackSearch").click(function(){
		fn_callbackList();
	});
});

/* View처리 */
function fn_searchConsult(){
	$("#pageIdx1").val(1);
	$(".tabs li").removeClass("active");
	$(".tabs li").eq(0).addClass("active");
	$(".tab_content").hide();
	var activeTab = $(".tabs li").eq(0).attr("rel");
	$("#" + activeTab).fadeIn(0);
	KBIZIO.requestViewAjax("consultSearchForm", "consultInfoView", "");
};
function fn_searchConsultPage(){
	KBIZIO.requestViewAjax("consultSearchForm", "consultInfoView", "");
}
function fn_searchConsultKey(){
	if(event.keyCode == "13"){
		$("#pageIdx1").val(1);
		fn_searchConsultPage();
	}
};
function fn_searchConsult2(){
	//날짜검사
    if($("#startDate2").val() == ""){
        alert("날짜를 입력해주세요.");
        $("#startDate2").focus();
        return;
    }else if($("#endDate2").val() == ""){
        alert("날짜를 입력해주세요.");
        $("#endDate2").focus();
        return;
    }
  /*  if($("#startDate2").val().length == 10){           //날짜가 정확하게 입력되었는지 검사
        if($("#endDate2").val().length == 10){
            //skip
        }else{
            alert("검색할 날짜를 제대로 설정해주세요.\nex) 2018-01-01");
            $("#endDate2").focus();
            return;
        }
    }else{
        alert("검색할 날짜를 제대로 설정해주세요.\nex) 2018-01-01");
        $("#startDate2").focus();
        return;
    }
   if(KBIZDT.getDayInterval($("#startDate2").val(),$("#endDate2").val()) < 0){
   	   alert("조회날짜가 잘못되었습니다.");
       return false;
   } */
   //조회기간 3개월로 기간 제한
   if(KBIZDT.getDayCheck($("#startDate2").val(),$("#endDate2").val()) > 93){
       alert('조회기간은 3개월 이내만 가능합니다.');
       return false;
   }
	$("#pageIdx2").val(1);
	$(".tabs li").removeClass("active");
	$(".tabs li").eq(1).addClass("active");
	$(".tab_content").hide();
	var activeTab = $(".tabs li").eq(1).attr("rel");
	$("#" + activeTab).fadeIn(1);
	KBIZIO.requestViewAjax("consultSearchForm2", "consultInfoView2", "");
};
function fn_searchConsultPage2(){
	//날짜검사
    if($("#startDate2").val() == ""){
        alert("날짜를 입력해주세요.");
        $("#startDate2").focus();
        return;
    }else if($("#endDate2").val() == ""){
        alert("날짜를 입력해주세요.");
        $("#endDate2").focus();
        return;
    }
 /*   if($("#startDate2").val().length == 10){           //날짜가 정확하게 입력되었는지 검사
        if($("#endDate2").val().length == 10){
            //skip
        }else{
            alert("검색할 날짜를 제대로 설정해주세요.\nex) 2018-01-01");
            $("#endDate2").focus();
            return;
        }
    }else{
        alert("검색할 날짜를 제대로 설정해주세요.\nex) 2018-01-01");
        $("#startDate2").focus();
        return;
    }
   if(KBIZDT.getDayInterval($("#startDate2").val(),$("#endDate2").val()) < 0){
   	alert("조회날짜가 잘못되었습니다.");
       return false;
   } */
   //조회기간 3개월로 기간 제한
   if(KBIZDT.getDayCheck($("#startDate2").val(),$("#endDate2").val()) > 93){
       alert('조회기간은 3개월 이내만 가능합니다. ');
       return false;
   }
	KBIZIO.requestViewAjax("consultSearchForm2", "consultInfoView2", "");
}
function fn_searchConsult2Key(){
	if(event.keyCode == "13"){
		$("#pageIdx2").val(1);
		fn_searchConsultPage2();
	}
};
function fn_callbackList(){
	$("#pageIdx3").val(1);
	KBIZIO.requestViewAjax("callbackListForm","callbackView", "");
};
function fn_callbackListPage(){
	KBIZIO.requestViewAjax("callbackListForm","callbackView", "");
};
function fn_callbackKey(){
	if(event.keyCode == "13"){
		fn_callbackList();
	}
}
function fn_reserveList(){
	$("#pageIdx4").val(1);
	KBIZIO.requestViewAjax("reserveListForm","reserveView", "");
};
function fn_reserveListPage(){
	KBIZIO.requestViewAjax("reserveListForm","reserveView", "");
}
function fn_transferList(){
	$("#pageIdx5").val(1);
	KBIZIO.requestViewAjax("transferListForm","transferView", "");
};
function fn_transferListPage(){
	KBIZIO.requestViewAjax("transferListForm","transferView", "");
};
/* View처리 */

// 상담이력 상세 팝업
function fn_con_detail(cnltSeq,cnltDetailNo){
	KBIZUI.highlightTrByEvent(window.event);
	window.open('/inbound/consult/consultInfoDetail.do?cnltDetailNo='+cnltDetailNo+'&cnltSeq='+cnltSeq+"&tranId=",cnltSeq+'-'+cnltDetailNo,'width=800,height=500,resizable=no,scrollbars=no,toolbar=no');
};

/* 이관내역 상세 조회 and Outbound */
function fn_tran_detail(cnltSeq,cnltDetailNo,cnltProcCd,tellNum){
	KBIZUI.highlightTrByEvent(window.event);
	if("03,04,07".indexOf(cnltProcCd) != -1){
		var con = confirm("이관 상담정보를 조회하고 전화를 거시겠습니까?");
		if(con){
			if($("#ctiYn", parent.parent.topFrame.document).val() != "Y" || $("#ctiLoginYn", parent.parent.topFrame.document).val() != "Y"){
				alert("CTI로그인을 해주세요.");
				return false;
			}else{
				if(parent.parent.topFrame.SCall.CtiAgentStateEx() != "B"){
					parent.conFrame.document.getElementById("out").checked=true;
					parent.conFrame.fn_selLcode();
					$("#ioType", parent.parent.topFrame.document).val("O");
					$("#tellNum",parent.parent.topFrame.document).val(tellNum); // 전화번호 세팅
					$("#cnltSeq",parent.conFrame.document).val(cnltSeq);
					$("#cnltDetailNo",parent.conFrame.document).val(cnltDetailNo);
					$("#recUrl",parent.parent.topFrame.document).val("");
					$("#callbackSeq", parent.conFrame.document).val("");
					KBIZIO.requestParamAjax("/inbound/consult/consultTranDetail.json", fn_rsrv_detailBack, {params: {cnltSeq: cnltSeq, cnltDetailNo: cnltDetailNo}});
					KBIZIO.requestParamAjax("/inbound/consult/consultTranDetail2.json", fn_rsrv_detailBack2, {params: {cnltSeq: cnltSeq, cnltDetailNo: cnltDetailNo}});
					parent.parent.topFrame.manualCall();
				}else{
					alert("지금은 통화중입니다.");
				}
			}
		}else{
			if(parent.parent.topFrame.SCall.CtiAgentStateEx() != "B"){
				parent.conFrame.document.getElementById("out").checked=true;
				parent.conFrame.fn_selLcode();
				$("#ioType", parent.parent.topFrame.document).val("O");
				$("#tellNum",parent.parent.topFrame.document).val(tellNum); // 전화번호 세팅
				$("#cnltSeq",parent.conFrame.document).val(cnltSeq);
				$("#cnltDetailNo",parent.conFrame.document).val(cnltDetailNo);
				$("#recUrl",parent.parent.topFrame.document).val("");
				$("#callbackSeq", parent.conFrame.document).val("");
				KBIZIO.requestParamAjax("/inbound/consult/consultTranDetail.json", fn_rsrv_detailBack, {params: {cnltSeq: cnltSeq, cnltDetailNo: cnltDetailNo}});
				KBIZIO.requestParamAjax("/inbound/consult/consultTranDetail2.json", fn_rsrv_detailBack2, {params: {cnltSeq: cnltSeq, cnltDetailNo: cnltDetailNo}});
			}
			if(cnltProcCd == "04"){
				window.open('/inbound/consult/consultInfoDetail.do?cnltDetailNo='+cnltDetailNo+'&cnltSeq='+cnltSeq+"&tranId=tranId",cnltSeq+'-'+cnltDetailNo,'width=800,height=500,resizable=no,scrollbars=no,toolbar=no');
			}else{
				window.open('/inbound/consult/consultInfoDetail.do?cnltDetailNo='+cnltDetailNo+'&cnltSeq='+cnltSeq+"&tranId=",cnltSeq+'-'+cnltDetailNo,'width=800,height=500,resizable=no,scrollbars=no,toolbar=no');
			}
		}
	}
};

 /* 예약전화 상세 조회 and Outbound */
function fn_rsrv_detail(cnltSeq, cnltDetailNo, tellNum) {
	KBIZUI.highlightTrByEvent(window.event);
	var con = confirm("예약 상담정보를 조회하고 전화를 거시겠습니까?");
	if(con){
		if($("#ctiYn", parent.parent.topFrame.document).val() != "Y" || $("#ctiLoginYn", parent.parent.topFrame.document).val() != "Y"){
			alert("CTI로그인을 해주세요.");
			return false;
		}else{
			if(parent.parent.topFrame.SCall.CtiAgentStateEx() != "B"){
				parent.conFrame.document.getElementById("out").checked=true;
				parent.conFrame.fn_selLcode();
				$("#ioType", parent.parent.topFrame.document).val("O");
				$("#tellNum",parent.parent.topFrame.document).val(tellNum); // 전화번호 세팅
				$("#cnltSeq",parent.conFrame.document).val(cnltSeq);
				$("#cnltDetailNo",parent.conFrame.document).val(cnltDetailNo);
				$("#recUrl",parent.parent.topFrame.document).val("");
				$("#callbackSeq", parent.conFrame.document).val("");
				$("#callTellNum").val("");
				KBIZIO.requestParamAjax("/inbound/consult/consultRsrvDetail.json", fn_rsrv_detailBack, {params: {cnltSeq: cnltSeq, cnltDetailNo: cnltDetailNo}});
				KBIZIO.requestParamAjax("/inbound/consult/consultRsrvDetail2.json", fn_rsrv_detailBack2, {params: {cnltSeq: cnltSeq, cnltDetailNo: cnltDetailNo}});
				parent.parent.topFrame.manualCall();
			}else{
				alert("지금은 통화중입니다.");
			}
		}
	}else{
		if(parent.parent.topFrame.SCall.CtiAgentStateEx() != "B"){
			parent.conFrame.document.getElementById("out").checked=true;
			parent.conFrame.fn_selLcode();
			$("#ioType", parent.parent.topFrame.document).val("O");
			$("#tellNum",parent.parent.topFrame.document).val(tellNum); // 전화번호 세팅
			$("#cnltSeq",parent.conFrame.document).val(cnltSeq);
			$("#cnltDetailNo",parent.conFrame.document).val(cnltDetailNo);
			$("#recUrl",parent.parent.topFrame.document).val("");
			$("#callbackSeq", parent.conFrame.document).val("");
			$("#callTellNum").val("");
			KBIZIO.requestParamAjax("/inbound/consult/consultRsrvDetail.json", fn_rsrv_detailBack, {params: {cnltSeq: cnltSeq, cnltDetailNo: cnltDetailNo}});
			KBIZIO.requestParamAjax("/inbound/consult/consultRsrvDetail2.json", fn_rsrv_detailBack2, {params: {cnltSeq: cnltSeq, cnltDetailNo: cnltDetailNo}});
		}
		window.open('/inbound/consult/consultInfoDetail.do?cnltDetailNo='+cnltDetailNo+'&cnltSeq='+cnltSeq+"&tranId=",cnltSeq+'-'+cnltDetailNo,'width=800,height=500,resizable=no,scrollbars=no,toolbar=no');
	}
 };

/* 예약전화/이관내역 상세 조회 콜백세팅 */
function fn_rsrv_detailBack(ret) {
	var r = ret.rsrvd;
	if(r.ioType == "I"){
		parent.conFrame.document.getElementById("in").checked=true;
	}else if(r.ioType == "O"){
		parent.conFrame.document.getElementById("out").checked=true;
	}else{
		parent.conFrame.document.getElementById("callback").checked=true;
	}
	$("#chnlCode", parent.conFrame.document).val(r.chnlCode);
	parent.conFrame.fn_selLcode();
	$("#lcode", parent.conFrame.document).val(r.lcode);
	parent.conFrame.fn_selMcode();
	$("#mcode", parent.conFrame.document).val(r.mcode);
	parent.conFrame.fn_selScode();
	$("#scode", parent.conFrame.document).val(r.scode);
	$("#cntrNo", parent.conFrame.document).val(r.cntrNo);
	$("#custNm", parent.conFrame.document).val(r.custNm);
	$("#tellNum", parent.conFrame.document).val(r.tellNum);
	$("#recvNote", parent.conFrame.document).text(r.recvNote);
	$("#procNote", parent.conFrame.document).text(r.procNote);
	$("#untyCntrNo", parent.conFrame.document).val(r.untyCntrNo);
};

/* 예약전화 상세 조회 콜백세팅 */
function fn_rsrv_detailBack2(ret) {
	var r = ret.rsrvd;
	$("#custSpecial", parent.custFrame.document).hide();
	parent.custFrame.inbound(r);
};

/* CallBack 상세 조회 and Outbound */
function fn_callback_detail(seq, tellNum, chnlCode) {
	if($("#ctiYn", parent.parent.topFrame.document).val() != "Y" || $("#ctiLoginYn", parent.parent.topFrame.document).val() != "Y"){
		alert("CTI로그인을 해주세요.");
		return false;
	}else{
		if(parent.parent.topFrame.SCall.CtiAgentStateEx() != "B"){
			$("#chnlCode").val(chnlCode);
			$("#callSeq").val(seq);
			$("#tellNum").val(tellNum);
			KBIZUI.highlightTrByEvent(window.event);
			//KBIZIO.requestParamAjax("/inbound/customer/custInbound.json", fn_Callback, {params: {tlno: tellNum}});
			KBIZIO.requestParamAjax("/inbound/customer/callbackYn.json", fn_Callback_yn, {params: {callbackSeq: $("#callSeq").val()}});
		}else{
			alert("지금은 통화중입니다.");
		}
	}
};

/* 선점여부 확인  -> 선점N이면 고객조회*/
function fn_Callback_yn(ret){
	var r = ret.callYn;
	if(r == "N"){
		KBIZIO.requestParamAjax("/inbound/consult/callbackProc.json","", {params: {callbackSeq: $("#callSeq").val()}}); // 선점 = Y
		KBIZIO.requestParamAjax("/inbound/customer/custInbound.json", fn_Callback, {params: {tlno: $("#tellNum").val()}});
	}else{
		KBIZIO.requestParamAjax("/inbound/customer/callbackModYn.json", fn_modYn, {params: {callbackSeq: $("#callSeq").val()}}); // 이미선점됨
	}
};

/* 선점된 ID와 로그인 아이디 일치여부 판단 */
function fn_modYn(ret){
	var r = ret.modYn;
	if(r == "Y"){
		KBIZIO.requestParamAjax("/inbound/customer/custInbound.json", fn_Callback, {params: {tlno: $("#tellNum").val()}});
	}else{
		alert("이미 선점되었습니다.");
	}
};

function fn_Callback(ret){
	var r = ret.totList;
	var len = r.length;
	var chnlCode = $("#chnlCode").val();
	var tellNum = $("#tellNum").val();
	var seq = $("#callSeq").val();
	parent.conFrame.fn_selLcode();
	$(".init", parent.conFrame.document).val("");
	$(".init2", parent.conFrame.document).val("");
	$(".init", parent.custFrame.document).val("");
	$("#tellNum", parent.parent.topFrame.document).val(tellNum);
	$("#callTellNum").val(tellNum);
	$("#recUrl", parent.parent.topFrame.document).val("");
	$("#callbackSeq", parent.conFrame.document).val(seq);
	$("#cnltSeq", parent.conFrame.document).val("");
	$("#cnltDetailNo", parent.conFrame.document).val("");
	parent.conFrame.document.getElementById("callback").checked=true;
	if(len>1){
		parent.parent.topFrame.consult_popUp();
		$("#chnlCode", parent.conFrame.document).val(chnlCode);
	}else if(len==1){
		parent.conFrame.inbound(r[0]);
		parent.custFrame.inbound(r[0]);
		$("#chnlCode", parent.conFrame.document).val(chnlCode);
	}else{
		$("#custNm1", parent.custFrame.document).val("미확인");
		$("#custNm2", parent.custFrame.document).val("미확인");
		$("#custNm", parent.conFrame.document).val("미확인");
		$("#tellNum", parent.conFrame.document).val(tellNum);
		$("#chnlCode", parent.conFrame.document).val(chnlCode);
	}
	parent.conFrame.fn_selLcode();
	fn_searchConsult2();
};
</script>
</head>
<body>
<input type="hidden" id="chnlCode" value=""/>
<input type="hidden" id="callSeq" value=""/>
<input type="hidden" id="tellNum" value=""/>
<div class="brd_top clfix">
	<!--탭//-->
	<div class="com_tab db">
		<ul class="tabs color03" style="min-width:745px !important">
			<li class="active" rel="tab1" onclick="fn_searchConsult()"><a href="#">나의상담이력</a></li>
			<li rel="tab2" onclick="fn_searchConsult2()"><a href="#">고객상담이력</a></li>
			<li rel="tab3" onclick="fn_callbackList()"><a href="#">CallBack</a></li>
			<li rel="tab4" onclick="fn_reserveList()"><a href="#">예약전화</a></li>
			<li rel="tab5" onclick="fn_transferList()"><a href="#">이관내역</a></li>
		</ul>
	</div>
	<!--//탭-->
</div>
<div class="tab_container">
	<div id="tab1" class="tab_content">
		<form id="consultSearchForm" action="/inbound/consult/view/consultInfo.view" method="post" onsubmit="return false;">
        <input type="hidden" id="pageIdx1" name="pageIdx" value="1" />
		<input type="hidden" id="rowsPerPage1" name="rowsPerPage" value="5" />
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch mgb10">
            <colgroup>
	            <col style="width:80px"/>
	            <col style="width:120px"/>
	            <col style="width:80px"/>
	            <col style="width:80px"/>
	            <col style="width:56px"/>
            </colgroup>
            <thead>
            <tr>
                <th class="min_width100">고객명</th>
                <td><input type="text" name="custNm" id="custNm" value="" class="min_width270" onkeypress="fn_searchConsultKey()"/></td>
                <th  class="min_width115">처리구분</th>
                <td>
                	<select name="cnltProcCd" id="cnltProcCd" class="min_width190" onkeypress="fn_searchConsultKey()">
                		<option value="">선택</option>
						<c:forEach items="${code}" var="c">
							<c:if test="${c.lcode == '001'}">
								<c:if test="${c.mcode != '00'}">
									<option value="${c.mcode}">${c.codeName}</option>
								</c:if>
							</c:if>
						</c:forEach>
					</select>
                </td>
                <td class="ar"><a href="#" class="btn small g_orange min_width55" id="consultInfoSearch">조회</a></td>
            </tr>
           </thead>
        </table>
		</form>
        <div id="consultInfoView">
        </div>
    </div>

	<div id="tab2" class="tab_content">
		<form id="consultSearchForm2" action="/inbound/consult/view/consultInfo2.view" method="post" onsubmit="return false;">
        <input type="hidden" id="pageIdx2" name="pageIdx" value="1" />
		<input type="hidden" id="rowsPerPage2" name="rowsPerPage" value="5" />
		<input type="hidden" id="untyCsno" name="untyCsno" value="" />
		<input type="hidden" id="untyCntrNo" name="untyCntrNo" value="" />
		<input type="hidden" id="callTellNum" name="tellNum" value=""/>
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch mgb10">
            <colgroup>
				<col width="65px"/>
	            <col width="80px"/>
	            <col width="25px"/>
	            <col width="80px"/>
	            <col width="55px"/>
	            <col width="90px"/>
	            <col width="55px"/>
	            <col width="65px"/>
	            <col width="65px"/>
	            <col width="75px"/>
	            <col width="55px"/>
            </colgroup>
            <thead>
            <tr>
            	<th class="min_width55">상담일시</th>
            	<td class="ellips min_width80"><input type="text" name="startDate" id="startDate2" onkeypress="fn_searchConsult2Key()"/></td>
            	<th>~</th>
            	<td class="ellips min_width80"><input type="text" name="endDate" id="endDate2" onkeypress="fn_searchConsult2Key()"/></td>
                <th class="min_width55">상담사</th>
                <td class="ellips min_width80"><input type="text" name="userNm" id="userNm2" value=""  onkeypress="fn_searchConsult2Key()"/></td>
                <th class="min_width55">고객명</th>
                <td class="ellips min_width100"><input type="text" name="custNm" id="custNm2" value=""  onkeypress="fn_searchConsult2Key()"/></td>
                <th class="min_width65">처리구분</th>
                <td class="ellips min_width100">
                	<select name="cnltProcCd" id="cnltProcCd2" onkeypress="fn_searchConsult2Key()">
                		<option value="">선택</option>
						<c:forEach items="${code}" var="c">
							<c:if test="${c.lcode == '001'}">
								<c:if test="${c.mcode != '00'}">
									<option value="${c.mcode}">${c.codeName}</option>
								</c:if>
							</c:if>
						</c:forEach>
					</select>
                </td>
                <td class="ar min_width60"><a href="#" class="btn small g_orange min_width55" id="consultInfoSearch2">조회</a></td>
            </tr>
           </thead>
        </table>
		</form>
        <div id="consultInfoView2">
        </div>
    </div>

    <div id="tab3" class="tab_content">
	<form id="callbackListForm" action="/inbound/consult/view/callbackList.view" onsubmit="return false;">
	 	<input type="hidden" id="pageIdx3" name="pageIdx" value="1" />
		<input type="hidden" id="rowsPerPage3" name="rowsPerPage" value="5" />
	 <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch mgb10">
            <colgroup>
				<col width="200px"/>
				<col width="200px"/>
				<col width="200px"/>
	            <col width="60px"/>
            </colgroup>
            <thead>
            <tr>
            	<td>
					<select id="allOrMy" name="allOrMy" onchange="fn_callbackList()">
						<option value="all">전체콜백</option>
						<option value="my">나의콜백</option>
					</select>
				</td>
            	<th>인입채널</th>
            	<td class="ellips">
					<select id="chnlCode" name="chnlCode" onkeypress="fn_callbackKey()" onchange="fn_callbackList()">
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
				<td class="ar min_width60"><a href="#" class="btn small g_orange min_width55" id="callbackSearch">조회</a></td>
            </tr>
           </thead>
        </table>
        </form>
		<div id="callbackView">
		</div>
    </div>

    <div id="tab4" class="tab_content">
    	<form id="reserveListForm" action="/inbound/consult/view/reserveList.view" onsubmit="return false;">
	 		<input type="hidden" id="pageIdx4" name="pageIdx" value="1" />
			<input type="hidden" id="rowsPerPage4" name="rowsPerPage" value="5" />
		</form>
		<div id="reserveView">
		</div>
    </div>

    <div id="tab5" class="tab_content">
		<form id="transferListForm" action="/inbound/consult/view/transferList.view" onsubmit="return false;">
	 		<input type="hidden" id="pageIdx5" name="pageIdx" value="1" />
			<input type="hidden" id="rowsPerPage" name="rowsPerPage" value="5" />
		</form>
		<div id="transferView">
		</div>
    </div>
</div>
</body>
</html>