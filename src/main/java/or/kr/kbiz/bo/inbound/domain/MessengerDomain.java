package or.kr.kbiz.bo.inbound.domain;

import or.kr.kbiz.serv.spring.mvc.BaseDomain;

public class MessengerDomain extends BaseDomain{
	private String mesgSeq;			//일련번호
	private String userId;				//상담사id
	private String tranId;				//중앙회id
	private String userNm;				//상담사명
	private String tranNm;				//중앙회명
	private String mesgContent;		//상담내역
	private String regId;				//등록자id
	private String regDate;				//등록일시
	private String mesgTitle;			//제목
	private String mesgUrl;				//url

	public String getMesgSeq() {
		return mesgSeq;
	}
	public void setMesgSeq(String mesgSeq) {
		this.mesgSeq = mesgSeq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTranId() {
		return tranId;
	}
	public void setTranId(String tranId) {
		this.tranId = tranId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getTranNm() {
		return tranNm;
	}
	public void setTranNm(String tranNm) {
		this.tranNm = tranNm;
	}
	public String getMesgContent() {
		return mesgContent;
	}
	public void setMesgContent(String mesgContent) {
		this.mesgContent = mesgContent;
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
	public String getMesgTitle() {
		return mesgTitle;
	}
	public void setMesgTitle(String mesgTitle) {
		this.mesgTitle = mesgTitle;
	}
	public String getMesgUrl() {
		return mesgUrl;
	}
	public void setMesgUrl(String mesgUrl) {
		this.mesgUrl = mesgUrl;
	}

}
