package or.kr.kbiz.bo.batch.domain;

public class RenewIfCmUntycsDomain {
	private String untyCsno; // 통합고객번호
	private String csSrchNo; // 고객검색번호 (주민번호앞자리 | 사업자등록번호)
	private String csDscd; // 고객구분코드 [TH_CODE.LCODE : 006]
	private String csKrnNm; // 고객한글명
	private String csSrchKwrdNm; // 고객검색키워드
	private String rlCsKrnNm; // 관계고객한글명
	private String fnlUdtDtm; // 최종수정일시
	private String csRnno; // 식별번호(임시)
	private String tlno; // 전화번호
	private String codeName; // 고객구분코드이름

	public String getUntyCsno() {
		return untyCsno;
	}
	public void setUntyCsno(String untyCsno) {
		this.untyCsno = untyCsno;
	}
	public String getCsSrchNo() {
		return csSrchNo;
	}
	public void setCsSrchNo(String csSrchNo) {
		this.csSrchNo = csSrchNo;
	}
	public String getCsDscd() {
		return csDscd;
	}
	public void setCsDscd(String csDscd) {
		this.csDscd = csDscd;
	}
	public String getCsKrnNm() {
		return csKrnNm;
	}
	public String getCsSrchKwrdNm() {
		return csSrchKwrdNm;
	}
	public void setCsSrchKwrdNm(String csSrchKwrdNm) {
		this.csSrchKwrdNm = csSrchKwrdNm;
	}
	public void setCsKrnNm(String csKrnNm) {
		this.csKrnNm = csKrnNm;
	}
	public String getRlCsKrnNm() {
		return rlCsKrnNm;
	}
	public void setRlCsKrnNm(String rlCsKrnNm) {
		this.rlCsKrnNm = rlCsKrnNm;
	}
	public String getFnlUdtDtm() {
		return fnlUdtDtm;
	}
	public void setFnlUdtDtm(String fnlUdtDtm) {
		this.fnlUdtDtm = fnlUdtDtm;
	}
	/**
	 * @return the csRnno
	 */
	public String getCsRnno() {
		return csRnno;
	}
	/**
	 * @param csRnno the csRnno to set
	 */
	public void setCsRnno(String csRnno) {
		this.csRnno = csRnno;
	}
	public String getTlno() {
		return tlno;
	}
	public void setTlno(String tlno) {
		this.tlno = tlno;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
}
