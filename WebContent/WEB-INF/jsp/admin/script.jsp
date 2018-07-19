<%--
 * file name    : script.jsp
 * description  : 스크립트
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
        $("#chnlCode").change(function() {
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

        $("#mcode").change(function() {
            fn_mcode();
       });

        $("#curFile").click(function(){
            location.href="/admin/script/downloadFile.do?scrpFile="+encodeURI($("#curFile").text());
        });
    });

    //조회
    function fn_searchClick(){
        $("#pageIdx").val("1");
        $("#pageIdx2").val("1");
        fn_submit();
    }

     function fn_submit() {
        $("#scriptSearchForm").prop("action","/admin/scriptList.view");
        KBIZIO.requestViewAjax("scriptSearchForm", "scriptListView", fn_submitCallback);
    }

    function fn_submitCallback(ret) {
    	//2번째 조회 hidden값 초기화해주기
    	$("#scriptSearchForm2 #hidChnlCode2").val('');
        $("#scriptSearchForm2 #hidLcode2").val('');
        $("#scriptSearchForm2 #hidMcode2").val('');
        $("#scriptSearchForm2 #hidScode2").val('');
    	fn_submit2();
    }

    function fn_submit2() {
        $("#scriptSearchForm2").prop("action","/admin/scriptList2.view");
        KBIZIO.requestViewAjax("scriptSearchForm2", "scriptListView2", fn_submitCallback2);
    }
    function fn_submitCallback2(ret) {
        fn_init();
    }

    //인입채널 클릭 시
    function fn_selChnl(id){
		var clickId = "chnlCode";
		var checkedValue = $('#' + clickId).val();
		console.log("hidChnlCode::"+$("#scriptDetailForm #chnlCode").val());
	    if (id.indexOf('sel') != -1) {
	        /* 검색 */
	        clickId = "selChnlCode";
	        checkedValue = $('input:radio[name=' + clickId + ']:checked').val();
	    }
	   KBIZIO.requestParamAjax("/admin/scriptLcode.json", fn_lcodeCallback, {params: {chnlCode: checkedValue, targetId: id},async:false});
   }

	//대분류 가져오기
	function fn_lcodeCallback(ret, params){
	     var r = ret.result;
	     var len = r.length;
	     var option = " <option value=''>선택</option>";
         $('#scode').html(option);

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
        var clickId = "chnlCode";
        var codeId = "lcode";
        var checkedValue = $('#' + clickId).val();
         if (id.indexOf("sel") != -1) {
             /* 검색 */
             clickId = "selChnlCode";
             codeId = "selLcode";
             checkedValue = $('input:radio[name='+clickId+']:checked').val();
         }

        var lcodeValue = $("#"+codeId+" option:selected").val();
        KBIZIO.requestParamAjax("/admin/scriptMcode.json", fn_mcodeCallback, {params: {chnlCode: checkedValue,lcode: lcodeValue, targetId: id},async:false});
    }

    //중분류 가져오기
    function fn_mcodeCallback(ret, params){
    	 var r = ret.result;
         var len = r.length;
         var option = " <option value=''>선택</option>";
         $('#scode').html(option);
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


   //중분류 선택 시
   function fn_mcode(){
       var checkedValue = $('#chnlCode').val();
       var lcodeValue = $("#lcode option:selected").val();
       var mcodeValue = $("#mcode option:selected").val();

       KBIZIO.requestParamAjax("/admin/scriptScode.json", fn_scodeCallback,{params: {chnlCode: checkedValue,lcode: lcodeValue, mcode: mcodeValue},async:false});
   }

   //소분류 가져오기
   function fn_scodeCallback(ret){
        var r = ret.result;
        var len = r.length;
        var option = " <option value=''>선택</option>";
        for(var i = 0; i < len ; i++){
            option += "<option value='" + r[i].scode + "'>" + r[i].codeName + "</option>";
        }
        $('#scode').html(option);
   }


    //스크립트 리스트 클릭 시
    function fn_detail(chnlCode,lcode,mcode,scode) {
    	//2번째 리스트 페이징을 하기위해 값 셋팅
        $("#pageIdx2").val("1");
        $("#scriptSearchForm2 #hidChnlCode2").val(chnlCode);
        $("#scriptSearchForm2 #hidLcode2").val(lcode);
        $("#scriptSearchForm2 #hidMcode2").val(mcode);
        $("#scriptSearchForm2 #hidScode2").val(scode);
        KBIZUI.highlightTrByEvent(window.event);
        var options = {};
        options.params = {chnlCode:chnlCode,
                                 lcode:lcode,
                                 mcode:mcode,
                                 scode:scode
                                };
        $("#scriptSearchForm").prop("action","/admin/scriptList2.view");
        KBIZIO.requestViewAjax("scriptSearchForm2", "scriptListView2", fn_detailCallback, options);
    }

    function fn_detailCallback(ret) {
    	fn_init();
    }

    //상세보기
    function fn_detail2(scrpNo) {
        KBIZUI.highlightTrByEvent(window.event);
		var options = {};
		options.params = { scrpNo:scrpNo };
        KBIZIO.requestParamAjax("/admin/scriptDetail.json", fn_detailCallback2, options);
    }

    //상세보기 콜백
    function fn_detailCallback2(ret) {
        var r = ret.result;
        $("#scriptDetailForm #scrpNo").val(r.scrpNo);
        console.log(r.chnlCode);
        $("#scriptDetailForm #chnlCode").val(r.chnlCode);
        fn_selChnl('lcode');
        $("#scriptDetailForm #lcode").val(r.lcode);
        fn_lcode('mcode');
        $("#scriptDetailForm #mcode").val(r.mcode);
        fn_mcode();
        $("#scriptDetailForm #scode").val(r.scode);
        $("#scriptDetailForm #scrpCont").val(r.scrpCont);
        $("#scriptDetailForm #scrpTitle").val(r.scrpTitle);
        $("#scriptDetailForm #curFile").text(KBIZST.toDefaultString(r.scrpFile,''));
        $("#scriptDetailForm #chnlCode").attr("disabled",true);
        $("#scriptDetailForm #lcode").attr("disabled",true);
        $("#scriptDetailForm #mcode").attr("disabled",true);
        $("#scriptDetailForm #scode").attr("disabled",true);

        $("#scriptDetailForm #hidChnlCode").val(r.chnlCode);
        $("#scriptDetailForm #hidLcode").val(r.lcode);
        $("#scriptDetailForm #hidMcode").val(r.mcode);
        $("#scriptDetailForm #hidScode").val(r.scode);
        $("#btn_del").show();
    }

    //저장 및 수정
     function fn_save() {
    	//값 체크
    	if(!val_check())return;
        //파일확장자 체크
        if(!KBIZVA.fileExtensionChk("scrpFile"))return;

        if(!confirm("저장하시겠습니까?"))return;
        $("#scriptDetailForm").prop("action","/admin/saveScript.json");
        KBIZIO.requestJsonAjax("scriptDetailForm", fn_saveCallback);
    }

    //첨부파일 삭제 후  업데이트
    function fn_saveCallback(ret) {
     	if($("#scrpFile").val() != ""){
             var $f = $("#scriptDetailForm");
             if($("#curFile").text() != ""){
            	$f.attr("action","/admin/script/deleteFile.do?scrpFile="+encodeURI($("#curFile").text()));
            	$f.submit();
             }
             $f.attr("action","/admin/script/uploadFile.do?scrpNo="+$("#scrpNo").val());
             $f.submit();
             //fn_searchClick();
    	}
    	alert('저장되었습니다.');
    	fn_submit2();
      }

    //값 체크
    function val_check(){
    	if (KBIZVA.isNullOrEmpty($("#chnlCode").val())) {
            alert($("#chnlCode").attr("title") + "은 필수입니다.");
            $("#chnlCode").focus();
            return false;
        }
        if (KBIZVA.isNullOrEmpty($("#lcode").val())) {
            alert($("#lcode").attr("title") + "은 필수입니다.");
            $("#lcode").focus();
            return false;
        }
        if (KBIZVA.isNullOrEmpty($("#mcode").val())) {
            alert($("#mcode").attr("title") + "은 필수입니다.");
            $("#mcode").focus();
            return false;
        }
        if (KBIZVA.isNullOrEmpty($("#scode").val())) {
            alert($("#scode").attr("title") + "은 필수입니다.");
            $("#scode").focus();
            return false;
        }

        if(!KBIZVA.valCheck("scrpTitle",true))return false;
        if(!KBIZVA.valCheck("scrpCont",true))return false;

        return true;
    }

    //스크립트 삭제
    function fn_delete(){
    	if($("#scrpNo").val() == ""){
            alert('삭제 할 항목을 선택해주세요.');
            return;
        }
        if(!confirm("삭제하시겠습니까?"))return;
        var scrpNo = $("#scrpNo").val();
        KBIZIO.requestParamAjax("/admin/scriptDelete.do", fn_deleteCallback, {
             params: { scrpNo: scrpNo}, async: false});
    }

    //스크립트 삭제 후 첨부파일 삭제
    function fn_deleteCallback() {
        var $f = $("#scriptDetailForm");
        if($("#curFile").text() != ""){
        	$f.attr("action","/admin/script/deleteFile.do?scrpFile="+encodeURI($("#curFile").text()));
            $f.submit();
        }
        alert("삭제되었습니다.");
        fn_searchClick();
    }

    //검색조건 초기화여부
    var init_flag = true;
    //초기화
    function fn_init(){
        $("#lcode").val('');
        $("#mcode").val('');
        $("#scode").val('');
        $("#chnlCode").val('');
        $("#scrpTitle").val('');
        $("#scrpCont").val('');
        $("#scrpNo").val('');
        $("#curFile").text('');
        $("#btn_del").hide();
        document.scriptDetailForm.reset();
        if(init_flag){
            fn_selChnl('selLcode');
        	init_flag = false;
        }else{
            var option = " <option value=''>선택</option>";
            $('#lcode').html(option);
            $('#mcode').html(option);
            $('#scode').html(option);
        }

        $("#scriptDetailForm #hidChnlCode").val('');
        $("#scriptDetailForm #hidLcode").val('');
        $("#scriptDetailForm #hidMcode").val('');
        $("#scriptDetailForm #hidScode").val('');

        $("#chnlCode").attr("disabled",false);
        $("#lcode").attr("disabled",false);
        $("#mcode").attr("disabled",false);
        $("#scode").attr("disabled",false);
    }

</script>
</head>
<body>
<div class="admin_content">
<div class="template_wrap">
<!-- 1번째 리스트 -->
<form id="scriptSearchForm" name="scriptSearchForm" method="post" onsubmit="return false;">
<input type="hidden" id="pageIdx" name="pageIdx" value="1" />
<input type="hidden" id="rowsPerPage" name="rowsPerPage" value="5" />
    <div class="section">
        <h3><span class="sec_tit">스크립트 검색</span></h3>
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch">
            <colgroup>
                <col style="width:60px">
                <col style="width:450px">
                <col style="width:60px">
                <col style="width:100px">
                <col style="width:60px">
                <col style="width:100px">
                <col style="width:60px">
                <col style="width:200px">
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
                <th>키워드</th>
                <td class="ellips"><input type="text" id="selKeyword" name="selKeyword" value=""  onkeydown="if(event.keyCode == 13) fn_searchClick();"/></td>
                <td class="ellips ar"><a href="#" class="btn small g_orange" onclick="fn_searchClick();">조회</a></td>
             </tr>
        </table>
    </div>
</form>
<div class="section">
    <div id="scriptListView">
    </div>
</div>
<!-- 2번째 리스트 -->
<form id="scriptSearchForm2" name="scriptSearchForm2" method="post" onsubmit="return false;">
    <input type="hidden" id="pageIdx2" name="pageIdx" value="1" />
    <input type="hidden" id="rowsPerPage2" name="rowsPerPage" value="5" />
    <input type="hidden" id="hidChnlCode2" name="hidChnlCode" value="" />
    <input type="hidden" id="hidLcode2" name="hidLcode" value="" />
    <input type="hidden" id="hidMcode2" name="hidMcode" value="" />
    <input type="hidden" id="hidScode2" name="hidScode" value="" />
</form>
<div class="section">
    <div id="scriptListView2">
    </div>
</div>

<div class="section"><h3><span class="sec_tit">스크립트 상세보기</span></h3></div>
<div id="scriptDetailJson">
    <form id="scriptDetailForm" name="scriptDetailForm" enctype="multipart/form-data" method="post" action="" >
        <input type="hidden" id="scrpNo" name="scrpNo" value="" />
        <input type="hidden" id="hidChnlCode" name="hidChnlCode" value="" />
        <input type="hidden" id="hidLcode" name="hidLcode" value="" />
        <input type="hidden" id="hidMcode" name="hidMcode" value="" />
        <input type="hidden" id="hidScode" name="hidScode" value="" />
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch mgb10">
             <colgroup>
                <col style="width:60px">
                <col style="width:180px">
                <col style="width:60px">
                <col style="width:180px">
                <col style="width:60px">
                <col style="width:180px">
                <col style="width:60px">
                <col style="width:180px">
            </colgroup>
            <tbody>
               <tr>
                   <th scope="row">인입채널</th>
                   <td>
	                    <select id="chnlCode" name="chnlCode" title="인입채널">
	                        <option value="">전체</option>
	                        <c:forEach items="${selChCode}" var="ch">
	                                <option value="${ch.chnlCode}">${ch.codeName}</option>
	                        </c:forEach>
	                    </select>
                   </td>
                   <th scope="row">대분류</th>
                   <td>
                        <select id="lcode" name="lcode" title="대분류">
                            <option value="">선택</option>
                         </select>
                   </td>
                   <th scope="row">중분류</th>
                   <td>
                        <select id="mcode" name="mcode" title="중분류">
                            <option value="">선택</option>
                        </select>
                   </td>
                   <th scope="row">소분류</th>
                   <td>
                        <select id="scode" name="scode" title="소분류">
                            <option value="">선택</option>
                        </select>
                   </td>
               </tr>
               <tr>
                   <th scope="row">제목</th>
                   <td colspan="7">
                        <input type="text" id="scrpTitle" name="scrpTitle" value="" title="제목" maxlength="150">
                   </td>
               </tr>
               <tr>
                   <th scope="row">내용</th>
                   <td colspan="7">
                        <textarea rows="10" cols="11" id="scrpCont" name="scrpCont" maxlength="3000" title="내용"></textarea>
                   </td>
               </tr>
               <tr>
                   <th scope="row">첨부파일</th>
                   <td colspan="7"><input type="file" id="scrpFile" name="scrpFile"/> 현재파일 : <a href="#"><span id="curFile"></span></a></td>
               </tr>
            </tbody>
        </table>
    </form>
    </div>
    <div class="btn_area clfix">
        <div class="fr">
            <button type="button" class="btn small g_blue" onclick="fn_init();">초기화</button>
            <button type="button" class="btn small g_blue" onclick="javascript:fn_save();">저장</button>
            <button id="btn_del" type="button" class="btn small g_red" onclick="javascript:fn_delete();">삭제</button>
        </div>
    </div>
</div>
</div>
</body>
</html>