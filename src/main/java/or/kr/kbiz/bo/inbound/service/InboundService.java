package or.kr.kbiz.bo.inbound.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import or.kr.kbiz.bo.admin.domain.ScriptDomain;
import or.kr.kbiz.bo.admin.domain.UserDomain;
import or.kr.kbiz.bo.inbound.domain.CallbackDomain;
import or.kr.kbiz.bo.inbound.domain.CodeDomain;
import or.kr.kbiz.bo.inbound.domain.ConsultDetailDomain;
import or.kr.kbiz.bo.inbound.domain.ConsultDomain;
import or.kr.kbiz.bo.inbound.domain.CustomerDomain;
import or.kr.kbiz.bo.inbound.domain.InboundSpecialDomain;
import or.kr.kbiz.bo.inbound.domain.MessengerDomain;
import or.kr.kbiz.bo.inbound.domain.OrganizationDomain;
import or.kr.kbiz.bo.inbound.domain.SmsDomain;
import or.kr.kbiz.bo.inbound.domain.UntyCntrDomain;
import or.kr.kbiz.bo.inbound.domain.VocDomain;

public interface InboundService {

	abstract List<CodeDomain> selectCustCode();

	/**
	 * 고객 검색조건 조회
	 *
	 * @param CustomerDomain
	 * @return List<CustomerDomain>
	 */
	abstract List<CustomerDomain> selectCsSearch(CustomerDomain custDomain);

	/**
	 * 고객/계약 카운트 조회
	 *
	 * @param CustomerDomain
	 * @return List<CustomerDomain>
	 */
	abstract List<CustomerDomain> selectCustomerCount(CustomerDomain custlDomain);

	/**
	 * 고객조회 상담시작
	 *
	 * @param CustomerDomain
	 * @return CustomerDomain
	 */
	abstract CustomerDomain selectStartCon(CustomerDomain custlDomain);

	/**
	 * 고객조회
	 *
	 * @param CustomerDomain
	 * @return List<UntyCsDomain>
	 */
	abstract List<CustomerDomain> selectCustomer(CustomerDomain custlDomain);

	/**
	 * 고객조회
	 *
	 * @param CustomerDomain
	 * @return List<UntyCsDomain>
	 */
	abstract CustomerDomain selectCustomer2(CustomerDomain custlDomain);

	/**
	 * 계약조회
	 *
	 * @param CustomerDomain
	 * @return List<UntyCntrDomain>
	 */
	abstract List<UntyCntrDomain> selectContract(CustomerDomain cntrDomain);

	/**
	 * 계약상세
	 *
	 * @param CustomerDomain
	 * @return List<CustomerDomain>
	 */
	abstract CustomerDomain selectCntrDetail(CustomerDomain cntrDomain);

	/**
	 * 콜백선점여부
	 *
	 * @param String
	 * @return String
	 */
	abstract String callbackYn(int callbackSeq);

	/**
	 * 콜백선점ID체크
	 *
	 * @param CallbackDomain
	 * @return String
	 */
	abstract String callbackModYn(CallbackDomain cbd);

	/**
	 * 특이성향 여부 조회
	 *
	 * @param String
	 * @return String
	 */
	abstract String selectSpclAppvYn(String untyCsno);

	/**
	 * 특이성향 여부 조회(미고객)
	 *
	 * @param String
	 * @return String
	 */
	abstract String selectSpclAppvYn2(String tlno);


	/**
	 * 상담이력리스트(상세) 조회
	 *
	 * @param ConsultDetailDomain
	 * @return List<ConsultDetailDomain>
	 */
	abstract List<ConsultDetailDomain> selectConsultDetailList(ConsultDetailDomain consultDetailDomain);

	/**
	 * 상담이력선택 조회
	 *
	 * @param ConsultDetailDomain
	 * @return List<ConsultDetailDomain>
	 */
	abstract ConsultDetailDomain selectConsultInfoDetail(ConsultDetailDomain consultDetailDomain);

	/**
	 * 상담이력 검색(상담사기준)
	 *
	 * @param ConsultDetailDomain
	 * @return List<ConsultDetailDomain>
	 */
	abstract List<ConsultDetailDomain> selectConsultSearchList(ConsultDetailDomain consultDetailDomain);

	/**
	 * 상담이력 검색(고객기준)
	 *
	 * @param ConsultDetailDomain
	 * @return List<ConsultDetailDomain>
	 */
	abstract List<ConsultDetailDomain> selectConsultSearchList2(ConsultDetailDomain consultDetailDomain);

	/**
	 * 상담 저장
	 *
	 * @param ConsultDetailDomain
	 * @return int
	 */
	abstract ConsultDetailDomain insertConsult(ConsultDetailDomain consultDetailDomain);

	/**
	 * 예약저장
	 *
	 * @param ConsultDetailDomain
	 * @return int
	 */
	abstract Integer insertRsrv(ConsultDetailDomain consultDetailDomain);

	/**
	 * 이관저장
	 *
	 * @param ConsultDetailDomain
	 * @return int
	 */
	abstract Integer insertTran(ConsultDetailDomain consultDetailDomain);

	/**
	 * 콜백 리스트 조회
	 *
	 * @param CallbackDomain
	 * @return List<CallbackDomain>
	 */
	abstract List<CallbackDomain> selectCallbackList(CallbackDomain callbackDomain);

	/**
	 * 콜백 총개수 조회
	 *
	 * @param CallbackDomain
	 * @return CallbackDomain
	 */
	abstract CallbackDomain selectCallbackTotalCnt(CallbackDomain callbackDomain);

	/**
	 * 콜백 선점
	 *
	 * @param CallbackDomain
	 * @return
	 */
	abstract void callBackProc(CallbackDomain callbackDomain);

	/**
	 * 예약전화 리스트 조회
	 *
	 * @param ConsultDetailDomain
	 * @return List<ConsultDetailDomain>
	 */
	abstract List<ConsultDetailDomain> selectRsrvList(ConsultDetailDomain consultDetailDomain);

	/**
	 * 예약전화 상세 조회(상담정보)
	 *
	 * @param consultDetailDomain
	 * @return ConsultDetailDomain
	 */
	abstract ConsultDetailDomain selectConsultRsrvDetail(ConsultDetailDomain consultDetailDomain);

	/**
	 * 예약전화 상세 조회(고객정보)
	 *
	 * @param consultDetailDomain
	 * @return ConsultDetailDomain
	 */
	abstract CustomerDomain selectConsultRsrvDetail2(ConsultDetailDomain consultDetailDomain);

	/**
	 * 이관내역 상세 조회(상담정보)
	 *
	 * @param consultDetailDomain
	 * @return ConsultDetailDomain
	 */
	abstract ConsultDetailDomain selectConsultTranDetail(ConsultDetailDomain consultDetailDomain);

	/**
	 * 이관내역 상세 조회(고객정보)
	 *
	 * @param consultDetailDomain
	 * @return ConsultDetailDomain
	 */
	abstract CustomerDomain selectConsultTranDetail2(ConsultDetailDomain consultDetailDomain);

	/**
	 * 이관내역 조회
	 *
	 * @param consultDetailDomain
	 * @return ConsultDetailDomain
	 */
	abstract List<ConsultDetailDomain> selectTransList(ConsultDetailDomain consultDetailDomain);

	/**
	 * 스크립트조회
	 *
	 * @param CodeDomain
	 * @return List<ScriptDomain>
	 */
	abstract List<CodeDomain> selectScript(CodeDomain codeDomain);

	/**
	 * 스크립트조회2
	 *
	 * @param CodeDomain
	 * @return List<ScriptDomain>
	 */
	abstract List<ScriptDomain> selectScript2(CodeDomain codeDomain);

	/**
	 * 스크립트상세조회
	 *
	 * @param CodeDomain
	 * @return ScriptDomain
	 */
	abstract ScriptDomain selectScriptDetail(String scrpNo);

	/**
	 * 스크립트파일다운로드
	 *
	 * @param scriptDomain
	 * @return
	 */
	abstract void downloadFile(ScriptDomain scriptDomain, HttpServletRequest request, HttpServletResponse response) throws Exception;

	/**
	 * 코드조회
	 *
	 * @param
	 * @return List<CodeDomain>
	 */
	abstract List<CodeDomain> selectCode();

	/**
	 * 대분류코드조회
	 *
	 * @param
	 * @return List<CodeDomain>
	 */
	abstract List<CodeDomain> selectChCode();

	/**
	 * 대분류코드조회
	 *
	 * @param CodeDomain
	 * @return List<CodeDomain>
	 */
	abstract List<CodeDomain> selectLcode(CodeDomain codeDomain);

	/**
	 * 중분류코드조회
	 *
	 * @param CodeDomain
	 * @return List<CodeDomain>
	 */
	abstract List<CodeDomain> selectMcode(CodeDomain codeDomain);

	/**
	 * 소분류코드조회
	 *
	 * @param CodeDomain
	 * @return List<CodeDomain>
	 */
	abstract List<CodeDomain> selectScode(CodeDomain codeDomain);

	/**
	 * 상담원조회
	 *
	 * @param
	 * @return List<UserDomain>
	 */
	abstract List<UserDomain> selectUserList();

	/**
	 * sms히스토리저장
	 *
	 * @param String
	 * @return
	 */
	abstract void insertSms(Map<String, String> map);

	/**
	 * sms전송
	 *
	 * @param String
	 * @return
	 */
	abstract void sendSms(Map<String, String> map);

	/**
	 * lms전송
	 *
	 * @param String
	 * @return
	 */
	abstract void sendSms2(Map<String, Object> map);


	/**
	 * 특이성향고객조회
	 *
	 * @param String
	 * @return
	 */
	abstract List<InboundSpecialDomain> selectSpecial(ConsultDetailDomain cdd);

	/**
	 * 특이성향고객저장
	 *
	 * @param String
	 * @return
	 */
	abstract void insertSpecial(ConsultDetailDomain consultDetailDomain);

	/**
	 * 조직도조회
	 *
	 * @param String
	 * @return
	 */
	abstract List<OrganizationDomain> selectOrganization(OrganizationDomain ornglDomain);

	/**
	 * 부서원조회
	 *
	 * @param String
	 * @return
	 */
	abstract List<OrganizationDomain> organizationSearch(OrganizationDomain ornglDomain);

	/**
	 * 조건조회
	 *
	 * @param String
	 * @return
	 */
	abstract List<OrganizationDomain> orgnSearch(String kbizNm, String kbizId);

	/**
	 * AP상담관리자
	 *
	 * @param String
	 * @return
	 */
	abstract List<OrganizationDomain> selectAdminList();

	/**
	 * VOC내부저장
	 *
	 * @param VOCDOMAIN
	 * @return
	 */
	abstract void vocReg(VocDomain vocDomain);

	/**
	 * SMS고객이력
	 *
	 * @param SmsDomain
	 * @return List<SmsDomain>
	 */
	abstract List<SmsDomain> smsList(SmsDomain smsDomain);

	/**
	 * SMS 상세
	 *
	 * @param SmsDomain
	 * @return SmsDomain
	 */
	abstract SmsDomain smsDetail(SmsDomain smsDomain);

	/**
	 * 메신저 전송
	 *
	 * @param messengerDomain
	 */
	abstract void insertMesg(MessengerDomain messengerDomain);
}
