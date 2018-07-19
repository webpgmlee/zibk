<%--
 * file name    : scriptList.jsp
 * description  : 스크립트 리스트
 * author       : 백소영
 * initial date : 2017.11.20
 * history
  수정일자      수정자     수정내용
  2017.11.20    백소영     Initialization
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
    <div class="brd_list_minR${pageDomain.rowsPerPage }">
	    <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_list_a hover_action">
	        <colgroup>
	            <col width="40px" />
	            <col width="400px" />
	            <col width="100px" />
	        </colgroup>
	        <thead>
	           <tr>
	                 <th>NO</th>
	                 <th>제목</th>
	                 <th>첨부파일</th>
	           </tr>
	        </thead>
	        <tbody>
	           <c:if test="${resultList ne null}">
	           <c:forEach items="${resultList }" var="items">
	               <tr onclick="fn_detail2(${items.scrpNo});">
	                   <td class="ellips">${items.rnum }</td>
	                   <td class="ellips al">${items.scrpTitle }</td>
	                   <td class="ellips">
                            <c:if test="${items.scrpFile ne null}">
		                        <img src="/img/file_icon.gif" style="vertical-align: middle''"/>
		                    </c:if>
                       </td>
	               </tr>
	           </c:forEach>
	           </c:if>
	            <c:if test="${resultList[0] eq null}">
	            <tfoot>
	            <tr>
	                <td colspan="3" style="height:18px;">조회 결과가 없습니다.</td>
	            </tr>
	            </tfoot>
	           </c:if>
	        </tbody>
	    </table>
    </div>
<div class="boardPagingWrap">
    <kbiz:pageNavi pageDomain="${pageDomain }" executeTargetFunction="fn_submit2" submitTargetForm="scriptSearchForm2" />
</div>