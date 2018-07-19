package or.kr.kbiz.bo.common.domain;

public class LoginSessDomain {
	private String loginUserId;
	private String loginUserNm;
	private String loginCallApGrade;
	private String ctiDevice;
	private String apLoginYn;
	private String ssoLoginYn;

	/**
	 * @return the loginUserId
	 */
	public String getLoginUserId() {
		return loginUserId;
	}
	/**
	 * @param loginUserId the loginUserId to set
	 */
	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}
	/**
	 * @return the loginUserNm
	 */
	public String getLoginUserNm() {
		return loginUserNm;
	}
	/**
	 * @param loginUserNm the loginUserNm to set
	 */
	public void setLoginUserNm(String loginUserNm) {
		this.loginUserNm = loginUserNm;
	}
	/**
	 * @return the loginCallApGrade
	 */
	public String getLoginCallApGrade() {
		return loginCallApGrade;
	}
	/**
	 * @param loginCallApGrade the loginCallApGrade to set
	 */
	public void setLoginCallApGrade(String loginCallApGrade) {
		this.loginCallApGrade = loginCallApGrade;
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
	 * @return the apLoginYn
	 */
	public String getApLoginYn() {
		return apLoginYn;
	}
	/**
	 * @param apLoginYn the apLoginYn to set
	 */
	public void setApLoginYn(String apLoginYn) {
		this.apLoginYn = apLoginYn;
	}
	/**
	 * @return the ssoLoginYn
	 */
	public String getSsoLoginYn() {
		return ssoLoginYn;
	}
	/**
	 * @param ssoLoginYn the ssoLoginYn to set
	 */
	public void setSsoLoginYn(String ssoLoginYn) {
		this.ssoLoginYn = ssoLoginYn;
	}
}
