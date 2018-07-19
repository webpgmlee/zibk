<%--
 * file name 	: index.jsp
 * description	: admin index
 * author		: 백소영
 * initial date	: 2017.11.20
 * history
  수정일자		수정자	    수정내용
  2017.11.20	백소영    	Initialization
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
		<meta name="subject" content="KBIZ">
		<meta name="author" content="KBIZ">
		<meta name="keywords" content="KBIZ">
		<meta name="description" content="KBIZ">
		<title>KBIZ</title>
		<title>관리자 MAIN</title>
		<jsp:include page="/WEB-INF/jsp/comm_top.jsp"/>
		<script type="text/javascript">
		    _NARU.menu = {};
		    (function() {
		        var secondMenuList = $.parseJSON(KBIZIO.requestParamAjax("/admin/secondMenuList.json", null, {async: false})).secondMenuList;
		        var PREFIX = "/admin/";
		        var SUFFIX = ".do";
		        var currentFirstMenuCode = "01";

		        function getBodyUrl(secondMenuCode) {
		        	var mvn = KBIZME.getMenuViewName(secondMenuCode);
		        	if (KBIZVA.isNullOrEmpty(mvn)) {
		        		return "";
		        	} else {
	                    return PREFIX + KBIZME.getMenuViewName(secondMenuCode) + SUFFIX;
		        	}
		        };

		        _NARU.menu.getMenuViewName = function(secondMenuCode) {
					if(secondMenuCode == "00"){
						return secondMenuList[0].menuViewName;
					}else{
	                    for (var i = 0; i < secondMenuList.length; i++) {
	                         if (secondMenuList[i].frstMenuCode == currentFirstMenuCode
	                             && secondMenuList[i].secdMenuCode == secondMenuCode) {
	                             return secondMenuList[i].menuViewName;
	                      }
	                  }
					}
			      /* NOT MATCHED */
			      return "";
		        };

		        _NARU.menu.setCurrentFisrtMenu = function(cfmc,view) {
		            currentFirstMenuCode = cfmc;
		            $("#top_"+cfmc).addClass("on").siblings().removeClass("on");
		            document.bodyFrame.location.href = PREFIX + view + SUFFIX;
		            /* 레프트 메뉴 화면 출력 */
		            $("#leftMenuArea > ul > li").remove();
		            for (var i = 0, tIdx = 0; i < secondMenuList.length; i++) {
		                if (secondMenuList[i].frstMenuCode == currentFirstMenuCode) {
		                    $("<li" + (tIdx == 0 ? " class=\"on\"" : "") + "><a href=\"#\" id=\"" + secondMenuList[i].secdMenuCode + "\">" + secondMenuList[i].menuName + "</a></li>").appendTo("#leftMenuArea > ul").click(function (e) {
		                        document.bodyFrame.location.href = getBodyUrl($(this).find("a").attr("id"));
		                        if (window.event.target.tagName.toUpperCase == "LI")
		                            $(window.event.target).addClass("on").siblings().removeClass("on");
		                        else
		                            $(window.event.target).parent("li").addClass("on").siblings().removeClass("on");
		                    });
		                    tIdx++;
		                }
		            }
		        };

		    })();
		    var KBIZME = _NARU.menu;

		    $(function (){
		        if ($(".gnb.clfix.fl > dd").length > 0) {
		            KBIZME.setCurrentFisrtMenu("01", KBIZME.getMenuViewName("01"));
		        };
		    });
		</script>

	</head>
	<body style="overflow:hidden">
	    <div class="admin_warp">
		    <div class="admin_header">
		        <!--상단메뉴//-->
		        <form id="softphfrm" name="softphfrm">
		        <input type="hidden" name="hid_userid" id="hid_userid" value="" />
		        <input type="hidden" name="hid_state" id="hid_state" value="" />
		        <div class="gnb_wrap clfix" id="topMenuArea">
		            <dl class="gnb clfix fl">
		                <dt><h1><img src="/img/logo_admin.png" border="0" style="padding-right:30px;"></h1></dt>
		                <c:forEach var="items" items="${firstMenuList }" varStatus="st">
		                     <dd class="${st.index eq 0 ? "on bgnone" : "" }"  id="top_${items.frstMenuCode}"><a href="#" class="admin_top" onclick="KBIZME.setCurrentFisrtMenu('${items.frstMenuCode}','${items.menuViewName}')" >${items.menuName }</a></dd>
		                </c:forEach>
		            </dl>
		        </div>
		        </form>
		        <!--//상단메뉴-->
		    </div>

		    <div class="admin_container">
		        <div class="admin_lnb">
		            <!--좌측메뉴//-->
		            <div class="lnb_wrap" id="leftMenuArea">
	                    <ul class="lnb">
	                    </ul>
		            </div>
		            <!--//좌측메뉴-->
		        </div>
		        <div class="admin_content">
		            <iframe name="bodyFrame" id="bodyFrame" src="/admin/notice.do" style="border:none; overflow:hidden; width:100%; height:100%"></iframe>
		        </div>
		    </div>

		</div>
	</body>
</html>