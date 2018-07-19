<%--
 * file name : index.jsp
 * description : 메인페이지
 * author : H.K.Lee
 * initial date : 2017.11.01
 * history
  --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script type="text/javascript">
function lockRefresh(){
	if(event.keyCode == "116"){
		event.keyCode = 0;
		return false;
	}
};
document.onkeydown = lockRefresh;
</script>
</head>
<frameset rows="100,*" cols="100%" frameborder="NO" border="0" framespacing="0">
  <frame src="/softphone/softphone.do?ctiYn=${ctiYn}" name="topFrame" id="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" />
  <frameset cols="90,*" cols="100%" frameborder="NO" border="0" framespacing="0">
    <frame src="/main/left.do" name="leftFrame" scrolling="No" noresize="noresize" id="leftFrame" title="leftFrame" />
    <frame src="/main/main.do"  name="mainFrame"  id="mainFrame" title="mainFrame" scrolling="yes" noresize="noresize"/>
  </frameset>
</frameset>
<noframes>
<body>
</body>
</noframes>
</html>

