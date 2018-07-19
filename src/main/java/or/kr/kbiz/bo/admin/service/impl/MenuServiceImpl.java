package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.AdminCodeDomain;
import or.kr.kbiz.bo.admin.domain.AdminMenuDomain;
import or.kr.kbiz.bo.admin.service.MenuService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>공통코드 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class MenuServiceImpl implements MenuService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<AdminMenuDomain> selectMenuList(AdminMenuDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("menu.selectCodeTotalCount", param));
		return baseDao.getList("menu.select", param);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AdminMenuDomain> selectCommFMenuList(AdminMenuDomain param) {
		return baseDao.getList("menu.selectFMenu", param);
	}
	

	@Override
	public AdminMenuDomain selectMenuDetail(AdminMenuDomain param) {
		return (AdminMenuDomain) baseDao.getObject("menu.selectDetail", param);
	}
	
	@Override
	public AdminMenuDomain selectMenuCheck(AdminMenuDomain param) {
		return (AdminMenuDomain) baseDao.getObject("menu.selectCheck", param);
	}
	

	@Override
	public void saveMenu(AdminMenuDomain param) {
		baseDao.insert("menu.insertMenu", param);
	}

	@Override
	public void menuUpdate(AdminMenuDomain param) {
		baseDao.getObject("menu.updateMenu", param);
	}

	@Override
	public void menuDelete(AdminMenuDomain param) {
		baseDao.getObject("menu.deleteMenu", param);
	}
	
}
