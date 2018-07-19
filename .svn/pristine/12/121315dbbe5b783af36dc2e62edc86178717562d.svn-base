package or.kr.kbiz.serv.spring.mvc;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class BaseController {
	protected final Logger LOG = LoggerFactory.getLogger(getClass());

	/* TODO: JSON 관련 메소드들은 정확한 사용법을 잘 모른채 베껴다 놓음. */
//	protected void sendJsonData(HttpServletResponse response, Object retObj) throws Exception {
//		response.setCharacterEncoding("UTF-8");
//		JsonDataBox jsonData = new JsonDataBox();
//
//        if( retObj != null ){
//        	jsonData.putObject(retObj);
//        }
//        String str = jsonData.toString();
//
//        LOG.debug("JSON STRING::::::::::::::::::::::::");
//       	LOG.debug(str);
//       	response.getWriter().write(str);
//        response.flushBuffer();
//	}

//	protected void sendJsonDataList(HttpServletResponse response, List<? extends Object> retList, String[] retAttrNames) throws Exception {
//		response.setCharacterEncoding("UTF-8");
//		String str = makeJsonDataList(retList, retAttrNames);
//		response.getWriter().write(str);
//        response.flushBuffer();
//	}

//	private String makeJsonDataList(List<? extends Object> retList, String[] retAttrNames) throws Exception {
//		String str = "";
//        if( retList != null && retList.size() > 0 ){
//        	JsonDataBox jsonData = new JsonDataBox();
//        	jsonData.putListFixedAttrs(retList, retAttrNames);
//
//        	str = jsonData.toString();
//
//        	LOG.debug("JSON STRING::::::::::::::::::::::::");
//            LOG.debug(str);
//
//        }else{
//        	str = "{\"resultInfo\":[{\""+JsonDataBox.JSON_DATA_KEY+"\":\"null\"}]}";
//        }
//        return str;
//	}


}
