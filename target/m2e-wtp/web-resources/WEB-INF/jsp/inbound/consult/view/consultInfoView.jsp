<%--
 * file name : consultInfoView.jsp
 * description : 나의상담이력뷰
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
<title>나의상담이력뷰</title>
</head>
<body>
	<div class="brd_list_minR${pageDomain.rowsPerPage}">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="brd_list_a hover_action">
			<colgroup>
				<col style="width: 40px">
				<col style="width: 240px">
				<col style="width: 300px">
				<col style="width: 150px">
				<col style="width: 150px">
				<col style="width: 150px">
			</colgroup>
			<thead>
				<tr>
					<th class="min_width40">NO</th>
					<th class="min_width125">상담일시</th>
					<th class="min_width310">내용</th>
					<th class="min_width95">고객명</th>
					<th class="min_width95">상담사</th>
					<th class="min_width75">처리구분</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="no" value="${pageDomain.fromRowPerPage}" />
				<c:forEach items="${cnltList}" var="cnlt" varStatus="cn">
					<tr onclick="fn_con_detail('${cnlt.cnltSeq}','${cnlt.cnltDetailNo}')">
						<td class="ellips">${no+cn.index}</td>
						<td class="ellips">${kbiz:getDateTime(cnlt.cnltDate)}</td>
						<td class="ellips">${kbiz:getMaxString(cnlt.recvNote,50)}</td>
						<td class="ellips">${cnlt.custNm}</td>
						<td class="ellips">${cnlt.userNm}</td>
						<td class="ellips">${cnlt.codeName}</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${cnltList[0] eq null}">
				<tfoot>
					<tr>
						<td colspan="6">조회 결과가 없습니다.</td>
					</tr>
				</tfoot>
			</c:if>
		</table>
	</div>
	<div class="boardPagingWrap mgb20">
		<kbiz:pageNavi pageDomain="${pageDomain}" executeTargetFunction="fn_searchConsultPage" submitTargetForm="consultSearchForm" />
	</div>
</body>
</html>