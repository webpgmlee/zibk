<%--
 * file name : custInfoDetail.jsp
 * description : 상담이력상세
 * author : H.K.Lee
 * initial date : 2017.11.01
 * history
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
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
<jsp:include page="/WEB-INF/jsp/comm_top.jsp"/>
<title>상담이력 상세</title>
<script type="text/javascript">
$(function(){
	if($("#tranId").val() != "tranId"){
		$("#vocYn").hide();
	}
	var m_path="http://callrec.kbiz.or.kr:8080/";
	var recArr = new Array();
	recArr = ($("#recUrl").val()).split("&");
	$("a").click(function(){
		var id = this.id;
		var seq = id.substring(3,4);
		var path = m_path+recArr[seq];
		PlayWav.OpenURL(path);
	});
	var protocol = location.protocol;
	if($("#tranId").val() == "tranId"){
		KBIZIO.requestParamAjax(protocol+"//vocapi.kbiz.or.kr/api/call/vocDtl", fn_vocResult,{
			params: {
				callSeq: $("#cnltSeq").val(),
				callDtlSeq: $("#cnltDetailNo").val()
			},
			type : "POST"
		});
	}
});

function fn_vocResult(r){
	console.log(r);
	$("#tranState").text(r.DATA.procStat);
};
</script>
</head>
<body>
<input type="hidden" id="recUrl" value="${cDetail.recUrl}"/>
<input type="hidden" id="cnltSeq" value="${cDetail.cnltSeq}"/>
<input type="hidden" id="cnltDetailNo" value="${cDetail.cnltDetailNo}"/>
<input type="hidden" id="tranId" value="${tranId}"/>
<table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch">
	<colgroup>
		<col style="width:13%">
		<col style="width:20%">
		<col style="width:13%">
		<col style="width:20%">
		<col style="width:13%">
		<col style="width:20%">
	</colgroup>
	<tr class="ac">
		<th>인입채널</th>
		<td>${cDetail.codeName}</td>
		<th>콜구분</th>
		<td>
			<c:if test="${cDetail.ioType eq 'I'}">IN</c:if>
			<c:if test="${cDetail.ioType eq 'O'}">OUT</c:if>
			<c:if test="${cDetail.ioType eq 'C'}">CALLBACK</c:if>
		</td>
		<th>녹취파일</th>
		<td>${kbiz:getRecSplit(cDetail.recUrl)}</td>
	</tr>
	<tr class="ac">
		<th>대분류</th>
		<td>${cDetail.lcode}</td>
		<th>중분류</th>
		<td>${cDetail.mcode}</td>
		<th>소분류</th>
		<td>${cDetail.scode }</td>
	</tr>
	<tr class="ac">
		<th>고객명</th>
		<td>${cDetail.custNm}</td>
		<th>계약번호</th>
		<td>${cDetail.cntrNo}</td>
		<th>전화번호</th>
		<td>${kbiz:getTellNumber(cDetail.tellNum)}</td>
	</tr>
	<tr class="ac" id="vocYn">
		<th>VOC처리상태</th><td id="tranState"></td><th colspan="4"></th>
	</tr>
	<tr>
		<th>문의</th>
		<td colspan="7"><textarea cols="10" rows="5" readonly="readonly">${cDetail.recvNote}</textarea></td>
	</tr>
	<tr>
		<th>답변</th>
		<td colspan="7"><textarea cols="10" rows="5" readonly="readonly">${cDetail.procNote}</textarea></td>
	</tr>
	<tr>
		<td colspan="8">
			<object id='PlayWav' classid='CLSID:5474D51F-02EE-4EB5-AC97-5F27E094EE4D'  width='100%' height='135' ></object>
		</td>
	</tr>
</table>
</body>
</html>