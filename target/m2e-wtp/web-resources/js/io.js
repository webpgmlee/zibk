/**
 * io.js
 *
 */
(function() {

	var _JSON = "json";
	var _HTML = "html";
	var _ASYNC = "true";
	var _TYPE = "POST";
	var _FORCEXECBFN = false;

	/**
	 *
	 * options.async: 비동기여부(true[default], false)
	 * options.params: 전송 데이터({params: {key: value, key: value}}
	 * options.dataType: 요청결과 타입('json', 'html')
	 * options.type: 요청방식('GET', 'POST'[default])
	 * options.isDimmed: 딤처리여부(true[default], false)
	 * options.isForcExeCbFn: AJAX 요청 처리 결과 실패 시에도 강제 callback 함수 실행 여부(true, false[default])
	 *
	 * @param options (object)
	 */
	function requestAjax(options) {
		if (!options.url || $.trim(options.url) == '') {
			alert("요청 URL이 없습니다.");
			return;
		}
		var reqOpt = {
				url: options.url
				, type: options.type || _TYPE
				, data: options.params
				, dataType: options.dataType || _JSON
				, async: options.async == undefined || options.async == 'undefined' ? _ASYNC: options.async
				, cache: false
				, success: function(result, status) {
				                    if (result.hasOwnProperty("ex_code")) {
				                        alert(result.ex_msg);
				                        return;
				                    }
									if (this.dataType == "html") $('#' + options.targetId).html(result);
									if ($.isFunction(options.callbackFn)) options.callbackFn(result, options.params);
								}
				, error: function(r, s) {
								// TODO error process
			                    var isFecf = options.isForcExeCbFn || _FORCEXECBFN;
			                    if (isFecf) {
			                        var result = {ex_code: "SYSERRO"};
			                        if ($.isFunction(options.callbackFn)) options.callbackFn(result, options.params);
			                    } else {
			                        alert('시스템 에러입니다.');
			                    }
							}
				, complete: function(result) {
									// TODO dimmed off
									console.log('dimmed off');
								}
			};

		// TODO data에 추가 정보 SET
		// TODO dimmed on
		if (reqOpt.async || $.isFunction(options.callbackFn)) {
		    $.ajax(reqOpt);
		} else {
		    return $.ajax(reqOpt).responseText;
		}
	}

	/**
	 * json object를 serialize화 시켜줌
	 * escape 처리
	 *
	 * @param obj (object)
	 */
	function objectToSerialize(obj) {
        if (!obj) return "";

    	function objectParser(obj) {
    		var r = "";
            for (var o in obj) {
                if (typeof(obj[o]) == 'object') {
                    if (Array.isArray(obj[o])) {
                        for (var i = 0; i < obj[o].length; i++) {
                            r += objectParser(obj[o]);
                        }
                    } else {
                        r += objectParser(obj[o]);
                    }
                } else if (typeof(obj[o]) == 'string') {
                    r += o + "=" + encodeURIComponent(obj[o]) + "&";
                }
            }
            return r;
    	}

        if (typeof(obj) == 'object') {
            var r = objectParser(obj);
            return r.substr(0, r.length -1);
        } else {
        	console.log("argument obj is not object!");
        	return "";
        }
    }

	/**
	 *
	 * options.async: 비동기여부(true[default], false)
	 * options.params: 전송 데이터({params: {key: value, key: value}}
	 * options.dataType: 요청결과 타입('json'[default], 'html')
	 * options.type: 요청방식('GET', 'POST'[default])
	 * options.isDimmed: 딤처리여부(true[default], false)
	 *
	 * @param url (string)
	 * @param callbackFn (function)
	 * @param [options] (object)
	 */
	_NARU.io.requestParamAjax = function(url, callbackFn, options) {
		options = options || {};
		options.url = url;
		options.callbackFn = callbackFn;
		return requestAjax(options);

	};

	/**
	 *
	 * options.async: 비동기여부(true[default], false)
	 * options.params: 추가 파라메터({params: {key: value, key: value}}
	 * options.isDimmed: 딤처리여부(true[default], false)
	 *
	 * @param options (object)
	 * @param callbackFn (function)
	 */
	_NARU.io.requestJsonAjax = function(formId, callbackFn, options) {
		options = options || {};
		var $f = typeof(formId) == 'string' ? $('#' + formId) : $(formId);

		options.url = $f.attr("action");
		options.type = $f.attr("method");
		options.callbackFn = callbackFn;
		options.params = $f.serialize() + ($.trim($f.serialize()) == '' ? "" : "&") + (options.params ? objectToSerialize(options.params) : "");
		options.dataType = _JSON;
		return requestAjax(options);
	};

	/**
	 * view형태의 AJAX 요청
	 * 요청 후 targetId에 response된 jsp를 파싱하여 출력
	 *
	 * options.async: 비동기여부(true[default], false)
	 * options.params: 추가 파라메터({params: {key: value, key: value}}
	 * options.isDimmed: 딤처리여부(true[default], false)
	 *
	 * @param formId (string || object)
	 * @param targetId (string)
	 * @param [callbackFn] (function)
	 * @param [options] (object)
	 */
	_NARU.io.requestViewAjax = function(formId, targetId, callbackFn, options) {
		options = options || {};
		var $f = typeof(formId) == 'string' ? $('#' + formId) : $(formId);
		options.url = $f.attr("action");
		options.type = $f.attr("method");
		options.callbackFn = callbackFn || {};
		options.targetId = targetId;
		options.params = $f.serialize() + ($.trim($f.serialize()) == '' ? "" : "&") + (options.params ? objectToSerialize(options.params) : "");
		options.dataType = _HTML;
		return requestAjax(options);
	};

	_NARU.io.requestPageIdx = function(pageIdx, formId, targetFn) {
	    $("#" + formId + " input[name=pageIdx]").val(pageIdx);
	    targetFn();
	};

})();

