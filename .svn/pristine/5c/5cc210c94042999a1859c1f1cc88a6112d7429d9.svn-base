package or.kr.kbiz.bo.admin.service;

import java.util.List;

import or.kr.kbiz.bo.admin.domain.AdminCodeDomain;
import or.kr.kbiz.bo.admin.domain.AdminMenuDomain;
/**
 * <pre>CodeService</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
public interface MenuService {

	/**
	 * 목록 조회 템플릿
	 *
	 * @param param
	 * @return List<AdminMenuDomain>
	 */
	abstract List<AdminMenuDomain> selectMenuList(AdminMenuDomain param);
	
	/**
	 * 대분류코드 템플릿
	 *
	 * @param param
	 * @return selectCommLcodeList
	 */
	abstract List<AdminMenuDomain> selectCommFMenuList(AdminMenuDomain codeDomain);
	
	/**
	 * 상세목록 조회 템플릿
	 *
	 * @param param
	 * @return AdminCodeDomain
	 */
	abstract AdminMenuDomain selectMenuDetail(AdminMenuDomain param);
	
	/**
	 * 입력값 중복조회 템플릿
	 *
	 * @param param
	 * @return AdminCodeDomain
	 */
	abstract AdminMenuDomain selectMenuCheck(AdminMenuDomain menuDomain);

	/**
	 * 저장 템플릿
	 *
	 * @param param
	 * @return saveCode
	 */
	abstract void saveMenu(AdminMenuDomain menuDomain);

	/**
	 * 수정 템플릿
	 *
	 * @param param
	 * @return AdminMenuDomain
	 */
	abstract void menuUpdate(AdminMenuDomain menuDomain);
	
	/**
	 * 삭제 템플릿
	 *
	 * @param param
	 * @return AdminMenuDomain
	 */
	abstract void menuDelete(AdminMenuDomain menuDomain);
}
