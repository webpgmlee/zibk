package or.kr.kbiz.bo.batch.service;

import java.util.List;

import or.kr.kbiz.bo.batch.domain.RenewIfCaUntycntrDomain;
import or.kr.kbiz.bo.batch.domain.RenewIfCmAdrDomain;
import or.kr.kbiz.bo.batch.domain.RenewIfCmCnplDomain;
import or.kr.kbiz.bo.batch.domain.RenewIfCmEmailDomain;
import or.kr.kbiz.bo.batch.domain.RenewIfCmUntycsDomain;

/**
 * 고객 정보 갱신 배치 서비스
 *
 * @author hyeok
 * @since 2017.12.20
 * @version 1.0
 */
public interface RenewUntyBatchService {
	/**
	 * 차세대 통합계약 테이블 배치 대상 데이터 조회
	 *
	 * @param diffDay
	 * @return List<RenewIfCaUntycntrDomain>
	 */
	abstract List<RenewIfCaUntycntrDomain> selectIfCaUntycntrList(int diffDay);

	/**
	 * 차세대 통합고객 테이블 배치 대상 데이터 조회
	 *
	 * @param diffDay
	 * @return List<RenewIfCmUntycsDomain>
	 */
	abstract List<RenewIfCmUntycsDomain> selectIfCmUntycsList(int diffDay);

	/**
	 * 차세대 고객전화번호 테이블 배치 대상 데이터 조회
	 *
	 * @param diffDay
	 * @return List<RenewIfCmCnplDomain>
	 */
	abstract List<RenewIfCmCnplDomain> selectIfCmCnplList(int diffDay);

	/**
	 * 차세대 고객주소 테이블 배치 대상 데이터 조회
	 *
	 * @param diffDay
	 * @return List<RenewIfCmAdrDomain>
	 */
	abstract List<RenewIfCmAdrDomain> selectIfCmAdrList(int diffDay);

	/**
	 * 차세대 고객이메일 테이블 배치 대상 데이터 조회
	 *
	 * @param diffDay
	 * @return List<RenewIfCmEmailDomain>
	 */
	abstract List<RenewIfCmEmailDomain> selectIfCmEmailList(int diffDay);

	/**
	 * 차세대 통합계약 테이블 배치 대상 데이터 저장
	 *
	 * @param renewIfCaUntycntrDomain
	 */
	abstract void saveIfCaUntycntr(RenewIfCaUntycntrDomain renewIfCaUntycntrDomain);

	/**
	 * 차세대 통합고객 테이블 배치 대상 데이터 저장
	 *
	 * @param renewIfCmUntycsDomain
	 */
	abstract void saveIfCmUntycs(RenewIfCmUntycsDomain renewIfCmUntycsDomain);

	/**
	 * 차세대 고객전화번호 테이블 배치 대상 데이터 저장
	 *
	 * @param renewIfCmCnplDomain
	 */
	abstract void saveIfCmCnpl(RenewIfCmCnplDomain renewIfCmCnplDomain);

	/**
	 * 차세대 고객주소 테이블 배치 대상 데이터 저장
	 *
	 * @param renewIfCmAdrDomain
	 */
	abstract void saveIfCmAdr(RenewIfCmAdrDomain renewIfCmAdrDomain);

	/**
	 * 차세대 고객이메일 테이블 배치 대상 데이터 저장
	 *
	 * @param renewIfCmEmailDomain
	 */
	abstract void saveIfCmEmail(RenewIfCmEmailDomain renewIfCmEmailDomain);
}
