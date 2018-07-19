package or.kr.kbiz.bo.mypage.service;

import java.util.List;

import or.kr.kbiz.bo.mypage.domain.MypageDomain;

/**
 * <pre>MypageService</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
public interface MypageService {

	/**
	 * 목록 조회 템플릿
	 *
	 * @param param
	 * @return List<MypageDomain>
	 */
	abstract List<MypageDomain> selectMypageList(MypageDomain param);

	/**
	 * 상세 조회 템플릿
	 *
	 * @param param
	 * @return MypageDomain
	 */
	abstract MypageDomain selectMypageDetail(MypageDomain param);

	/**
	 * 인입채널 조회 템플릿
	 *
	 * @param param
	 * @return List<MypageDomain>
	 */
	abstract List<MypageDomain> selectChCodeList(MypageDomain param);

	/**
	 * 대분류 조회 템플릿
	 *
	 * @param param
	 * @return List<MypageDomain>
	 */
	abstract List<MypageDomain> selectMypageLcodeList(MypageDomain param);

	/**
	 * 중분류 조회 템플릿
	 *
	 * @param param
	 * @return List<MypageDomain>
	 */
	abstract List<MypageDomain> selectMypageMcodeList(MypageDomain param);

	/**
	 * 소분류 조회 템플릿
	 *
	 * @param param
	 * @return List<MypageDomain>
	 */
	abstract List<MypageDomain> selectMypageScodeList(MypageDomain param);
}
