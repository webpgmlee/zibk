package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.CnltProcStatDomain;
import or.kr.kbiz.bo.admin.service.CnltProcStatService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>처리구분별통계 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class CnltProcStatServiceImpl implements CnltProcStatService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<CnltProcStatDomain> selectCnltProcStatList(CnltProcStatDomain param) {
		return baseDao.getList("cnltProcStat.select",param);
	}
}
