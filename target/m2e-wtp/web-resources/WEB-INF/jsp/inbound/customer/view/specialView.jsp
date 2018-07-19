<%--
 * file name : specialView.jsp
 * description : 특이성향뷰
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
<title>특이성향뷰</title>
</head>
<body>
	<div class="brd_list_minR${pageDomain.rowsPerPage}">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="brd_list_a hover_action mgb30 ac mgt10">
			<colgroup>
				<col style="width: 90px;">
				<col style="width: 420px;">
				<col style="width: 90px;">
			</colgroup>
			<thead>
				<th>NO</th>
				<th>고객명</th>
				<th>특이성향</th>
				<th>등록자명</th>
			</thead>
			<tbody>
				<c:set var="no" value="${pageDomain.fromRowPerPage}" />
				<c:forEach items="${spec}" var="s" varStatus="sp">
					<tr onclick="fn_selSpecial('${s.cnltSeq}','${s.cnltDetailNo}',${sp.index})">
						<td class="ellips">${no+sp.index}</td>
						<td class="ellips">${s.csKrnNm}</td>
						<td class="spclCont ellips">${kbiz:getMaxString(s.spclCont,90)}</td>
						<td class="ellips">${s.userNm}</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${spec[0] eq null}">
				<tfoot>
					<tr>
						<td colspan="7">조회 결과가 없습니다.</td>
					</tr>
				</tfoot>
			</c:if>
		</table>
	</div>
	<div class="boardPagingWrap mgb20">
		<kbiz:pageNavi pageDomain="${pageDomain}" executeTargetFunction="fn_specialList" submitTargetForm="specialListForm" />
	</div>
</body>
</html>