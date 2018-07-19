package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.AdminCodeDomain;
import or.kr.kbiz.bo.admin.service.CodeService;
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
public class CodeServiceImpl implements CodeService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<AdminCodeDomain> selectCodeList(AdminCodeDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("code.selectCodeTotalCount", param));
		return baseDao.getList("code.select", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AdminCodeDomain> selectCommLcodeList(AdminCodeDomain param) {
		return baseDao.getList("code.selectLcode", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AdminCodeDomain> selectCommMcodeList(AdminCodeDomain param) {
		return baseDao.getList("code.selectMcode", param);
	}

	@Override
	public AdminCodeDomain selectCodeDetail(AdminCodeDomain param) {
		return (AdminCodeDomain) baseDao.getObject("code.selectDetail", param);
	}

	@Override
	public void saveCode(AdminCodeDomain param) {
		baseDao.insert("code.insertCode", param);
	}

	@Override
	public AdminCodeDomain selectCodeCheck(AdminCodeDomain param) {
		return (AdminCodeDomain) baseDao.getObject("code.selectCheck", param);
	}

	@Override
	public void codeUpdate(AdminCodeDomain param) {
		baseDao.getObject("code.updateCode", param);
	}
}
