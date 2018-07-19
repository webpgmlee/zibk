package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.ReserveCallDomain;
import or.kr.kbiz.bo.admin.service.ReserveCallService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>예약내역 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class ReserveCallServiceImpl implements ReserveCallService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<ReserveCallDomain> selectReserveCallList(ReserveCallDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("reserve.selectReserveCallTotalCount", param));
		return baseDao.getList("reserve.select", param);
	}

	@Override
	public ReserveCallDomain selectReserveCallDetail(ReserveCallDomain param) {
		return (ReserveCallDomain) baseDao.getObject("reserve.selectDetail", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ReserveCallDomain> selectReserveCallExcelList(ReserveCallDomain param) {
		return baseDao.getList("reserve.selectExcel", param);
	}


}
