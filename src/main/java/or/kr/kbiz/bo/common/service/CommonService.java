package or.kr.kbiz.bo.common.service;

import java.util.List;

import or.kr.kbiz.bo.common.domain.BatchLogDomain;
import or.kr.kbiz.bo.common.domain.CommonCodeDomain;
import or.kr.kbiz.bo.common.domain.CommonMngtMenuDomain;

/**
 * 공통서비스
 *
 * @author hyeok
 * @since 20171109
 */
public interface CommonService {

	/**
	 * 서버(DB)시간 조회
	 *
	 * @param format
	 * @return
	 */
	abstract String getServerDateTime(String format);

	/**
	 * 대분류별 공통코드 조회
	 *
	 * @param commonCodeDomain
	 * @return List<CommonCodeDomain>
	 */
	abstract List<CommonCodeDomain> getCommonCodeList(CommonCodeDomain commonCodeDomain);

	/**
	 * 중분류별 공통코드 조회
	 *
	 * @param commonCodeDomain
	 * @return CommonCodeDomain
	 */
	abstract CommonCodeDomain getCommonCodeOne(CommonCodeDomain commonCodeDomain);

	/**
	 * 메뉴관리 상단메뉴 조회
	 *
	 * @param commonMngtMenuDomain
	 * @return List<CommonMngtMenuDomain>
	 */
	abstract List<CommonMngtMenuDomain> getFirstMngtMenuList(CommonMngtMenuDomain commonMngtMenuDomain);

	/**
	 * 메뉴관리 레프트메뉴 조회
	 *
	 * @param commonMngtMenuDomain
	 * @return List<CommonMngtMenuDomain>
	 */
	abstract List<CommonMngtMenuDomain> getSecondMngtMenuList(CommonMngtMenuDomain commonMngtMenuDomain);

	/**
	 * 배치결과 저장
	 * @param batchLogDomain
	 */
	abstract void insertBatchLog(BatchLogDomain batchLogDomain);
}
