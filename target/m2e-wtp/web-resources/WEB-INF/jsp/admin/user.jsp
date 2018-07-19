<%--
 * file name    : user.jsp
 * description  : 사용자관리
 * author       : 백소영
 * initial date : 2017.11.21
 * history
  수정일자      수정자     수정내용
  2017.11.21    백소영     Initialization
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
        });

        //조회
        function fn_searchClick(){
            $("#pageIdx").val("1");
            fn_submit();
        }

        function fn_submit() {
            KBIZIO.requestViewAjax("userSearchForm", "userListView", fn_submitCallback);
        }

        function fn_submitCallback(ret) {
        	 fn_init();
        }

        //상세
        function fn_detail(seq) {
            KBIZUI.highlightTrByEvent(window.event);
        	KBIZIO.requestParamAjax("/admin/userDetail.json", fn_detailCallback, {params: {userId: seq}});
        }

        function fn_detailCallback(ret) {
            var r = ret.result;
            $("#hidUserId").val(KBIZST.toDefaultString(r.userId));
            $("#userId").text(KBIZST.toDefaultString(r.userId));
            $("#userNm").text(KBIZST.toDefaultString(r.userNm));
            $("#deptNm").text(KBIZST.toDefaultString(r.deptNm));
            $("#ofcpsNm").text(KBIZST.toDefaultString(r.ofcpsNm));
            $("#rspofcNm").text(KBIZST.toDefaultString(r.rspofcNm));
            $("#ofrmTelNo").text(KBIZST.toDefaultString(r.ofrmTelNo));
            $("#ofrmTelNo2").text(KBIZST.toDefaultString(r.ofrmTelNo2));
            $("#lognAtmpCont").text(r.lognAtmpCont);
            $("#initPswdYn").val(KBIZST.toDefaultString(r.initPswdYn));
            $("#lastLognDate").text(KBIZDT.getFormattedDate(KBIZST.toDefaultString(r.lastLognDate), "yyyy-MM-dd HH:mm:ss"));
            $("#pswdChngDate").text(KBIZDT.getFormattedDate(KBIZST.toDefaultString(r.pswdChngDate), "yyyy-MM-dd HH:mm:ss"));
            $("#callApGrade").val(KBIZST.toDefaultString(r.callApGrade));
            $("#apGrade").val(KBIZST.toDefaultString(r.apGrade));
             // 사용자등급 수정여부
                /* 상담사일경우  */
            console.log(":::::::::"+$("#apGrade").val());
            if($("#apGrade").val() == "03"){
                $("#btn_grade").hide();
                $("#callApGrade").attr("disabled",true);
                /* 시스템관리자 또는 관리자일경우   */
            }else if($("#apGrade").val() == "01" ||$("#apGrade").val() == "02"){
                $("#btn_grade").show();
                $("#callApGrade").attr("disabled",false);
            }
            //관리자가 시스템관리자의 권한은 변경못하도록..
            if($("#apGrade").val() == "02"){
            	if($("#callApGrade").val() == "01"){
            		$("#btn_grade").hide();
                    $("#callApGrade").attr("disabled",true);
            	}
            }
        }

        //사용자등급 수정
        function fn_gradeUpd(){
        	var $f = $("#userDetailForm");
            if ($("#userId").text() == '') {
                alert("사용자를 선택해주세요.");
                return;
            }
            console.log(":::::::::"+$("#callApGrade").val());

            if($("#callApGrade").val() == ""){
               alert("권한을 선택해주세요.");
               return;
            }

            if($("#apGrade").val() == "02"){
                if($("#callApGrade").val() == "01"){
                    alert("해당 권한으로 변경할수 없습니다.");
                    return;
                }
            }
            if(!confirm("사용자등급을 수정하시겠습니까?"))return;
            $f.attr("action","/admin/gradeUpdUser.json");
            KBIZIO.requestJsonAjax("userDetailForm", fn_gradeUpdCallback);
        }

        function fn_gradeUpdCallback(ret) {
            alert("사용자등급이 수정 되었습니다.");
            fn_searchClick();
        }

        //비밀번호초기화
        function fn_pwdInit(){
        	var $f = $("#userDetailForm");
        	if ($("#userId").text() == '') {
                alert("사용자를 선택해주세요.");
                return;
            }
        	if($("#initPswdYn").val() =='Y'){
        		alert('이미 비밀번호초기화가 되었습니다.');
        		return;
        	}
            if(!confirm("비밀번호를 초기화하시겠습니까?"))return;
            $f.attr("action","/admin/userPwdInit.json");
            KBIZIO.requestJsonAjax("userDetailForm", fn_pwdInitCallback);
        }

        function fn_pwdInitCallback(ret) {
            alert("비밀번호가 초기화되었습니다.");
            fn_searchClick();
        }

      //초기화
        function fn_init() {
            $("#hidUserId").val('');
            $("#userId").text('');
            $("#userNm").text('');
            $("#deptNm").text('');
            $("#rspofcNm").text('');
            $("#ofcpsNm").text('');
            $("#ofrmTelNo").text('');
            $("#ofrmTelNo2").text('');
            $("#lognAtmpCont").text('');
            $("#lastLognDate").text('');
            $("#pswdChngDate").text('');
            $("#initPswdYn").val('');
            $("#callApGrade").val('');
            $("#btn_grade").hide();
            $("#callApGrade").attr("disabled",true);
        }
    </script>
</head>
<body>
<div class="template_wrap">
<form id="userSearchForm" name="userSearchForm" method="post" action="/admin/userList.view" onsubmit="return false;">
<input type="hidden" id="pageIdx" name="pageIdx" value="1" />
<input type="hidden" id="rowsPerPage" name="rowsPerPage" value="10" />
    <div class="section">
        <h3><span class="sec_tit">사용자 검색</span></h3>
        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch">
            <colgroup>
                <col style="width:60px">
                <col style="width:180px">
                <col style="width:60px">
                <col style="width:180px">
                <col style="width:60px">
                <col style="width:180px">
                <col style="width:60px">
                <col style="width:180px">
                <col style="width:60px">
            </colgroup>
            <tr>
                <th>사용자ID</th>
                <td class="ellips"><input type="text" id="selUserId" name="selUserId" value="" onkeydown="if(event.keyCode == 13) fn_searchClick();" />
                <th>사용자명</th>
                <td class="ellips"><input type="text" id="selUserNm" name="selUserNm" value="" onkeydown="if(event.keyCode == 13) fn_searchClick();"/>
                <th>부서명</th>
                <td class="ellips"><input type="text" id="selDeptNm" name="selDeptNm" value="" onkeydown="if(event.keyCode == 13) fn_searchClick();"/>
                <th>사무실전화번호</th>
                <td class="ellips"><input type="text" id="selOfrmTelNo" name="selOfrmTelNo" value="" onkeydown="if(event.keyCode == 13) fn_searchClick();"/>
                <td class="ellips ar"><a href="#" class="btn small g_orange" onclick="fn_searchClick();">조회</a></td>
             </tr>
        </table>
    </div>
</form>
<div class="section">
    <div id="userListView">
    </div>
</div>
<div class="section"><h3><span class="sec_tit">사용자 상세보기</span></h3></div>
<div id="userDetailJson">
    <form id="userDetailForm" name="userDetailForm" method="post" onsubmit="return false;">
    <input type="hidden" id="hidUserId" name="hidUserId" value="">
    <input type="hidden" id="initPswdYn" name="initPswdYn" value="">
    <input type="hidden" id="apGrade" name="apGrade" value=""/>
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
                   <th scope="row">사용자ID</th>
                   <td id="userId"></td>
                   <th scope="row">사용자명</th>
                   <td id="userNm"></td>
                   <th scope="row">사용자등급</th>
                   <td><kbiz:commCodeSelect lcode="002" selectId="callApGrade" firstOption="ALL"/></td>
                   <th scope="row">부서명</th>
                   <td id="deptNm"></td>
               </tr>
               <tr>
                   <th scope="row">직책</th>
                   <td id="rspofcNm"></td>
                   <th scope="row">직위</th>
                   <td id="ofcpsNm"></td>
                   <th scope="row">사무실전화번호</th>
                   <td id="ofrmTelNo"></td>
                   <th scope="row">사무실전화번호2</th>
                   <td id="ofrmTelNo2"></td>
               </tr>
               <tr>
                   <th scope="row">로그인시도횟수</th>
                   <td id="lognAtmpCont"></td>
                   <th scope="row">비밀번호 변경일시</th>
                   <td id="pswdChngDate"></td>
                   <th scope="row">마지막 로그인 일시</th>
                   <td id="lastLognDate"></td>
                   <th colspan="2"></th>
               </tr>
            </tbody>
        </table>
    </form>
    </div>
    <div class="btn_area clfix">
        <div class="fr">
            <button type="button" id="btn_grade" class="btn small g_blue" onclick="fn_gradeUpd();">등급수정</button>
            <button type="button" class="btn small g_blue" onclick="fn_pwdInit();">비밀번호초기화</button>
        </div>
    </div>
</div>
</body>
</html>