package or.kr.kbiz.bo.inbound.domain;

public class ConsultDomain {
	private String cnltSeq; // 상담번호
	private String cnltProcCd; // 처리구분
	private String custNm; // 고객명
	private String cntrNo; // 통합계약번호
	private String custNo; // 통합고객번호
	private String regId; // 등록자 Id
	private String regDate; // 등록일자
	private String modId; // 수정자 Id
	private String modDate; // 수정일자
	public String getCnltSeq() {
		return cnltSeq;
	}
	public void setCnltSeq(String cnltSeq) {
		this.cnltSeq = cnltSeq;
	}
	public String getCnltProcCd() {
		return cnltProcCd;
	}
	public void setCnltProcCd(String cnltProcCd) {
		this.cnltProcCd = cnltProcCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
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
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getregDate() {
		return regDate;
	}
	public void setregDate(String regDate) {
		this.regDate = regDate;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getmodDate() {
		return modDate;
	}
	public void setmodDate(String modDate) {
		this.modDate = modDate;
	}




}
