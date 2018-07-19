package or.kr.kbiz.serv.web.filter;

/**
 * @author archer
 *
 */
public class InjectionConstants {
	
	/* 
	 * 특수문자 체크  %3D = NL %27 ' -- %3B ; 
	 * http://www.symantec.com/connect/articles/detection-sql-injection-and-cross-site-scripting-attacks
	 * Regex for detecting SQL Injection meta-characters
	 */
	public static final String SQL_INJECTION_SPC_CHAR_PATTERN = "/((\\%3D)|(=))[^\\n]*((\\%27)|(\')|(\\-\\-)|(\\%3B)|(;))/i";
	// value = value.replaceAll(SQL_INJECTION_SPC_CHAR_PATTERN,"");
	
	
	/*
	 * regex for detection of sql Meta-characters
	 * [ ] ' -- #
	 */
	public static final String SQL_INJECTION_META_CHAR_PATTERN = "/(\\[)|(\\])|(\\%27)|(\')|(\\-\\-)|(\\%23)|(#)/ix";
	// value = value.replaceAll(SQL_INJECTION_META_CHAR_PATTERN,"");
	
	/*
	 * regex for detection of siebel query Meta-characters
	 * ' ? ( ) [ ]
	 */
	public static final String SIEBEL_INJECTION_META_CHAR_PATTERN = "/(\\%27)|(\')|([?])|(\\()|(\\))|(\\[)|(\\%5B)|(\\])|(\\%5D)/ix";
	// value = value.replaceAll(SIEBEL_INJECTION_META_CHAR_PATTERN,"");
	
	/*
	 * single quote와 union 체크
	 * (\%27)|(\') - the single-quote and its hex equivalent
	 * union - the keyword union
	 */
	public static final String SQL_INJECTION_QUOTE_UNION_PATTERN = "/((\\%27)|(\'))union/ix";

	/*
	 * 항상 true를 만드는 조건 체크
	 * 예) 1'or'1'='1   1'or2>1--
	 *  Regex for typical SQL Injection attack
	 *  /\w*((\%27)|(\'))((\%6F)|o|(\%4F))((\%72)|r|(\%52))/ix
	 */
	public static final String SQL_INJECTION_ALWAYS_TRUE_PATTERN = "/\\w*((\\%27)|(\\'))((\\%6F)|o|(\\%4F))((\\%72)|r|(\\%52))/ix";
	
	/*
	 * checking for the keywords and a combination of quotes with conjunctions and quotes with double pipe (||)
	 */
	public static final String SQL_INJECTION_KEYWORD_PATTERN = "insert|update|delete|having|drop|(\'|%27).(and|or).(\'|%27)|(\'|%27).%7C{0,2}|%7C{2}";		
}
