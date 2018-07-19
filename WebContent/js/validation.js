/**
 * validation.js
 */

(function() {

	/**
	 * NULL 체크
	 * @param str(String)
	 */
	_NARU.validation.nvl = function(source, defaultVal)
	{
		if (source == "" || source == null) return defaultVal || "";
		return source;
	};

	_NARU.validation.isNullOrEmpty = function(source)
	{
	    /* TODO stringUtil.js trim기능 추가 */
		if (source == null || $.trim(source) == "") return true;
		else return false;
	};


	/**
	 * @param isNull boolean [default: false]
	 */
	_NARU.validation.valCheck = function(id, isNull) {
		var e = document.getElementById(id);
		isNull = isNull || false;
		/* 널체크 */
		if (this.isNullOrEmpty(e.value) && isNull) {
		    alert(e.title + "은(는) 필수입니다.");
		    e.focus();
		    return false;
		}

		/* 길이체크 */
		if (e.maxLength) {
		    if (KBIZST.byteLen(e.value) > e.maxLength) {
		        var ml = e.maxLength;
		        alert(e.title + "은(는) 최대 한글(" + parseInt(e.maxLength/_NARU.stringUtil.getKorByte()) + ") 영문/숫자(" + e.maxLength + ")자리입니다.");
		        e.focus();
		        return false;
		    }
		}

		return true;
	};


	_NARU.validation.lenCheck = function(id) {
		var e = document.getElementById(id);

		/* 길이체크 */
		if (e.maxLength) {
		    if (KBIZST.byteLen(e.value) > e.maxLength) {
		        var ml = e.maxLength;
		        alert(e.title + "은(는) 최대 한글(" + parseInt(e.maxLength/_NARU.stringUtil.getKorByte()) + ") 영문/숫자(" + e.maxLength + ")자리입니다.");
		        e.focus();
		        return false;
		    }
		}
		return true;
	};


	/**
	 * 유효값 검사
	 * @param regExp(String), str(String)
	 */
	function fn_regExp(regExp,str){
		if(regExp.test(str)) {
		    return false;
		}else{
		    return true;
		}
	}
	/**
	 * 숫자만 허용값
	 * @param str(String)
	 */
	_NARU.validation.isNumber = function(str)
	{
		var regExp = /^[0-9]+$/;
		return fn_regExp(regExp,str);
	};

	/**
	 * 한글만 허용값
	 * @param str(String)
	 */
	_NARU.validation.isKor = function(str)
	{
		var regExp = /^[가-힣]+$/;
		return fn_regExp(regExp,str);
	};

	/**
	 * 영문만 허용값
	 * @param str(String)
	 */
	_NARU.validation.isEng = function(str)
	{
		var regExp = /^[A-Za-z]+$/;
		return fn_regExp(regExp,str);
	};

	/**
	 * 영문+숫자 허용값
	 * @param str (String)
	 */
	_NARU.validation.isIdChk = function(str)
	{
		var regExp = /^[A-Za-z0-9]+$/;
		return fn_regExp(regExp,str);
	};

	/**
	 * 이메일 허용값
	 * @param str (String)
	 */
	_NARU.validation.isEmail = function(str)
	{
		var regExp = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)+$/;
		return fn_regExp(regExp,str);
	};

	/**
	 * 전화번호 허용값
	 * @param str (String)
	 */
	_NARU.validation.isTellnum = function(str)
	{
		var regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
		return fn_regExp(regExp,str);
	};

	/**
	 * 휴대전화 허용값
	 * @param str (String)
	 */
	_NARU.validation.isCellnum = function(str)
	{
		var regExp =  /^\d{3}-\d{3,4}-\d{4}$/;
		return fn_regExp(regExp,str);
	};

	/**
	 * 파일 확장자 유효값 체크
	 * @param file_name (String)
	 */
	_NARU.validation.fileExtensionChk = function(file_name){
		var fn = document.getElementById(file_name);
		var fn_value = document.getElementById(file_name).value;

		var index     = fn_value.lastIndexOf(".")+1;
		var index2    = fn_value.lastIndexOf("\\")+1;
		var ext = (fn_value.substring(index, fn.length)).toLowerCase();

        if((ext == "" || ext == "txt" || ext == "pptx" || ext == "hwp" || ext == "xls" || ext == "bmp" || ext == "png" || ext == "jpg" || ext == "gif" || ext == "jpeg")){
        }else{
        	alert('등록하실 수 없는 확장자 입니다.');
            return false;
        }
        return true;
	}

})();