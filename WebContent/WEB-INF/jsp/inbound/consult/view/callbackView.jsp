<%--
 * file name : callbackView.jsp
 * description : 콜백뷰
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
<title>콜백뷰</title>
</head>
<body>
	<div class="brd_list_minR${pageDomain.rowsPerPage}">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="brd_list_a hover_action">
			<colgroup>
				<col style="width: 10%">
				<col style="width: 30%">
				<col style="width: 20%">
				<col style="width: 20%">
			</colgroup>
			<thead>
				<tr>
					<th class="min_width60">NO</th>
					<th class="min_width180">일시</th>
					<th class="min_width180">전화번호</th>
					<th class="min_width160">인입채널</th>
					<th class="min_width180">선점자ID</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="no" value="${pageDomain.fromRowPerPage}" />
				<c:forEach items="${callback}" var="call" varStatus="ca">
					<tr onclick="fn_callback_detail('${call.callbackSeq}','${call.callbackNum}','${call.chnlCode}')">
						<td class="ellips">${no+ca.index}</td>
						<td class="ellips">${kbiz:getDateTime(call.callbackDate)}</td>
						<td class="ellips">${kbiz:getTellNumber(call.callbackNum)}<img src="/images/icon/outcall_red01.gif" class="mgl05"></td>
						<td class="ellips">${call.codeName}</td>
						<td class="ellips">
							<c:if test="${call.modId ne 'IVR'}">
								${call.modId}
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${callback[0] eq null}">
				<tfoot>
					<tr>
						<td colspan="5">조회 결과가 없습니다.</td>
					</tr>
				</tfoot>
			</c:if>
		</table>
	</div>
	<div class="boardPagingWrap mgb20">
		<kbiz:pageNavi pageDomain="${pageDomain}" executeTargetFunction="fn_callbackListPage" submitTargetForm="callbackListForm" />
	</div>
</body>
</html>