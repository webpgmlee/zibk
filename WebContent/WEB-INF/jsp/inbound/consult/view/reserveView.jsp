<%--
 * file name : reserveView.jsp
 * description : 예약전화뷰
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
<title>예약전화뷰</title>
</head>
<body>
	<div class="brd_list_minR${pageDomain.rowsPerPage}">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="brd_list_a hover_action">
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
					<th class="min_width60">NO</th>
					<th class="min_width145">상담일시</th>
					<th class="min_width145">예약일시</th>
					<th class="min_width135">전화번호</th>
					<th class="min_width130">고객명</th>
					<th class="min_width130">상담사</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="no" value="${pageDomain.fromRowPerPage}" />
				<c:forEach items="${reserve}" var="r" varStatus="rs">
					<tr onclick="fn_rsrv_detail('${r.cnltSeq}','${r.cnltDetailNo}','${r.rsrvTellNum}')">
						<td class="ellips">${no+rs.index}</td>
						<td class="ellips">${kbiz:getDateTime(r.cnltDate)}</td>
						<td class="ellips">${kbiz:getDateTime(r.rsrvDate)}</td>
						<td class="ellips">${kbiz:getTellNumber(r.rsrvTellNum)}
						<a href="#" class="mgl05"><img src="/images/icon/outcall_red01.gif"></a></td>
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
		<kbiz:pageNavi pageDomain="${pageDomain}" executeTargetFunction="fn_reserveListPage" submitTargetForm="reserveListForm" />
	</div>
</body>
</html>