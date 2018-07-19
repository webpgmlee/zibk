package or.kr.kbiz.bo.inbound.domain;

public class OrganizationDomain {
	private String level;
	private String deptCd;
	private String deptNm;
	private String upprDept;
	private String userId;
	private String userNm;
	private String emailAdr;
	private String ofrmTelNo = "";
	private String callTelNum;
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getDeptCd() {
		return deptCd;
	}
	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	public String getUpprDept() {
		return upprDept;
	}
	public void setUpprDept(String upprDept) {
		this.upprDept = upprDept;
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
	public String getEmailAdr() {
		return emailAdr;
	}
	public void setEmailAdr(String emailAdr) {
		this.emailAdr = emailAdr;
	}
	public String getOfrmTelNo() {
		return ofrmTelNo;
	}
	public void setOfrmTelNo(String ofrmTelNo) {
		this.ofrmTelNo = ofrmTelNo;
	}
	public String getCallTelNum() {
		return callTelNum;
	}
	public void setCallTelNum(String callTelNum) {
		this.callTelNum = callTelNum;
	}
}
