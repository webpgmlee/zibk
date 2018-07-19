<!--
 * file name    : left.jsp
 * description  : left menu
 * author       : wihyeok
 * initial date : 2017.11.20
 * history
  수정일자      수정자 수정내용
  -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<!DOCTYPE HTML>
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
	$(function(){
		$("a").click(function(){
			var con=false;
			var menu = $(this).text();
			if(typeof(parent.mainFrame.conFrame) != "undefined"){
				if(!KBIZVA.isNullOrEmpty($("#callbackSeq", parent.mainFrame.conFrame.document).val())){
					con = confirm("**저장되지 않은 콜백 상담내역이 있습니다.**\n저장하지 않을 경우 콜백이 선점된 채 상담내역은 저장되지 않습니다.\n페이지를 이동하시겠습니까?\n상담내역을 저장하지 않고 계속해서 진행하시려면 '확인'버튼을 클릭하세요.");
				}else{
					if(menu=="IN"){
						parent.mainFrame.location.href = "/inbound/main.do?chnlCode=&startCon=";
						$(".on").removeClass("on");
						$("#in").addClass("on");
						$("#tellNum", parent.topFrame.document).val("");
					}
					if(menu=="MAIN"){
						parent.mainFrame.location.href = "/main/main.do";
						$(".on").removeClass("on");
						$("#main").addClass("on");
						$("#tellNum", parent.topFrame.document).val("");
					}
		            if(menu=="MYPAGE"){
		                parent.mainFrame.location.href = "/mypage/mypage.do";
		                $(".on").removeClass("on");
		                $("#mypage").addClass("on");
		            }
		            if(menu=="SMS"){
		                parent.mainFrame.location.href = "/sms/sms.do";
		                $(".on").removeClass("on");
		                $("#sms").addClass("on");
		            }
				}
				if(con){
					if(menu=="IN"){
						parent.mainFrame.location.href = "/inbound/main.do?chnlCode=&startCon=";
						$(".on").removeClass("on");
						$("#in").addClass("on");
						$("#tellNum", parent.topFrame.document).val("");
					}
					if(menu=="MAIN"){
						parent.mainFrame.location.href = "/main/main.do";
						$(".on").removeClass("on");
						$("#main").addClass("on");
						$("#tellNum", parent.topFrame.document).val("");
					}
		            if(menu=="MYPAGE"){
		                parent.mainFrame.location.href = "/mypage/mypage.do";
		                $(".on").removeClass("on");
		                $("#mypage").addClass("on");
		            }
		            if(menu=="SMS"){
		                parent.mainFrame.location.href = "/sms/sms.do";
		                $(".on").removeClass("on");
		                $("#sms").addClass("on");
		            }
				}
			}else{
				if(menu=="IN"){
					parent.mainFrame.location.href = "/inbound/main.do?chnlCode=&startCon=";
					$(".on").removeClass("on");
					$("#in").addClass("on");
					$("#tellNum", parent.topFrame.document).val("");
				}
				if(menu=="MAIN"){
					parent.mainFrame.location.href = "/main/main.do";
					$(".on").removeClass("on");
					$("#main").addClass("on");
					$("#tellNum", parent.topFrame.document).val("");
				}
	            if(menu=="MYPAGE"){
	                parent.mainFrame.location.href = "/mypage/mypage.do";
	                $(".on").removeClass("on");
	                $("#mypage").addClass("on");
	            }
	            if(menu=="SMS"){
	                parent.mainFrame.location.href = "/sms/sms.do";
	                $(".on").removeClass("on");
	                $("#sms").addClass("on");
	            }
			}
		});
	});
	</script>
</head>
<body>
<div class="lnb_wrap">
    <ul class="lnb">
        <li id="main" class="on"><a href="#" >MAIN</a></li>
        <li id="in"><a href="#">IN</a></li>
        <li id="mypage"><a href="#">MYPAGE</a></li>
        <li id="sms"><a href="#">SMS</a></li>
    </ul>
    <!-- 차세대 -->
    <ul class="lnb" style="margin-top: 20px;">
        <c:forEach items="${sso}" var="sso">
            <li id="${sso.codeName }"><a href="#" >${sso.codeName }</a></li>
        </c:forEach>
    </ul>
</div>
</body>
</html>