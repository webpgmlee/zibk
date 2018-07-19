package or.kr.kbiz.serv.web.converter;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.SerializationConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpInputMessage;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.http.converter.json.MappingJacksonHttpMessageConverter;

/**
 * Json 문자열 -> Java Domain, Java Domain -> Json 문자열로 변환해주는 Converter.
 * <BR>Jackson Object Mapper의 환경 설정을 통하여 변환 과정을 제어할 수 있다. 
 * 
 * @version 1.0
 * @see org.springframework.http.converter.json.MappingJacksonHttpMessageConverter
 * @see org.codehaus.jackson.map.DeserializationConfig 
 * @see org.codehaus.jackson.map.SerializationConfig 
 * @since 1.0
 */
public class JsonHttpMessageConverter extends MappingJacksonHttpMessageConverter {

	private final static Logger LOG = LoggerFactory.getLogger(JsonHttpMessageConverter.class);
	
	/**
	 * Json->Java, Java->Json 변환 시 Annotation을 사용할지를 설정한다.
	 * <BR>만일 true이면 Annotation을  사용하고, false이면 사용하지 않는다.
	 * 
	 * <BR>Default : true
	 * @param useAnnotations
	 */
	public void setUseAnnotations(boolean useAnnotations) {
		super.getObjectMapper().configure(DeserializationConfig.Feature.USE_ANNOTATIONS, useAnnotations);
		
		super.getObjectMapper().configure(SerializationConfig.Feature.USE_ANNOTATIONS, useAnnotations);
	}
	
	/**
	 * Json->Java로 변환 시 Properties를 찾지 못할 경우 JsonMappingException을 발생시킬지 무시할지 설정한다.
	 * <BR>만일 true이면 JsonMappingException을 발생시키고, false이면 무시한다.
	 * 
	 * <BR>Default : true
	 * @param failOnUnknownProperties
	 */
	public void setFailOnUnknownProperties(boolean failOnUnknownProperties) {
		super.getObjectMapper().configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, failOnUnknownProperties);
	}

	/**
	 * Json->Java로 변환 시 null 문자열을 primitive property로 설정 시  JsonProcessingException을 발생시킬지 아니면 Default 값을 설정할지 설정한다.
	 * <BR>만일 true이면 JsonProcessingException을 발생시키고, false이면 null 문자열을 Default 값으로 설정한다.
	 * 
	 * <BR>Default : false
	 * @param failOnNullForPrimitives
	 */
	public void setFailOnNullForPrimitives(boolean failOnNullForPrimitives) {
		super.getObjectMapper().configure(DeserializationConfig.Feature.FAIL_ON_NULL_FOR_PRIMITIVES, failOnNullForPrimitives);
	}

	/**
	 * Java->Json로 변환 시 Json 문자열 출력 시 Indent(2자리)를 주어 출력할지를 설정한다.
	 * <BR>만일 true이면 indent를 출력하고, false이면 출력하지 않는다.
	 * 
	 * <BR>Default : false
	 * @param identOutput
	 */
	public void setIdentOutput(boolean identOutput) {
		super.getObjectMapper().configure(SerializationConfig.Feature.INDENT_OUTPUT, identOutput);
	}
	
	/**
	 * Java->Json로 변환 시 Properties를 알파벳 순서로 정렬할지를 설정한다.
	 * <BR>만일 true이면 알파벳 순서로 정렬하고, false이면 정렬하지 않는다.
	 * 
	 * <BR>Default : false
	 * @param sortPropertiesAlphabetically
	 */
	public void setSortPropertiesAlphabetically(boolean sortPropertiesAlphabetically) {
		super.getObjectMapper().configure(SerializationConfig.Feature.SORT_PROPERTIES_ALPHABETICALLY, sortPropertiesAlphabetically);
	}
	
	/**
	 * Java->Json로 변환 시 Domain Class의 이름으로 Json 문자열을 감쌀지를 설정한다.
	 * <BR>만일 true이면 Wrapping 하고, false이면 Wrapping 하지 않는다.
	 * 
	 * <BR>Default : false
	 * @param wrapRootValue
	 */
	public void setWrapRootValue(boolean wrapRootValue) {
		super.getObjectMapper().configure(SerializationConfig.Feature.WRAP_ROOT_VALUE, wrapRootValue);
	}

	@Override
	protected Object readInternal(Class<?> clazz, HttpInputMessage inputMessage)
			throws IOException, HttpMessageNotReadableException {
		//TODO : Error Logging
		
		return super.readInternal(clazz, inputMessage);
	}
	
	/**
	 * Java Domin 객체를 json 문자열로 변환하는 테스트용 함수
	 * 
	 * @param targetObject
	 * @return
	 */
	public String writeValueAsString(Object targetObject) {
	    String retValue = null;
	    
	    try {
	    	retValue = getObjectMapper().writeValueAsString(targetObject);
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
	    return retValue;		
	}
	
	/**
	 *	json 문자열를 Java Domin 객체로 변환하는  테스트용 함수
	 * 
	 * @param targetValue
	 * @param valueType
	 * @return
	 */
	public Object readValue(String targetValue, Class<?> valueType) {
	    Object retObject = null;

	    try {
	    	retObject = getObjectMapper().readValue(targetValue.getBytes(), valueType);
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
