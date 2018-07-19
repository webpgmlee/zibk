package or.kr.kbiz.bo.login.domain;

import or.kr.kbiz.bo.common.domain.LoginSessDomain;

public class LoginUserDomain extends LoginSessDomain {
	private String userId;
	private String userNm;
	private String callApGrade;
	private String deptCd;
	private String pswdChngYn;
	private String pswd;
	private int lognAtmpCont;
	private String initPswdYn;
	private String acctLockedYn;
	private String ctiYn;
	private String ctiDevice;
	private String lastLognDtm;

	/* RESULT */
	private String resultCode;
	private String resultMsg;
	private String resultUrl;

	/* CHANGE PASSWORD */
	private String chngUserId;
	private String chngPswd;
	private String chngNewPswd;

	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return the userNm
	 */
	public String getUserNm() {
		return userNm;
	}
	/**
	 * @param userNm the userNm to set
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	/**
	 * @return the callApGrade
	 */
	public String getCallApGrade() {
		return callApGrade;
	}
	/**
	 * @param callApGrade the callApGrade to set
	 */
	public void setCallApGrade(String callApGrade) {
		this.callApGrade = callApGrade;
	}
	/**
	 * @return the deptCd
	 */
	public String getDeptCd() {
		return deptCd;
	}
	/**
	 * @param deptCd the deptCd to set
	 */
	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}
	/**
	 * @return the pswdChngYn
	 */
	public String getPswdChngYn() {
		return pswdChngYn;
	}
	/**
	 * @param pswdChngYn the pswdChngYn to set
	 */
	public void setPswdChngYn(String pswdChngYn) {
		this.pswdChngYn = pswdChngYn;
	}
	/**
	 * @return the pswd
	 */
	public String getPswd() {
		return pswd;
	}
	/**
	 * @param pswd the pswd to set
	 */
	public void setPswd(String pswd) {
		this.pswd = pswd;
	}
	/**
	 * @return the lognAtmpCont
	 */
	public int getLognAtmpCont() {
		return lognAtmpCont;
	}
	/**
	 * @param lognAtmpCont the lognAtmpCont to set
	 */
	public void setLognAtmpCont(int lognAtmpCont) {
		this.lognAtmpCont = lognAtmpCont;
	}
	/**
	 * @return the initPswdYn
	 */
	public String getInitPswdYn() {
		return initPswdYn;
	}
	/**
	 * @param initPswdYn the initPswdYn to set
	 */
	public void setInitPswdYn(String initPswdYn) {
		this.initPswdYn = initPswdYn;
	}
	/**
	 * @return the acctLockedYn
	 */
	public String getAcctLockedYn() {
		return acctLockedYn;
	}
	/**
	 * @param acctLockedYn the acctLockedYn to set
	 */
	public void setAcctLockedYn(String acctLockedYn) {
		this.acctLockedYn = acctLockedYn;
	}
	/**
	 * @return the ctiYn
	 */
	public String getCtiYn() {
		return ctiYn;
	}
	/**
	 * @param ctiYn the ctiYn to set
	 */
	public void setCtiYn(String ctiYn) {
		this.ctiYn = ctiYn;
	}
	/**
	 * @return the ctiDevice
	 */
	public String getCtiDevice() {
		return ctiDevice;
	}
	/**
	 * @param ctiDevice the ctiDevice to set
	 */
	public void setCtiDevice(String ctiDevice) {
		this.ctiDevice = ctiDevice;
	}
	/**
	 * @return the lastLognDtm
	 */
	public String getLastLognDtm() {
		return lastLognDtm;
	}
	/**
	 * @param lastLognDtm the lastLognDtm to set
	 */
	public void setLastLognDtm(String lastLognDtm) {
		this.lastLognDtm = lastLognDtm;
	}
	/**
	 * @return the resultCode
	 */
	public String getResultCode() {
		return resultCode;
	}
	/**
	 * @param resultCode the resultCode to set
	 */
	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	/**
	 * @return the resultMsg
	 */
	public String getResultMsg() {
		return resultMsg;
	}
	/**
	 * @param resultMsg the resultMsg to set
	 */
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	/**
	 * @return the resultUrl
	 */
	public String getResultUrl() {
		return resultUrl;
	}
	/**
	 * @param resultUrl the resultUrl to set
	 */
	public void setResultUrl(String resultUrl) {
		this.resultUrl = resultUrl;
	}
	/**
	 * @return the chngUserId
	 */
	public String getChngUserId() {
		return chngUserId;
	}
	/**
	 * @param chngUserId the chngUserId to set
	 */
	public void setChngUserId(String chngUserId) {
		this.chngUserId = chngUserId;
	}
	/**
	 * @return the chngPswd
	 */
	public String getChngPswd() {
		return chngPswd;
	}
	/**
	 * @param chngPswd the chngPswd to set
	 */
	public void setChngPswd(String chngPswd) {
		this.chngPswd = chngPswd;
	}
	/**
	 * @return the chngNewPswd
	 */
	public String getChngNewPswd() {
		return chngNewPswd;
	}
	/**
	 * @param chngNewPswd the chngNewPswd to set
	 */
	public void setChngNewPswd(String chngNewPswd) {
		this.chngNewPswd = chngNewPswd;
	}
}
