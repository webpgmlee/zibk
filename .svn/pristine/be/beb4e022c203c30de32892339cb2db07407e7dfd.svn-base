<%--
 * file name    : cnltProcStat.jsp
 * description  : 처리구분별 통계
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
    <script src="/js/Chart.bundle.min.js"></script>

    <script type="text/javascript">
	     $(document).ready(function() {
            var now = new Date();
            var year= now.getFullYear();
            var mon = now.getMonth()+1;
            var day = now.getDate();

            $("#selFromDt").val(KBIZDT.addFormattedDate(year+''+mon+''+day,'d',0));
            $("#selToDt").val(KBIZDT.addFormattedDate(year+''+mon+''+day,'d',0));
            KBIZDT.setDatepicker("selFromDt");
            KBIZDT.setDatepicker("selToDt");
            KBIZDT.datepicker();
	    	fn_submit();

	        $("input:radio[name=selDate]").click(function() {
	        	fn_submit();
	    	});
	    });


        var list = KBIZIO.requestParamAjax("/common/getCommonCodeList.json","",{params : {lcode : "001"}, async: false});
        var codeList = $.parseJSON(list).codeList;
        var codeVal = [];
        for(var i=0;i<codeList.length;i++){
            codeVal[i] = codeList[i].codeName;
        }

	    //조회
	    function fn_submit() {

	    	//날짜검사
            if($("#selFromDt").val() == ""){
                alert("날짜를 입력해주세요.");
                $("#selFromDt").focus();
                return;
            }else if($("#selToDt").val() == ""){
                alert("날짜를 입력해주세요.");
                $("#selToDt").focus();
                return;
            }

            //조회기간이 앞보다 뒤가 작은지 검사
            if(KBIZDT.getDayInterval($("#selFromDt").val(),$("#selToDt").val()) < 0){
                alert("조회날짜가 잘못되었습니다.");
                return false;
            }
            //조회기간 3개월로 기간 제한
            if(KBIZDT.getDayCheck($("#selFromDt").val(),$("#selToDt").val()) > 93){
                alert('조회기간은 3개월 이내만 가능합니다. ');
                return false;
            }

           if($("#selFromDt").val().length == 10){           //날짜가 정확하게 입력되었는지 검사
                if($("#selToDt").val().length == 10){
                    //skip
                }else{
                    alert("검색할 날짜를 제대로 설정해주세요.\nex) 2018-01-01");
                    $("#selToDt").focus();
                    return;
                }
            }else{
                alert("검색할 날짜를 제대로 설정해주세요.\nex) 2018-01-01");
                $("#selFromDt").focus();
                return;
            }

	        var selDate = $('input:radio[name=selDate]:checked').val();
	    	var selFromDt = $("#selFromDt").val();
	    	var selToDt = $("#selToDt").val();
	    	if(selDate =="month"){
                selFromDt=selFromDt.substr(0,7);
                selToDt=selToDt.substr(0,7);
	    	}
	    	selFromDt = selFromDt.replace(/\-/gi,'');
	    	selToDt = selToDt.replace(/\-/gi,'');
	        KBIZIO.requestParamAjax("/admin/cnltProcStatList.json", fn_submitCallback, {params : {selDate : selDate, selFromDt : selFromDt, selToDt : selToDt}, async: false});
	    }

	    function fn_submitCallback(ret) {
	        /* window.chartColors = {
	                red: 'rgb(255, 99, 132)',
	                orange: 'rgb(255, 159, 64)',
	                yellow: 'rgb(255, 205, 86)',
	                green: 'rgb(75, 192, 192)',
	                blue: 'rgb(54, 162, 235)',
	                purple: 'rgb(153, 102, 255)',
	                grey: 'rgb(201, 203, 207)'
	            }; */
	    	var r = ret.result;
	        var len = r.length;
            var a_dataVal = [];
            for(var i =0;i<len;i++){
                a_dataVal[i] = r[i].aCnt;
            }
            var b_dataVal = [];
            for(var i =0;i<len;i++){
            	b_dataVal[i] = r[i].bCnt;
            }
            var c_dataVal = [];
            for(var i =0;i<len;i++){
            	c_dataVal[i] = r[i].cCnt;
            }
            var d_dataVal = [];
            for(var i =0;i<len;i++){
            	d_dataVal[i] = r[i].dCnt;
            }
            var e_dataVal = [];
            for(var i =0;i<len;i++){
            	e_dataVal[i] = r[i].eCnt;
            }

        	var config = {
        	// 라인차트임을 명시
        	type: 'bar',
        	data: {
        	// 데이타들의 라벨. X축이 된다.
        	 labels: codeVal,
        	// 실제 데이타를 넣는다.
        	datasets: [{
        	// 각 데이타의 라벨
                label: "노란우산공제",
                backgroundColor: "rgb(255, 99, 132)",
                borderColor: "rgb(255, 99, 132)",
	        	// 데이타 값. config.data.labels와 수를 같게 해주면 된다.
                data: a_dataVal,
                fill: false,
               }, {
                  label: "공제기금",
                  fill: false,
                  backgroundColor: "rgb(54, 162, 235)",
                  borderColor: "rgb(54, 162, 235)",
                  data: b_dataVal,
               }, {
                  label: "공공구매",
                  fill: false,
                  backgroundColor: "rgb(255, 159, 64)",
                  borderColor: "rgb(255, 159, 64)",
                  data: c_dataVal,
               }, {
                  label: "대표착신",
                  fill: false,
                  backgroundColor: "rgb(255, 205, 86)",
                  borderColor: "rgb(255, 205, 86)",
                  data: d_dataVal,
               }, {
                  label: "경영지원단",
                  fill: false,
                  backgroundColor: "rgb(201, 203, 207)",
                  borderColor: "rgb(201, 203, 207)",
                  data: e_dataVal,
              }]
	        },
	        options: {
	            responsive: true,
	           /*  title:{
	                display:true,
	                text:'처리구분별'
	            }, */
	            tooltips: {
	                mode: 'index',
	                intersect: false,
	            },
	            hover: {
	                mode: 'nearest',
	                intersect: true
	            },
	            scales: {
	                xAxes: [{
	                    display: true,
	                    scaleLabel: {
	                        display: true,
	                        labelString: '[처리구분]'
	                    }
	                }],
	                yAxes: [{
	                    display: true,
	                    scaleLabel: {
	                        display: true,
	                        labelString: '[Value]'
	                    }
	                }]
	            }
	        }
	    };
      	// 캔버스에 셋팅
      	if (window.myLine != undefined)
      	 window.myLine.destroy();
          var ctx = document.getElementById("canvas").getContext("2d");
          window.myLine = new Chart(ctx, config);
    }
    </script>
</head>
<body>
<div class="admin_content">
	<div class="template_wrap">
		<form id="channelStatSearchForm" name="channelStatSearchForm" method="post" action="/admin/cnltProcStatList.view" onsubmit="return false;">
		    <div class="section">
		        <h3><span class="sec_tit">처리구분별 검색</span></h3>
		        <table width="100%" border="0"  cellspacing="0" cellpadding="0" class="brd_sch">
		            <colgroup>
                        <col style="width:60px">
                        <col style="width:120px">
                        <col style="width:60px">
                        <col style="width:100px">
                        <col style="width:10px">
                        <col style="width:100px">
                        <col style="width:400px">
		            </colgroup>
		            <tr>
                        <th>구분</th>
                        <td class="ellips">
							&nbsp;<label><input type="radio" name="selDate" value="date" checked="checked">일별</label>&nbsp;&nbsp;
							<label><input type="radio" name="selDate" value="month">월별</label>
						</td>
                        <th>상담일자</th>
                        <td class="ellips"><input type="text" name="selFromDt" id="selFromDt" value="" /></td>
                        <th>~</th>
                        <td class="ellips"><input type="text" name="selToDt" id="selToDt" value="" /></td>
		                <td class="ellips"><a href="#" class="btn small g_orange" onclick="fn_submit();">조회</a></td>
		             </tr>
		        </table>
		    </div>
		</form>
		<div style="width: 80%;padding-top: 20px;">
		    <canvas id="canvas" height="750" width="1500"></canvas>
		</div>
	</div>
</div>
</body>
</html>