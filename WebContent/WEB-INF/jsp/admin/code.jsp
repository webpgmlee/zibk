<%--
 * file name    : code.jsp
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
        KBIZIO.requestViewAjax("codeSearchForm", "codeListView", fn_submitCallback);
    }

    function fn_submitCallback(ret) {
        fn_init();
    }

  //대분류 조회
    function fn_initLcode(id){
        //alert($("#lcode option:selected").val());
        var codeId = "lcode";
         if (id.indexOf("sel") != -1) {
             /* 검색 */
             codeId = "selLcode";
         }
        var lcodeValue = $("#"+codeId+" option:selected").val();
        KBIZIO.requestParamAjax("/admin/commLcode.json", fn_lcodeCallback, {params: {targetId: id},async:false});
    }

    //대분류 가져오기
    function fn_lcodeCallback(ret, params){
         var r = ret.result;
         var len = r.length;

         var option = "";

         var tId = params.targetId;
         if (tId.indexOf("sel") != -1) {
             /* 검색 */
             tId = "selLcode";
         } else {
             /* 상세 */
             option += " <option value='000'>선택</option>";
             tId = "lcode"
         }
         for(var i = 0; i < len ; i++){
             option += "<option value='" + r[i].lcode + "'>" + r[i].codeName + "</option>";
         }
         $('#' + tId).html(option);
    }

    //대분류 선택 시
    function fn_lcode(id){
        var lcodeValue = $("#selLcode option:selected").val();
        KBIZIO.requestParamAjax("/admin/commMcode.json", fn_mcodeCallback, {params: {lcode: lcodeValue, targetId: id}});
    }

    //중분류 가져오기
    function fn_mcodeCallback(ret, params){
         var r = ret.result;
         var len = r.length;
         var option = " <option value='000'>선택</option>";
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
    }

    //상세보기
    function fn_detail(lcode,mcode) {
        KBIZUI.highlightTrByEvent(window.event);
        var options = {};
        options.params = {lcode:lcode,
                                 mcode:mcode
                                };
        KBIZIO.requestParamAjax("/admin/codeDetail.json", fn_detailCallback, options);
    }

    //상세보기 콜백
    function fn_detailCallback(ret) {
        $("#btn_save").text('수정');
        init_Formflag = false;
        var r = ret.result;

        $("#codeDetailForm #codeName").val(r.codeName);
        $("#codeDetailForm #lcode").val(r.lcode);
        $("#codeDetailForm #hidLcode").val(r.lcode);
        $("#codeDetailForm #mcode").val(r.mcode);
        $("#codeDetailForm #sortIdx").val(r.sortIdx);
        $("#codeDetailForm #useYn").val(r.useYn);
        $("#codeDetailForm #codeDesc").val(r.codeDesc);

        var codeVal = "";
         if( r.mcode == "00"){
            $("#codeDetailForm #code").val(r.lcode);
            codeVal = "대분류";
        }else if(r.mcode != "00"){
            $("#codeDetailForm #code").val(r.mcode);
            codeVal = "중분류";
        }
        $("#codeVal").val(codeVal);

        fn_style();
    }

    //컬럼 활성화 여부
    function fn_style(){
        if($("#btn_save").text() == "저장"){
            $("#lcode").attr("disabled", false);
            $("#code").attr("readonly", false);
            $("#codeName").attr("readonly", false);
        }else if($("#btn_save").text() == "수정"){
            $("#lcode").attr("disabled", true);
            $("#code").attr("readonly", true);
            $("#codeName").attr("readonly", true);
        }
    }

    function fn_lcodeMax(obj){
        if(obj.value == "000"){
            $("#code").attr("maxlength","3");
            $("#code").val('');
        }else if(obj.value != "000"){
            $("#code").attr("maxlength","2");
            $("#code").val('');
        }
    }

    //저장  or 수정
     function fn_save() {
        var $f = $("#codeDetailForm");
        $("input[name=chnlCode]").attr("disabled",false);
        $("#lcode").attr("disabled", false);

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

        if(init_Formflag){
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

	        if (!KBIZVA.valCheck("code",true)) return;
	        if (!KBIZVA.valCheck("codeName",true)) return;
        }
        if(!KBIZVA.valCheck("codeDesc"))return;

        if($("#lcode").val() == "000"){
        	if($("#code").val().length < 3){
                alert("코드는 숫자3자리로 입력하세요.");
                $f.find("#code").focus();
                return;
            }
        }else{
        	if($("#code").val().length < 2){
                alert("코드는 숫자2자리로 입력하세요.");
                $f.find("#code").focus();
                return;
            }
        }

        if(!confirm("저장하시겠습니까?"))return;
        //코드 중복체크
        fn_overlapCheck();
    }
     //코드 중복체크
    function fn_overlapCheck(){
        var $f = $("#codeDetailForm");
        $f.prop("action","/admin/codeCheck.json");
        KBIZIO.requestJsonAjax("codeDetailForm", fn_overLapCallback);
    }

    function fn_overLapCallback(ret) {
    	var $f = $("#codeDetailForm");
        var r = ret.result;
        if(init_Formflag){
            if(r.overlapCnt > 0){
                alert('이미 존재하는 코드입니다.');
                return;
            }else{
                $f.prop("action","/admin/saveCode.json");
            }
        }else{
            $f.prop("action","/admin/codeUpdate.json");
        }
        KBIZIO.requestJsonAjax("codeDetailForm", fn_saveCallback);
    }

    function fn_saveCallback(ret) {
        alert("저장되었습니다.");
        fn_searchClick();
    }

    var init_flag = true;       //검색조건 초기화여부
    var init_Formflag = false; //form조건 초기화여부
    //초기화
    function fn_init(){
        $("#btn_save").text('저장');
        init_Formflag = true;
        document.codeDetailForm.reset();
        $("#code").attr("maxlength","3");
        fn_style();
        if(init_flag){
            fn_initLcode('selLcode');
            fn_lcode("selMcode");
            init_flag = false;
        }
        fn_initLcode('lcode');
    }

</script>
</head>
<body>
<div class="admin_content">
<div class="template_wrap">
<form id="codeSearchForm" name="codeSearchForm" method="post" action="/admin/codeList.view" onsubmit="return false;">
<input type="hidden" id="pageIdx" name="pageIdx" value="1" />
<input type="hidden" id="rowsPerPage" name="rowsPerPage" value="10" />
    <div class="section">
        <h3><span class="sec_tit">공통코드 검색</span></h3>
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch">
            <colgroup>
                <col style="width:60px">
                <col style="width:270px">
                <col style="width:60px">
                <col style="width:270px">
                <col style="width:60px">
                <col style="width:270px">
                <col style="width:60px">
            </colgroup>
            <tr>
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
                <th>사용여부</th>
                <td class="ellips">
                      <select id="selUseYn" name="selUseYn" onkeydown="if(event.keyCode == 13) fn_searchClick();">
                            <option value="">선택</option>
                            <option value="Y">Y</option>
                            <option value="N">N</option>
                        </select>
                </td>
                <td class="ellips ar"><a href="#" class="btn small g_orange" onclick="fn_searchClick();">조회</a></td>
             </tr>
        </table>
    </div>
</form>

<div class="section">
	<div id="codeListView">
	</div>
</div>
<div class="section"><h3><span class="sec_tit">공통코드 상세보기</span></h3></div>
<div id="codeDetailJson">
    <form id="codeDetailForm" name="codeDetailForm" method="post" onsubmit="return false;">
        <input type="hidden" id="mcode" name="mcode" value="" />
        <input type="hidden" id="hidLcode" name="hidLcode" value="" />
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch mgb10">
             <colgroup>
                <col style="width:60px">
                <col style="width:180px">
                <col style="width:60px">
                <col style="width:180px">
                <col style="width:60px">
                <col style="width:180px">
            </colgroup>
            <tbody>
               <tr>
                   <th scope="row">대분류</th>
                   <td>
                        <select id="lcode" name="lcode" onchange="fn_lcodeMax(this);">
                            <option value="000">선택</option>
                         </select>
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
                   <th scope="row">코드</th>
                   <td><input type="text" id="code" name="code" title="코드" maxlength="3"/></td>
                   <th scope="row">코드명</th>
                   <td><input type="text" id="codeName" name="codeName" title="코드명" maxlength="200"/></td>
                   <th scope="row">분류</th>
                   <td><input type="text" id="codeVal" name="codeVal" readonly="readonly"/></td>
               </tr>
               <tr>
                   <th scope="row" >코드설명</th>
                   <td colspan="5"><input type="text" id="codeDesc" name="codeDesc" title="코드설명" maxlength="1000"/></td>
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