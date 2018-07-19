<%--
 * file name    : codeList.jsp
 * description  : 공통코드 리스트
 * author       : 백소영
 * initial date : 2017.11.20
 * history
  수정일자      수정자     수정내용
  2017.11.20    백소영     Initialization
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<h3><span class="sec_tit">공통코드</span></h3>
    <div class="brd_list_minR${pageDomain.rowsPerPage }">
	    <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_list_a hover_action">
	        <colgroup>
	            <col width="20px" />
	            <col width="100px" />
	            <col width="100px" />
	            <col width="100px" />
	            <col width="100px" />
	        </colgroup>
	        <thead>
	           <tr>
	                 <th>NO</th>
	                 <th>대분류</th>
	                 <th>중분류</th>
	                 <th>정렬</th>
	                 <th>사용여부</th>
	           </tr>
	        </thead>
	        <tbody>
	           <c:if test="${resultList ne null}">
	           <c:forEach items="${resultList }" var="items">
	               <tr onclick="fn_detail('${items.lcode}','${items.mcode}');">
                       <td>${items.rnum }</td>
	                   <td>${items.lcodeName }(${items.lcode })</td>
	                   <td>${items.mcodeName }(${items.mcode })</td>
	                   <td>${items.sortIdx }</td>
	                   <td>${items.useYn }</td>
	               </tr>
	           </c:forEach>
	           </c:if>
	            <c:if test="${resultList[0] eq null}">
	            <tfoot>
	            <tr>
	                <td colspan="5" style="height:18px;">조회 결과가 없습니다.</td>
	            </tr>
	            </tfoot>
	           </c:if>
	        </tbody>
	    </table>
    </div>
<div class="boardPagingWrap">
    <kbiz:pageNavi pageDomain="${pageDomain }" executeTargetFunction="fn_submit" submitTargetForm="codeSearchForm" />
</div>