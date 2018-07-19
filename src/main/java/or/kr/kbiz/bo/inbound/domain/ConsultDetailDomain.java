package or.kr.kbiz.bo.inbound.domain;

import or.kr.kbiz.serv.spring.mvc.BaseDomain;

public class ConsultDetailDomain extends BaseDomain{
	private String cntrNo; // 계약번호
	private String custNo; // 통합고객번호
	private String cnltSeq; // 상담번호
	private Integer cnltDetailNo; // 상담상세번호
	private String cnltProcCd; // 처리구분
	private String cnltDate; // 상담일자
	private String callStartDate; // 상담시작일시
	private String callEndDate; // 상담종료일시
	private String startDate; // 상담검색 시작일시
	private String endDate; // 상담검색 종료일시
	private String tellNum; // 전화번호
	private String callYn; // 통화여부
	private String ioType; // Inbound/Outbound 타입
	private String recUrl; // 녹취URL
	private String recKey; // 녹취KEY
	private String recvNote; // 상담문의
	private String procNote; // 상담답변
	private String userId; // 상담원ID
	private String userNm; // 상담원이름
	private String chnlCode; // 인입채널코드
	private String scode; // 소분류
	private String mcode; // 중분류
	private String lcode; // 대분류
	private String tranId; // 이관처리담당자ID
	private String rsrvDate; // 예약일시
	private String rsrvTellNum; // 예약전화번호
	private String regId; // 등록자ID
	private String regDate; // 등록일자
	private String modId; // 수정자ID
	private String modDate; // 수정일자
	private String custNm; // 고객명
	private String tranNm; // 이관받은 담당자
	private String regNm; // 이관자
	private String codeName; // 코드이름 (th_cdoe)
	private Integer callbackSeq; // 콜백시퀀스
	private String untyCntrNo; // 통합계약번호
	private String untyCsno; // 고객번호
	private String spclCont; // 특이성향
	private String needsType; // 민원유형(VOC)
	private String kbizId; // VOC 이관아이디
	private String juminTemp;
	private Integer seq;

	public String getCntrNo() {
		return cntrNo;
	}
	public void setCntrNo(String cntrNo) {
		this.cntrNo = cntrNo;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getCnltSeq() {
		return cnltSeq;
	}
	public void setCnltSeq(String cnltSeq) {
		this.cnltSeq = cnltSeq;
	}
	public Integer getCnltDetailNo() {
		return cnltDetailNo;
	}
	public void setCnltDetailNo(Integer cnltDetailNo) {
		this.cnltDetailNo = cnltDetailNo;
	}
	public String getCnltProcCd() {
		return cnltProcCd;
	}
	public void setCnltProcCd(String cnltProcCd) {
		this.cnltProcCd = cnltProcCd;
	}
	public String getCnltDate() {
		return cnltDate;
	}
	public void setCnltDate(String cnltDate) {
		this.cnltDate = cnltDate;
	}
	public String getCallStartDate() {
		return callStartDate;
	}
	public void setCallStartDate(String callStartDate) {
		this.callStartDate = callStartDate;
	}
	public String getCallEndDate() {
		return callEndDate;
	}
	public void setCallEndDate(String callEndDate) {
		this.callEndDate = callEndDate;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getTellNum() {
		return tellNum;
	}
	public void setTellNum(String tellNum) {
		this.tellNum = tellNum;
	}
	public String getCallYn() {
		return callYn;
	}
	public void setCallYn(String callYn) {
		this.callYn = callYn;
	}
	public String getIoType() {
		return ioType;
	}
	public void setIoType(String ioType) {
		this.ioType = ioType;
	}
	public String getRecUrl() {
		return recUrl;
	}
	public void setRecUrl(String recUrl) {
		this.recUrl = recUrl;
	}
	public String getRecKey() {
		return recKey;
	}
	public void setRecKey(String recKey) {
		this.recKey = recKey;
	}
	public String getRecvNote() {
		return recvNote;
	}
	public void setRecvNote(String recvNote) {
		this.recvNote = recvNote;
	}
	public String getProcNote() {
		return procNote;
	}
	public void setProcNote(String procNote) {
		this.procNote = procNote;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getChnlCode() {
		return chnlCode;
	}
	public void setChnlCode(String chnlCode) {
		this.chnlCode = chnlCode;
	}
	public String getScode() {
		return scode;
	}
	public void setScode(String scode) {
		this.scode = scode;
	}
	public String getMcode() {
		return mcode;
	}
	public void setMcode(String mcode) {
		this.mcode = mcode;
	}
	public String getLcode() {
		return lcode;
	}
	public void setLcode(String lcode) {
		this.lcode = lcode;
	}
	public String getTranId() {
		return tranId;
	}
	public void setTranId(String tranId) {
		this.tranId = tranId;
	}
	public String getRsrvDate() {
		return rsrvDate;
	}
	public void setRsrvDate(String rsrvDate) {
		this.rsrvDate = rsrvDate;
	}
	public String getRsrvTellNum() {
		return rsrvTellNum;
	}
	public void setRsrvTellNum(String rsrvTellNum) {
		this.rsrvTellNum = rsrvTellNum;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getModDate() {
		return modDate;
	}
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getTranNm() {
		return tranNm;
	}
	public void setTranNm(String tranNm) {
		this.tranNm = tranNm;
	}
	public String getRegNm() {
		return regNm;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public Integer getCallbackSeq() {
		return callbackSeq;
	}
	public void setCallbackSeq(Integer callbackSeq) {
		this.callbackSeq = callbackSeq;
	}
	public String getUntyCntrNo() {
		return untyCntrNo;
	}
	public void setUntyCntrNo(String untyCntrNo) {
		this.untyCntrNo = untyCntrNo;
	}
	public String getUntyCsno() {
		return untyCsno;
	}
	public void setUntyCsno(String untyCsno) {
		this.untyCsno = untyCsno;
	}
	public String getSpclCont() {
		return spclCont;
	}
	public void setSpclCont(String spclCont) {
		this.spclCont = spclCont;
	}
	public String getNeedsType() {
		return needsType;
	}
	public void setNeedsType(String needsType) {
		this.needsType = needsType;
	}
	public String getKbizId() {
		return kbizId;
	}
	public void setKbizId(String kbizId) {
		this.kbizId = kbizId;
	}
	public String getJuminTemp() {
		return juminTemp;
	}
	public void setJuminTemp(String juminTemp) {
		this.juminTemp = juminTemp;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}

}
