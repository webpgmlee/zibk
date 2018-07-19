package or.kr.kbiz.bo.admin.domain;

import or.kr.kbiz.serv.spring.mvc.BaseDomain;

public class UserStatDomain extends BaseDomain{
	private String userNm;
	private String aCnt;
	private String bCnt;
	private String cCnt;
	private String dCnt;
	private String eCnt;
	private String fCnt;
	private String gCnt;
	private String sumCnt;
	private Integer rnum ;

	//조회조건
	private String selDate;
	private String selFromDt;
	private String selToDt;
	private String selUserNm;

	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
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
	public String getfCnt() {
		return fCnt;
	}
	public void setfCnt(String fCnt) {
		this.fCnt = fCnt;
	}
	public String getgCnt() {
		return gCnt;
	}
	public void setgCnt(String gCnt) {
		this.gCnt = gCnt;
	}
	public String getSumCnt() {
		return sumCnt;
	}
	public void setSumCnt(String sumCnt) {
		this.sumCnt = sumCnt;
	}
	public String getSelUserNm() {
		return selUserNm;
	}
	public void setSelUserNm(String selUserNm) {
		this.selUserNm = selUserNm;
	}
	public Integer getRnum() {
		return rnum;
	}
	public void setRnum(Integer rnum) {
		this.rnum = rnum;
	}



}
