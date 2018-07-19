package or.kr.kbiz.serv.spring.mvc;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public abstract class BaseService {
	/**
	 * 로깅을 위한 logger
	 */
	protected final Logger LOG = LoggerFactory.getLogger(getClass());
	
}