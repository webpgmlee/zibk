<%--
 * file name : smsPop.jsp
 * description : sms전송
 * author : H.K.Lee
 * initial date : 2017.11.01
 * history
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<meta name="subject" content="KBIZ">
<meta name="author" content="KBIZ">
<meta name="keywords" content="KBIZ">
<meta name="description" content="KBIZ">
<jsp:include page="/WEB-INF/jsp/comm_top.jsp"/>
<title>SMS전송</title>
<script type="text/javascript">
var add="";
var count=1;
// 추가할 html
$(function(){
	add = $("#addTell").html();
	$(".tellNum").val($("#softTlno").val());
	$("#title").hide();
	$("#cbyte2").hide();
	$("#cbyte3").hide();
	$("#content2").hide();

	$("#sms").click(function(){
		$("#content").show();
		$("#title").hide();
		$("#content2").hide();
		$("#cbyte").show();
		$("#cbyte2").hide();
		$("#cbyte3").hide();
	});

	$("#lms").click(function(){
		$("#content2").show();
		$("#title").show();
		$("#content").hide();
		$("#cbyte").hide();
		$("#cbyte2").show();
		$("#cbyte3").show();
	});
});

// 휴대폰번호 추가
function addRow(){
	count++;
	var tcount = $(".tnum").length;
	if(tcount>=10){
		alert("SMS는 최대 10명까지만 보낼 수 있습니다.");
		return false;
	}else{
		var append = add.replace("Tell1","Tell"+count);
		append = append.replace("delBtn1","delBtn"+count);
		append = append.replace("delRow(1)","delRow("+(count)+")");
		$("#addTell").append(append);
		for(var t=0;t<tcount+1;t++){
			$(".tnum").eq(t).text("핸드폰번호"+(t+1));
		};
	}
};

// 휴대폰번호 삭제
function delRow(num){
	if(num!=1){
		$("#Tell"+num).remove();
		for(var t=0;t<$(".tnum").length;t++){
			$(".tnum").eq(t).text("핸드폰번호"+(t+1));
		};
	}else{
		alert("번호1은 삭제할 수 없습니다.");
	}
};

function sendSms(){
	var arr = new Array();
	for(var i=0; i<$(".tellNum").length; i++){
		if($(".tellNum").eq(i).val().length >= 10){
			arr[i] = $.trim(KBIZST.replaceTell($(".tellNum").eq(i).val()));
		}else{
			alert("핸드폰번호"+(i+1)+"를 다시입력하시거나 삭제해주세요.");
			return false;
		}
	}
	alert("발송되었습니다.");
	//location.href="/inbound/customer/smsSend.do?arr="+arr+"&content="+encodeURI($("#content").val());
	if(document.getElementById("sms").checked == true){
		location.href="/inbound/customer/smsSend.do?arr="+arr+"&content="+encodeURI($("#content").val());
	}else{
		location.href="/inbound/customer/smsSend2.do?arr="+arr+"&content="+encodeURI($("#content2").val()+"&title="+encodeURI($("#title").val()));
	}
};

/* SMS 본문 내용 입력할 때마다 길이 체크*/
function lenCheck() {
	var expression = $("#content").val();
	var VLength = 0;
	var temp = expression;
	var EscTemp;
	if (temp != "" & temp != null) {
		for (var i = 0; i < temp.length; i++) {
			if (temp.charAt(i) != escape(temp.charAt(i))) {
				EscTemp = escape(temp.charAt(i));
				if (EscTemp.length >= 6)
					VLength += 2;
				else
					VLength += 1;
			} else
				VLength += 1;
		}
	}
	if(VLength>90){
		alert("문자는 한글 최대 45자, 영문 최대 90자 입니다.");
		var cut = cutStr(expression, 90);
		$("#content").val(cut);
		$("#cbyte").text("90/90bytes");
		return false;
	}
	$("#cbyte").text(VLength+"/90bytes");
};

function lenCheck2() {
	var expression = $("#title").val();
	var VLength = 0;
	var temp = expression;
	var EscTemp;
	if (temp != "" & temp != null) {
		for (var i = 0; i < temp.length; i++) {
			if (temp.charAt(i) != escape(temp.charAt(i))) {
				EscTemp = escape(temp.charAt(i));
				if (EscTemp.length >= 6)
					VLength += 2;
				else
					VLength += 1;
			} else
				VLength += 1;
		}
	}
	if(VLength>40){
		alert("제목은 한글 최대 20자, 영문 최대 40자 입니다.");
		var cut = cutStr(expression, 40);
		$("#title").val(cut);
		$("#cbyte2").text("40/40bytes");
		return false;
	}
	$("#cbyte2").text(VLength+"/40bytes");
}

function lenCheck3() {
	var expression = $("#content2").val();
	var VLength = 0;
	var temp = expression;
	var EscTemp;
	if (temp != "" & temp != null) {
		for (var i = 0; i < temp.length; i++) {
			if (temp.charAt(i) != escape(temp.charAt(i))) {
				EscTemp = escape(temp.charAt(i));
				if (EscTemp.length >= 6)
					VLength += 2;
				else
					VLength += 1;
			} else
				VLength += 1;
		}
	}
	if(VLength>2000){
		alert("본문은 한글 최대 1000자, 영문 최대 2000자 입니다.");
		var cut = cutStr(expression, 2000);
		$("#content2").val(cut);
		$("#cbyte3").text("2000/2000bytes");
		return false;
	}
	$("#cbyte3").text(VLength+"/2000bytes");
}

/* 제한 바이트로 내용 자르기 */
function cutStr(str, limit){
	var retstr = "";
	var strlength = 0;
	var character = "";

	for(var i=0; i<str.length; i++){
		character = str.charAt(i);
		strlength += chk_byte(character);
		if(strlength > limit){
			break;
		}else{
			retstr += character;
		}
	}
	return retstr;
};

function chk_byte(character){
	if(escape(character).length >= 6){
		return 2;
	}else{
		return 1;
	}
};
</script>
</head>
<body>
<input type="hidden" value="${tlno}" id="softTlno"/>
<div class="ar mgt10 mgr20">
	SMS <input type="radio" id="sms" name="sType" checked="checked"/>
	LMS <input type="radio" id="lms" name="sType"/>
</div>
<div>
<textarea rows="6" cols="50" id="content" class="mgl10 mgt10 mgb10" onkeyup="lenCheck()" placeholder="본문(한글 최대 45자, 영문 최대 90자)">
</textarea>
<input type="text" value="" id="title" name="title" style="width:317px;" class="mgl10 mgb10 mgt10"  onkeyup="lenCheck2()" placeholder="제목(한글 최대 20자, 영문 최대 40자)"/>
<span class="fl mgl10" id="cbyte2">0/40bytes</span>
<textarea rows="6" cols="50" id="content2" name="content2" class="mgl10 mgt10 mgb10"  onkeyup="lenCheck3()" placeholder="본문(한글 최대 1000자, 영문 최대 2000자">
</textarea>
<span class="fl mgl10" id="cbyte">0/90bytes</span>
<span class="fl mgl10" id="cbyte3">0/2000bytes</span>
</div>
<div class="ar"><a href="#" class="btn small g_blue mgr10" onclick="addRow()">추가</a></div>
<div>
	<table border="0" cellspacing="0" cellpadding="0" class="brd_sch mgt05">
		<colgroup>
			<col style="width:100px">
			<col style="width:190px">
			<col style="width:60px">
		</colgroup>
		<tbody id="addTell">
			<tr id="Tell1">
				<th class="tnum">핸드폰번호1</th>
				<td><input type="text" name="" value="" class="tellNum"/></td>
				<td>
					<a href="#" id="delBtn1" class="btn small g_red delBtn ellips" onclick="delRow(1)">삭제</a>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="popup-layer">
	<div class="popup-footer">
		<a href="#" class="btn small g_blue mgr02" onclick="sendSms()">전송</a>
		<a href="#stop" class="btn small g_darkgray clostBtn" onClick="javascript:window.close();"><span class="buttonStyleText">닫기</span></a>
	</div>
</div>
</body>
</html>