<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="kbiz" uri="/WEB-INF/tld/kbiz.tld" %>
<jsp:include page="/WEB-INF/jsp/comm_top.jsp"/>
<html>
<head>
	<title>Home</title>
<script type="text/javascript">
$(function(){
	$(".sl").hide();
	$("#kbiz").click(function(){
		$("#d1").slideToggle();
	});
	$("#d2").click(function(){
		$("#d3").slideToggle();
	});
	$("#but").click(function(){
		$("#sel").html("<option value=''>선택</option><option value='a'>a</option>");
		$("#sel").val("a");
	});
	$("#down").click(function(){
		location.href="/admin/downloadFile.do";
	});
});
</script>

</head>
<body>
<input type="button" id="but"/>
<form action="/inbound/ExcelDown" method="post">
	<input type="text" name="url" value="/index.do"/>
	<input type="submit" value="엑셀다운"/>
</form>
<input type="button" value="다운로드" id="down"/>
</body>
</html>
