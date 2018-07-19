<%--
 * file name : reserveView.jsp
 * description : 이관내역뷰
 * author : H.K.Lee
 * initial date : 2017.11.01
 * history
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<!doctype html>
<html>
<head>
<title>이관내역뷰</title>
</head>
<body>
	<div class="brd_list_minR${pageDomain.rowsPerPage}">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="brd_list_a hover_action">
			<colgroup>
				<col style="width: 8%">
				<col style="width: 23%">
				<col style="width: 20%">
				<col style="width: 9%">
				<col style="width: 9%">
				<col style="width: 9%">
				<col style="width: 11%">
				<col style="width: 11%">
			</colgroup>
			<thead>
				<tr>
					<th class="min_width40">NO</th>
					<th class="min_width135">상담일시</th>
					<th class="min_width120">전화번호</th>
					<th class="min_width120">고객명</th>
					<th class="min_width110">상담사</th>
					<th class="min_width110">담당자</th>
					<th class="min_width110">처리구분</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="no" value="${pageDomain.fromRowPerPage}" />
				<c:forEach items="${transfer}" var="t" varStatus="ts">
					<tr onclick="fn_tran_detail('${t.cnltSeq}','${t.cnltDetailNo}','${t.cnltProcCd}','${t.tellNum}')">
						<td class="ellips">${no+ts.index}</td>
						<td class="ellips">${kbiz:getDateTime(t.cnltDate)}</td>
						<td class="ellips">${kbiz:getTellNumber(t.tellNum)}</td>
						<td class="ellips">${t.custNm}</td>
						<td class="ellips">${t.regNm}</td>
						<td class="ellips">
							<c:if test="${t.tranNm ne null}">
								${t.tranNm}
							</c:if>
							<c:if test="${t.tranNm eq null}">
								VOC담당자
							</c:if>
						</td>
						<td class="ellips">${t.codeName}</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${transfer[0] eq null}">
				<tfoot>
					<tr>
						<td colspan="7">조회 결과가 없습니다.</td>
					</tr>
				</tfoot>
			</c:if>
		</table>
	</div>
	<div class="boardPagingWrap mgb20">
		<kbiz:pageNavi pageDomain="${pageDomain}" executeTargetFunction="fn_transferListPage" submitTargetForm="transferListForm" />
	</div>
</body>
</html>