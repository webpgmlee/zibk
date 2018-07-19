package or.kr.kbiz.bo.common.domain;

import or.kr.kbiz.serv.spring.mvc.BaseDomain;

public class PageNaviDomain extends BaseDomain {
	
	private String executeTargetFunction;
	private String submitTargetForm;
	
	public PageNaviDomain() {}
	
	public PageNaviDomain(BaseDomain baseDomain) {
		setPageIdx(baseDomain.getPageIdx());
		setTotalcnt(baseDomain.getTotalcnt());
		setRowsPerPage(baseDomain.getRowsPerPage());
		setPageRange(baseDomain.getPageRange());
	}
	

	public String getExecuteTargetFunction() {
		return executeTargetFunction;
	}

	public void setExecuteTargetFunction(String executeTargetFunction) {
		this.executeTargetFunction = executeTargetFunction;
	}

	public String getSubmitTargetForm() {
		return submitTargetForm;
	}

	public void setSubmitTargetForm(String submitTargetForm) {
		this.submitTargetForm = submitTargetForm;
	}

	public int getTotalPage() {
		return (int) Math.ceil((double) getTotalcnt() / (double) getRowsPerPage());
	}
	
	public int getTotalPageGroup() {
		return (int) Math.ceil((double) getTotalPage() / (double) getPageRange());
	}
	
	public int getPageGroupIdx() {
		return (int) Math.ceil((double) getPageIdx() / (double) getPageRange());
	}
	
	public int getStartPageGroupIdx() {
		return ((getPageGroupIdx() - 1) * getPageRange()) + 1;
	}
	
}
