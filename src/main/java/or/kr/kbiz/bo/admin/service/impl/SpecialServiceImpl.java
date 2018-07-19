package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.SpecialDomain;
import or.kr.kbiz.bo.admin.service.SpecialService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>특이성향 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class SpecialServiceImpl implements SpecialService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<SpecialDomain> selectSpecialList(SpecialDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("special.selectSpecialTotalCount", param));
		return baseDao.getList("special.select", param);
	}

	@Override
	public SpecialDomain selectSpecialDetail(SpecialDomain param) {
		return (SpecialDomain) baseDao.getObject("special.selectDetail", param);
	}

	@Override
	public void saveSpecial(SpecialDomain param) {
		baseDao.update("special.updateSpecial", param);
	}
}
