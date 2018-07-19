package or.kr.kbiz.serv.spring.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import or.kr.kbiz.serv.exception.BizException;

public class BoBaseExceptionResolver implements HandlerExceptionResolver {

	private static final Logger LOG = LoggerFactory.getLogger(BoBaseExceptionResolver.class);

//	private final String DEFUALT_PAGE = "exception";

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handle, Exception ex ) {
		ModelAndView modelAndView = new ModelAndView();
    	LOG.error(ex.toString());
    	LOG.debug("----------------- BoBaseExceptionResolver ---------------");

    	String error_code = "EX.RUNTIME";
    	String error_msg = "시스템 에러입니다.";

        // 에러 클래스에 따른 view 설정 또는 로그 추가.
        if (ex instanceof BizException) {
        	BizException bizException = (BizException)ex;

            // 전달 받은 commonAbstractException 처리.
        	try {
        		error_code = "EX." + bizException.getErrorMessage();
        		error_msg = bizException.getAddMessage();
        	} catch (Exception e) {
        		error_code = "EX.RUNTIME";
            	error_msg = "시스템 에러입니다.";
        	}
        }


        modelAndView.addObject("ex_code", error_code);
        modelAndView.addObject("ex_msg", error_msg);
        /* DOTO JSON or VIEW 페이지 설정 */
//        modelAndView.setViewName("jsonView");
        return modelAndView;
	}

}
