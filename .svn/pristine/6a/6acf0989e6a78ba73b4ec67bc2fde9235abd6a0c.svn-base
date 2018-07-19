<%--
 * file name    : main.jsp
 * description  : 메인
 * author       : H.K.Lee
 * initial date : 2017.11.01
 * history
  수정일자      수정자 수정내용
--%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
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
<jsp:include page="/WEB-INF/jsp/comm_top.jsp" />
<title>KBIZ</title>
<script type="text/javascript">
$(function() {
	fn_notice();
	fn_transfer();
	fn_reserve();
	// 메인 날짜 세팅
	var cal = new Date();
	var year = cal.getFullYear() + "년";
	var month = cal.getMonth() + 1 + "월";
	var day = cal.getDate() + "일";
	var week = cal.getDay();
	if (week == 0) week = "일요일";
	else if (week == 1) {week = "월요일";}
	else if (week == 2) {week = "화요일";}
	else if (week == 3) {week = "수요일";}
	else if (week == 4) {week = "목요일";}
	else if (week == 5) {week = "금요일";}
	else if (week == 6) {week = "토요일";}

	$("#year").text(year);
	$("#month").text(month);
	$("#day").text(day);
	$("#week").text(week);

	// 탭이동 스크팁트
	$(".tab_content").hide();
	$(".tab_content:first").show();
	$("ul.tabs li").click(function() {
		$("ul.tabs li").removeClass("active");
		$(this).addClass("active").css({
			"color" : "darkred",
			"font-weight" : "bolder"
		});
		$(this).addClass("active");
		$(".tab_content").hide()
		var activeTab = $(this).attr("rel");
		$("#" + activeTab).fadeIn(0);
	});

	$("#nFile").click(function(){
		location.href="/notice/downloadFile.do?notiFilename="+encodeURI($("#nFile").text());
	});
	// 전일상담현황 세팅
	/* 미처리건수 : 예약, 콜백, 이관(VOC제외)
	상담완료 : 처리완료, 부재중, 이관-VOC
	이관건수 : 이관
	예약전화 : 예약 */
	$("#noticeSearch").click(function(){
		$("#pageIdx").val(1);
    	KBIZIO.requestViewAjax("noticeForm","noticeView", "");
    });
});
// 공지사항 뷰
function fn_notice(){
	$("#notiTitle").text("");
	$("#regNm").text("");
	$("#tarea").text("");
	$("#regDate").text("");
	$("#nFile").text("");
	$("#notiType").text("");
	KBIZIO.requestViewAjax("noticeForm","noticeView", "");
};
function fn_notice2(){
	if(event.keyCode == "13"){
		$("#pageIdx").val(1);
		fn_notice();
	}
};
function fn_transfer(){
	KBIZIO.requestViewAjax("transferForm","transferView", "");
};
function fn_reserve(){
	KBIZIO.requestViewAjax("reserveForm","reserveView", "");
};
// 공지사항 상세
function fn_detail(seq) {
	KBIZIO.requestParamAjax("/main/noticeDetail.json", fn_detailCallback, {
		params : {
			notiSeq : seq
		}
	});
};
function fn_detailCallback(ret) {
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
</script>
</head>
<body>
	<div class="wrap_index">
		<div class="container">
			<table width="100%" height="100%" border="0" cellspacing="0"
				cellpadding="0" class="frame_wrap">
				<colgroup>
					<col style="width: 50%">
					<col style="width: 50%">
				</colgroup>
				<tbody>
					<tr>
						<td style="height: 230px; vertical-align: top">
							<div class="frame">
								<div class="main_today">
									<ul>
										<li><span id="year"></span></li>
										<li><span id="month"></span></li>
										<li><span id="day"></span></li>
										<li><span id="week"></span></li>
									</ul>
								</div>
							</div>
						</td>
						<td style="height: 230px; vertical-align: top">
							<div class="frame">
								<!--전일상담현황-->
								<div class="section pdt00">
									<div class="main_status">
										<ul class="clfix">
											<li><em><strong>${ystd.CONCOUNT}</strong>건</em><span>상담건수</span></li>
											<li><em><strong>${ystd.COMCOUNT}</strong>건</em><span>상담완료</span></li>
											<li><em><strong>${ystd.TRANSCOUNT}</strong>건</em><span>이관내역</span></li>
											<li><em><strong>${ystd.RSRVCOUNT}</strong>건</em><span>예약전화</span></li>
										</ul>
									</div>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="height: auto; vertical-align: top">
							<div class="frame">
								<!--공지사항-->
								<div class="section pdt03">
									<h3>
										<span class="sec_tit">공지사항</span>
									</h3>
									<form id="noticeForm" action="/main/view/notice.view"
										method="post" onsubmit="return false;">
										<input type="hidden" id="pageIdx" name="pageIdx" value="1" />
										<input type="hidden" id="rowsPerPage" name="rowsPerPage"
											value="5" />
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="brd_sch mgb10">
											<colgroup>
												<col style="width: 130px" />
												<col style="width: 430px" />
												<col style="width: 130px" />
												<col style="width: 290px" />
												<col style="width: 75px" />
											</colgroup>
											<thead>
												<tr>
													<th class="ellips">키워드</th>
													<td class="ellips"><input type="text"
														name="selKeyword" id="selKeyword"
														onkeypress="fn_notice2()" /></td>
													<th class="ellips">공지구분</th>
													<td class="ellips"><select id="notiTypeCd"
														name="notiTypeCd" onkeypress="fn_notice2()">
															<option value="">선택</option>
															<c:forEach items="${code}" var="c">
																<c:if test="${c.lcode == '004'}">
																	<c:if test="${c.mcode != '00'}">
																		<option value="${c.mcode}">${c.codeName}</option>
																	</c:if>
																</c:if>
															</c:forEach>
													</select></td>
													<td class="ellips"><a href="#"
														class="btn small g_orange" id="noticeSearch">조회</a></td>
												</tr>
											</thead>
										</table>
									</form>
									<div id="noticeView"></div>
									<table border="0" cellspacing="0" cellpadding="0"
										class="brd_sch mgt20">
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
											<td colspan="6" class="pdl10" id="notiTitle"></td>
										</tr>
										<tr>
											<th>공지구분</th>
											<td class="pdl10" id="notiType"></td>
											<th>작성자</th>
											<td class="pdl10" id="regNm"></td>
											<th>작성일</th>
											<td class="pdl10" id="regDate"></td>
										</tr>
										<tr>
											<th>첨부파일</th>
											<td class="pdl10" colspan="5"><a href="#"><span
													id="nFile"></span></a></td>
										</tr>
										<tr>
											<th>내용</th>
											<td colspan="7"><textarea id="tarea"
													style="height: 200px" readonly="readonly"></textarea></td>
										</tr>
									</table>
								</div>
								<!--/공지사항-->
							</div>
						</td>
						<td style="height: auto; vertical-align: top">
							<div class="frame">
								<!--이관내역//-->
								<div class="brd_top clfix">
									<!--탭//-->
									<div class="com_tab db">
										<ul class="tabs color03">
											<li class="active" rel="tab1"><a href="#">이관내역</a></li>
											<li rel="tab2"><a href="#">예약전화</a></li>
										</ul>
									</div>
									<!--//탭-->
								</div>
								<div class="tab_container">
									<div id="tab1" class="tab_content">
										<form id="transferForm" action="/main/view/transfer.view"
											method="post" onsubmit="return false;">
											<input type="hidden" id="pageIdx" name="pageIdx" value="1" />
											<input type="hidden" id="rowsPerPage" name="rowsPerPage"
												value="5" />
										</form>
										<div id="transferView"></div>
									</div>
									<div id="tab2" class="tab_content">
										<form id="reserveForm" action="/main/view/reserve.view"
											method="post" onsubmit="return false;">
											<input type="hidden" id="pageIdx" name="pageIdx" value="1" />
											<input type="hidden" id="rowsPerPage" name="rowsPerPage"
												value="5" />
										</form>
										<div id="reserveView"></div>
									</div>
								</div>
							</div>
						</td>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>