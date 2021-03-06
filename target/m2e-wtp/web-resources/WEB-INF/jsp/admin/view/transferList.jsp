<%--
 * file name    : transferList.jsp
 * description  : 이관내역
 * author       : 백소영
 * initial date : 2017.11.21
 * history
  수정일자      수정자     수정내용
  2017.11.21    백소영     Initialization
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<h3><span class="sec_tit">이관내역</span></h3>
    <div class="brd_list_minR${pageDomain.rowsPerPage }">
	    <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_list_a hover_action">
	        <colgroup>
	            <col width="10px" />
	            <col width="100px" />
                <col width="10px" />
	            <col width="100px" />
	            <col width="100px" />
                <col width="100px" />
                <col width="100px" />
                <col width="100px" />
                <col width="100px" />
                <col width="100px" />
                <col width="100px" />
                <col width="100px" />
	        </colgroup>
	        <thead>
	           <tr>
	                 <th>NO</th>
	                 <th>상담일시</th>
                     <th></th>
	                 <th>상담사명</th>
	                 <th>고객명</th>
	                 <th>연락처</th>
                     <th>처리담당자</th>
                     <th>인입구분</th>
                     <th>인입채널</th>
                     <th>대분류</th>
                     <th>중분류</th>
                     <th>소분류</th>
	           </tr>
	        </thead>
	        <tbody>
	           <c:if test="${resultList ne null}">
	           <c:forEach items="${resultList }" var="items">
	                <tr onclick="fn_detail(${items.cnltSeq},${items.cnltDetailNo});" >
	                   <td class="ellips">${items.rnum}</td>
	                   <td class="ellips">${kbiz:getDateTime(items.cnltDate) }</td>
                       <td class="ellips">
                            <c:if test="${ items.recUrl ne  null}">
                            <img src="/img/icon_speaker_in.gif" style="vertical-align: middle;">
                            </c:if>
                       </td>
	                   <td class="ellips">${items.userNm}</td>
	                   <td class="ellips">${items.custNm }</td>
	                   <td class="ellips">${kbiz:getTellNumber(items.tellNum) }</td>
                       <td class="ellips">${items.tranNm }</td>
                       <td class="ellips">
                       <c:if test="${items.ioType eq 'I'}">IN</c:if>
                       <c:if test="${items.ioType eq 'O'}">OUT</c:if>
                       <c:if test="${items.ioType eq 'C'}">CALLBACK</c:if>
                       </td>
                       <td class="ellips">${items.chnlCodeName }</td>
                       <td class="ellips">${items.lcodeName }</td>
                       <td class="ellips">${items.mcodeName }</td>
                       <td class="ellips">${items.scodeName }</td>
	               </tr>
	           </c:forEach>
	           </c:if>
	            <c:if test="${resultList[0] eq null}">
	            <tfoot>
	            <tr>
	                <td colspan="12" style="height:18px;">조회 결과가 없습니다.</td>
	            </tr>
	            </tfoot>
	           </c:if>
	        </tbody>
	    </table>
   </div>
<div class="boardPagingWrap">
    <kbiz:pageNavi pageDomain="${pageDomain }" executeTargetFunction="fn_submit" submitTargetForm="transferSearchForm" />
</div>