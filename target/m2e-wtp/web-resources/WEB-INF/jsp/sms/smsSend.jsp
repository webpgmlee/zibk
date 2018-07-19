<%--
 * file name    : smsSend.jsp
 * description  : sms발송내역
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

            $("#selFromDt").val(KBIZDT.addFormattedDate(year+''+mon+''+day,'d',(1-day)));
            $("#selToDt").val(KBIZDT.addFormattedDate(year+''+mon+''+day,'m',0));
        	fn_searchClick();

            KBIZDT.setDatepicker("selFromDt");
            KBIZDT.setDatepicker("selToDt");
            KBIZDT.datepicker();
        });

        //조회
        function fn_searchClick(){
            $("#pageIdx").val("1");
            fn_submit();
        }

        function fn_submit() {
        	 //날짜검사
            if($("#selFromDt").val() == ""){
                alert("날짜를 입력해주세요.");
                $("#selFromDt").focus();
                return;
            }else if($("#selToDt").val() == ""){
                alert("날짜를 입력해주세요.");
                $("#selToDt").focus();
                return;
            }

            //조회기간이 앞보다 뒤가 작은지 검사
            if(KBIZDT.getDayInterval($("#selFromDt").val(),$("#selToDt").val()) < 0){
                alert("조회날짜가 잘못되었습니다.");
                return false;
            }
            //조회기간 3개월로 기간 제한
            if(KBIZDT.getDayCheck($("#selFromDt").val(),$("#selToDt").val()) > 93){
                alert('조회기간은 3개월 이내만 가능합니다. ');
                return false;
            }

           if($("#selFromDt").val().length == 10){           //날짜가 정확하게 입력되었는지 검사
                if($("#selToDt").val().length == 10){
                    //skip
                }else{
                    alert("검색할 날짜를 제대로 설정해주세요.\nex) 2018-01-01");
                    $("#selToDt").focus();
                    return;
                }
            }else{
                alert("검색할 날짜를 제대로 설정해주세요.\nex) 2018-01-01");
                $("#selFromDt").focus();
                return;
            }
           $("#selTellNum").val(KBIZST.replaceTell($("#selTellNum").val()));
            KBIZIO.requestViewAjax("smsSendSearchForm", "smsSendListView", fn_submitCallback);
        }

        function fn_submitCallback(ret) {
        	fn_init();
            console.log('------- fn_submitCallback() ---------');
        }

        function fn_detail(seq) {
            KBIZUI.highlightTrByEvent(window.event);
        	KBIZIO.requestParamAjax("/sms/smsSendDetail.json", fn_detailCallback, {params: {sendSmsSeq: seq}});
        }

        function fn_detailCallback(ret) {
            var r = ret.result;
            $("#tellNum").text(KBIZST.parseTell(r.tellNum));
            $("#sendSmsDate").text(KBIZDT.getFormattedDate(r.sendSmsDate, "yyyy-MM-dd HH:mm:ss"));
            $("#sendUserNm").text(KBIZVA.nvl(r.sendUserNm));
            $("#smsTitle").text(KBIZVA.nvl(r.smsTitle));
            $("#smsSendDetailForm #smsContent").val(r.smsContent);
        }

        function fn_init() {
            $("#tellNum").text('');
            $("#sendSmsDate").text('');
            $("#sendUserNm").text('');
            $("#smsTitle").text('');
            $("#smsSendDetailForm #smsContent").val('');
            document.smsSendDetailForm.reset();
        }
    </script>
</head>
<body>

<div class="template_wrap">
<form id="smsSendSearchForm" name="smsSendSearchForm" method="post" action="/sms/smsSendList.view" onsubmit="return false;">
<input type="hidden" id="pageIdx" name="pageIdx" value="1" />
<input type="hidden" id="rowsPerPage" name="rowsPerPage" value="10" />
    <div class="section">
        <h3><span class="sec_tit">SMS발송내역 검색</span></h3>
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch">
            <colgroup>
                <col style="width:60px">
                <col style="width:100px">
                <col style="width:10px">
                <col style="width:100px">
                <col style="width:60px">
                <col style="width:150px">
                <col style="width:450px">
            </colgroup>
            <tr>
                <th>전송일자</th>
                <td class="ellips"><input type="text" name="selFromDt" id="selFromDt" value="" /></td>
                <th>~</th>
                <td class="ellips"><input type="text" name="selToDt" id="selToDt" value="" /></td>
                <th>전화번호</th>
                <td class="ellips"><input type="text" id="selTellNum" name="selTellNum" value="" placeholder="ex)01012345678" onkeydown="if(event.keyCode == 13) fn_searchClick();" />
                <td class="ellips ar"><a href="#" class="btn small g_orange" onclick="fn_searchClick();">조회</a></td>
             </tr>
        </table>
    </div>
</form>

<div class="section">
	<div id="smsSendListView">
	</div>
</div>
<div class="section"><h3><span class="sec_tit">SMS발송내역 상세보기</span></h3></div>
<div id="smsSendDetailJson">
    <form id="smsSendDetailForm" name="smsSendDetailForm" method="post" action="" onsubmit="return false;">
        <table  width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch mgb10">
            <colgroup>
                <col style="width:60px">
                <col style="width:100px">
                <col style="width:60px">
                <col style="width:100px">
                <col style="width:60px">
                <col style="width:100px">
            </colgroup>
            <tbody>
               <tr>
                   <th scope="row">전송일시</th>
                   <td id="sendSmsDate"></td>
                   <th scope="row">전화번호</th>
                   <td id="tellNum"></td>
                   <th scope="row">상담사명</th>
                   <td id="sendUserNm"></td>
               </tr>
               <tr>
                   <th scope="row">제목</th>
                   <td colspan="5" id="smsTitle"></td>
               </tr>
               <tr>
                    <th scope="row">내용</th>
                    <td colspan="5">
                        <textarea rows="8" cols="70" id="smsContent" name="smsContent" readonly="readonly"></textarea>
                    </td>
               </tr>
            </tbody>
        </table>
    </form>
    </div>
</div>

</body>
</html>