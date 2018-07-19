<%--
 * file name    : userStat.jsp
 * description  : 상담원별 통계
 * author       : 백소영
 * initial date : 2017.11.20
 * history
  수정일자      수정자     수정내용
  2017.11.20    백소영     Initialization
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta name="subject" content="KBIZ">
    <meta name="author" content="KBIZ">
    <meta name="keywords" content="KBIZ">
    <meta name="description" content="KBIZ">
    <title>KBIZ</title>
    <%@ include file="/WEB-INF/jsp/comm_top.jsp"%>

    <script type="text/javascript">
         $(document).ready(function() {
            var now = new Date();
            var year= now.getFullYear();
            var mon = now.getMonth()+1;
            var day = now.getDate();

            $("#searchFromDt").val(KBIZDT.addFormattedDate(year+''+mon+''+day,'d',0));
            $("#searchToDt").val(KBIZDT.addFormattedDate(year+''+mon+''+day,'d',0));
            KBIZDT.setDatepicker("searchFromDt");
            KBIZDT.setDatepicker("searchToDt");
            KBIZDT.datepicker();
            fn_searchClick();

           //일 or 월 클릭시
            $("input:radio[name=searchDate]").click(function() {
            	fn_searchClick();
            });
           //엑셀
            $("#btn_excel").click(function(){
                var selDate = $('input:radio[name=searchDate]:checked').val();
                var selFromDt = $("#searchFromDt").val();
                var selToDt = $("#searchToDt").val();
                if(selDate =="month"){
                    selFromDt=selFromDt.substr(0,7);
                    selToDt=selToDt.substr(0,7);
                }
                selFromDt = selFromDt.replace(/\-/gi,'');
                selToDt = selToDt.replace(/\-/gi,'')
                $("#userStatSearchForm").attr("action","/admin/userStat/excel?selDate="+selDate+"&selFromDt="+selFromDt+"&selToDt="+selToDt);
                document.userStatSearchForm.submit();
            });
        });

       //조회
         function fn_searchClick(){
             $("#pageIdx").val("1");
             fn_submit();
         }

        //조회
        function fn_submit() {
            //날짜검사
            if($("#searchFromDt").val() == ""){
                alert("날짜를 입력해주세요.");
                $("#searchFromDt").focus();
                return;
            }else if($("#searchToDt").val() == ""){
                alert("날짜를 입력해주세요.");
                $("#searchToDt").focus();
                return;
            }

            //조회기간이 앞보다 뒤가 작은지 검사
            if(KBIZDT.getDayInterval($("#searchFromDt").val(),$("#searchToDt").val()) < 0){
                alert("조회날짜가 잘못되었습니다.");
                return false;
            }
            //조회기간 3개월로 기간 제한
            if(KBIZDT.getDayCheck($("#searchFromDt").val(),$("#searchToDt").val()) > 93){
                alert('조회기간은 3개월 이내만 가능합니다. ');
                return false;
            }

           if($("#searchFromDt").val().length == 10){           //날짜가 정확하게 입력되었는지 검사
                if($("#searchToDt").val().length == 10){
                    //skip
                }else{
                    alert("검색할 날짜를 제대로 설정해주세요.\nex) 2018-01-01");
                    $("#searchToDt").focus();
                    return;
                }
            }else{
                alert("검색할 날짜를 제대로 설정해주세요.\nex) 2018-01-01");
                $("#searchFromDt").focus();
                return;
            }

           var selDate = $('input:radio[name=searchDate]:checked').val();
           var selFromDt = $("#searchFromDt").val();
           var selToDt = $("#searchToDt").val();
           if(selDate =="month"){
               selFromDt=selFromDt.substr(0,7);
               selToDt=selToDt.substr(0,7);
           }
           selFromDt = selFromDt.replace(/\-/gi,'');
           selToDt = selToDt.replace(/\-/gi,'')
           $("#userStatSearchForm").attr("action","/admin/userStatList.view");
           KBIZIO.requestViewAjax("userStatSearchForm", "userStatListView","",{params : {selDate : selDate, selFromDt : selFromDt, selToDt : selToDt}});
        }
    </script>
</head>
<body>
<div class="template_wrap">
<form id="userStatSearchForm" name="userStatSearchForm" method="post" action="/admin/userStatList.view" onsubmit="return false;">
<input type="hidden" id="pageIdx" name="pageIdx" value="1" />
<input type="hidden" id="rowsPerPage" name="rowsPerPage" value="13" />
    <div class="section">
        <h3><span class="sec_tit">상담원별 검색</span></h3>
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch">
            <colgroup>
                <col style="width:60px">
                <col style="width:120px">
                <col style="width:60px">
                <col style="width:100px">
                <col style="width:10px">
                <col style="width:100px">
                <col style="width:60px">
                <col style="width:100px">
                <col style="width:400px">
            </colgroup>
            <tr>
                <th>구분</th>
                <td class="ellips">
                    &nbsp;<label><input type="radio" name="searchDate" value="date" checked="checked">일별</label>&nbsp;&nbsp;
                    <label><input type="radio" name="searchDate" value="month">월별</label>
                </td>
                <th>상담일자</th>
                <td class="ellips"><input type="text" name="searchFromDt" id="searchFromDt" value="" /></td>
                <th>~</th>
                <td class="ellips"><input type="text" name="searchToDt" id="searchToDt" value="" /></td>
                <th>상담사명</th>
                <td class="ellips"><input type="text" id="selUserNm" name="selUserNm" value=""  onkeydown="if(event.keyCode == 13) fn_searchClick();"/></td>
                <td class="ellips">
                    <a href="#" class="btn small g_orange" onclick="fn_searchClick();">조회</a>
                    <a href="#" id="btn_excel" class="btn small g_green">엑셀</a>
                  </td>
              </tr>
         </table>
     </div>
 </form>
<div class="section">
 <div id="userStatListView">
 </div>
</div>
</div>
</body>
</html>