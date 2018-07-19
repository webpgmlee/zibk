<%--
 * file name : vocPop.jsp
 * description : voc이관
 * author : H.K.Lee
 * initial date : 2017.11.01
 * history
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
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
<jsp:include page="/WEB-INF/jsp/comm_top.jsp"/>
<title>VOC이관</title>
<script type="text/javascript">
	$(function(){
		$("#vocSave").click(function(){
			if(KBIZVA.isNullOrEmpty($("#needsType").val())){
				alert("민원유형을 입력해주세요.");
				return false;
			}
			if(KBIZVA.isNullOrEmpty($("#title").val())){
				alert("제목을 입력해주세요.");
				return false;
			}
			if(KBIZVA.isNullOrEmpty($("#content").val())){
				alert("내용을 입력해주세요.");
				return false;
			}
			if(KBIZVA.isNullOrEmpty($("#opinion").val())){
				alert("의견을 입력해주세요.");
				return false;
			}
			$("#needsType",opener.document).val($("#needsType").val());
			$("#vocTitle",opener.document).val($("#title").val());
			$("#vocContent",opener.document).val($("#content").val());
			$("#vocOpinion",opener.document).val($("#opinion").val());
			window.close();
		});
	});
</script>
</head>
<body>
<table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch mgb05 ac">
	<colgroup>
		<col style="width:150px;">
		<col style="width:450px;">
	</colgroup>
	<tr>
		<th>민원유형</th>
		<td>
			<select id="needsType">
				<option value="">선택</option>
				<c:forEach items="${code}" var="c">
					<c:if test="${c.lcode == '011'}">
						<c:if test="${c.mcode != '00'}">
							<option value="${c.mcode}">${c.codeName}</option>
						</c:if>
					</c:if>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td colspan="9"><input type="text" id="title" value=""/></td>
	</tr>
	<tr>
		<th>내용</th>
		<td colspan="9"><textarea rows="4" id="content" cols="*"></textarea></td>
	</tr>
	<tr>
		<th>접수자<br>의견</th>
		<td colspan="9"><textarea rows="4" id="opinion" cols="*"></textarea></td>
	</tr>
</table>
<div class="popup-layer">
	<div class="popup-footer">
		<a href="#" class="btn small g_blue" id="vocSave" title="저장">저장</a>
		<a href="#stop" class="btn small g_darkgray clostBtn" onClick="javascript:window.close();"><span class="buttonStyleText">닫기</span></a>
	</div>
</div>
</body>
</html>