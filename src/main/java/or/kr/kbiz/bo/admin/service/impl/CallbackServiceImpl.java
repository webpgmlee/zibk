package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.AdminCallbackDomain;
import or.kr.kbiz.bo.admin.service.CallbackService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>콜백내역 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class CallbackServiceImpl implements CallbackService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<AdminCallbackDomain> selectCallbackList(AdminCallbackDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("callback.selectCallbackTotalCount", param));
		return baseDao.getList("callback.select", param);
	}

	@Override
	public AdminCallbackDomain selectCallbackDetail(AdminCallbackDomain param) {
		return (AdminCallbackDomain) baseDao.getObject("callback.selectDetail", param);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<AdminCallbackDomain> selectChCodeList(AdminCallbackDomain param) {
		return baseDao.getList("callback.selectChCodeList", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AdminCallbackDomain> selectCallbackExcelList(AdminCallbackDomain param) {
		return baseDao.getList("callback.selectExcel", param);
	}
}
