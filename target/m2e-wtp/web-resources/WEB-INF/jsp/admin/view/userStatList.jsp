<%--
 * file name    : userStatList.jsp
 * description  : 상담원별통계
 * author       : 백소영
 * initial date : 2017.11.21
 * history
  수정일자      수정자     수정내용
  2017.11.21    백소영     Initialization
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
    <div class="brd_list_minR${pageDomain.rowsPerPage }">
    <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_statlist_a hover_action">
        <colgroup>
            <col width="50px" />
            <col width="100px" />
            <col width="100px" />
            <col width="100px" />
            <col width="100px" />
            <col width="100px" />
            <col width="100px" />
            <col width="100px" />
            <col width="50px" />
        </colgroup>
        <thead>
            <tr>
                <th class="ellips" rowspan="2">상담원</th>
                <th class="ellips" colspan="7">처리구분</th>
                <th class="ellips" rowspan="2">합계</th>
            </tr>
            <tr>
                <th class="ellips">처리완료</th>
                <th class="ellips">예약</th>
                <th class="ellips">이관-상담사</th>
                <th class="ellips">이관-관리자</th>
                <th class="ellips">이관-VOC</th>
                <th class="ellips">호전환</th>
                <th class="ellips">부재중</th>
            </tr>
        </thead>
        <tbody>
           <c:if test="${resultList ne null}">
           <c:forEach items="${resultList }" var="items">
               <tr>
                   <td>${items.userNm }</td>
                   <td>${items.aCnt }건</td>
                   <td>${items.bCnt }건</td>
                   <td>${items.gCnt }건</td>
                   <td>${items.cCnt }건</td>
                   <td>${items.dCnt }건</td>
                   <td>${items.eCnt }건</td>
                   <td>${items.fCnt }건</td>
                   <td>${items.sumCnt }건</td>
               </tr>
           </c:forEach>
           </c:if>
           <c:if test="${resultList[0] eq null}">
           <tfoot>
           <tr>
               <td colspan="9" style="height:18px;">조회 결과가 없습니다.</td>
           </tr>
           </tfoot>
           </c:if>
        </tbody>
        </table>
    </div>
<div class="boardPagingWrap">
    <kbiz:pageNavi pageDomain="${pageDomain }" executeTargetFunction="fn_submit" submitTargetForm="userStatSearchForm" />
</div>