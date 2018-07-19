package or.kr.kbiz.bo.batch.domain;

public class RenewIfCaUntycntrDomain {
	private String untyCntrNo; // 통합계약번호
	private String ddctBizDscd; // 공제사업구분코드[1: 전체(AP코드없음), 2: A, 3: B, 4: 손해공제(AP코드없음), 5: PL단체보험(AP코드없음), 6: 보증공제(AP코드없음)]
	private String cntrNo; // 계약번호[실제 공제회 계약번호]
	private String prdCd; // 상품코드(현재 미사용)
	private String nregBzpnYn; // 무등록사업자여부[Y/N]
	private String cntrBgnDt; // 계약시작일자
	private String cntrEndDt; // 계약종료일자
	private String abndYn; // 해지여부[Y/N]
	private String postTrsplDscd; // 우편발송지구분코드
	private String smsYn; // sms 수신동의 여부
	private String dlgtUntyCsno; // 대표자고객번호
	private String bzplUntyCsno; // 사업장고객번호
	private String bzenChrpnNm; // 업체담당자명
	private String fnlUdtDtm; // 최종수정일시
	private String untyCsno; // 통합고객번호


	public String getUntyCntrNo() {
		return untyCntrNo;
	}
	public void setUntyCntrNo(String untyCntrNo) {
		this.untyCntrNo = untyCntrNo;
	}
	public String getDdctBizDscd() {
		return ddctBizDscd;
	}
	public void setDdctBizDscd(String ddctBizDscd) {
		this.ddctBizDscd = ddctBizDscd;
	}
	public String getCntrNo() {
		return cntrNo;
	}
	public void setCntrNo(String cntrNo) {
		this.cntrNo = cntrNo;
	}
	public String getPrdCd() {
		return prdCd;
	}
	public void setPrdCd(String prdCd) {
		this.prdCd = prdCd;
	}
	public String getNregBzpnYn() {
		return nregBzpnYn;
	}
	public void setNregBzpnYn(String nregBzpnYn) {
		this.nregBzpnYn = nregBzpnYn;
	}
	public String getCntrBgnDt() {
		return cntrBgnDt;
	}
	public void setCntrBgnDt(String cntrBgnDt) {
		this.cntrBgnDt = cntrBgnDt;
	}
	public String getCntrEndDt() {
		return cntrEndDt;
	}
	public void setCntrEndDt(String cntrEndDt) {
		this.cntrEndDt = cntrEndDt;
	}
	public String getAbndYn() {
		return abndYn;
	}
	public void setAbndYn(String abndYn) {
		this.abndYn = abndYn;
	}
	public String getPostTrsplDscd() {
		return postTrsplDscd;
	}
	public void setPostTrsplDscd(String postTrsplDscd) {
		this.postTrsplDscd = postTrsplDscd;
	}
	public String getSmsYn() {
		return smsYn;
	}
	public void setSmsYn(String smsYn) {
		this.smsYn = smsYn;
	}
	public String getDlgtUntyCsno() {
		return dlgtUntyCsno;
	}
	public void setDlgtUntyCsno(String dlgtUntyCsno) {
		this.dlgtUntyCsno = dlgtUntyCsno;
	}
	public String getBzplUntyCsno() {
		return bzplUntyCsno;
	}
	public void setBzplUntyCsno(String bzplUntyCsno) {
		this.bzplUntyCsno = bzplUntyCsno;
	}
	public String getBzenChrpnNm() {
		return bzenChrpnNm;
	}
	public void setBzenChrpnNm(String bzenChrpnNm) {
		this.bzenChrpnNm = bzenChrpnNm;
	}
	public String getFnlUdtDtm() {
		return fnlUdtDtm;
	}
	public void setFnlUdtDtm(String fnlUdtDtm) {
		this.fnlUdtDtm = fnlUdtDtm;
	}
	public String getUntyCsno() {
		return untyCsno;
	}
	public void setUntyCsno(String untyCsno) {
		this.untyCsno = untyCsno;
	}
}
