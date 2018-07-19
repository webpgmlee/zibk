package or.kr.kbiz.bo.batch.service;

import java.util.List;

import or.kr.kbiz.bo.batch.domain.RenewOrngDomain;
import or.kr.kbiz.bo.batch.domain.RenewUserDomain;

/**
 * 사용자 및 조직정보 갱신 배치 서비스
 *
 * @author hyeok
 * @since 2017.12.20
 * @version 1.0
 */
public interface RenewUserBatchService {
	/**
	 * 두레 사용자 목록 조회
	 *
	 * @return List<RenewUserDomain>
	 */
	abstract List<RenewUserDomain> selectOraintUserList();

	/**
	 * 두레 조직도 목록 조회
	 *
	 * @return List<RenewOrngDomain>
	 */
	abstract List<RenewOrngDomain> selectOraintOrngList();

	/**
	 * 두레 조직도 저장
	 *
	 * @param renewOrngDomain
	 * @return String [I: 신규, U: 수정]
	 */
	abstract String saveOrng(RenewOrngDomain renewOrngDomain);

	/**
	 * 두레 사용자 저장
	 *
	 * @param renewUserDomain
	 * @return String [I: 신규, U: 수정]
	 */
	abstract String saveUser(RenewUserDomain renewUserDomain);
}
