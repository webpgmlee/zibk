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
					<th>NO</th>
					<th>상담일시</th>
					<th>전화번호</th>
					<th>고객명</th>
					<th>상담사</th>
					<th>담당자</th>
					<th>처리구분</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="no" value="${pageDomain.fromRowPerPage}" />
				<c:forEach items="${transfer}" var="t" varStatus="ts">
					<tr>
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
				<tr>
			</tbody>
			<tfoot>
				<c:if test="${transfer[0] eq null}">
					<tr>
						<td colspan="7">조회 결과가 없습니다.</td>
					</tr>
				</c:if>
			</tfoot>
		</table>
	</div>
	<div class="boardPagingWrap mgb20">
		<kbiz:pageNavi pageDomain="${pageDomain}" executeTargetFunction="fn_transfer" submitTargetForm="transferForm" />
	</div>
</body>
</html>