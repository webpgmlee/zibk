package or.kr.kbiz.bo.inbound.domain;

import or.kr.kbiz.serv.spring.mvc.BaseDomain;

public class CodeDomain  extends BaseDomain {
	private String chnlCode;
	private String code;
	private String lcode;
	private String mcode;
	private String scode;
	private String codeName;
	private Integer sortIdx;
	private String useYn;
	private String codeDesc;
	private String remk1;
	private String remk2;
	private String regId;
	private String regNm;
	private String regDate;
	private String modId;
	private String modDate;
	private String scodeName;        //소분류명
	private String lcodeName;			//대분류명
	private String mcodeName;		//중분류명
	private String uploadFile;          //업로드파일명
	private String callGbCd;
	//검색조건
	private String selLcode;				//대분류
	private String selMcode;				//중분류
	private String selUseYn;				//사용유무
	private String keyword;
	private String script;


	public String getChnlCode() {
		return chnlCode;
	}
	public void setChnlCode(String chnlCode) {
		this.chnlCode = chnlCode;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
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
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public Integer getSortIdx() {
		return sortIdx;
	}
	public void setSortIdx(Integer sortIdx) {
		this.sortIdx = sortIdx;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getCodeDesc() {
		return codeDesc;
	}
	public void setCodeDesc(String codeDesc) {
		this.codeDesc = codeDesc;
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
	public String getRegNm() {
		return regNm;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
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
	public String getSelUseYn() {
		return selUseYn;
	}
	public void setSelUseYn(String selUseYn) {
		this.selUseYn = selUseYn;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getScript() {
		return script;
	}
	public void setScript(String script) {
		this.script = script;
	}
	public String getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(String uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getCallGbCd() {
		return callGbCd;
	}
	public void setCallGbCd(String callGbCd) {
		this.callGbCd = callGbCd;
	}
}
