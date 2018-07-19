package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.UserStatDomain;
import or.kr.kbiz.bo.admin.service.UserStatService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>상담원별통계 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class UserStatServiceImpl implements UserStatService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	@Override
	public List<UserStatDomain> selectUserStatList(UserStatDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("userStat.selectUserStatTotalCount", param));
		return baseDao.getList("userStat.select",param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UserStatDomain> selectUserStatExcelList(UserStatDomain param) {
		return baseDao.getList("userStat.selectExcel",param);
	}
}
