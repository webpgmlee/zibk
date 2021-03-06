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
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="brd_list_a hover_action mgt01 main_table">
			<colgroup>
				<col style="width: 40px">
				<col>
				<col style="width: 200px">
				<col style="width: 60px">
			</colgroup>
			<thead>
				<tr>
					<th>NO</th>
					<th>제목</th>
					<th>공지일시</th>
					<th>등록자</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="no" value="${pageDomain.fromRowPerPage}" />
				<c:forEach items="${noticeList}" var="items" varStatus="seq">
					<tr onclick="fn_detail('${items.notiSeq}');" style="cursor: hand;">
						<td class="ellips">${no+seq.index}</td>
						<c:choose>
	                       <c:when test="${items.notiTypeCd eq '07'}">
                           <td class="title al"><img src="/img/notice_icon${items.notiTypeCd}.${items.remk1}">&nbsp;${kbiz:getMaxString(items.notiTitle,70)}</td>
	                       </c:when>
	                       <c:otherwise>
                           <td class="ellips al"><img src="/img/notice_icon${items.notiTypeCd}.${items.remk1}">&nbsp;${kbiz:getMaxString(items.notiTitle,70)}</td>
	                       </c:otherwise>
	                   </c:choose>
						<td class="ellips">${kbiz:getDate(items.regDate)}</td>
						<td class="ellips">${items.regNm}</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${noticeList[0] eq null}">
				<tfoot>
					<tr>
						<td colspan="5">조회 결과가 없습니다.</td>
					</tr>
				</tfoot>
			</c:if>
		</table>
	</div>
	<div class="boardPagingWrap mgb20">
		<kbiz:pageNavi pageDomain="${pageDomain}" executeTargetFunction="fn_notice" submitTargetForm="noticeForm" />
	</div>
</body>
</html>