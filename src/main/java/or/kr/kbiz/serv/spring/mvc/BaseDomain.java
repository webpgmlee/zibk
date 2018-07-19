package or.kr.kbiz.serv.spring.mvc;

import java.beans.PropertyDescriptor;

import org.springframework.beans.BeanUtils;

import or.kr.kbiz.bo.common.domain.LoginSessDomain;

public abstract class BaseDomain extends LoginSessDomain {
	private int pageIdx = 1;

	private int totalcnt;

	private int rowsPerPage = 10;

	private int pageRange = 10;

	public int getPageIdx() {
		return pageIdx;
	}

	public void setPageIdx(int pageIdx) {
		this.pageIdx = pageIdx;
	}

	public int getTotalcnt() {
		return totalcnt;
	}

	public void setTotalcnt(int totalcnt) {
		this.totalcnt = totalcnt;
	}

	public int getPageRange() {
		return pageRange;
	}

	public void setPageRange(int pageRange) {
		this.pageRange = pageRange;
	}

	public int getRowsPerPage() {
		return rowsPerPage;
	}

	public void setRowsPerPage(int rowsPerPage) {
		this.rowsPerPage = rowsPerPage;
	}

	public int getFromRowPerPage() {
		return ((pageIdx - 1) * rowsPerPage) + 1;
	}

	public int getToRowPerPage() {
		return pageIdx * rowsPerPage;
	}

	/**
	 * attribute 타입이 String인 것의 null을 ""으로 변환
	 *
	 * @param bean
	 */
	public void fixNull() {
		try {
			PropertyDescriptor[] keys = BeanUtils.getPropertyDescriptors(this.getClass());
			for (int i = 0; i < keys.length; i++) {
				if (keys[i].getPropertyType().getName()
						.equals("java.lang.String")) {
					if (keys[i].getValue(keys[i].getName()) == null) {
						keys[i].setValue(keys[i].getName(), "");
					}
				}
			}
		} catch (Exception e) {
			;
		}
	}

}
