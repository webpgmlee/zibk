package or.kr.kbiz.serv.web.filter;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.AnnotationIntrospector;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.SerializationConfig.Feature;
import org.codehaus.jackson.xc.JaxbAnnotationIntrospector;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JsonUtils {
	private final static Logger LOG = LoggerFactory.getLogger(JsonUtils.class);

	public static String writeValueAsString(Object targetObject) {
		return writeValueAsString(targetObject, false, false);
	}
	
	public static String writeValueAsString(Object targetObject, boolean enableWrapRootValue, boolean enableJaxAnnotation) {
	    String retValue = null;
	    ObjectMapper mapper = new ObjectMapper();
	    // enable indent
	    mapper.configure(SerializationConfig.Feature.INDENT_OUTPUT, true);
	    
	    // enable JAXB Annotation
	    if (enableJaxAnnotation) {
		    AnnotationIntrospector introspector = new JaxbAnnotationIntrospector();
		    mapper.setAnnotationIntrospector(introspector);
	    }
	    
	    // enable Warp Root Value
	    if (enableWrapRootValue) {
	    	mapper.enable(Feature.WRAP_ROOT_VALUE);
	    }	
	    
	    try {
	    	retValue = mapper.writeValueAsString(targetObject);
		} catch (JsonGenerationException e) {
			LOG.error(e.getMessage());
		} catch (JsonMappingException e) {
			LOG.error(e.getMessage());
		} catch (IOException e) {
			LOG.error(e.getMessage());
		}
	    return retValue;
	}


	public static Object readValue(String targetValue, Class<?> valueType) {
		return readValue(targetValue, valueType, false, false);	
	}
	
	public static Object readValue(String targetValue, Class<?> valueType, boolean enableWrapRootValue, boolean enableJaxAnnotation) {
	    if (targetValue==null)
	    	return null;
	    
	    Object retObject = null;
		ObjectMapper mapper = new ObjectMapper();
	    // enable indent
	    mapper.configure(SerializationConfig.Feature.INDENT_OUTPUT, true);
	    
	    // 중요 ( domain class에 없는 field가 있을때 오류 발생안하게 하는 옵션 )
	    mapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false); 
	    
	    
	    // enable JAXB Annotation
	    if (enableJaxAnnotation) {
		    AnnotationIntrospector introspector = new JaxbAnnotationIntrospector();
		    mapper.setAnnotationIntrospector(introspector);
	    }
	    
	    // enable Warp Root Value
	    if (enableWrapRootValue) {
	    	mapper.enable(Feature.WRAP_ROOT_VALUE);
	    }	
	    
	    try {
	    	retObject = mapper.readValue(targetValue.getBytes(), valueType);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
		} catch (JsonMappingException e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			LOG.error(e.getMessage());
		}
	    return retObject;
	}
}
