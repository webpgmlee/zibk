package or.kr.kbiz.serv.web.converter;

import java.sql.Date;
import java.text.SimpleDateFormat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.support.WebBindingInitializer;
import org.springframework.web.context.request.WebRequest;

public class CustomWebBindingInitializer implements WebBindingInitializer {

	private static final Logger LOG = LoggerFactory.getLogger(CustomWebBindingInitializer.class);
	
	@Override
	public void initBinder(WebDataBinder binder, WebRequest request) {
		// TODO Auto-generated method stub
		LOG.debug("-------------------------------------- CustomWebBindingInitializer ---------------------------");
		LOG.debug("-------------------------------------- CustomWebBindingInitializer ---------------------------");
		LOG.debug("-------------------------------------- CustomWebBindingInitializer ---------------------------");
		LOG.debug("-------------------------------------- CustomWebBindingInitializer ---------------------------");
		LOG.debug("-------------------------------------- CustomWebBindingInitializer ---------------------------");
		LOG.debug(binder.getTarget().getClass().getName());
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
//        binder.registerCustomEditor(binder.getTarget().getClass(), binder.getTarget().getClass().newInstance());
        
        
	}

}
