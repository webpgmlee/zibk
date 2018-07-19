<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
 * file name    : login.jsp
 * description  : 로그인
 * author       : 위혁
 * initial date : 2018.01.08
 * history
  수정일자      수정자     수정내용
  --%>
<!doctype html>
<html lang="ko">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
		<meta name="subject" content="KBIZ">
		<meta name="author" content="KBIZ">
		<meta name="keywords" content="KBIZ">
		<meta name="description" content="KBIZ">
		<title>KBIZ</title>
		<%@ include file="/WEB-INF/jsp/comm_top.jsp"%>

		<script type="text/javascript">
		    $(document).ready(function () {

		        /* cookie 설정 */
		        if (getCookie("chkRemUserId") == "Y") {
			        $("#userId").val(getCookie("userId"));
			        $("#ctiDevice").val(getCookie("ctiDevice"));
		            $("#chkRemUserId").prop("checked", true);
		        }

		        /* 로그인 */
		        $("#btnLogin").click(function(e) {
		            execLogin();
		        });

		        /* 비밀번호 input에서 엔터키 입력 시 로그인 실행 */
		        $("#pswd").keypress(function(e) {
		            if (e.keyCode == "13") {
		                execLogin();
		            }
		        });

		        /* 내선번호 input에서 엔터키 입력 시 로그인 실행 */
		        $("#ctiDevice").keypress(function(e) {
		            if (e.keyCode == "13") {
		                execLogin();
		            }
		        });

		        /* 내선번호 input에서 엔터키 입력 시 로그인 실행 */
		        $("#chkCtiYn").click(function(e) {
		            if ($(this).is(":checked")) {
		                $("#ctiDevice").prop("disabled", false);
		            } else {
		                $("#ctiDevice").prop("disabled", true).val("");
		            }
		        });

		        /* 비밀번호 변경 레이어 노출 */
		        $("#btnShowChngPswd").click(function(e) {
		            $("#chngPswdLayer").show();
		        });

		        /* 비밀번호 변경 실행 */
		        $("#btnExecChngPswd").click(function(e) {
		            execChngPswd();
		        });

		        /* 비밀번호 변경 취소 */
		        $("#btnCnclChngPswd").click(function(e) {
		            setUiResetChngPswd();
		        });

		        /* 비밀번호 변경 레이어 닫기 */
		        $("#btnCloseChngPswd").click(function(e) {
		            setUiResetChngPswd();
		        });

		    });

		    /* cookie 설정 */
		    function setCookie(cname, cvalue, exdays) {
		        var d = new Date();
		        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
		        var expires = "expires=" + d.toUTCString();
		        document.cookie = cname + "=" + escape(cvalue) + "; " + expires + "; path=/";
		    }

		    /* cookie 조회 */
		    function getCookie(cname) {
		        var name = cname + "=";
		        var decodedCookie = decodeURIComponent(unescape(document.cookie));
		        var ca = decodedCookie.split(';');
		        for (var i=0; i<ca.length; i++) {
		            var c = ca[i];
		            while (c.charAt(0) == ' ') {
		                c = c.substring(1);
		            }
		            if (c.indexOf(name) == 0) {
		                return c.substring(name.length, c.length);
		            }
		        }
		        return "";
		    }

		    /* cookie 삭제 */
		    function delCookie(cname) {
		        document.cookie = cname + "=; path=/";
		    }

		    /* 로그인 */
		    function execLogin() {
		        if (KBIZVA.isNullOrEmpty($("#userId").val())) {
		            alert("아이디를 입력하세요");
		            $("#userId").focus();
		            return;
		        }
		        if (KBIZVA.isNullOrEmpty($("#pswd").val())) {
		            alert("비밀번호를 입력하세요");
		            $("#pswd").focus();
		            return;
		        }
		        if ($("#chkCtiYn").is(":checked")) {
		            var v = $("#ctiDevice").val();
		            if (KBIZVA.isNullOrEmpty(v)) {
	                    alert("내선번호를 입력하세요.");
	                    $("#ctiDevice").focus();
	                    return;
	                }
		            if (KBIZVA.isNumber(v)) {
	                    alert("내선번호는 숫자만 입력 가능합니다.");
	                    $("#ctiDevice").focus();
	                    return;
		            }
		            if (v.length != 4) {
		                alert("내선번호는 4자리입니다.");
	                    $("#ctiDevice").focus();
	                    return;
		            }
		        }
		        KBIZIO.requestJsonAjax("loginForm", execLoginCallback);
		    }

		    /* 로그인 callback */
		    function execLoginCallback(ret) {
		        if (ret.resultCode == "01") {
		            /* 로그인 ID cookie 설정 */
		            if ($("#chkRemUserId").is(":checked")) {
		                setCookie("userId", $("#userId").val(), 30);
		                setCookie("ctiDevice", $("#ctiDevice").val(), 30);
		                setCookie("chkRemUserId", "Y", 30);
		            } else {
		                delCookie("userId");
		                delCookie("ctiDevice");
		                delCookie("chkRemUserId");
		            }

		            var msg = ret.resultMsg;
		            msg += "\n최종 로그인 일시: " + KBIZDT.getFormattedDate(ret.lastLognDtm, 'yyyy-MM-dd HH:mm:ss');
		            msg += "\n[콜센터 프로그램 사용 시 보안 주의사항]";
		            msg += "\n1. 임의의 고객정보 조회 금지";
		            msg += "\n2. 비밀번호 3개월마다 변경";
		            msg += "\n3. 비밀번호는 추측불가능하게 설정";
		            msg += "\n4. 장기간(3개월) 미사용 시 계정 잠김";

		            alert(msg);
		            location.href = ret.resultUrl;
// 		            var $f = $("#loginForm");
// 		            $f.attr({"action": ret.resultUrl, "onsubmit": ""});
// 		            $f.submit();
		        } else {
		            $("#pswd").val("");
		            alert(ret.resultMsg);
		            if (ret.resultCode == "12" || ret.resultCode == "13") {
		                $("#chngPswdLayer").show();
		            }
		        }
		    }

		    /* 비밀번호 변경 레이어 초기화 */
		    function setUiResetChngPswd() {
		        $("#chngPswdLayer input").val("");
	            $("#chngPswdLayer").hide();
		    }

		    /* 비밀번호 변경 */
		    function execChngPswd() {
		        if (KBIZVA.isNullOrEmpty($("#chngUserId").val())) {
                    alert("비밀번호를 변경할 아이디를 입력하세요");
                    $("#chngUserId").focus();
                    return;
                }
                if (KBIZVA.isNullOrEmpty($("#chngPswd").val())) {
                    alert("기존 비밀번호를 입력하세요");
                    $("#chngPswd").focus();
                    return;
                }

                var chngNewPswd = $("#chngNewPswd").val();
                if (KBIZVA.isNullOrEmpty(chngNewPswd)) {
                    alert("신규 비밀번호를 입력하세요");
                    $("#chngNewPswd").focus();
                    return;
                }

//                 if (chngNewPswd.length < 6 || chngNewPswd > 12) {
//                     alert("비밀번호는 6~12자리로 입력하세요.");
//                     $("#chngNewPswd").focus();
//                     return;
//                 }

//                 if (KBIZVA.isIdChk(chngNewPswd)) {
//                     alert("비밀번호는 영문(A~Z, a~z) 및 숫자(0~9)만 사용 가능합니다.");
//                     $("#chngNewPswd").focus();
//                     return;
//                 }

//                 var isContainEng = false, isContainNum = false;
//                 var regEx = /[A-Za-z]/g;
//                 if (regEx.test(chngNewPswd)) {
//                     isContainEng = true;
//                 }
//                 regEx = /[0-9]/g;
//                 if (regEx.test(chngNewPswd)) {
//                     isContainNum = true;
//                 }

//                 if (!isContainEng) {
//                     alert("비밀번호는 영문(A~Z, a~z)을 반드시 포함해야합니다.");
//                     $("#chngNewPswd").focus();
//                     return;
//                 }

//                 if (!isContainNum) {
//                     alert("비밀번호는 숫자(0~9)를 반드시 포함해야합니다.");
//                     $("#chngNewPswd").focus();
//                     return;
//                 }

                var regNum = /[0-9]/;
                var regEng = /[a-zA-Z]/;
                var regSpc = /[~!@\#$%<>^&*]/;

                if ((!regNum.test(chngNewPswd) || !regEng.test(chngNewPswd) || !regSpc.test(chngNewPswd)
                        || chngNewPswd.length < 6 || chngNewPswd.length > 12)) {
                    alert("비밀번호는 영문/숫자/특수기호를 포함하여 6자리이상 12자리 이하로 입력하여야 합니다.");
                    $("#chngNewPswd").focus();
                    return;
                }

                if (chngNewPswd.indexOf($("#chngUserId").val()) > -1) {
                    alert("비밀번호는 추측이 가능한 사용자 아이디를 포함할 수 없습니다.");
                    $("#chngNewPswd").focus();
                    return;
                }

				// 동일 숫자 5자리 이상, 동일 문자 3자리 이상이면 안됨
				var chkCnt = 3;     // 동일/연속 값 체크 카운트
				var sign = 1;
				var crCh, nxCh;
				for (var i = 0; i < chngNewPswd.length; i++) {
				    if (regNum.test(chngNewPswd.charAt(i))
				            || regEng.test(chngNewPswd.charAt(i))) {
					    crCh = chngNewPswd.charCodeAt(i);
					    for (var j = i + 1; j < i + chkCnt; j++) {
					        if (regSpc.test(chngNewPswd.charAt(j))) { break; }
					        nxCh = chngNewPswd.charCodeAt(j);
					        /* 동일 값 */
					        if (crCh == nxCh) {
					            if (k == chkCnt) {
					                alert("비밀번호에 3번 이상 동일한 문자가 입력되었습니다.\n비밀번호는 추측하기 어려운 비밀번호로 설정하여야 합니다.");
					                return;
					            }
					        } else {
					            break;
					        }
					    }
					    for (var j = i + 1, k = 1; j < i + chkCnt; j++, k++) {
                            if (regSpc.test(chngNewPswd.charAt(j))) { break; }
                            nxCh = chngNewPswd.charCodeAt(j);
                            var diff = nxCh - crCh;
                            if (diff != 0) {
                                var sign = diff / Math.abs(diff);
                                /* 연속 값 */
                                if (crCh + (k * sign) == nxCh) {
                                    if ((k + 1) == chkCnt) {
                                        alert("비밀번호에 3번 이상 연속된 문자가 입력되었습니다.\n비밀번호는 추측하기 어려운 비밀번호로 설정하여야 합니다.");
                                        return;
                                    }
                                } else {
                                    break;
                                }
                            }
                        }
				    }
				}

                if (KBIZVA.isNullOrEmpty($("#chngCnfmNewPswd").val())) {
                    alert("신규 비밀번호 확인을 입력하세요");
                    $("#chngCnfmNewPswd").focus();
                    return;
                }
                if ($("#chngNewPswd").val() != $("#chngCnfmNewPswd").val()) {
                    alert("신규 비밀번호와 신규 비밀번호 확인이 일치하지 않습니다.");
                    $("#chngCnfmNewPswd").focus();
                    return;
                }
                KBIZIO.requestJsonAjax("chngPswdForm", execChngPswdCallback);
		    }

		    /* 비밀번호 변경 callback */
		    function execChngPswdCallback(ret) {
		        var result = ret.result;

		        alert(result.resultMsg);
                if (result.resultCode == "01") {
                    setUiResetChngPswd();
                }
		    }

		    function exVoc() {
		        var ret = KBIZIO.requestParamAjax("https://vocapit.kbiz.or.kr/api/call/vocReg", null, {async: false, params: {cstNm: "cstNm", neesType: "01", tit: "testTit", qstnCntn: "testQstnCntn", callSeq: "20180122000001", callDtlSeq: "1", wrkDvn: "001"}});
		        console.log('ret', ret);
		    }

		</script>
	</head>
	<body>
		<div class="wrap2">
		    <div class="login_wrap">
		        <div class="gbcover"></div>
                <form name="loginForm" id="loginForm" action="/execLogin.json" method="post" onsubmit="return false;">
			        <div class="inner_box">
			            <dl>
			                <dt><img src="img/login_logo2.png"></dt>
			                <dd><input name="userId" id="userId" type="text" title="아이디" maxlength="32" placeholder="아이디를 입력하세요"></dd>
			                <dd><input name="pswd" id="pswd" type="password" title="비밀번호" maxlength="12" placeholder="비밀번호를 입력하세요"></dd>
			                <dd><input name="ctiDevice" id="ctiDevice" type="text" title="내선번호" maxlength="4" placeholder="내선번호를 입력하세요"></dd>
			                <dd><input name="btnLogin" id="btnLogin" type="button" title="로그인" class="btn xlarge orange brdronone" value="로그인" style="width:100%; text-align:center; cursor:pointer"></dd>
			                <dd class="clfix pdt10">
			                    <label class="fl"><input name="chkRemUserId" id="chkRemUserId" type="checkbox" value="" style="vertical-align:middle" checked="checked"> 아이디 기억하기</label>
			                    <label class="fl mgl05"><input name="ctiYn" id="chkCtiYn" type="checkbox" value="Y" style="vertical-align:middle" checked="checked"> CTI LOGIN</label>
			                    <a href="#pwchange" class="fr btn-example" id="btnShowChngPswd">비밀번호변경</a>
			                </dd>
			                <dd class="pdb00 pdt30"><p>이곳은 중소기업중앙회 노란우산공제 고객센터입니다.<br>대표전화 : 1666-9988</p></dd>
			            </dl>
			        </div>
                </form>
		    </div>
		</div>
		<!--비밀번호변경 모달창//-->
		<div class="dim-layer" id="chngPswdLayer">
		    <div class="dimBg"></div>
		    <div id="pwchange" class="pop-layer">
		        <div class="pop-header"><h1>비밀번호변경</h1><button type="button" class="closeBtn" id="btnCloseChngPswd"><img src="img/btn_layer_close.gif"></button></div>
		        <div class="pop-container">
		            <div class="pop-conts">
		                <!--content //-->
		                <div class="boardListWrap" style="width:360px;">
		                    <form name="chngPswdForm" id="chngPswdForm" action="/execChngPswd.json" method="post" onsubmit="return false;">
			                    <table border="0" cellspacing="0" cellpadding="0" class="brd_sch">
			                        <colgroup>
			                            <col style="width:100px">
			                            <col style="width:">
			                        </colgroup>
			                        <tr>
			                            <th>아이디</th>
			                            <td><input type="text" name="chngUserId" id="chngUserId" title="아이디" placeholder="아이디를 입력하세요." /></td>
			                        </tr>
			                        <tr>
			                            <th>현재 비밀번호</th>
			                            <td><input type="password" name="chngPswd" id="chngPswd" title="현재 비밀번호" placeholder="현재 비밀번호를 입력하세요" /></td>
			                        </tr>
			                        <tr>
			                            <th>신규 비밀번호</th>
			                            <td><input type="password" name="chngNewPswd" id="chngNewPswd" title="신규 비밀번호" maxlength="12" placeholder="신규 비밀번호를 입력하세요" /></td>
			                        </tr>
			                        <tr>
			                            <th>비밀번호 확인</th>
			                            <td><input type="password" name="chngCnfmNewPswd" id="chngCnfmNewPswd" title="신규 비밀번호 확인" maxlength="12" placeholder="신규 비밀번호를 다시 입력하세요" /></td>
			                        </tr>
			                    </table>
		                    </form>
		                </div>
		                <div class="btn_area" style="text-align:center">
		                    <a href="#chng" class="btn small g_blue" id="btnExecChngPswd"><span class="buttonStyleText">변경</span></a> <a href="#cncl" class="btn small g_blue" id="btnCnclChngPswd"><span class="buttonStyleText">취소</span></a>
		                </div>
		                <!--// content-->
		            </div>
		        </div>
		        <!--<div class="pop-footer">
		            <a href="#stop" class="btn_type1"><span class="buttonStyleText">확인</span></a><a href="#stop" class="btn_type1"><span class="buttonStyleText">삭제</span></a><a href="#stop" class="btn_type1 closeBtn"><span class="buttonStyleText">닫기</span></a>
		        </div>-->
		    </div>
		</div>
	</body>
</html>