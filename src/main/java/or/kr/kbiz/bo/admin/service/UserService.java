package or.kr.kbiz.bo.admin.service;

import java.util.List;

import or.kr.kbiz.bo.admin.domain.UserDomain;
/**
 * <pre>UserService</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
public interface UserService {

	/**
	 * 목록 조회 템플릿
	 *
	 * @param param
	 * @return List<UserDomain>
	 */
	abstract List<UserDomain> selectUserList(UserDomain param);

	/**
	 * 상세 조회 템플릿
	 *
	 * @param param
	 * @return UserDomain
	 */
	abstract UserDomain selectUserDetail(UserDomain param);

	/**
	 * 비밀번호 초기화 템플릿
	 *
	 * @param param
	 * @return UserDomain
	 */
	abstract void userPwdInit(UserDomain param);

	/**
	 * 사용자등급 변경  템플릿
	 *
	 * @param param
	 * @return UserDomain
	 */
	abstract void gradeUpdUser(UserDomain param);
}
