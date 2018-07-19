package or.kr.kbiz.serv.web.tags;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import or.kr.kbiz.bo.common.service.CommonService;


/**
 * HTML ELEMENT 생성 TAG
 *
 */
public class ElTag extends RequestContextAwareTag {

	/**
	 *
	 */
	private static final long serialVersionUID = 8111432100615955037L;

	@Autowired
	private CommonService commonService;

	private static final Logger LOG = LoggerFactory.getLogger(ElTag.class);

	@Override
    protected int doStartTagInternal() throws Exception {
		if (commonService == null) {
            WebApplicationContext wac = getRequestContext().getWebApplicationContext();
            AutowireCapableBeanFactory beanFactory = wac.getAutowireCapableBeanFactory();
            beanFactory.autowireBean(this);
        }
		LOG.debug("123123123123123123123123123");
        return SKIP_BODY;
    }

//	public static String getMakeCodeSelect(String code) {
//		StringBuffer sb = new StringBuffer();
//		commonService.getCodeList()
//		sb.append("<select>");
//		sb.append("<option value=\"01\">테스트</option>");
//		sb.append("</select>");
//		return sb.toString();
//	}
	public static String getTellNumber(String tell){
		String result = "";
		if(tell == null || tell.trim().equals("")){
			return result;
		}else{
			if(tell.length() >= 2){
				if(tell.substring(0,2).indexOf("02")!=-1){
					if(tell.length()==10){
						result = tell.substring(0,2)+"-"+tell.substring(2,6)+"-"+tell.substring(6,10);
					}else if(tell.length()==9){
						result = tell.substring(0,2)+"-"+tell.substring(2,5)+"-"+tell.substring(5,9);
					}else{
						result = tell;
					}
				}else if(tell.length()==10){
					result = tell.substring(0,3)+"-"+tell.substring(3,6)+"-"+tell.substring(6,10);
				}else if(tell.length()==11){
					result = tell.substring(0,3)+"-"+tell.substring(3,7)+"-"+tell.substring(7,11);
				}else if(tell.length()==12){
					result = tell.substring(0,4)+"-"+tell.substring(4,8)+"-"+tell.substring(8,12);
				}else{
					result = tell;
				}
			}else{
				result = tell;
			}
		}
		return result;
	}

	public static String getDate(String date) {
		if (date == null || date.trim().equals("")) {
			return "";
		} else {
			return date.substring(0, 10);
		}
	}

	public static String getTime(String date) {
		if (date == null || date.trim().equals("") || date.length() < 10) {
			return "";
		} else {
			return date.substring(11, 19);
		}
	}

	public static String getDateTime(String date) {
		if (date == null || date.trim().equals("") || date.length() < 10) {
			return "";
		} else {
			return date.substring(0, 19);
		}
	}

	public static String getRecSplit(String recUrl){
		if(recUrl != null && recUrl.length() > 0){
			String [] arr = recUrl.split("&");
			StringBuffer sb = new StringBuffer();
			for(int i=0; i<arr.length; i++){
				sb.append("<a href='#' id='rec"+i+"'>");
				if(i != 0){
					sb.append(", ");
				}
				sb.append("REC"+(i+1));
				sb.append("</a>");
			}
			return sb.toString();
		}else{
			return "";
		}
	}
}
