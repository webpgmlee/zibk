package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.SmsSendDomain;
import or.kr.kbiz.bo.admin.service.SmsSendService;
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
public class SmsSendServiceImpl implements SmsSendService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<SmsSendDomain> selectSmsSendList(SmsSendDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("smsSend.selectSmsSendTotalCount", param));
		return baseDao.getList("smsSend.select", param);
	}

	public SmsSendDomain selectSmsSendDetail(SmsSendDomain param) {
		return (SmsSendDomain) baseDao.getObject("smsSend.selectDetail", param);
	}

}
