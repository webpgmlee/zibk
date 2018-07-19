<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld"%>
<jsp:include page="/WEB-INF/jsp/comm_top.jsp" />
<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<meta name="subject" content="KBIZ">
<meta name="author" content="KBIZ">
<meta name="keywords" content="KBIZ">
<meta name="description" content="KBIZ">
<title>KBIZ</title>
<script type="text/javascript">
$(function() {
	fn_notice();
	fn_smsHist();
	// 탭 이동 스크립트
	$(".tab_content").hide();
	$(".tab_content:first").show();

	$("ul.tabs li").click(function() {
		$("ul.tabs li").removeClass("active");
		//$(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
		$(this).addClass("active");
		$(".tab_content").hide()
		var activeTab = $(this).attr("rel");
		$("#" + activeTab).fadeIn(0)
	});

	$("#noticeSearch").click(function() {
		$("#pageIdx").val(1);
		$(".init").text("");
		KBIZIO.requestViewAjax("noticeForm", "noticeView", fn_noticeCallback);
	});

	if ($("#chcode").val() != null && $("#chcode").val().length > 0) {
		inbound($("#chcode").val());
	} else {
		inbound("A");
	}
	fn_searchScript();
	fn_script_list("","","","");

	// 스크립트 키워드조회
	$("#searchBtn").click(function() {
		$("#pageIdx2").val(1);
		$("#pageIdx3").val(1);
		$(".init2").text("");
		fn_script_list("","","","");
		fn_searchScript();
	});

	// 스크립트 첨부파일 다운로드
	$("#uploadFile").click(function() {
		if ($("#file").text() != "" && $("#file").text() != null) {
			location.href = "/inbound/script/downloadFile.do?scrpFile="+ encodeURI($("#file").text());
		}
	});

	// 공지사항 첨부파일 다운로드
	$("#nFile").click(function(){
		if($("#nFile").text() != "" && $("#nFile").text != null){
			location.href="/notice/downloadFile.do?notiFilename="+encodeURI($("#nFile").text());
		}
	});
});

function fn_notice() {
	$(".init").text("");
	KBIZIO.requestViewAjax("noticeForm", "noticeView", "");
};
function fn_notice2() {
	$("#pageIdx").val(1);
	if (event.keyCode == "13") {
		fn_notice();
	}
};

function fn_detail(seq) {
	KBIZIO.requestParamAjax("/main/noticeDetail.json", fn_detailCallback, {params : {notiSeq : seq}});
};
function fn_detailCallback(ret) {
	$(".init").text("");
	var r = ret.noticeDetail;
	$("#notiTitle").text(r.notiTitle);
	$("#regNm").text(r.regNm);
	$("#tarea").text(r.notiContents);
	$("#regDate").text(KBIZDT.getFormattedDate(r.regDate, "yyyy-MM-dd HH:mm:ss"));
	if(r.notiFilename != null && r.notiFilename.length > 0){
		$("#nFile").text(r.notiFilename);
	}else{
		$("#nFile").text("");
	}
	$("#notiType").text(r.notiTypeNm);
};

/* 스크립트 키워드 조회 */
function fn_searchScript() {
	$(".init2").text("");
	$("#uploadFile").html("");
	fn_script_list("","","","");
	KBIZIO.requestViewAjax("scriptSearchForm", "scriptList", "");
};

function fn_searchScript2() {
	if (event.keyCode == "13") {
		$("#pageIdx2").val(1);
		$("#pageIdx3").val(1);
		$(".init2").text("");
		fn_script_list("","","","");
		fn_searchScript();
	}
}

// inbound 인입채널 세팅
function inbound(chnlCode) {
	$("#chnlCode").val(chnlCode);
	fn_selLcode();
};

// 인입채널/대/중/소분류 세팅
function fn_selLcode() {
	$("#lcode").html("<option value=''>선택</option>");
	$("#mcode").html("<option value=''>선택</option>");
	var chnlCode = $("#chnlCode").val();
	KBIZIO.requestParamAjax("/inbound/consult/selectLcode.json",fn_lcodeCallback, {params : {chnlCode : chnlCode}});
};

function fn_lcodeCallback(ret) {
	var r = ret.lcode;
	var option = "<option value=''>선택</option>";
	var len = r.length;
	for (var l = 0; l < len; l++) {
		option += "<option value='"+r[l].lcode+"'>" + r[l].codeName + "</option>";
		if (len == 1) {
			$("#lcode").html(option);
			$("#lcode").val(r[l].lcode);
			fn_selMcode();
			return;
		}
	}
	$("#lcode").html(option);
};
function fn_selMcode() {
	var chnlCode = $("#chnlCode").val();
	var lcode = $("#lcode").val();
	KBIZIO.requestParamAjax("/inbound/consult/selectMcode.json", fn_mcodeCallback, {params : {chnlCode : chnlCode,lcode : lcode}});
};
function fn_mcodeCallback(ret) {
	var r = ret.mcode;
	var option = "<option value=''>선택</option>";
	var len = r.length;
	for (var m = 0; m < len; m++) {
		option += "<option value='"+r[m].mcode+"'>" + r[m].codeName + "</option>";
		if (len == 1) {
			$("#mcode").html(option);
			$("#mcode").val(r[m].mcode);
			return;
		}
	}
	$("#mcode").html(option);
};

function fn_script_list(chnlCode, lcode, mcode, scode){
	$(".init2").text("");
	$("#uploadFile").text("");
	$("#chnlCode2").val(chnlCode);
	$("#lcode2").val(lcode);
	$("#mcode2").val(mcode);
	$("#scode2").val(scode);
	$("#pageIdx3").val(1);
	KBIZIO.requestViewAjax("scriptSearchForm2", "scriptList2");
};

function fn_script_list2(){
	KBIZIO.requestViewAjax("scriptSearchForm2", "scriptList2");
};

// 스크립트 상세 정보 세팅
function fn_script_detail(scrpNo) {
	KBIZIO.requestParamAjax("/inbound/knowledge/selectScriptDetail.json", fn_script_callback, { params : {scrpNo : scrpNo}});
};

function fn_script_callback(ret) {
	$(".init2").text("");
	var r = ret.scriptDetail;
	$("#lname").text(r.lcodeName);
	$("#mname").text(r.mcodeName);
	$("#sname").text(r.scodeName);
	$("#script").text(r.scrpCont);
	$("#title").text(r.scrpTitle);
	if (r.scrpFile != null) {
		$("#uploadFile").html(
				"<a href='#' id='file'>" + r.scrpFile + "</a>");
	} else {
		$("#uploadFile").html("");
	}
	// 스크롤 위치 상세로 이동
	var scroll = $("#script").outerHeight() + 100;
	$("html, body").animate({
		scrollTop : scroll
	});
};

function fn_smsHist(){
	$("#tellNum").val(KBIZST.replaceTell($("#tellNum", parent.parent.topFrame.document).val()));
	KBIZIO.requestViewAjax("smsHistForm", "smsList");
};

function fn_smsDetail(seq){
	KBIZIO.requestParamAjax("/inbound/sms/smsDetail.json", fn_sms_callback, { params : {sendSmsSeq : seq}});
};

function fn_sms_callback(ret){
	var r = ret.smsDetail;
	$("#smsTitle").text("");
	$("#sendSmsDate").text("");
	$("#smsTellNum").text("");
	$("#sendUserNm").text("");
	$("#smsContent").val("");
	if(r.smsTitle != null){
		$("#smsTitle").text(r.smsTitle);
	}
	$("#sendSmsDate").text(KBIZDT.getFormattedDate(r.sendSmsDate, "yyyy-MM-dd HH:mm:ss"));
	$("#smsTellNum").text(KBIZST.parseTell(r.tellNum));
	$("#sendUserNm").text(r.sendUserNm);
	$("#smsContent").val(r.smsContent);
}
</script>
</head>
<body>
	<input type="hidden" id="chcode" value="${chnlCode}" />
	<div class="brd_top clfix">
		<!--탭//-->
		<div class="com_tab db">
			<ul class="tabs color03">
				<li class="active" rel="tab1" onclick="fn_notice()"><a href="#">공지사항</a></li>
				<li rel="tab2" onclick="fn_searchScript()"><a href="#">스크립트</a></li>
				<li rel="tab3" onclick="fn_smsHist()"><a href="#">SMS이력</a></li>
			</ul>
		</div>
		<!--//탭-->
	</div>
	<div class="tab_container">
		<div id="tab1" class="tab_content">
			<form id="noticeForm" action="/inbound/notice/view/notice.view" method="post" onsubmit="return false;">
				<input type="hidden" id="pageIdx" name="pageIdx" value="1" />
				<input type="hidden" id="rowsPerPage" name="rowsPerPage" value="5" />
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="brd_sch mgb10">
					<colgroup>
						<col style="width: 100px" />
						<col style="width: 280px" />
						<col style="width: 100px" />
						<col style="width: 200px" />
						<col style="width: 80px" />
					</colgroup>
					<thead>
						<tr>
							<th class="ellips">키워드</th>
							<td class="ellips"><input type="text" name="selKeyword" id="selKeyword" onkeypress="fn_notice2()" /></td>
							<th class="ellips">공지구분</th>
							<td class="ellips">
								<select id="notiTypeCd" name="notiTypeCd" onkeypress="fn_notice2()">
									<option value="">선택</option>
									<c:forEach items="${code}" var="c">
										<c:if test="${c.lcode == '004'}">
											<c:if test="${c.mcode != '00'}">
												<option value="${c.mcode}">${c.codeName}</option>
											</c:if>
										</c:if>
									</c:forEach>
								</select></td>
							<td><a href="#" class="btn small g_orange" id="noticeSearch">조회</a></td>
						</tr>
					</thead>
				</table>
			</form>
			<div id="noticeView"></div>
			<table border="0" cellspacing="0" cellpadding="0" class="brd_sch mgt20">
				<colgroup>
					<col style="width: 100px">
					<col style="width: 80px">
					<col style="width: 80px">
					<col style="width: 100px">
					<col style="width: 80px">
					<col style="width: 160px">
				</colgroup>
				<tr>
					<th>제목</th>
					<td colspan="6" class="pdl10 init" id="notiTitle"></td>
				</tr>
				<tr>
					<th>공지구분</th>
					<td class="ac min_width75 init" id="notiType"></td>
					<th>작성자</th>
					<td class="ac min_width100 init" id="regNm"></td>
					<th>작성일</th>
					<td class="ac min_width135 init" id="regDate"></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td class="pdl10" colspan="5"><a href="#"><span id="nFile" class="init"></span></a></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="7"><textarea id="tarea" class="init" style="height: 200px" readonly="readonly"></textarea></td>
				</tr>
			</table>
		</div>
	</div>
	<div class="tab_container">
		<div id="tab2" class="tab_content">
			<form id="scriptSearchForm" action="/inbound/knowledge/view/knowledgeList.view" method="post" onsubmit="return false;">
				<input type="hidden" id="pageIdx2" name="pageIdx" value="1" />
				<input type="hidden" id="rowsPerPage2" name="rowsPerPage" value="5" />
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="brd_sch mgb10">
					<colgroup>
						<col style="width: 65px">
						<col style="width: 190px">
						<col style="width: 60px">
						<col style="width: 190px">
						<col style="width: 60px">
						<col style="width: 110px">
						<col style="width: 80px">
					</colgroup>
					<tr>
						<th><label for="chnlCode">인입채널</label></th>
						<td class="ellips min_width110"><select id="chnlCode" name="chnlCode" onchange="fn_selLcode()" onkeypress="fn_searchScript2()">
								<c:forEach items="${chCode}" var="ch">
									<c:if test="${ch.lcode eq '00'}">
										<option value="${ch.chnlCode}">${ch.codeName}</option>
									</c:if>
								</c:forEach>
						</select></td>
						<th><label for="lcode">대분류</label></th>
						<td class="ellips min_width110">
							<select id="lcode" name="lcode" onchange="fn_selMcode()" onkeypress="fn_searchScript2()">
								<option value="">선택</option>
							</select></td>
						<th><label for="mcode">중분류</label></th>
						<td class="ellips min_width110" colspan="2">
						<select id="mcode" name="mcode" onkeypress="fn_searchScript2()">
								<option value="">선택</option>
						</select></td>
					</tr>
					<tr>
						<th>키워드</th>
						<td class="ellips" colspan="5">
							<input type="text" name="keyword" id="keyword" onkeypress="fn_searchScript2()" /></td>
						<td class="ellips min_width60"><a href="#" class="btn small g_orange" id="searchBtn">조회</a></td>
					</tr>
				</table>
			</form>
			<div id="scriptList"></div>
			<form id="scriptSearchForm2" action="/inbound/knowledge/view/knowledgeList2.view" method="post" onsubmit="return false;">
				<input type="hidden" id="pageIdx3" name="pageIdx" value="1" />
				<input type="hidden" id="rowsPerPage3" name="rowsPerPage" value="5" />
				<input type="hidden" id="chnlCode2" class="init3" name="chnlCode" />
				<input type="hidden" id="lcode2" class="init3" name="lcode" />
				<input type="hidden" id="mcode2" class="init3" name="mcode" />
				<input type="hidden" id="scode2" class="init3" name="scode" />
			</form>
			<div id="scriptList2"></div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="brd_sch mgt20">
				<colgroup>
					<col style="width: 16.5%">
					<col style="width: 16.5%">
					<col style="width: 16.5%">
					<col style="width: 16.5%">
					<col style="width: 16.5%">
					<col style="width: 16.5%">
				</colgroup>
				<tr class="ac">
					<th>대분류</th>
					<td id="lname" class="init2 min_width85"></td>
					<th>중분류</th>
					<td id="mname" class="init2 min_width85"></td>
					<th>소분류</th>
					<td id="sname" class="init2 min_width85"></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td id="uploadFile" colspan="5"></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="5" class="init2" id="title"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="5"><textarea style="height: 200px;" id="script" class="init2" readonly="readonly"></textarea></td>
				</tr>
			</table>
		</div>
	</div>
	<div class="tab_container">
		<div id="tab3" class="tab_content">
			<form id="smsHistForm" action="/inbound/sms/view/smsList.view" method="post" onsubmit="return false;">
				<input type="hidden" id="pageIdx4" name="pageIdx" value="1" />
				<input type="hidden" id="rowsPerPage4" name="rowsPerPage" value="5" />
				<input type="hidden" id="tellNum" name="tellNum" value="" />
			</form>
			<div id="smsList"></div>
			<table border="0" cellspacing="0" cellpadding="0" class="brd_sch mgt20">
				<colgroup>
					<col style="width: 100px">
					<col style="width: 140px">
					<col style="width: 80px">
					<col style="width: 100px">
					<col style="width: 80px">
					<col style="width: 100px">
				</colgroup>
				<tr>
					<th>전송일시</th>
					<td class="ac min_width140 init" id="sendSmsDate"></td>
					<th>전화번호</th>
					<td class="ac min_width110 init" id="smsTellNum"></td>
					<th>상담사명</th>
					<td class="ac min_width120 init" id="sendUserNm"></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="6" class="pdl10 init" id="smsTitle"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="7"><textarea id="smsContent" class="init" style="height: 200px" readonly="readonly"></textarea></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>