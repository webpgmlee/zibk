package or.kr.kbiz.bo.inbound.domain;

public class CustomerDomain {
    private String untyCsno; // 통합고객번호
    private String csKrnNm; // 고객/기업 한글명
    private String untyCntrNo; // 통합게약번호
    private String cntrNo; // 계약번호
    private String addr; // 주소
    private String abndYn=""; // 해지여부
    private String dlgtUntyCsno; // 대표자고객번호
    private String bzplUntyCsno; // 사업장고객번호
    private String smsYn; // SMS 수신동의 여부
    private String tlno; // 전화번호
    private String codeName; // 고객구분코드이름
    private String csDscd; // 고객구분코드
    private String csSrchNo; // 고객검색번호
    private String cnltSeq;
    private String cnltDetailNo;
    private String spclAppvYn;
    private String ddctBizDscd;

    public CustomerDomain(){
    	this.spclAppvYn = "N";
    }

    public String getUntyCsno() {
        return untyCsno;
    }
    public void setUntyCsno(String untyCsno) {
        this.untyCsno = untyCsno;
    }
    public String getCsKrnNm() {
        return csKrnNm;
    }
    public void setCsKrnNm(String csKrnNm) {
        this.csKrnNm = csKrnNm;
    }
    public String getUntyCntrNo() {
        return untyCntrNo;
    }
    public void setUntyCntrNo(String untyCntrNo) {
        this.untyCntrNo = untyCntrNo;
    }
    public String getCntrNo() {
		return cntrNo;
	}
	public void setCntrNo(String cntrNo) {
		this.cntrNo = cntrNo;
	}
	public String getAddr() {
        return addr;
    }
    public void setAddr(String addr) {
        this.addr = addr;
    }
    public String getAbndYn() {
        return abndYn;
    }
    public void setAbndYn(String abndYn) {
        this.abndYn = abndYn;
    }
    public String getDlgtUntyCsno() {
        return dlgtUntyCsno;
    }
    public void setDlgtUntyCsno(String dlgtUntyCsno) {
        this.dlgtUntyCsno = dlgtUntyCsno;
    }
    public String getBzplUntyCsno() {
        return bzplUntyCsno;
    }
    public void setBzplUntyCsno(String bzplUntyCsno) {
        this.bzplUntyCsno = bzplUntyCsno;
    }
	public String getSmsYn() {
		return smsYn;
	}
	public void setSmsYn(String smsYn) {
		this.smsYn = smsYn;
	}
	public String getTlno() {
		return tlno;
	}
	public void setTlno(String tlno) {
		this.tlno = tlno;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getCsDscd() {
		return csDscd;
	}
	public void setCsDscd(String csDscd) {
		this.csDscd = csDscd;
	}
	public String getCsSrchNo() {
		return csSrchNo;
	}
	public void setCsSrchNo(String csSrchNo) {
		this.csSrchNo = csSrchNo;
	}
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
	public String getSpclAppvYn() {
		return spclAppvYn;
	}
	public void setSpclAppvYn(String spclAppvYn) {
		this.spclAppvYn = spclAppvYn;
	}
	public String getDdctBizDscd() {
		return ddctBizDscd;
	}

	public void setDdctBizDscd(String ddctBizDscd) {
		this.ddctBizDscd = ddctBizDscd;
	}

}