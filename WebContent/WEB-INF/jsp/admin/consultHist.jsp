<%--
 * file name    : consultHist.jsp
 * description  : 상담이력
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

           $("#selFromDt").val(KBIZDT.addFormattedDate(year+''+mon+''+day,'d',0));
           $("#selToDt").val(KBIZDT.addFormattedDate(year+''+mon+''+day,'d',0));
           fn_searchClick();

	       KBIZDT.setDatepicker("selFromDt");
	       KBIZDT.setDatepicker("selToDt");
	       KBIZDT.datepicker();

            $("#selChnlCode").change(function() {
                fn_selChnl();
           });
            $("#selLcode").change(function() {
                fn_lcode();
           });
            $("#selMcode").change(function() {
                fn_mcode();
           });

            $("#btn_excel").click(function(){
                $("#consultHistSearchForm").attr("action","/admin/consultHist/excel");
                document.consultHistSearchForm.submit();

//                 나중에수정할것 엑셀용
            	/* $.ajax({
                    url: "/admin/consultHist/excel"
                    , type: "POST"
                    , data: {param: "1"}
                    //, dataType: options.dataType || _JSON
                    , success: function(result, status) {
                                        alert(status);
                                        fn_excelCallback();
                                    }
                    , error: function(r, e) {
                                    alert('error');
                                }
                    , complete: function(result) {
                                        // TODO dimmed off
                                        console.log('dimmed off');
                                    }
                });

                function fn_excelCallback(){
                    alert('1111111');
                } */
            });
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
           $("#consultHistSearchForm").attr("action","/admin/consultHistList.view");
            KBIZIO.requestViewAjax("consultHistSearchForm", "consultHistListView", fn_submitCallback);
        }

        function fn_submitCallback(ret) {
        	fn_init();
        }

      //인입채널 클릭 시
        function fn_selChnl(){
        	var checkedValue = $('#selChnlCode').val();
        	KBIZIO.requestParamAjax("/admin/consultLcode.json", fn_lcodeCallback, {params: {chnlCode: checkedValue}});
       }

        //대분류 가져오기
        function fn_lcodeCallback(ret){
             var r = ret.result;
             var len = r.length;
             var option = " <option value='00'>전체</option>";
             $('#selMcode').html(option);
             $('#selScode').html(option);
             for(var i = 0; i < len ; i++){
                 option += "<option value='" + r[i].lcode + "'>" + r[i].codeName + "</option>";
             }
             $('#selLcode').html(option);
        }

      //대분류 선택 시
        function fn_lcode(){
            var checkedValue = $('#selChnlCode').val();
            var lcodeValue = $("#selLcode option:selected").val();
            KBIZIO.requestParamAjax("/admin/consultMcode.json", fn_mcodeCallback, {params: {chnlCode: checkedValue,lcode: lcodeValue}});
        }

        //중분류 가져오기
        function fn_mcodeCallback(ret){
             var r = ret.result;
             var len = r.length;
             var option = " <option value='00'>전체</option>";
             $('#selScode').html(option);
             for(var i = 0; i < len ; i++){
                 option += "<option value='" + r[i].mcode + "'>" + r[i].codeName + "</option>";
             }
             $('#selMcode').html(option);
        }

        //중분류 선택 시
        function fn_mcode(){
            var checkedValue = $('#selChnlCode').val();
            var lcodeValue = $("#selLcode option:selected").val();
            var mcodeValue = $("#selMcode option:selected").val();
            var options ={};
            options.params = {chnlCode : checkedValue,
            		                lcode : lcodeValue,
				            		mcode : mcodeValue
				            	    };
            KBIZIO.requestParamAjax("/admin/consultScode.json", fn_scodeCallback,options);
        }

        //소분류 가져오기
        function fn_scodeCallback(ret){
             var r = ret.result;
             var len = r.length;
             var option = " <option value='00'>전체</option>";
             for(var i = 0; i < len ; i++){
                 option += "<option value='" + r[i].scode + "'>" + r[i].codeName + "</option>";
             }
             $('#selScode').html(option);
        }

        function fn_detail(seq,deSeq) {
            KBIZUI.highlightTrByEvent(window.event);
        	KBIZIO.requestParamAjax("/admin/consultHistDetail.json", fn_detailCallback, {params: {cnltSeq: seq,cnltDetailNo:deSeq}});
        }

        function fn_detailCallback(ret) {
            var r = ret.result;
            $("#cnltDate").text(KBIZDT.getFormattedDate(r.cnltDate, "yyyy-MM-dd HH:mm:ss"));
            $("#userNm").text(KBIZST.toDefaultString(r.userNm,''));
            $("#custNm").text(KBIZST.toDefaultString(r.custNm,''));
            $("#tellNum").text(KBIZST.parseTell(r.tellNum));
            $("#chnlCodeName").text(KBIZST.toDefaultString(r.chnlCodeName,''));
            $("#lcodeName").text(KBIZST.toDefaultString(r.lcodeName,''));
            $("#mcodeName").text(KBIZST.toDefaultString(r.mcodeName,''));
            $("#scodeName").text(KBIZST.toDefaultString(r.scodeName,''));
            $("#cnltProcNm").text(r.cnltProcNm);
            $("#rsrvDate").text(KBIZDT.getFormattedDate(KBIZST.toDefaultString(r.rsrvDate,''), "yyyy-MM-dd HH:mm"));
            $("#tranNm").text(KBIZST.toDefaultString(r.tranNm,''));
            $("#recvNote").text(KBIZST.toDefaultString(r.recvNote,''));
            $("#procNote").text(KBIZST.toDefaultString(r.procNote,''));
            $("#recUrl").val(KBIZST.toDefaultString(r.recUrl,''));
            $("#reRecUrl").html(KBIZST.getRecSplit(KBIZST.toDefaultString(r.recUrl,'')));
            $("#cntrNo").text(KBIZST.toDefaultString(r.cntrNo,''));
            //녹취청취 display none으로 변경 후 청취 멈춤
            var wav = document.getElementById("PlayWav");
            wav.style.display = "none";
            PlayWav.Stop();
        }

        function fn_init() {
           //document.consultHistDetailForm.reset();
        	$("#cnltDate").text('');
            $("#custNm").text('');
            $("#tellNum").text('');
            $("#userNm").text('');
            $("#chnlCodeName").text('');
            $("#lcodeName").text('');
            $("#mcodeName").text('');
            $("#scodeName").text('');
            $("#cnltProcNm").text('');
            $("#rsrvDate").text('');
            $("#tranNm").text('');
            $("#recvNote").text('');
            $("#procNote").text('');
            $("#reRecUrl").text('');
            $("#recUrl").val('');
            $("#cntrNo").text('');
            //녹취청취 display none으로 변경 후 청취 멈춤
            var wav = document.getElementById("PlayWav");
            wav.style.display = "none";
            PlayWav.Stop();
        }

        //녹취파일 클릭 시 녹취청취 display inline
        function fn_recUrl(seq){
            var wav = document.getElementById("PlayWav");
            wav.style.display = "inline";
            fn_interval(seq);
        }

        //청취오류때문에 setTimeout함수 사용
        function fn_interval(seq){
            var play;
            play = setTimeout("fn_recPlay("+seq+")",300);
        }

        //실 청취듣기
        function fn_recPlay(seq){
             var m_path="http://callrec.kbiz.or.kr:8080/";
             var recArr = new Array();
             recArr = ($("#recUrl").val()).split("&");
             var path = m_path+recArr[seq];
             PlayWav.OpenURL(path);
        }
    </script>
</head>
<body>
<div class="template_wrap">
<form id="consultHistSearchForm" name="consultHistSearchForm" method="post" action="/admin/consultHistList.view" onsubmit="return false;">
<input type="hidden" id="pageIdx" name="pageIdx" value="1" />
<input type="hidden" id="rowsPerPage" name="rowsPerPage" value="10" />

    <div class="section">
        <h3><span class="sec_tit">상담이력 검색</span></h3>
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch" >
            <colgroup>
                <col style="width:60px">
                <col style="width:100px">
                <col style="width:10px">
                <col style="width:100px">
                <col style="width:60px">
                <col style="width:150px">
                <col style="width:60px">
                <col style="width:150px">
                <col style="width:60px">
                <col style="width:150px">
                <col style="width:60px">
                <col style="width:150px">
                <col style="width:20px">
            </colgroup>
            <tr>
                <th>상담일자</th>
                <td><input type="text" name="selFromDt" id="selFromDt" value="" /></td>
                <th>~</th>
                <td><input type="text" name="selToDt" id="selToDt" value="" /></td>
                 <th>고객명</th>
                <td><input type="text" id="selCustNm" name="selCustNm" value="" onkeydown="if(event.keyCode == 13) fn_searchClick();" /></td>
                <th>연락처</th>
                <td><input type="text" id="selTellNum" name="selTellNum" value="" placeholder="ex)01012345678" onkeydown="if(event.keyCode == 13) fn_searchClick();"/></td>
                 <th>상담사명</th>
                <td><input type="text" id="selUserNm" name="selUserNm" value="" onkeydown="if(event.keyCode == 13) fn_searchClick();" /></td>
                <th>처리구분</th>
                <td><kbiz:commCodeSelect lcode="001" selectId="selCnltProcCd" firstOption="ALL"  keydown="if(event.keyCode == 13) fn_searchClick();"/></td>
            </tr>
            <tr>
                <th>인입채널</th>
                <td colspan="3">
		            <select id="selChnlCode" name="selChnlCode" onkeydown="if(event.keyCode == 13) fn_searchClick();">
                        <option value="00">전체</option>
		                <c:forEach items="${selChCode}" var="ch">
		                        <option value="${ch.chnlCode}">${ch.codeName}</option>
		                </c:forEach>
		            </select>
		        </td>
                <th>대분류</th>
                <td>
                         <select id="selLcode" name="selLcode" onkeydown="if(event.keyCode == 13) fn_searchClick();">
                               <option value="">전체</option>
                           </select>
                </td>
                <th>중분류</th>
                <td>
                         <select id="selMcode" name="selMcode" onkeydown="if(event.keyCode == 13) fn_searchClick();">
                               <option value="">전체</option>
                           </select>
                </td>
                <th>소분류</th>
                <td>
                         <select id="selScode" name="selScode" onkeydown="if(event.keyCode == 13) fn_searchClick();">
                               <option value="">전체</option>
                           </select>
                </td>
                <td class="ar" colspan="2">
                    <a href="#" class="btn small g_orange" onclick="fn_searchClick();">조회</a>
                    <a href="#" id="btn_excel" class="btn small g_green" onclick="fn_submit();">엑셀</a>
                </td>
             </tr>
        </table>
    </div>
</form>

<div class="section">
    <div id="consultHistListView"></div>
</div>
<div class="section"><h3><span class="sec_tit">상담이력 상세보기</span></h3></div>
<div id="consultHistDetailJson">
    <form id="consultHistDetailForm" name="consultHistDetailForm" method="post" onsubmit="return false;">
        <input type="hidden" id="recUrl" name="recUrl" value=""/>
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch mgb10">
             <colgroup>
                <col style="width:60px">
                <col style="width:100px">
                <col style="width:60px">
                <col style="width:100px">
                <col style="width:60px">
                <col style="width:100px">
                <col style="width:60px">
                <col style="width:100px">
            </colgroup>
            <tbody>
               <tr>
                   <th scope="row">상담일시</th>
                   <td id="cnltDate"></td>
                   <th scope="row">상담사명</th>
                   <td id="userNm"></td>
                   <th scope="row">고객명</th>
                   <td id="custNm"></td>
                   <th scope="row">연락처</th>
                   <td id="tellNum"></td>
               </tr>
               <tr>
                   <th scope="row">인입채널</th>
                   <td id="chnlCodeName"></td>
                   <th scope="row">대분류</th>
                   <td id="lcodeName"></td>
                   <th scope="row">중분류</th>
                   <td id="mcodeName"></td>
                   <th scope="row">소분류</th>
                   <td id="scodeName"></td>
                </tr>
               <tr>
                   <th scope="row">계약번호</th>
                   <td id="cntrNo"></td>
                   <th scope="row">처리구분</th>
                   <td id="cnltProcNm"></td>
                   <th scope="row">처리담당자</th>
                   <td id="tranNm"></td>
                   <th scope="row">예약일시</th>
                   <td id="rsrvDate"></td>
               </tr>
               <tr>
                    <th scope="row">문의</th>
                    <td colspan="7">
                        <textarea rows="7"  id="recvNote" name="recvNote" readonly="readonly"></textarea>
                    </td>
               </tr>
               <tr>
                    <th scope="row">답변</th>
                    <td colspan="7">
                        <textarea rows="7" id="procNote" name="procNote" readonly="readonly"></textarea>
                    </td>
               </tr>
               <tr>
	                <th scope="row">녹취파일</th>
	                <td colspan="7" id="reRecUrl"></td>
               </tr>
            </tbody>
        </table>
    </form>
    </div>
     <object id='PlayWav' classid='CLSID:5474D51F-02EE-4EB5-AC97-5F27E094EE4D' width='100%' height='115' style="display: none;"></object>
</div>
</body>
</html>