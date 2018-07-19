<%--
 * file name : custSearch.jsp
 * description : 고객조회
 * author : H.K.Lee
 * initial date : 2017.11.01
 * history
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
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
<title>고객조회</title>
<script type="text/javascript">
$(function(){
	var csno = "";
	if($("#open").val() == "custInfo" || $("#open").val() == "softphone2" ||$("#open").val() == "callback"){
		$("#startCall").hide();
	}

	/* 전화받기 */
	$("#startCall").click(function(){
		opener.SCall.CtiAnswer();
		opener.call_start(1);
	});

	/* 검색조건 고객 조회 */
	$("#csSearch").click(function(){
		var csDscd = $("#csDscd").val();
		if(KBIZVA.isNullOrEmpty($("#tlno").val()) == false){
			var csKrnNm = $("#csKrnNm").val();
			var tlno = $.trim(KBIZST.replaceTell($("#tlno").val()));
			$("#tellNum").val(tlno);
			KBIZIO.requestParamAjax("/inbound/customer/csSearch.json", fn_csSearch, {params: {csDscd: csDscd, csKrnNm: csKrnNm, tlno: tlno}});
		}else{
			alert("전화번호는 필수값 입니다.");
			return false;
		}
	});
});

function fn_searchCustomer(){
	if( event.keyCode == "13"){
		var csDscd = $("#csDscd").val();
		if( KBIZVA.isNullOrEmpty($("#tlno").val()) == false ){
			var csKrnNm = $("#csKrnNm").val();
			var tlno = $.trim(KBIZST.replaceTell($("#tlno").val()));
			$("#tellNum").val(tlno);
			KBIZIO.requestParamAjax("/inbound/customer/csSearch.json", fn_csSearch, {params: {csDscd: csDscd, csKrnNm: csKrnNm, tlno: tlno}});
		}else{
			alert("전화번호 또는 고객명을 입력해주세요.");
			return false;
		}
	}
}

function fn_csSearch(ret){
	var r = ret.csList;
	var temp = "";
	if(r.length>0){
		for(var i=0; i<r.length; i++){
			temp += "<tr onclick=\"fn_cntr_list('"+r[i].untyCsno+"','"+r[i].csDscd+"')\">";
			temp += "<td>"+(i+1)+"</td>";
			temp += "<td>"+r[i].csKrnNm+"</td>";
			temp += "<td>"+r[i].codeName+"</td>";
			temp += "<td>"+KBIZST.parseTell(r[i].tlno)+"</td>";
			temp += "<td>"+r[i].csSrchNo+"-*******</td>";
			temp += "</tr>";
		}
	}else{
		temp += "<tr><td colspan='5'>검색 결과가 없습니다.</td></tr>";
	}
	$("#csList").html(temp);
	$("#cntrList").html("");
}

/* 고객번호로 계약조회 */
function fn_cntr_list(untyCsno, csDscd){
	csno = untyCsno;
	KBIZIO.requestParamAjax("/inbound/customer/cntrSearch.json", fn_CntrCallback, {params: {untyCsno: untyCsno, csDscd: csDscd}});
};

/* 계약리스트 */
function fn_CntrCallback(ret){
	var r = ret.cntrList;
	var temp = "";
	if(r.length>0){
		for(var i=0; i<r.length;i++){
			temp+="<tr onclick=\"fn_cntr_detail('"+r[i].untyCntrNo+"','"+r[i].untyCsno+"')\" id='"+r[i].cntrNo+"'>";
			temp+="<td>"+(i+1)+"</td>";
			temp+="<td>"+r[i].cntrNo+"</td>";
			var ddct = "";
			if(r[i].ddctBizDscd == "2"){
				ddct = "노란우산공제";
			}else if(r[i].ddctBizDscd == "3"){
				ddct = "공제기금";
			}else if(r[i].ddctBizDscd == "4"){
				ddct = "손해공제";
			}else if(r[i].ddctBizDscd == "5"){
				ddct = "PL단체보험";
			}else if(r[i].ddctBizDscd == "6"){
				ddct = "보증공제";
			}else{
				ddct = "공제구분코드없음";
			}
			temp+="<td>"+ddct+"</td>";
			temp+="<td>"+KBIZDT.getFormattedDate(r[i].cntrBgnDt,"yyyy-MM-dd")+"</td>";
			if(r[i].abndYn != null && r[i].abndYn.length > 0){
				temp+="<td>"+r[i].abndYn+"</td>";
			}else{
				temp+="<td>N</td>";
			}
			temp+="</tr>";
		}
		$("#cntrList").html(temp);
	}else{
		var con = confirm("계약이 없는 고객입니다. 바로 상담을 시작하시겠습니까?");
		if(con){
			KBIZIO.requestParamAjax("/inbound/customer/custSearch2.json", fn_startConCallback, {params: {untyCsno: csno, tlno: tlno}});
		}
	}
};

function fn_startConCallback(ret){
	var r = ret.custList2;
	if($("#open").val() == "custInfo" ){
		opener.parent.custFrame.inbound(r);
		opener.parent.conFrame.inbound(r);
		if(KBIZVA.isNullOrEmpty($("#tellNum", opener.parent.parent.topFrame.document).val())){
			$("#tellNum", opener.parent.parent.topFrame.document).val(r.tlno);
		}
		/* $("#untyCsno", opener.parent.conInfoFrame.document).val(r.untyCsno);
		$("#untyCntrNo", opener.parent.conInfoFrame.document).val(r.untyCntrNo); */
		opener.parent.conInfoFrame.fn_searchConsult2();
	}else if($("#open").val() == "callback"){
		opener.parent.mainFrame.custFrame.inbound(r);
		opener.parent.mainFrame.conFrame.inbound(r);
		/* $("#untyCsno", opener.parent.mainFrame.conInfoFrame.document).val(r.untyCsno);
		$("#untyCntrNo", opener.parent.mainFrame.conInfoFrame.document).val(r.untyCntrNo); */
		opener.parent.mainFrame.conInfoFrame.fn_searchConsult2();
	}else{
		opener.parent.mainFrame.custFrame.inbound(r);
		opener.parent.mainFrame.conFrame.inbound(r);
		/* $("#untyCsno", opener.parent.mainFrame.conInfoFrame.document).val(r.untyCsno);
		$("#untyCntrNo", opener.parent.mainFrame.conInfoFrame.document).val(r.untyCntrNo); */
		opener.parent.conInfoFrame.fn_searchConsult2();
	}
	window.close();
}

/* 계약번호로 고객정보 조회 */
function fn_cntr_detail(untyCntrNo, untyCsno){
	tlno = $.trim(KBIZST.replaceTell($("#tellNum").val()));
	KBIZIO.requestParamAjax("/inbound/customer/cntrDetail.json", fn_CntrDetailCallback, {params: {untyCntrNo: untyCntrNo, untyCsno: untyCsno, tlno: tlno}});
};

/* 고객정보 세팅 */
function fn_CntrDetailCallback(ret){
	var r = ret.cntrDetail;
	if($("#open").val() == "custInfo"){
		opener.parent.custFrame.inbound(r);
		opener.parent.conFrame.inbound(r);
		if(KBIZVA.isNullOrEmpty($("#tellNum", opener.parent.parent.topFrame.document).val())){
			$("#tellNum", opener.parent.parent.topFrame.document).val(r.tlno);
		}
		/* $("#untyCsno", opener.parent.conInfoFrame.document).val(r.untyCsno);
		$("#untyCntrNo", opener.parent.conInfoFrame.document).val(r.untyCntrNo);
		opener.parent.conInfoFrame.fn_searchConsult2(); */
	}else if($("#open").val() == "callback"){
		opener.parent.mainFrame.custFrame.inbound(r);
		opener.parent.mainFrame.conFrame.inbound(r);
		/* $("#untyCsno", opener.parent.mainFrame.conInfoFrame.document).val(r.untyCsno);
		$("#untyCntrNo", opener.parent.mainFrame.conInfoFrame.document).val(r.untyCntrNo);
		opener.parent.mainFrame.conInfoFrame.fn_searchConsult2(); */
	}else{
		opener.parent.mainFrame.custFrame.inbound(r);
		opener.parent.mainFrame.conFrame.inbound(r);
		/* $("#untyCsno", opener.parent.mainFrame.conInfoFrame.document).val(r.untyCsno);
		$("#untyCntrNo", opener.parent.mainFrame.conInfoFrame.document).val(r.untyCntrNo);
		opener.parent.mainFrame.conInfoFrame.fn_searchConsult2(); */
	}
	window.close();
};
</script>
</head>
<body>
<input type="hidden" id="open" value="${opener}"/>
<input type="hidden" id="noCntr" value="${custList}"/>
<input type="hidden" id="tellNum" value="${custList[0].tlno}"/>
<div class="popup-wrap">
    <div class="popup-layer">
        <div class="popup-container">
            <div class="popup-conts">
				<div class="boardListWrap mgb" style="width:100%;">
				<p style="font-size:15px;font-weight:bolder;">고객조회</p>
					<table border="0" cellspacing="0" cellpadding="0" class="brd_sch mgt10">
						<colgroup>
							<col style="width:100px">
							<col style="width:150px">
							<col style="width:100px">
							<col style="width:150px">
							<col style="width:100px">
							<col style="width:150px">
							<col style="width:100px">
						</colgroup>
						<tr>
							<th>고객구분</th>
							<td>
								<select id="csDscd" name="csDscd" onkeypress="fn_searchCustomer()">
									<option value="">선택</option>
									<option value="01">개인</option>
									<option value="02">법인기업</option>
									<option value="03">개인기업</option>
									<option value="07">외국인</option>
									<option value="90">미확인</option>
								</select>
							</td>
							<th>전화번호</th>
							<td><input type="text" id="tlno" value="" placeholder="ex) 01043215678" onkeypress="fn_searchCustomer()"/></td>
							<th>고객명</th>
							<td><input type="text" id="csKrnNm" value="" onkeypress="fn_searchCustomer()"/></td>
							<td class="ac"><a href="#" class="btn small g_orange mgl10" id="csSearch">조회</a></td>
						</tr>
					</table>
					<p class="mgt20" style="font-size:15px;font-weight:bolder;">고객목록</p>
					<table border="0" cellspacing="0" cellpadding="0" class="brd_list_a mgt10 hover_action">
						<colgroup>
							<col style="width:80px">
							<col style="width:150px">
							<col style="width:150px">
							<col style="width:150px">
							<col style="width:150px">
						</colgroup>
						<thead>
							<tr>
								<th>NO</th><th>고객명</th><th>고객구분</th>
								<th>전화번호</th><th>고객검색번호</th>
							</tr>
						</thead>
						<tbody id="csList">
							<c:forEach items="${custList}" var="c" varStatus="cur">
								<tr onclick="fn_cntr_list('${c.untyCsno}','${c.csDscd}');">
									<td>${cur.index+1}</td>
									<td>${c.csKrnNm}</td>
									<td>
										<c:forEach items="${code}" var="cd">
											<c:if test="${cd.mcode == c.csDscd}">
												${cd.codeName}
											</c:if>
										</c:forEach>
										<c:if test="${c.csDscd eq null}">
											개인
										</c:if>
									</td>
									<td>${kbiz:getTellNumber(c.tlno)}</td>
									<td>${c.csSrchNo}-*******</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="mgt20" style="width:100%;height:15px;">
						<div class="al" style="width:48%;float:left;font-size:15px;font-weight:bolder;">계약목록</div>
						<div class="ar" style="width:48%;float:right">
							<!-- <input type="radio" value="해지" name="yn" class="yn" id="yes" checked="checked"/>정상
							<input type="radio" value="정상" name="yn" class="yn" id="no" />해지 -->
						</div>
					</div>
					<table border="0" cellspacing="0" cellpadding="0" class="brd_list_a mgt10 hover_action">
						<colgroup>
							<col style="width:80px">
							<col style="width:150px">
							<col style="width:150px">
							<col style="width:150px">
							<col style="width:150px">
						</colgroup>
						<thead>
							<tr>
								<th>NO</th><th>계약번호</th><th>공제사업코드</th><th>계약일자</th><th>해지여부</th>
							</tr>
						</thead>
						<tbody id="cntrList">

						</tbody>
					</table>
				</div>
            </div>
        </div>
		<div class="popup-footer">
			<a href="#" class="btn small g_blue" id="startCall">전화받기</a>
			<a href="#stop" class="btn small g_darkgray clostBtn" onClick="javascript:window.close();"><span class="buttonStyleText">닫기</span></a>
		</div>
    </div>
</div>
</body>
</html>
