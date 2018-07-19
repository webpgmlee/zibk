<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<!doctype html>
<html>
<head>
<title>공지사항뷰</title>
</head>
<body>
	<div class="brd_list_minR${pageDomain.rowsPerPage}">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="brd_list_a hover_action main_table">
			<colgroup>
				<col style="width: 8%">
				<col style="width: 22%">
				<col style="width: 22%">
				<col style="width: 16%">
				<col style="width: 16%">
				<col style="width: 16%">
			</colgroup>
			<thead>
				<tr>
					<th>NO</th>
					<th>상담일시</th>
					<th>예약일시</th>
					<th>전화번호</th>
					<th>고객명</th>
					<th>상담사</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="no" value="${pageDomain.fromRowPerPage}" />
				<c:forEach items="${reserve}" var="r" varStatus="rs">
					<tr onclick="fn_rsrv_detail('${r.cnltSeq}','${r.cnltDetailNo}')">
						<td class="ellips">${no+rs.index}</td>
						<td class="ellips">${kbiz:getDateTime(r.cnltDate)}</td>
						<td class="ellips">${kbiz:getDateTime(r.rsrvDate)}</td>
						<td class="ellips">${kbiz:getTellNumber(r.rsrvTellNum)}</td>
						<td class="ellips">${r.custNm}</td>
						<td class="ellips">${r.userNm}</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${reserve[0] eq null}">
				<tfoot>
					<tr>
						<td colspan="6">조회 결과가 없습니다.</td>
					</tr>
				</tfoot>
			</c:if>
		</table>
	</div>
	<div class="boardPagingWrap mgb20">
		<kbiz:pageNavi pageDomain="${pageDomain}" executeTargetFunction="fn_reserve" submitTargetForm="reserveForm" />
	</div>
</body>
</html>