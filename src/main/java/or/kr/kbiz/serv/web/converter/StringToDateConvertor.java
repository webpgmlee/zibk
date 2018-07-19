package or.kr.kbiz.serv.web.converter;

import java.sql.Date;
import java.util.Calendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.convert.converter.Converter;

public class StringToDateConvertor implements Converter<String, Date> {
	
	private static final Logger LOG = LoggerFactory.getLogger(StringToDateConvertor.class);
	
	public Date convert(String date) {
		Calendar c = Calendar.getInstance();
		LOG.debug("---------------------- StringToDateConvertor --------------------------");
		LOG.debug("---------------------- StringToDateConvertor --------------------------");
		LOG.debug("---------------------- StringToDateConvertor --------------------------");
		LOG.debug("---------------------- StringToDateConvertor --------------------------");
		
		if (date != null && !"".equals(date)) {
			
//			c.set(year, month, date, hourOfDay, minute, second);
			
		}
		return new Date(c.getTimeInMillis());
	}

}
