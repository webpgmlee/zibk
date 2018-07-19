package or.kr.kbiz.bo.admin.domain;

import or.kr.kbiz.serv.spring.mvc.BaseDomain;

public class ScriptDomain extends BaseDomain {
	private String chnlCode;			//인입채널코드
	private String lcode;				//대분류
	private String mcode;				//중분류
	private String scode;				//소분류
	private Integer scrpNo;			//일렵번호
	private String scrpTitle;			//제목
	private String scrpCont;			//내용
	private String scrpFile;				//첨부파일
	private String regId;				//등록자id
	private String regDate;				//등록일시
	private String regNm;				//등록자명
	private String modId;				//수정자id
	private String modDate;			//수정일시

	private Integer overlapCnt;		//중복체크
	private String hidChnlCode;		//인입채널
	private String hidLcode;			//대분류
	private String hidMcode;			//중분류
	private String hidScode;			//소분류
	private String hidScrpNo;			//일련번호
	private String chnlCodeName;	//인입채널명
	private String lcodeName;			//대분류명
	private String mcodeName;		//중분류명
	private String scodeName;		//소분류명
	private Integer rnum;

	//검색조건
	private String selChnlCode;			//인입채널코드
	private String selLcode;				//대분류
	private String selMcode;				//중분류
	private String selKeyword;			//키워드
	public String getChnlCode() {
		return chnlCode;
	}
	public void setChnlCode(String chnlCode) {
		this.chnlCode = chnlCode;
	}
	public String getLcode() {
		return lcode;
	}
	public void setLcode(String lcode) {
		this.lcode = lcode;
	}
	public String getMcode() {
		return mcode;
	}
	public void setMcode(String mcode) {
		this.mcode = mcode;
	}
	public String getScode() {
		return scode;
	}
	public void setScode(String scode) {
		this.scode = scode;
	}
	public Integer getScrpNo() {
		return scrpNo;
	}
	public void setScrpNo(Integer scrpNo) {
		this.scrpNo = scrpNo;
	}
	public String getScrpTitle() {
		return scrpTitle;
	}
	public void setScrpTitle(String scrpTitle) {
		this.scrpTitle = scrpTitle;
	}
	public String getScrpCont() {
		return scrpCont;
	}
	public void setScrpCont(String scrpCont) {
		this.scrpCont = scrpCont;
	}
	public String getScrpFile() {
		return scrpFile;
	}
	public void setScrpFile(String scrpFile) {
		this.scrpFile = scrpFile;
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
	public String getRegNm() {
		return regNm;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getModDate() {
		return modDate;
	}
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
	public Integer getOverlapCnt() {
		return overlapCnt;
	}
	public void setOverlapCnt(Integer overlapCnt) {
		this.overlapCnt = overlapCnt;
	}
	public String getHidChnlCode() {
		return hidChnlCode;
	}
	public void setHidChnlCode(String hidChnlCode) {
		this.hidChnlCode = hidChnlCode;
	}
	public String getHidLcode() {
		return hidLcode;
	}
	public void setHidLcode(String hidLcode) {
		this.hidLcode = hidLcode;
	}
	public String getHidMcode() {
		return hidMcode;
	}
	public void setHidMcode(String hidMcode) {
		this.hidMcode = hidMcode;
	}
	public String getHidScode() {
		return hidScode;
	}
	public void setHidScode(String hidScode) {
		this.hidScode = hidScode;
	}
	public String getHidScrpNo() {
		return hidScrpNo;
	}
	public void setHidScrpNo(String hidScrpNo) {
		this.hidScrpNo = hidScrpNo;
	}
	public String getChnlCodeName() {
		return chnlCodeName;
	}
	public void setChnlCodeName(String chnlCodeName) {
		this.chnlCodeName = chnlCodeName;
	}
	public String getLcodeName() {
		return lcodeName;
	}
	public void setLcodeName(String lcodeName) {
		this.lcodeName = lcodeName;
	}
	public String getMcodeName() {
		return mcodeName;
	}
	public void setMcodeName(String mcodeName) {
		this.mcodeName = mcodeName;
	}
	public String getScodeName() {
		return scodeName;
	}
	public void setScodeName(String scodeName) {
		this.scodeName = scodeName;
	}
	public Integer getRnum() {
		return rnum;
	}
	public void setRnum(Integer rnum) {
		this.rnum = rnum;
	}
	public String getSelChnlCode() {
		return selChnlCode;
	}
	public void setSelChnlCode(String selChnlCode) {
		this.selChnlCode = selChnlCode;
	}
	public String getSelLcode() {
		return selLcode;
	}
	public void setSelLcode(String selLcode) {
		this.selLcode = selLcode;
	}
	public String getSelMcode() {
		return selMcode;
	}
	public void setSelMcode(String selMcode) {
		this.selMcode = selMcode;
	}
	public String getSelKeyword() {
		return selKeyword;
	}
	public void setSelKeyword(String selKeyword) {
		this.selKeyword = selKeyword;
	}


}
