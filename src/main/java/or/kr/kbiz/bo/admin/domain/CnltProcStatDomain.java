package or.kr.kbiz.bo.admin.domain;

import or.kr.kbiz.serv.spring.mvc.BaseDomain;

public class CnltProcStatDomain extends BaseDomain{
	private String mode;
	private String codeName;
	private String aCnt;
	private String bCnt;
	private String cCnt;
	private String dCnt;
	private String eCnt;

	//조회조건
	private String selDate;
	private String selFromDt;
	private String selToDt;

	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getaCnt() {
		return aCnt;
	}
	public void setaCnt(String aCnt) {
		this.aCnt = aCnt;
	}
	public String getbCnt() {
		return bCnt;
	}
	public void setbCnt(String bCnt) {
		this.bCnt = bCnt;
	}
	public String getcCnt() {
		return cCnt;
	}
	public void setcCnt(String cCnt) {
		this.cCnt = cCnt;
	}
	public String getdCnt() {
		return dCnt;
	}
	public void setdCnt(String dCnt) {
		this.dCnt = dCnt;
	}
	public String geteCnt() {
		return eCnt;
	}
	public void seteCnt(String eCnt) {
		this.eCnt = eCnt;
	}
	public String getSelDate() {
		return selDate;
	}
	public void setSelDate(String selDate) {
		this.selDate = selDate;
	}
	public String getSelFromDt() {
		return selFromDt;
	}
	public void setSelFromDt(String selFromDt) {
		this.selFromDt = selFromDt;
	}
	public String getSelToDt() {
		return selToDt;
	}
	public void setSelToDt(String selToDt) {
		this.selToDt = selToDt;
	}
}
