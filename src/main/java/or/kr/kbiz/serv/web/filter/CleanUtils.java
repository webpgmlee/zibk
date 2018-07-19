package or.kr.kbiz.serv.web.filter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CleanUtils {
	
	private final static Logger LOG = LoggerFactory.getLogger(CleanUtils.class);
	public static final String EXCLUDE_PREFIX = "_EX_"; 

	
	public static String cleanParameter(String key, String value){
		String retValue = value;
		if(value!=null && key != null && !key.startsWith(EXCLUDE_PREFIX)){
			retValue = cleanValue(retValue);
		}
		return retValue;
	}
	
	public static String cleanValue(String value){
		String retValue = value;

		boolean runDefenseXSS = true; // config에서 정보 읽어와서 세팅 필요
		boolean runDefenseSQLInjecttion = true; // config에서 정보 읽어와서 세팅 필요
		boolean runDefenseSiebelInjecttion = true; // config에서 정보 읽어와서 세팅 필요
		
		if(value!=null){
			if(runDefenseXSS){
				retValue = cleanXSS(retValue);
			}
			if(runDefenseSQLInjecttion){
				retValue = cleanSQLInjection(retValue);
			}
			if(runDefenseSiebelInjecttion){
				retValue = cleanSiebelInjection(retValue);
			}
		}
		return retValue;
	}
	
	
	public static String cleanXSS(String srcValue) {
		String resultVal = null;
		try {
			resultVal = srcValue;
			resultVal = resultVal.replaceAll(XSSConstants.COMMENT_PATTERN,"");
			resultVal = resultVal.replaceAll(XSSConstants.SCRIPT_XSS_PATTERN, "SCRIPT_XSS_ACCESS $5");
			resultVal = resultVal.replaceAll(XSSConstants.STYLE_XSS_PATTERN, "STYLE_XSS_ACCESS $6");
			resultVal = resultVal.replaceAll(XSSConstants.TAG_SRC_XSS_PATTERN, "TAG_SRC_XSS_ACCESS $8");
			resultVal = resultVal.replaceAll(XSSConstants.TAG_ONERROR_XSS_PATTERN, "TAG_ONERROR_XSS_ACCESS $8");

			resultVal = resultVal.replaceAll(XSSConstants.BODY_XSS_PATTERN, "BODY_XSS_ACCESS $8");
			resultVal = resultVal.replaceAll(XSSConstants.TAG_STYLE_BG_XSS_PATTERN, "TAG_STYLE_BG_ACCESS $10");
			resultVal = resultVal.replaceAll(XSSConstants.META_XSS_PATTERN, "META_XSS_ACCESS $11");
			resultVal = resultVal.replaceAll(XSSConstants.TAG_STYLE_EXPRESSION_XSS_PATTERN, "TAG_STYLE_EXPRESSION_XSS_ACCESS $9");
		} catch (Exception e) {
			LOG.error("",e);
		}
		return resultVal;
	}
	
	public static String cleanSimpleXSS(String srcValue) {
		String resultVal = srcValue;
		resultVal = resultVal.replaceAll("<", "& lt;").replaceAll(">", "& gt;");
		resultVal = resultVal.replaceAll("eval\\((.*)\\)", "");
		resultVal = resultVal.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		resultVal = resultVal.replaceAll("script", "");
		//resultVal = resultVal.replaceAll("<script>", "");
		//resultVal = resultVal.replaceAll("</script>", "");
		//resultVal = resultVal.replaceAll("\\(", "& #40;").replaceAll("\\)", "& #41;"); 
        //resultVal = resultVal.replaceAll("'", "& #39;"); 
		//resultVal = resultVal.replaceAll("(?i)<script.*?>.*?<script.*?>", "");
		//resultVal = resultVal.replaceAll("(?i)<script.*?>.*?</script.*?>", "");
		//resultVal = resultVal.replaceAll("(?i)<.*?javascript:.*?>.*?</.*?>", "");
		//resultVal = resultVal.replaceAll("(?i)<.*?\\s+on.*?>.*?</.*?>", "");
				
		return resultVal;
	}
	
	public static String cleanSQLInjection(String srcValue) {
		String resultVal = null;
		try {
			resultVal = srcValue;
			resultVal = resultVal.replaceAll(InjectionConstants.SQL_INJECTION_META_CHAR_PATTERN,"");
			resultVal = resultVal.replaceAll(InjectionConstants.SQL_INJECTION_SPC_CHAR_PATTERN,"");
			resultVal = resultVal.replaceAll(InjectionConstants.SQL_INJECTION_QUOTE_UNION_PATTERN,"");
			resultVal = resultVal.replaceAll(InjectionConstants.SQL_INJECTION_ALWAYS_TRUE_PATTERN,"");
			resultVal = resultVal.replaceAll(InjectionConstants.SQL_INJECTION_KEYWORD_PATTERN,"");
			
		} catch (Exception e) {
			LOG.error("",e);
		}
		return resultVal;
	}
	
	public static String cleanSiebelInjection(String srcValue) {
		String resultVal = null;
		try {
			// TODO : cleanInjection 처리전에 excludeField인지 체크하는 로직 추가 필요
			/*  사전에 property나 cache에서 excludeField를 가져와서 excludeFieldsMap에 담은후, 
			 *  getParameter시에 해당 필드명이 excludeField에 있으면 cleanXSS, cleanInjection 에서 제외필요
			 */
			resultVal = srcValue;
			resultVal = resultVal.replaceAll(InjectionConstants.SIEBEL_INJECTION_META_CHAR_PATTERN,"");
		} catch (Exception e) {
			LOG.error("",e);
		}
		return resultVal;
	}
	
	
}
