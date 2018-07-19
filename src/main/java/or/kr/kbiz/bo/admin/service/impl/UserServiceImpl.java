package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.UserDomain;
import or.kr.kbiz.bo.admin.service.UserService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>사용자 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class UserServiceImpl implements UserService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<UserDomain> selectUserList(UserDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("user.selectUserTotalCount", param));
		return baseDao.getList("user.select", param);
	}

	public UserDomain selectUserDetail(UserDomain param) {
		return (UserDomain) baseDao.getObject("user.selectDetail", param);
	}

	public void userPwdInit(UserDomain param){
		baseDao.update("user.initUser", param);
		baseDao.insert("user.pwdInitUser", param);
	}

	public void gradeUpdUser(UserDomain param){
		baseDao.update("user.gradeUpdUser", param);
	}
}
