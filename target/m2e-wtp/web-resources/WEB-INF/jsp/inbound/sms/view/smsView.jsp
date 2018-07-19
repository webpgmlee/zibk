<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<!doctype html>
<html>
<head>
<title>SMS뷰</title>
</head>
<body>
	<div class="brd_list_minR${pageDomain.rowsPerPage}">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="brd_list_a hover_action">
			<colgroup>
				<col style="width: 40px">
				<col style="width: 200px">
				<col style="width: 200px">
				<col style="width: 100px">
			</colgroup>
			<thead>
				<tr>
					<th>NO</th>
					<th>전송일시</th>
					<th>전화번호</th>
					<th>상담사명</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="no" value="${pageDomain.fromRowPerPage}" />
				<c:forEach items="${smsList}" var="sms" varStatus="seq">
					<tr onclick="fn_smsDetail('${sms.sendSmsSeq}');" style="cursor: hand;">
						<td class="ellips">${no+seq.index}</td>
						<td class="ellips">${kbiz:getDateTime(sms.sendSmsDate)}</td>
						<td class="ellips">${kbiz:getTellNumber(sms.tellNum)}</td>
						<td class="ellips">${sms.sendUserNm}</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${smsList[0] eq null}">
				<tfoot>
					<tr>
						<td colspan="5">조회 결과가 없습니다.</td>
					</tr>
				</tfoot>
			</c:if>
		</table>
	</div>
	<div class="boardPagingWrap mgb20">
		<kbiz:pageNavi pageDomain="${pageDomain}" executeTargetFunction="fn_smsHist" submitTargetForm="smsHistForm" />
	</div>
</body>
</html>