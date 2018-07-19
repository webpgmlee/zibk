<%--
 * file name    : channelCode.jsp
 * description  : 인입채널코드
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
        fn_searchClick();

        $("input:radio[name=chnlCode]").click(function() {
            fn_selChnl('lcode');
       });
        $("input:radio[name=selChnlCode]").click(function() {
            fn_selChnl('selLcode');
       });

        $("#lcode").change(function() {
            fn_lcode('mcode');
       });
        $("#selLcode").change(function() {
            fn_lcode('selMcode');
       });
    });
    //조회
    function fn_searchClick(){
        $("#pageIdx").val("1");
        fn_submit();
    }

    function fn_submit() {
        KBIZIO.requestViewAjax("channelCodeSearchForm", "channelCodeListView", fn_submitCallback);
    }

    function fn_submitCallback(ret) {
        fn_init();
    }

    //인입채널 클릭 시
    function fn_selChnl(id){
    	var clickId = "chnlCode";
        if (id.indexOf('sel') != -1) {
            /* 검색 */
            clickId = "selChnlCode";
        }
    	var checkedValue = $('input:radio[name=' + clickId + ']:checked').val();
//     	var options = {};
//     	options.params = {};
//     	options.async = false;
        KBIZIO.requestParamAjax("/admin/channelLcode.json", fn_lcodeCallback, {params: {chnlCode: checkedValue, targetId: id},async:false});
   }

    //대분류 가져오기
    function fn_lcodeCallback(ret, params){
    	 var r = ret.result;
    	 var len = r.length;
    	 var option = " <option value='00'>선택</option>";

    	 var tId = params.targetId;
    	 if (tId.indexOf('sel') != -1) {
    		 /* 검색 */
    		 $('#selMcode').html(option);
    		 tId = "selLcode";
    	 } else {
    		 /* 상세 */
    		 $('#mcode').html(option);
    		 tId = "lcode";
    	 }
         for(var i = 0; i < len ; i++){
        	 option += "<option value='" + r[i].lcode + "'>" + r[i].codeName + "</option>";
         }
         $('#' + tId).html(option);
    }

    //대분류 선택 시
    function fn_lcode(id){
        //alert($("#lcode option:selected").val());
        var clickId = "chnlCode";
        var codeId = "lcode";
         if (id.indexOf("sel") != -1) {
             /* 검색 */
             clickId = "selChnlCode";
             codeId = "selLcode";
         }

        var checkedValue = $('input:radio[name='+clickId+']:checked').val();
    	var lcodeValue = $("#"+codeId+" option:selected").val();
        KBIZIO.requestParamAjax("/admin/channelMcode.json", fn_mcodeCallback, {params: {chnlCode: checkedValue,lcode: lcodeValue, targetId: id},async:false});
    }

    //중분류 가져오기
    function fn_mcodeCallback(ret, params){
         var r = ret.result;
         var len = r.length;
         var option = " <option value='00'>선택</option>";
         for(var i = 0; i < len ; i++){
             option += "<option value='" + r[i].mcode + "'>" + r[i].codeName + "</option>";
         }
         var tId = params.targetId;
         if (tId.indexOf("sel") != -1) {
             /* 검색 */
             tId = "selMcode";
         } else {
             /* 상세 */
             tId = "mcode"
         }
         $('#' + tId).html(option);
         console.log('fn_mcodeCallback');

    }

    //상세보기
    function fn_detail(chnlCode,lcode,mcode,scode) {
        KBIZUI.highlightTrByEvent(window.event);
		var options = {};
		options.params = {chnlCode: chnlCode,
				                 lcode:lcode,
				                 mcode:mcode,
				                 scode:scode
				                };
        KBIZIO.requestParamAjax("/admin/channelCodeDetail.json", fn_detailCallback, options);
    }

    //상세보기 콜백
    function fn_detailCallback(ret) {
        $("#btn_save").text('수정');
        init_flag = false;
        var r = ret.result;

        $("input:radio[name='chnlCode']:radio[value='"+r.chnlCode+"']").prop('checked', true);
        $("#channelCodeDetailForm #codeName").val(r.codeName);
        fn_selChnl('lcode');
        $("#channelCodeDetailForm #lcode").val(r.lcode);
        fn_lcode('mcode');
        $("#channelCodeDetailForm #mcode").val(r.mcode);
        $("#channelCodeDetailForm #scode").val(r.scode);
        $("#channelCodeDetailForm #regNm").val(r.regNm);
        $("#channelCodeDetailForm #regDate").val(r.regDate);
        $("#channelCodeDetailForm #sortIdx").val(r.sortIdx);
        $("#channelCodeDetailForm #useYn").val(r.useYn);
        $("#channelCodeDetailForm #callGbCd").val(r.callGbCd);

        var codeVal = "";
        if(r.lcode == "00" && r.mcode == "00" && r.scode == "00"){
            $("#channelCodeDetailForm #code").val(r.chnlCode);
            codeVal = "인입채널코드";
        }else if( r.mcode == "00" && r.scode == "00"){
        	$("#channelCodeDetailForm #code").val(r.lcode);
        	codeVal = "대분류";
        }else if(r.mcode != "00" && r.scode == "00"){
            $("#channelCodeDetailForm #code").val(r.mcode);
            codeVal = "중분류";
        }else if(r.mcode != "00" && r.scode != "00"){
            $("#channelCodeDetailForm #code").val(r.scode);
            codeVal = "소분류";
        }else{
        }
        $("#codeVal").val(codeVal);

        fn_style();
    }

    //컬럼 활성화 여부
    function fn_style(){
    	if($("#btn_save").text() == "저장"){
            $("input[name=chnlCode]").attr("disabled",false);
            $("#lcode").attr("disabled", false);
            $("#mcode").attr("disabled", false);
            $("#code").attr("readonly", false);
            $("#codeName").attr("readonly", false);
    	}else if($("#btn_save").text() == "수정"){
            $("input[name=chnlCode]").attr("disabled",true);
            $("#lcode").attr("disabled", true);
            $("#mcode").attr("disabled", true);
            $("#code").attr("readonly", true);
            $("#codeName").attr("readonly", true);
        }
    }

    //저장  or 수정
     function fn_save() {
        var $f = $("#channelCodeDetailForm");
        $("input[name=chnlCode]").attr("disabled",false);
        $("#lcode").attr("disabled", false);
        $("#mcode").attr("disabled", false);

        if (KBIZVA.isNullOrEmpty($.trim($f.find("#useYn").val())) == true) {
            alert($f.find("#useYn").attr("title") + "는 필수입니다.");
            $f.find("#useYn").focus();
            return;
        }

        if (KBIZVA.isNullOrEmpty($f.find("#sortIdx").val()) == true) {
            alert($f.find("#sortIdx").attr("title") + "는 필수입니다.");
            $f.find("#sortIdx").focus();
            return;
        }

        if (KBIZVA.isNumber($f.find("#sortIdx").val())) {
            alert($f.find("#sortIdx").attr("title") + "는 숫자만 입력 가능합니다.");
            $f.find("#sortIdx").focus();
            return;
        }
        if (KBIZVA.isNullOrEmpty($.trim($f.find("#callGbCd").val())) == true) {
            alert($f.find("#callGbCd").attr("title") + "는 필수입니다.");
            $f.find("#callGbCd").focus();
            return;
        }

        if(init_flag) {
            if (KBIZVA.isNullOrEmpty($f.find("#code").val()) == true) {
                alert($f.find("#code").attr("title") + "는 필수입니다.");
                $f.find("#code").focus();
                return;
            }
        	 if (KBIZVA.isNumber($f.find("#code").val())) {
                 alert($f.find("#code").attr("title") + "는 숫자만 입력 가능합니다.");
                 $f.find("#code").focus();
                 return;
             }
	        if (!KBIZVA.valCheck("codeName",true)) return;
        }

        if($("#code").val().length < 2){
            alert("코드는 숫자2자리로 입력하세요.");
            $f.find("#code").focus();
            return;
        }

        if(!confirm("저장하시겠습니까?"))return;
        //코드 중복체크
        fn_overlapCheck();
    }
     //코드 중복체크
    function fn_overlapCheck(){
        var $f = $("#channelCodeDetailForm");
        $f.prop("action","/admin/channelCodeCheck.json");
        KBIZIO.requestJsonAjax("channelCodeDetailForm", fn_overLapCallback);
    }

    function fn_overLapCallback(ret) {
        var $f = $("#channelCodeDetailForm");
        var r = ret.result;
        if(init_flag) {
        	if(r.overlapCnt > 0){
                alert('이미 존재하는 코드입니다.');
                return;
            }else{
                $f.prop("action","/admin/saveChannelCode.json");
            }
        }else{
        	$f.prop("action","/admin/channelCodeUpdate.json");
        }
        KBIZIO.requestJsonAjax("channelCodeDetailForm", fn_saveCallback);
    }

    function fn_saveCallback(ret) {
        alert("저장되었습니다.");
        fn_searchClick();
    }

    var init_selFlag = true;//검색조건 초기화여부
    var init_flag = false;   //FORM 초기화여부
    //초기화
    function fn_init(){
        $("#btn_save").text('저장');
    	document.channelCodeDetailForm.reset();
        fn_style();
        if(init_selFlag){
            fn_selChnl('selLcode');
            init_selFlag = false;
        }
        fn_selChnl('lcode');
        init_flag= true;
    }

</script>
</head>
<body>
<div class="admin_content">
<div class="template_wrap">
<form id="channelCodeSearchForm" name="channelCodeSearchForm" method="post" action="/admin/channelCodeList.view" onsubmit="return false;">
<input type="hidden" id="pageIdx" name="pageIdx" value="1" />
<input type="hidden" id="rowsPerPage" name="rowsPerPage" value="10" />
    <div class="section">
        <h3><span class="sec_tit">인입채널코드 검색</span></h3>
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch">
            <colgroup>
                <col style="width:60px">
                <col style="width:450px">
                <col style="width:60px">
                <col style="width:150px">
                <col style="width:60px">
                <col style="width:150px">
                <col style="width:60px">
                <col style="width:150px">
                <col style="width:60px">
            </colgroup>
            <tr>
                <th>인입채널</th>
                <td class="ellips">
                   <label><input type="radio" name="selChnlCode" value="A" checked="checked">노란우산공제</label>
                   <label><input type="radio" name="selChnlCode" value="B">공제기금</label>
                   <label><input type="radio" name="selChnlCode" value="C">공공구매</label>
                   <label><input type="radio" name="selChnlCode" value="D">대표착신</label>
                   <label><input type="radio" name="selChnlCode" value="E">경영지원단</label>
               </td>
                <th>대분류</th>
                <td class="ellips">
                     <select id="selLcode" name="selLcode" onkeydown="if(event.keyCode == 13) fn_searchClick();">
                           <option value="">선택</option>
                       </select>
                </td>
                <th>중분류</th>
                <td class="ellips">
                     <select id="selMcode" name="selMcode" onkeydown="if(event.keyCode == 13) fn_searchClick();">
                           <option value="">선택</option>
                       </select>
                </td>
                <th>콜구분코드</th>
                   <td class="ellips"><kbiz:commCodeSelect lcode="005" selectId="selCallGb" firstOption="SEL" title="콜구분코드" keydown="if(event.keyCode == 13) fn_searchClick();"/></td>
                <td class="ellips ar"><a href="#" class="btn small g_orange" onclick="fn_searchClick();">조회</a></td>
             </tr>
        </table>
    </div>
</form>

<div class="section">
	<div id="channelCodeListView">
	</div>
</div>
<div class="section"><h3><span class="sec_tit">인입채널코드 상세보기</span></h3></div>
<div id="channelCodeDetailJson">
    <form id="channelCodeDetailForm" name="channelCodeDetailForm" method="post" onsubmit="return false;">
        <input type="hidden" id="scode" name="scode" value="" />
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch mgb10">
             <colgroup>
                <col style="width:60px">
                <col style="width:150px">
                <col style="width:60px">
                <col style="width:150px">
                <col style="width:60px">
                <col style="width:150px">
                <col style="width:60px">
                <col style="width:150px">
            </colgroup>
            <tbody>
               <tr>
                   <th scope="row">인입채널코드</th>
                   <td colspan="3">
	                   <label><input type="radio" name="chnlCode" value="A" checked="checked">노란우산공제</label>
	                   <label><input type="radio" name="chnlCode" value="B">공제기금</label>
	                   <label><input type="radio" name="chnlCode" value="C">공공구매</label>
	                   <label><input type="radio" name="chnlCode" value="D">대표착신</label>
	                   <label><input type="radio" name="chnlCode" value="E">경영지원단</label>
                   </td>
                   <th scope="row">사용여부</th>
                   <td>
                        <select id="useYn" name="useYn" title="사용여부">
                            <option value="">선택</option>
                            <option value="Y">Y</option>
                            <option value="N">N</option>
                        </select>
                   </td>
                   <th scope="row">정렬</th>
                   <td><input type="text" id="sortIdx" name="sortIdx" title="정렬" maxlength="2"/></td>
               </tr>
               <tr>
                   <th scope="row">대분류</th>
                   <td>
                        <select id="lcode" name="lcode">
                            <option value="00">선택</option>
				         </select>
                   </td>
                   <th scope="row">중분류</th>
                   <td>
                        <select id="mcode" name="mcode">
                            <option value="00">선택</option>
                        </select>
                   </td>
                   <th scope="row">콜구분코드</th>
                   <td><kbiz:commCodeSelect lcode="005" selectId="callGbCd" firstOption="SEL" title="콜구분코드"/></td>
                   <th scope="row">분류</th>
                   <td><input type="text" id="codeVal" name="codeVal" readonly="readonly"/></td>
               </tr>
               <tr>
                   <th scope="row">코드</th>
                   <td><input type="text" id="code" name="code" title="코드" maxlength="2"/></td>
                   <th scope="row">코드명</th>
                   <td><input type="text" id="codeName" name="codeName" title="코드명" maxlength="200"/></td>
                   <th colspan="4">
               </tr>
               <tr>
               </tr>
            </tbody>
        </table>
    </form>
    </div>
    <div class="btn_area clfix">
        <div class="fr">
            <button type="button" class="btn small g_blue" onclick="fn_init();">초기화</button>
            <button id="btn_save" type="button" class="btn small g_blue" onclick="fn_save();">저장</button>
        </div>
    </div>
</div>
</div>
</body>
</html>