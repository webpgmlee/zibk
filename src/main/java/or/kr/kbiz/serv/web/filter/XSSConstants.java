package or.kr.kbiz.serv.web.filter;

/**
 * @author archer
 *
 */
public final class XSSConstants {

	public static final String ERR_USER_MESSAGE="errorMessage";

	public static final String NOTICE_POPUP="popupMessage";
	public static final String SCRIPT_ALERT="alertMessage";


	public static final String DATE_DELIMITER_SLASH = "/";


	public static final String SCRIPT_XSS_PATTERN = "<script([\\s\\/]+[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*[\\s\\/]*>([\\w;()\\s'\"{}\\[\\]\\-\\^?|}~_`:;<=>?@\\.!#$%&*+,]+)<\\/script([\\s\\/]+[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*[\\s\\/]*>";//$5
	public static final String STYLE_XSS_PATTERN  = "<style([\\s\\/]+[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*[\\s\\/]*>@import\"[\\s\\/]*(javascript|vbscript)[\\s\\/]*:[\\s\\/]*((alert|msgbox)\\(('|\")([\\w;()\\s'\"{}\\[\\]\\-\\^?|}~_`:;<=>?@\\.!#$%&*+,]+)('|\")\\))\";<\\/style([\\s\\/]+[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*[\\s\\/]*>";//$6
	public static final String TAG_SRC_XSS_PATTERN    = "<[a-z]+([\\s\\/]+[^src][\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*([\\s\\/]+src[\\s\\/]*=[\\s\\/]*('|\")?[\\s\\/]*(javascript|vbscript)?[\\s\\/]*:?[\\s\\/]*((alert|msgbox)\\(('|\")([\\w;()\\s'\"{}\\[\\]\\-\\^?|}~_`:;<=>?@\\.!#$%&*+,]+)('|\")\\);?)('|\")?)([\\s\\/]+[^src][\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*[\\s\\/]*>";//$8
	public static final String TAG_ONERROR_XSS_PATTERN    = "<[a-z]+([\\s\\/]+[^onerror][\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*([\\s\\/]+src[\\s\\/]*=[\\s\\/]*('|\")?[\\s\\/]*(javascript|vbscript)?[\\s\\/]*:?[\\s\\/]*((alert|msgbox)\\(('|\")([\\w;()\\s'\"{}\\[\\]\\-\\^?|}~_`:;<=>?@\\.!#$%&*+,]+)('|\")\\);?)('|\")?)([\\s\\/]+[^onerror][\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*[\\s\\/]*>";//$8
	public static final String BODY_XSS_PATTERN = "<body([\\s\\/]+[^onload][\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*([\\s\\/]+onload[\\s\\/]*=[\\s\\/]*('|\")?[\\s\\/]*(javascript|vbscript)?[\\s\\/]*:?[\\s\\/]*((alert|msgbox)\\(('|\")([\\w;()\\s'\"{}\\[\\]\\-\\^?|}~_`:;<=>?@\\.!#$%&*+,]+)('|\")\\);?)('|\")?)([\\s\\/]+[^onload][\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*[\\s\\/]*>";//$8

	public static final String TAG_STYLE_BG_XSS_PATTERN = "<[a-z]+" +
			"([\\s\\/]+[^style][\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*" +
				"([\\s\\/]*style[\\s\\/]*=[\\s\\/]*('|\")?" +
				"([\\s\\/]*[a-zA-Z\\-]+[\\s\\/]*:[\\s\\/]*[a-zA-Z_\\-]+[\\s\\/]*;?)*" +
					"([\\s\\/]*background-image[\\s\\/]*:[\\s\\/]*url\\([\\s\\/]*(javascript|vbscript)[\\s\\/]*:[\\s\\/]*((alert|msgbox)\\(('|\")([\\w;()\\s'\"{}\\[\\]\\-\\^?|}~_`:;<=>?@\\.!#$%&*+,]+)('|\")\\))\\);?" +
				"([\\s\\/]*[a-zA-Z\\-]+[\\s\\/]*:[\\s\\/]*[a-zA-Z_\\-]+[\\s\\/]*;?)*" +
								"('|\")?))" +
			"([\\s\\/]*[^style][\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*" +
				"[\\s\\/]*>";//$10

	public static final String META_XSS_PATTERN = "<meta" +
	"([\\s\\/]+[^content][\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*" +
		"([\\s\\/]*content[\\s\\/]*=[\\s\\/]*('|\")?" +
		"([\\s\\/]*[a-zA-Z0-9\\-]+[\\s\\/]*(=[\\s\\/]*[a-zA-Z_\\-]+[\\s\\/]*)?;?)*" +
			"([\\s\\/]*url[\\s\\/]*=[\\s\\/]*(javascript|vbscript)[\\s\\/]*:[\\s\\/]*((alert|msgbox)\\(('|\")([\\w;()\\s'\"{}\\[\\]\\-\\^?|}~_`:;<=>?@\\.!#$%&*+,]+)('|\")\\);?)" +
		"([\\s\\/]*[a-zA-Z0-9\\-]+[\\s\\/]*(=[\\s\\/]*[a-zA-Z_\\-]+[\\s\\/]*)?;?)*" +
						"('|\")?))" +
	"([\\s\\/]*[^content][\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*" +
		"[\\s\\/]*>";//$11

	public static final String TAG_STYLE_EXPRESSION_XSS_PATTERN = "<[a-z]+" +
	"([\\s\\/]+[^style][\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*" +
		"([\\s\\/]*style[\\s\\/]*=[\\s\\/]*('|\")?" +
		"([\\s\\/]*[a-zA-Z\\-]+[\\s\\/]*:[\\s\\/]*[a-zA-Z_\\-]+[\\s\\/]*;?)*" +
			"([\\s\\/]*[a-z]+[\\s\\/]*:[\\s\\/]*expression\\([\\s\\/]*(alert\\(('|\")([\\w;()\\s'\"{}\\[\\]\\-\\^?|}~_`:;<=>?@\\.!#$%&*+,]+)('|\")\\))\\))" +
		"([\\s\\/]*[a-zA-Z\\-]+[\\s\\/]*:[\\s\\/]*[a-zA-Z_\\-]+[\\s\\/]*;?)*" +
						"('|\")?)" +
	"([\\s\\/]*[^style][\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]+[\\s\\/]*(=[\\s\\/]*('|\")?[\\w;()'\"{}\\[\\]\\-\\^?|}~_`:;=?@\\.!#$%&*+,]*('|\")?)?)*" +
		"[\\s\\/]*>";//$9
	public static final String COMMENT_PATTERN ="\\/\\*[\\w;()\\s'\"{}\\[\\]\\-\\^?|}~_`:;<=>?@\\.!#$%&*+,]*\\s*\\*\\/";

	/*
	//No < and > as it could be for some sql. --> ex) value = value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	//No () brackets as part of data....      --> ex) value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
	// script world                           --> ex) value = value.replaceAll("script","");
	//Handle any apostrophe.  Can a name have this ?? --> ex) value = value.replaceAll("'", "&#39;");
	*/

	//Any java script stuff. --> ex) value = value.replaceAll(XSS_EVAL_PATTERN,"");
	public static final String XSS_EVAL_PATTERN = "eval\\((.*)\\)";
	// url javascript  --> ex) value = value.replaceAll(XSS_URL_JAVASCRIPT_PATTERN,"\"\"");
	public static final String XSS_URL_JAVASCRIPT_PATTERN = "[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']";
	//Regex for "<img src" CSS attack --> ex) value = value.replaceAll(XSS_IMG_CSS_PATTERN,"");
	public static final String XSS_IMG_CSS_PATTERN = "/((\\%3C)|<)((\\%69)|i|(\\%49))((\\%6D)|m|(\\%4D))((\\%67)|g|(\\%47))[^\n]+((\\%3E)|>)/I";
	
}