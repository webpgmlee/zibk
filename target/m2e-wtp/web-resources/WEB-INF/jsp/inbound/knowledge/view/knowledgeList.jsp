<%--
 * file name : knowledgeList.jsp
 * description : 스크립트리스트
 * author : H.K.Lee
 * initial date : 2017.11.01
 * history
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<!doctype html>
<html>
<head>
<title>스크립트리스트</title>
</head>
<body>
<div class="brd_list_minR${pageDomain.rowsPerPage}">
<table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_list_a hover_action">
        <colgroup>
            <col style="width:70px"/>
            <col style="width:140px"/>
            <col style="width:140px"/>
            <col style="width:140px"/>
            <col style="width:140px"/>
        </colgroup>
		<thead>
        <tr>
        	<th scope="col" class="min_width65">NO</th>
            <th scope="col">대분류</th>
            <th scope="col">중분류</th>
            <th scope="col">소분류</th>
        </tr>
		</thead>
		<tbody>
		<c:set var="no" value="${pageDomain.fromRowPerPage}"/>
		<c:forEach items="${script}" var="s" varStatus="sc">
	        <tr onclick="fn_script_list('${s.chnlCode}','${s.lcode}','${s.mcode}','${s.scode}')">
	            <td class="ellips">${no+sc.index}</td>
	            <td class="ellips">${s.lcodeName}</td>
	            <td class="ellips">${s.mcodeName}</td>
	            <td class="ellips">${s.scodeName}</td>
	        </tr>
        </c:forEach>
		</tbody>
		<c:if test="${script[0] eq null}">
			<tfoot>
	        <tr>
	            <td colspan="7">검색된 결과가 없습니다.</td>
	        </tr>
			</tfoot>
		</c:if>
    </table>
    </div>
	<div class="boardPagingWrap mgb20">
		<kbiz:pageNavi pageDomain="${pageDomain}" executeTargetFunction="fn_searchScript" submitTargetForm="scriptSearchForm" />
	</div>
</body>
</html>