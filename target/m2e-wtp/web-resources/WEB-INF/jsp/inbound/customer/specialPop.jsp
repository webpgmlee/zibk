<%--
 * file name : specialPop.jsp
 * description : 특이성향
 * author : H.K.Lee
 * initial date : 2017.11.01
 * history
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<meta name="subject" content="KBIZ">
<meta name="author" content="KBIZ">
<meta name="keywords" content="KBIZ">
<meta name="description" content="KBIZ">
<jsp:include page="/WEB-INF/jsp/comm_top.jsp"/>
<title>특이성향</title>
<script type="text/javascript">
$(function(){
	fn_specialList();
});
function fn_specialList(){
	KBIZIO.requestViewAjax("specialListForm", "spclView", "");
}
function fn_selSpecial(cnltSeq, cnltDetailNo, spclIndex){
	$(".init").text("");
	$(".init2").val("");
	$("#specialCont").val($(".spclCont").eq(spclIndex).text());
	KBIZIO.requestParamAjax("/inbound/consult/consultInfoDetail2.json", fn_DetailCallback, {params: {cnltSeq: cnltSeq, cnltDetailNo: cnltDetailNo}});
};
function fn_DetailCallback(ret){
	var r = ret.cDetail;
	if(!KBIZVA.isNullOrEmpty(r.lcode)){
		$("#chnlCode").text(r.lcode);
	}
	if(!KBIZVA.isNullOrEmpty(r.lcode)){
		$("#lcode").text(r.lcode);
	}
	if(!KBIZVA.isNullOrEmpty(r.scode)){
		$("#scode").text(r.scode);
	}
	if(!KBIZVA.isNullOrEmpty(r.mcode)){
		$("#mcode").text(r.mcode);
	}
	if(!KBIZVA.isNullOrEmpty(r.custNm)){
		$("#custNm").text(r.custNm);
	}
	if(!KBIZVA.isNullOrEmpty(r.cntrNo)){
		$("#untyCntrNo").text(r.cntrNo);
	}
	if(!KBIZVA.isNullOrEmpty(r.custNo)){
		$("#untyCsno").text(r.custNo);
	}
	$("#tlno").text(KBIZST.parseTell(r.tellNum));
	$("#recvNote").val(r.recvNote);
	$("#procNote").val(r.procNote);
};
</script>
</head>
<body>
<div class="popup-wrap">
<div class="popup-layer">
<div class="popup-container">
<div class="popup-conts">
<div class="boardListWrap mgb" style="width:100%;">
<p style="font-size:15px;font-weight:bolder;">특이성향</p>
<form id="specialListForm" action="/inbound/customer/view/specialView.view" method="post" onsubmit="return false;">
        <input type="hidden" id="pageIdx" name="pageIdx" value="1" />
		<input type="hidden" id="rowsPerPage" name="rowsPerPage" value="5" />
		<input type="hidden" id="untyCsno" name="untyCsno" value="${custInfo.untyCsno}" />
		<input type="hidden" id="tellNum" name="tellNum" value="${custInfo.tellNum}" />
</form>
<div id="spclView">
</div>
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
	<tr class="ac">
		<th>인입채널</th>
		<td id="chnlCode" class="init"></td>
		<th>대분류</th>
		<td id="lcode" class="init"></td>
		<th>중분류</th>
		<td id="mcode" class="init"></td>
		<th>소분류</th>
		<td id="scode" class="init"></td>
	</tr>
	<tr class="ac">
		<th>고객명</th>
		<td id="custNm" class="init"></td>
		<th>계약번호</th>
		<td id="untyCntrNo" class="init"></td>
		<th>고객번호</th>
		<td id="untyCsno" class="init"></td>
		<th>전화번호</th>
		<td id="tlno" class="init"></td>
		<th colspan="2"></th>
	</tr>
	<tr>
		<th>문의</th>
		<td colspan="7"><textarea cols="10" rows="5" readonly="readonly" id="recvNote" class="init2"></textarea></td>
	</tr>
	<tr>
		<th>답변</th>
		<td colspan="7"><textarea cols="10" rows="5" readonly="readonly" id="procNote" class="init2"></textarea></td>
	</tr>
	<tr>
		<th>특이성향</th>
		<td colspan="7"><textarea cols="10" rows="3" readonly="readonly" id="specialCont" class="init2"></textarea></td>
	</tr>
</table>
</div>
</div>
</div>
</div>
<div class="popup-layer">
	<div class="popup-footer">
		<a href="#stop" class="btn small g_darkgray clostBtn" onClick="javascript:window.close();"><span class="buttonStyleText">닫기</span></a>
	</div>
</div>
</div>
</body>
</html>