package or.kr.kbiz.bo.admin.service;

import java.util.List;

import or.kr.kbiz.bo.admin.domain.SpecialDomain;
/**
 * <pre>SpecialService</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
public interface SpecialService {
	/**
	 * 목록 조회 템플릿
	 *
	 * @param param
	 * @return List<SpecialDomain>
	 */
	abstract List<SpecialDomain> selectSpecialList(SpecialDomain param);

	/**
	 * 상세 조회 템플릿
	 *
	 * @param param
	 * @return SpecialDomain
	 */
	abstract SpecialDomain selectSpecialDetail(SpecialDomain param);

	/**
	 * 저장 템플릿
	 *
	 * @param param
	 * @return SpecialDomain
	 */
	abstract void saveSpecial(SpecialDomain param);


}
