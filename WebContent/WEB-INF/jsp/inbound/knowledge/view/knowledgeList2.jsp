<%--
 * file name    : scriptList.jsp
 * description  : 스크립트 리스트
 * author       : 이한결
 * initial date : 2017.11.20
 * history
  수정일자      수정자     수정내용
  2017.11.20    백소영     Initialization
  2017.02.08    이한결     Initialization
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
    <div class="brd_list_minR${pageDomain.rowsPerPage }">
	    <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_list_a hover_action">
	        <colgroup>
	            <col width="65px" />
	            <col width="300px" />
	            <col width="100px" />
	        </colgroup>
	        <thead>
	           <tr>
	                 <th class="min_width65">NO</th>
	                 <th>제목</th>
	                 <th>첨부파일</th>
	           </tr>
	        </thead>
	        <tbody>
	           <c:if test="${script2 ne null}">
	           <c:forEach items="${script2}" var="sc">
	               <tr onclick="fn_script_detail(${sc.scrpNo});">
	                   <td class="ellips">${sc.rnum}</td>
	                   <td class="ellips al">${kbiz:getMaxString(sc.scrpTitle,60) }</td>
	                   <td class="ellips">
                            <c:if test="${sc.scrpFile ne null}">
		                        <img src="/img/file_icon.gif" style="vertical-align: middle''"/>
		                    </c:if>
                       </td>
	               </tr>
	           </c:forEach>
	           </c:if>
	            <c:if test="${script2[0] eq null}">
	            <tfoot>
	            <tr>
	                <td colspan="4" style="height:18px;">조회 결과가 없습니다.</td>
	            </tr>
	            </tfoot>
	           </c:if>
	        </tbody>
	    </table>
    </div>
<div class="boardPagingWrap">
    <kbiz:pageNavi pageDomain="${pageDomain}" executeTargetFunction="fn_script_list2" submitTargetForm="scriptSearchForm2" />
</div>