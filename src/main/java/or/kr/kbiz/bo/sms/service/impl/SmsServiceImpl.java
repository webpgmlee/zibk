package or.kr.kbiz.bo.sms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.SmsSendDomain;
import or.kr.kbiz.bo.sms.service.SmsService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>SMS implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class SmsServiceImpl implements SmsService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<SmsSendDomain> selectSmsSendList(SmsSendDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("sms.selectSmsSendTotalCount", param));
		return baseDao.getList("sms.select", param);
	}

	public SmsSendDomain selectSmsSendDetail(SmsSendDomain param) {
		return (SmsSendDomain) baseDao.getObject("sms.selectDetail", param);
	}

}
