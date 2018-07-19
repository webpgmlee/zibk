package or.kr.kbiz.serv.spring.batch;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import or.kr.kbiz.bo.batch.domain.RenewIfCaUntycntrDomain;
import or.kr.kbiz.bo.batch.domain.RenewIfCmAdrDomain;
import or.kr.kbiz.bo.batch.domain.RenewIfCmCnplDomain;
import or.kr.kbiz.bo.batch.domain.RenewIfCmEmailDomain;
import or.kr.kbiz.bo.batch.domain.RenewIfCmUntycsDomain;
import or.kr.kbiz.bo.batch.domain.RenewOrngDomain;
import or.kr.kbiz.bo.batch.domain.RenewUserDomain;
import or.kr.kbiz.bo.batch.service.RenewUntyBatchService;
import or.kr.kbiz.bo.batch.service.RenewUserBatchService;
import or.kr.kbiz.bo.common.domain.BatchLogDomain;
import or.kr.kbiz.bo.common.domain.CommonCodeDomain;
import or.kr.kbiz.bo.common.service.CommonService;

@Component
public class ApBatchScheduledTaskExecutor {

	@Autowired
	@Qualifier("renewUserBatchService")
	private RenewUserBatchService renewUserBatchService;

	@Autowired
	@Qualifier("renewUntyBatchService")
	private RenewUntyBatchService renewUntyBatchService;

	@Autowired
	private CommonService commonService;

	private final Logger LOG = LoggerFactory.getLogger(getClass());

	/**
	 * 두레 조직/사용자 정보 갱신 배치
	 */
	public void intrfcUserAndOrg() {
		/* 배치 실행 가능 서버 확인 */
		if (!isPermittedServer()) {
			return;
		}

		int totalReadCount = 0, failCount = 0, insertCount = 0, updateCount = 0;
		String result;

		/* 두레조직정보 갱신 */
		List<RenewOrngDomain> renewOrngList = renewUserBatchService.selectOraintOrngList();
		if (renewOrngList != null) {
			for (int i = 0; i < renewOrngList.size(); i++) {
				totalReadCount++;
				try {
					result = renewUserBatchService.saveOrng(renewOrngList.get(i));
					if (result.equals("U")) {
						updateCount++;
					} else if (result.equals("I")) {
						insertCount++;
					}
				} catch (Exception e) {
					LOG.error("[ORAINT ORG BATCH]" + e.getMessage());
					failCount++;
				}
			}
		}

		/* 배치결과 */
		StringBuffer sb = new StringBuffer();
		sb.append("Execute intrfcUserAndOrg() result is totalReadCount(");
		sb.append(totalReadCount);
		sb.append("), failCount(");
		sb.append(failCount);
		sb.append("), insertCount(");
		sb.append(insertCount);
		sb.append("), updateCount(");
		sb.append(updateCount);
		sb.append("), successCount(");
		sb.append(insertCount + updateCount);
		sb.append(")");

		/* 배치 로그 저장 */
		BatchLogDomain batchLogDomain = new BatchLogDomain();
		batchLogDomain.setBatchJobId("BATCH.intrfuserAndOrg");
		batchLogDomain.setBatchResult(sb.toString());
		commonService.insertBatchLog(batchLogDomain);

		/* 배치 정보 시스템 출력 */
		LOG.info(sb.toString());

		/* 두레사용자정보 갱신 */
		List<RenewUserDomain> renewUserList = renewUserBatchService.selectOraintUserList();
		if (renewUserList != null) {
			totalReadCount = 0;
			failCount = 0;
			insertCount = 0;
			updateCount = 0;

			String serverDt = commonService.getServerDateTime("yyyyMMdd");
			RenewUserDomain rud;

			for (int i = 0; i < renewUserList.size(); i++) {
				totalReadCount++;
				rud = renewUserList.get(i);
				rud.setEndDt(serverDt);
				rud.setApplDt(serverDt);

				try {
					result = renewUserBatchService.saveUser(rud);
					if (result.equals("U")) {
						updateCount++;
					} else if (result.equals("I")) {
						insertCount++;
					}
				} catch (Exception e) {
					LOG.error("[ORAINT USER BATCH]" + e.getMessage());
					e.printStackTrace();
					failCount++;
				}
			}
		}

		/* 배치결과 */
		sb = new StringBuffer();
		sb.append("Execute intrfcUserAndOrg() result is totalReadCount(");
		sb.append(totalReadCount);
		sb.append("), failCount(");
		sb.append(failCount);
		sb.append("), insertCount(");
		sb.append(insertCount);
		sb.append("), updateCount(");
		sb.append(updateCount);
		sb.append("), successCount(");
		sb.append(insertCount + updateCount);
		sb.append(")");

		/* 배치 로그 저장 */
		batchLogDomain = new BatchLogDomain();
		batchLogDomain.setBatchJobId("BATCH.intrfuserAndOrg");
		batchLogDomain.setBatchResult(sb.toString());
		commonService.insertBatchLog(batchLogDomain);

		/* 배치 정보 시스템 출력 */
		LOG.info(sb.toString());
	}

	/**
	 * 차세대 통합계약 정보 갱신 배치
	 */
	public void intrfIfCaUntycntr() {
		/* 배치 실행 가능 서버 확인 */
		if (!isPermittedServer()) {
			return;
		}

		int totalReadCount = 0, failCount = 0, mergeCount = 0;
		CommonCodeDomain param = new CommonCodeDomain();
		param.setLcode("009");
		param.setMcode("01");
		int diffDay = Integer.parseInt(commonService.getCommonCodeOne(param).getCodeName());

		/* 차세대 통합계약 데이터 저장 */
		List<RenewIfCaUntycntrDomain> resultList = renewUntyBatchService.selectIfCaUntycntrList(diffDay);
		if (resultList != null) {
			for (int i = 0; i < resultList.size(); i++) {
				totalReadCount++;
				LOG.debug("LOOP INTRFIFCAUNTYCNTR() [" + i + "]");
				try {
					renewUntyBatchService.saveIfCaUntycntr(resultList.get(i));
					mergeCount++;
				} catch (Exception e) {
					e.printStackTrace();
					LOG.error(e.getMessage());
					failCount++;
				}
			}
		}

		/* 배치결과 */
		StringBuffer sb = new StringBuffer();
		sb.append("Execute intrfIfCaUntycntr() result is totalReadCount(");
		sb.append(totalReadCount);
		sb.append("), failCount(");
		sb.append(failCount);
		sb.append("), mergeCount(");
		sb.append(mergeCount);
		sb.append("), successCount(");
		sb.append(mergeCount);
		sb.append(")");

		/* 배치 로그 저장 */
		BatchLogDomain batchLogDomain = new BatchLogDomain();
		batchLogDomain.setBatchJobId("BATCH.intrfIfCaUntycntr");
		batchLogDomain.setBatchResult(sb.toString());
		commonService.insertBatchLog(batchLogDomain);

		/* 배치 정보 시스템 출력 */
		LOG.info(sb.toString());
	}

	/**
	 * 차세대 통합고객 정보 갱신 배치
	 */
	public void intrfIfCmUntycs() {
		/* 배치 실행 가능 서버 확인 */
		if (!isPermittedServer()) {
			return;
		}

		int totalReadCount = 0, failCount = 0, mergeCount = 0;
		CommonCodeDomain param = new CommonCodeDomain();
		param.setLcode("009");
		param.setMcode("01");
		int diffDay = Integer.parseInt(commonService.getCommonCodeOne(param).getCodeName());

		/* 차세대 통합고객 데이터 저장 */
		List<RenewIfCmUntycsDomain> resultList = renewUntyBatchService.selectIfCmUntycsList(diffDay);
		if (resultList != null) {
			for (int i = 0; i < resultList.size(); i++) {
				totalReadCount++;
				LOG.debug("LOOP INTRFIFCMUNTYCS() [" + i + "]");
				try {
					renewUntyBatchService.saveIfCmUntycs(resultList.get(i));
					mergeCount++;
				} catch (Exception e) {
					e.printStackTrace();
					LOG.error(e.getMessage());
					failCount++;
				}
			}
		}

		/* 배치결과 */
		StringBuffer sb = new StringBuffer();
		sb.append("Execute intrfIfCmUntycs() result is totalReadCount(");
		sb.append(totalReadCount);
		sb.append("), failCount(");
		sb.append(failCount);
		sb.append("), mergeCount(");
		sb.append(mergeCount);
		sb.append("), successCount(");
		sb.append(mergeCount);
		sb.append(")");

		/* 배치 로그 저장 */
		BatchLogDomain batchLogDomain = new BatchLogDomain();
		batchLogDomain.setBatchJobId("BATCH.intrfIfCmUntycs");
		batchLogDomain.setBatchResult(sb.toString());
		commonService.insertBatchLog(batchLogDomain);

		/* 배치 정보 시스템 출력 */
		LOG.info(sb.toString());
	}

	/**
	 * 차세대 고객이메일 정보 갱신 배치
	 */
	public void intrfIfCmEmail() {
		/* 배치 실행 가능 서버 확인 */
		if (!isPermittedServer()) {
			return;
		}

		int totalReadCount = 0, failCount = 0, mergeCount = 0;
		CommonCodeDomain param = new CommonCodeDomain();
		param.setLcode("009");
		param.setMcode("01");
		int diffDay = Integer.parseInt(commonService.getCommonCodeOne(param).getCodeName());

		/* 차세대 고객이메일 데이터 저장 */
		List<RenewIfCmEmailDomain> resultList = renewUntyBatchService.selectIfCmEmailList(diffDay);
		if (resultList != null) {
			for (int i = 0; i < resultList.size(); i++) {
				totalReadCount++;
				LOG.debug("LOOP INTRFIFCMEMAIL() [" + i + "]");
				try {
					renewUntyBatchService.saveIfCmEmail(resultList.get(i));
					mergeCount++;
				} catch (Exception e) {
					e.printStackTrace();
					LOG.error(e.getMessage());
					failCount++;
				}
			}
		}

		/* 배치결과 */
		StringBuffer sb = new StringBuffer();
		sb.append("Execute intrfIfCmEmail() result is totalReadCount(");
		sb.append(totalReadCount);
		sb.append("), failCount(");
		sb.append(failCount);
		sb.append("), mergeCount(");
		sb.append(mergeCount);
		sb.append("), successCount(");
		sb.append(mergeCount);
		sb.append(")");

		/* 배치 로그 저장 */
		BatchLogDomain batchLogDomain = new BatchLogDomain();
		batchLogDomain.setBatchJobId("BATCH.intrfIfCmEmail");
		batchLogDomain.setBatchResult(sb.toString());
		commonService.insertBatchLog(batchLogDomain);

		/* 배치 정보 시스템 출력 */
		LOG.info(sb.toString());
	}

	/**
	 * 차세대 연락처 정보 갱신 배치
	 */
	public void intrfIfCmCnpl() {
		/* 배치 실행 가능 서버 확인 */
		if (!isPermittedServer()) {
			return;
		}

		int totalReadCount = 0, failCount = 0, mergeCount = 0;
		CommonCodeDomain param = new CommonCodeDomain();
		param.setLcode("009");
		param.setMcode("01");
		int diffDay = Integer.parseInt(commonService.getCommonCodeOne(param).getCodeName());

		/* 차세대 고객전화번호 데이터 저장 */
		List<RenewIfCmCnplDomain> resultList = renewUntyBatchService.selectIfCmCnplList(diffDay);
		if (resultList != null) {
			for (int i = 0; i < resultList.size(); i++) {
				totalReadCount++;
				LOG.debug("LOOP INTRFIFCMCNPL() [" + i + "]");
				try {
					renewUntyBatchService.saveIfCmCnpl(resultList.get(i));
					mergeCount++;
				} catch (Exception e) {
					e.printStackTrace();
					LOG.error(e.getMessage());
					failCount++;
				}
			}
		}

		/* 차세대 고객주소 데이터 저장 */


		/* 배치결과 */
		StringBuffer sb = new StringBuffer();
		sb.append("Execute intrfIfCmCnpl() result is totalReadCount(");
		sb.append(totalReadCount);
		sb.append("), failCount(");
		sb.append(failCount);
		sb.append("), mergeCount(");
		sb.append(mergeCount);
		sb.append("), successCount(");
		sb.append(mergeCount);
		sb.append(")");

		/* 배치 로그 저장 */
		BatchLogDomain batchLogDomain = new BatchLogDomain();
		batchLogDomain.setBatchJobId("BATCH.intrfIfCmCnpl");
		batchLogDomain.setBatchResult(sb.toString());
		commonService.insertBatchLog(batchLogDomain);

		/* 배치 정보 시스템 출력 */
		LOG.info(sb.toString());
	}

	/**
	 * 차세대 고객주소 정보 갱신 배치
	 */
	public void intrfIfCmAdr() {
		/* 배치 실행 가능 서버 확인 */
		if (!isPermittedServer()) {
			return;
		}

		int totalReadCount = 0, failCount = 0, mergeCount = 0;
		CommonCodeDomain param = new CommonCodeDomain();
		param.setLcode("009");
		param.setMcode("01");
		int diffDay = Integer.parseInt(commonService.getCommonCodeOne(param).getCodeName());

		/* 차세대 고객주소 데이터 저장 */
		List<RenewIfCmAdrDomain> resultList = renewUntyBatchService.selectIfCmAdrList(diffDay);
		if (resultList != null) {
			for (int i = 0; i < resultList.size(); i++) {
				totalReadCount++;
				LOG.debug("LOOP INTRFIFCMADR() [" + i + "]");
				try {
					renewUntyBatchService.saveIfCmAdr(resultList.get(i));
					mergeCount++;
				} catch (Exception e) {
					e.printStackTrace();
					LOG.error(e.getMessage());
					failCount++;
				}
			}
		}

		/* 배치결과 */
		StringBuffer sb = new StringBuffer();
		sb.append("Execute intrfIfCmAdr() result is totalReadCount(");
		sb.append(totalReadCount);
		sb.append("), failCount(");
		sb.append(failCount);
		sb.append("), mergeCount(");
		sb.append(mergeCount);
		sb.append("), successCount(");
		sb.append(mergeCount);
		sb.append(")");

		/* 배치 로그 저장 */
		BatchLogDomain batchLogDomain = new BatchLogDomain();
		batchLogDomain.setBatchJobId("BATCH.intrfIfCmAdr");
		batchLogDomain.setBatchResult(sb.toString());
		commonService.insertBatchLog(batchLogDomain);

		/* 배치 정보 시스템 출력 */
		LOG.info(sb.toString());
	}

	/**
	 * 배치 실행 가능 서버 확인
	 *
	 * @return Boolean
	 */
	private boolean isPermittedServer() {
		CommonCodeDomain ccd = new CommonCodeDomain();
		ccd.setLcode("012");
		List<CommonCodeDomain> cList = commonService.getCommonCodeList(ccd);
		boolean isPermitted = false;
		if (cList != null) {
			for (int i = 0; i < cList.size(); i++) {
				CommonCodeDomain comp = cList.get(i);
				if (System.getProperty("user.name").equals(comp.getCodeName())) {
					isPermitted = true;
					break;
				}
			}
		}
		return isPermitted;
	}

}
