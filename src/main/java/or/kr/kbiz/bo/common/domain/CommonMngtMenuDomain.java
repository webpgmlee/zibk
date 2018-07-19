package or.kr.kbiz.bo.common.domain;

/**
 * 메뉴관리 도메인
 * 
 * @author hyeok
 * @since 20171109
 */
public class CommonMngtMenuDomain {
	
	private String frstMenuCode;
	private String secdMenuCode;
	private String menuName;
	private String menuViewName;
	private int menuSortIdx;
	private String menuAuthRoleCd;
	private String remk1;
	private String remk2;
	
	public String getFrstMenuCode() {
		return frstMenuCode;
	}
	public void setFrstMenuCode(String frstMenuCode) {
		this.frstMenuCode = frstMenuCode;
	}
	public String getSecdMenuCode() {
		return secdMenuCode;
	}
	public void setSecdMenuCode(String secdMenuCode) {
		this.secdMenuCode = secdMenuCode;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuViewName() {
		return menuViewName;
	}
	public void setMenuViewName(String menuViewName) {
		this.menuViewName = menuViewName;
	}
	public int getMenuSortIdx() {
		return menuSortIdx;
	}
	public void setMenuSortIdx(int menuSortIdx) {
		this.menuSortIdx = menuSortIdx;
	}
	public String getMenuAuthRoleCd() {
		return menuAuthRoleCd;
	}
	public void setMenuAuthRoleCd(String menuAuthRoleCd) {
		this.menuAuthRoleCd = menuAuthRoleCd;
	}
	public String getRemk1() {
		return remk1;
	}
	public void setRemk1(String remk1) {
		this.remk1 = remk1;
	}
	public String getRemk2() {
		return remk2;
	}
	public void setRemk2(String remk2) {
		this.remk2 = remk2;
	}
}
