package or.kr.kbiz.bo.admin.service;

import java.util.List;

import or.kr.kbiz.bo.admin.domain.CnltProcStatDomain;
/**
 * <pre>CnltProcStatService</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
public interface CnltProcStatService {

	/**
	 * 목록 조회 템플릿
	 *
	 * @param param
	 * @return List<CnltProcStatDomain>
	 */
	abstract List<CnltProcStatDomain> selectCnltProcStatList(CnltProcStatDomain param);

}
