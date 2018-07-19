<%--
 * file name    : smsSendList.jsp
 * description  : SMS발송내역
 * author       : 백소영
 * initial date : 2017.11.21
 * history
  수정일자      수정자     수정내용
  2017.11.21    백소영     Initialization
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
    <h3><span class="sec_tit">SMS발송내역</span></h3>
    <div class="brd_list_minR${pageDomain.rowsPerPage }">
    <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_list_a hover_action">
        <colgroup>
            <col width="10px" />
            <col width="150px" />
            <col width="150px" />
            <col width="150px" />
            <col width="150px" />
        </colgroup>
        <thead>
           <tr>
                 <th>NO</th>
                 <th>전송일시</th>
                 <th>내용</th>
                 <th>전화번호</th>
                 <th>상담사명</th>
           </tr>
        </thead>
        <tbody>
           <c:if test="${resultList ne null}">
           <c:forEach items="${resultList }" var="items">
               <tr onclick="fn_detail('${items.sendSmsSeq }');">
                   <td>${items.rnum}</td>
                   <td>${kbiz:getDateTime(items.sendSmsDate) }</td>
                   <td class="ellips al">${kbiz:getMaxString(items.smsContent,100) }</td>
                   <td>${kbiz:getTellNumber(items.tellNum) }</td>
                   <td>${items.sendUserNm }</td>
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
    <kbiz:pageNavi pageDomain="${pageDomain }" executeTargetFunction="fn_submit" submitTargetForm="smsSendSearchForm" />
</div>