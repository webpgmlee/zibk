package or.kr.kbiz.bo.admin.service;

import java.util.List;

import or.kr.kbiz.bo.admin.domain.AdminCodeDomain;
/**
 * <pre>CodeService</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
public interface CodeService {

	/**
	 * 목록 조회 템플릿
	 *
	 * @param param
	 * @return List<AdminCodeDomain>
	 */
	abstract List<AdminCodeDomain> selectCodeList(AdminCodeDomain param);

	/**
	 * 대분류코드 템플릿
	 *
	 * @param param
	 * @return selectCommLcodeList
	 */
	abstract List<AdminCodeDomain> selectCommLcodeList(AdminCodeDomain codeDomain);

	/**
	 * 중분류코드 템플릿
	 *
	 * @param param
	 * @return AdminCodeDomain
	 */
	abstract List<AdminCodeDomain> selectCommMcodeList(AdminCodeDomain codeDomain);

	/**
	 * 상세목록 조회 템플릿
	 *
	 * @param param
	 * @return AdminCodeDomain
	 */
	abstract AdminCodeDomain selectCodeDetail(AdminCodeDomain codeDomain);

	/**
	 * 저장 템플릿
	 *
	 * @param param
	 * @return saveCode
	 */
	abstract void saveCode(AdminCodeDomain codeDomain);

	/**
	 * 입력값 중복조회 템플릿
	 *
	 * @param param
	 * @return AdminCodeDomain
	 */
	abstract AdminCodeDomain selectCodeCheck(AdminCodeDomain codeDomain);

	/**
	 * 수정 템플릿
	 *
	 * @param param
	 * @return AdminCodeDomain
	 */
	abstract void codeUpdate(AdminCodeDomain codeDomain);

}
