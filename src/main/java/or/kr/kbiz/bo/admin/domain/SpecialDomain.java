package or.kr.kbiz.bo.admin.domain;

import or.kr.kbiz.serv.spring.mvc.BaseDomain;

public class SpecialDomain extends BaseDomain {
	private String cnltSeq;				//상담일련번호[yyyyMMdd000000]
	private String cnltDetailNo;		//상담상세번호
	private String untyCsno;			//통합고객번호
	private String spclCont;			//특이성향 내용
	private String spclAppvYn;		//특이성향 승인 여부[Y, N(DEFAULT)]
	private String spclAppvUserId;	//특이성향 승인자 ID
	private String spclAppvUserNm; //특이성향 승인자명
	private String regId;				//등록자ID
	private String regNm;				//등록자명
	private String regDate;				//등록일시
	private String modId;				//수정자ID
	private String modDate;			//수정일시

	private String tellNum;				//전화번호
	private String custNm;				//고객명
	private String rnum;

	//조회조건
	private String selCustNm;			//고객명
	private String selTellNum;			//전화번호
	private String selRegNm;			//등록자
	private String selSpclAppvYn;	//승인여부

	public String getCnltSeq() {
		return cnltSeq;
	}
	public void setCnltSeq(String cnltSeq) {
		this.cnltSeq = cnltSeq;
	}
	public String getCnltDetailNo() {
		return cnltDetailNo;
	}
	public void setCnltDetailNo(String cnltDetailNo) {
		this.cnltDetailNo = cnltDetailNo;
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
	public String getSpclAppvYn() {
		return spclAppvYn;
	}
	public void setSpclAppvYn(String spclAppvYn) {
		this.spclAppvYn = spclAppvYn;
	}
	public String getSpclAppvUserId() {
		return spclAppvUserId;
	}
	public void setSpclAppvUserId(String spclAppvUserId) {
		this.spclAppvUserId = spclAppvUserId;
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
	public String getSpclAppvUserNm() {
		return spclAppvUserNm;
	}
	public void setSpclAppvUserNm(String spclAppvUserNm) {
		this.spclAppvUserNm = spclAppvUserNm;
	}
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	public String getRegNm() {
		return regNm;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}
	public String getTellNum() {
		return tellNum;
	}
	public void setTellNum(String tellNum) {
		this.tellNum = tellNum;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getSelCustNm() {
		return selCustNm;
	}
	public void setSelCustNm(String selCustNm) {
		this.selCustNm = selCustNm;
	}
	public String getSelTellNum() {
		return selTellNum;
	}
	public void setSelTellNum(String selTellNum) {
		this.selTellNum = selTellNum;
	}
	public String getSelRegNm() {
		return selRegNm;
	}
	public void setSelRegNm(String selRegNm) {
		this.selRegNm = selRegNm;
	}
	public String getSelSpclAppvYn() {
		return selSpclAppvYn;
	}
	public void setSelSpclAppvYn(String selSpclAppvYn) {
		this.selSpclAppvYn = selSpclAppvYn;
	}
}
