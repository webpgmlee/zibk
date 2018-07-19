package or.kr.kbiz.bo.inbound.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.ScriptDomain;
import or.kr.kbiz.bo.admin.domain.UserDomain;
import or.kr.kbiz.bo.inbound.domain.CallbackDomain;
import or.kr.kbiz.bo.inbound.domain.CodeDomain;
import or.kr.kbiz.bo.inbound.domain.ConsultDetailDomain;
import or.kr.kbiz.bo.inbound.domain.CustomerDomain;
import or.kr.kbiz.bo.inbound.domain.InboundSpecialDomain;
import or.kr.kbiz.bo.inbound.domain.MessengerDomain;
import or.kr.kbiz.bo.inbound.domain.OrganizationDomain;
import or.kr.kbiz.bo.inbound.domain.SmsDomain;
import or.kr.kbiz.bo.inbound.domain.UntyCntrDomain;
import or.kr.kbiz.bo.inbound.domain.VocDomain;
import or.kr.kbiz.bo.inbound.service.InboundService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
import or.kr.kbiz.serv.util.AtMessenger7Communicator;

@Service
public class InboundServiceImpl implements InboundService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@Autowired(required=true)
	@Qualifier("kbizBaseDao")
	private BaseDao baseDao2;

	@Autowired(required=true)
	@Qualifier("smsBaseDao")
	private BaseDao baseDao3;

	private static final Logger logger = LoggerFactory.getLogger(InboundServiceImpl.class);

	@Override
	@SuppressWarnings("unchecked")
	public List<CodeDomain> selectCustCode() {
		return baseDao.getList("inbound.selectCustCode");
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<CustomerDomain> selectCsSearch(CustomerDomain custDomain) {
		List<CustomerDomain> list;
		// TODO 차세대 완료 후 주석 해제
		/*try{
			list = baseDao2.getList("kbizinbound.selectCsSearch", custDomain);
		}catch(Exception e){
			logger.debug("selectCsSearch="+e);
			list = baseDao.getList("inbound.selectCsSearch", custDomain);
		}*/
		list = baseDao.getList("inbound.selectCsSearch", custDomain);
		for(int i=0;i<list.size();i++){
			if(list.get(i).getCsDscd() != null){
				if(list.get(i).getCsDscd().equals("01")){
					list.get(i).setCodeName("개인");
				}else if(list.get(i).getCsDscd().equals("02")){
					list.get(i).setCodeName("법인기업");
				}else if(list.get(i).getCsDscd().equals("03")){
					list.get(i).setCodeName("개인기업");
				}else if(list.get(i).getCsDscd().equals("07")){
					list.get(i).setCodeName("외국인");
				}
			}else{
				list.get(i).setCodeName("개인");
			}
		}
		return list;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<CustomerDomain> selectCustomerCount(CustomerDomain custDomain) {
		List<CustomerDomain> list;
		// TODO 차세대 완료 후 주석 해제
		/*try{
			list = baseDao2.getList("kbizinbound.selectUntyCsno", custDomain);
		}catch(Exception e){
			logger.debug("1.selectCustomerCount="+e);
			list = baseDao.getList("inbound.selectUntyCsno", custDomain);
		}*/
		list = baseDao.getList("inbound.selectUntyCsno", custDomain);
		List<CustomerDomain> list2 = new ArrayList<CustomerDomain>();
		if(list.size() > 1){
			return list;
		}else if(list.size() == 1){
			// TODO 차세대 완료 후 주석 해제
			/*try{
				list = baseDao2.getList("kbizinbound.selectUntyCs", list.get(0));
			}catch(Exception e){
				logger.debug("2.selectCustomerCount="+e);
				list = baseDao.getList("inbound.selectUntyCs", list.get(0));
			}*/
			list = baseDao.getList("inbound.selectUntyCs", list.get(0));
			return list;
		}else{
			return list2;
		}
	}

	@Override
	public CustomerDomain selectStartCon(CustomerDomain custDomain) {
		CustomerDomain cd;
		// TODO 차세대 완료 후 주석 해제
		/*try{
			cd = (CustomerDomain)baseDao2.getObject("kbizinbound.selectUntyCsno", custDomain);
		}catch(Exception e){
			logger.debug("1.selectStartCon="+e);
			cd = (CustomerDomain)baseDao.getObject("inbound.selectUntyCsno", custDomain);
		}*/
		cd = (CustomerDomain)baseDao.getObject("inbound.selectUntyCsno", custDomain);
		if(cd != null){
			CustomerDomain cd2;
			// TODO 차세대 완료 후 주석 해제
			/*try{
				cd2 = (CustomerDomain)baseDao2.getObject("kbizinbound.selectUntyCs", cd);
			}catch(Exception e){
				logger.debug("2.selectStartCon="+e);
				cd2 = (CustomerDomain)baseDao.getObject("inbound.selectUntyCs", cd);
			}*/
			cd2 = (CustomerDomain)baseDao.getObject("inbound.selectUntyCs", cd);
			return cd2;
		}else{
			return cd;
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<CustomerDomain> selectCustomer(CustomerDomain custlDomain) {
		List<CustomerDomain> cd;
		// TODO 차세대 완료 후 주석 해제
		/*try{
			cd = baseDao2.getList("kbizinbound.selectCustomer", custlDomain);
		}catch(Exception e){
			logger.debug("selectCustomer="+e);
			cd = baseDao.getList("inbound.selectCustomer", custlDomain);
		}*/
		cd = baseDao.getList("inbound.selectCustomer", custlDomain);
		return cd;
	}

	@Override
	public CustomerDomain selectCustomer2(CustomerDomain custlDomain) {
		CustomerDomain cd;
		// TODO 차세대 완료 후 주석 해제
		/*try{
			cd = (CustomerDomain)baseDao2.getObject("kbizinbound.selectCustomer2", custlDomain);
		}catch(Exception e){
			logger.debug("selectCustomer2="+e);
			cd = (CustomerDomain)baseDao.getObject("inbound.selectCustomer2", custlDomain);
		}*/
		cd = (CustomerDomain)baseDao.getObject("inbound.selectCustomer2", custlDomain);
		return cd;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<UntyCntrDomain> selectContract(CustomerDomain cntrDomain) {
		List<UntyCntrDomain> ucd;
		// TODO 차세대 완료 후 주석 해제
		/*try{
			ucd = baseDao2.getList("kbizinbound.selectContract", cntrDomain);
		}catch(Exception e){
			logger.debug("selectContract="+e);
			ucd = baseDao.getList("inbound.selectContract", cntrDomain);
		}*/
		ucd = baseDao.getList("inbound.selectContract", cntrDomain);
		return ucd;
	}

	@Override
	public CustomerDomain selectCntrDetail(CustomerDomain cntrDomain) {
		CustomerDomain cd;
		// TODO 차세대 완료 후 주석 해제
		/*try{
			cd = (CustomerDomain)baseDao2.getObject("kbizinbound.selectCntrDetail", cntrDomain);
		}catch(Exception e){
			logger.debug("selectCntrDetail="+e);
			cd = (CustomerDomain)baseDao.getObject("inbound.selectCntrDetail", cntrDomain);
		}*/
		cd = (CustomerDomain)baseDao.getObject("inbound.selectCntrDetail", cntrDomain);
		return cd;
	}

	@Override
	public String callbackYn(int callbackSeq) {
		return (String)baseDao.getObject("inbound.callbackYn", callbackSeq);
	}

	@Override
	public String callbackModYn(CallbackDomain cbd) {
		int callbackCnt = (Integer)baseDao.getObject("inbound.callbackModYn", cbd);
		if(callbackCnt == 1){
			return "Y";
		}else{
			return "N";
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public String selectSpclAppvYn(String untyCsno) {
		List<String> st = baseDao.getList("inbound.selectSpclAppvYn", untyCsno);
		boolean yn = false;
		for(int i=0; i<st.size(); i++){
			if(st.get(i).equals("Y")){
				yn = true;
			}
		}
		if(yn == true){
			return "Y";
		}else{
			return "N";
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public String selectSpclAppvYn2(String tlno) {
		List<String> st = baseDao.getList("inbound.selectSpclAppvYn2", tlno);
		boolean yn = false;
		for(int i=0; i<st.size(); i++){
			if(st.get(i).equals("Y")){
				yn = true;
			}
		}
		if(yn == true){
			return "Y";
		}else{
			return "N";
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<ConsultDetailDomain> selectRsrvList(ConsultDetailDomain consultDetailDomain) {
		consultDetailDomain.setTotalcnt((Integer)baseDao.getObject("inbound.reserveTotalCount", consultDetailDomain));
		return baseDao.getList("inbound.selectRsrvList",consultDetailDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<CodeDomain> selectScript(CodeDomain codeDomain) {
		codeDomain.setTotalcnt((Integer)baseDao.getObject("inbound.scriptTotalCount", codeDomain));
		return baseDao.getList("inbound.selectScript",codeDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<ScriptDomain> selectScript2(CodeDomain codeDomain) {
		codeDomain.setTotalcnt((Integer)baseDao.getObject("inbound.scriptTotalCount2", codeDomain));
		return baseDao.getList("inbound.selectScript2", codeDomain);
	}

	@Override
	public ScriptDomain selectScriptDetail(String scrpNo) {
		return (ScriptDomain)baseDao.getObject("inbound.selectScriptDetail", scrpNo);
	}

	@Override
	public void downloadFile(ScriptDomain scriptDomain, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileName = scriptDomain.getScrpFile();
		String reFileName =  URLEncoder.encode(scriptDomain.getScrpFile(),"UTF-8").replaceAll("\\+", "%20");
		File file = new File("D:\\upload\\script\\"+fileName);
		response.setContentLength((int)file.length());
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Disposition","attachment;filename=\"" +reFileName +"\";");
		response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
		InputStream in = null;
		OutputStream os = null;
		try{ // 파일을 읽어 스트림에 담기
			in = new FileInputStream(file);
			os = response.getOutputStream();
            byte b[] = new byte[(int)file.length()];
            int leng = 0;
            while( (leng = in.read(b)) > 0 ){
                os.write(b,0,leng);
            }
            in.close();
            os.close();
		}catch(Exception e){
			logger.error("error : "+e);
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<ConsultDetailDomain> selectConsultDetailList(ConsultDetailDomain consultDetailDomain) {
		return baseDao.getList("inbound.selectConsultDetailList",consultDetailDomain);
	}

	@Override
	public ConsultDetailDomain selectConsultInfoDetail(ConsultDetailDomain consultDetailDomain) {
		return (ConsultDetailDomain)baseDao.getObject("inbound.selectConsultInfoDetail",consultDetailDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<ConsultDetailDomain> selectConsultSearchList(ConsultDetailDomain consultDetailDomain) {
		consultDetailDomain.setTotalcnt((Integer)baseDao.getObject("inbound.consultTotalCount", consultDetailDomain));
		return baseDao.getList("inbound.selectConsultSearch",consultDetailDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<ConsultDetailDomain> selectConsultSearchList2(ConsultDetailDomain consultDetailDomain) {
		consultDetailDomain.setTotalcnt((Integer)baseDao.getObject("inbound.consultTotalCount2", consultDetailDomain));
		return baseDao.getList("inbound.selectConsultSearch2",consultDetailDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<CallbackDomain> selectCallbackList(CallbackDomain callbackDomain) {
		return baseDao.getList("inbound.selectCallbackList", callbackDomain);
	}

	@Override
	public CallbackDomain selectCallbackTotalCnt(CallbackDomain callbackDomain) {
		callbackDomain.setTotalcnt((Integer)baseDao.getObject("inbound.callbackTotalCount", callbackDomain));
		return callbackDomain;
	}

	@Override
	public void callBackProc(CallbackDomain callbackDomain) {
		baseDao.getList("inbound.callBackProc", callbackDomain);
	}

	@Override
	public ConsultDetailDomain selectConsultRsrvDetail(ConsultDetailDomain consultDetailDomain) {
		return (ConsultDetailDomain)baseDao.getObject("inbound.selectConsultRsrvDetail", consultDetailDomain);
	}

	@Override
	public CustomerDomain selectConsultRsrvDetail2(ConsultDetailDomain consultDetailDomain) {
		CustomerDomain cd = (CustomerDomain)baseDao.getObject("inbound.selectConsultRsrvDetail2", consultDetailDomain);
		CustomerDomain cd2;
		// TODO 차세대 완료 후 주석 해제
		/*try{
			cd2 = (CustomerDomain)baseDao2.getObject("kbizinbound.selectCntrDetail", cd);
		}catch(Exception e){
			cd2 = (CustomerDomain)baseDao.getObject("inbound.selectCntrDetail", cd);
		}*/
		cd2 = (CustomerDomain)baseDao.getObject("inbound.selectCntrDetail", cd);
		return cd2;
	}

	@Override
	public ConsultDetailDomain selectConsultTranDetail(ConsultDetailDomain consultDetailDomain) {
		return (ConsultDetailDomain)baseDao.getObject("inbound.selectConsultTranDetail", consultDetailDomain);
	}

	@Override
	public CustomerDomain selectConsultTranDetail2(ConsultDetailDomain consultDetailDomain) {
		CustomerDomain cd = (CustomerDomain)baseDao.getObject("inbound.selectConsultTranDetail2", consultDetailDomain);
		CustomerDomain cd2;
		// TODO 차세대 완료 후 주석 해제
		/*try{
			cd2 = (CustomerDomain)baseDao2.getObject("kbizinbound.selectCntrDetail", cd);
		}catch(Exception e){
			cd2 = (CustomerDomain)baseDao.getObject("inbound.selectCntrDetail", cd);
		}*/
		cd2 = (CustomerDomain)baseDao.getObject("inbound.selectCntrDetail", cd);
		return cd2;
	}

	@Override
	public ConsultDetailDomain insertConsult(ConsultDetailDomain consultDetailDomain) {
		String tell = consultDetailDomain.getTellNum().replaceAll("-", "");
		consultDetailDomain.setTellNum(tell);

		if(consultDetailDomain.getCnltSeq() != null && consultDetailDomain.getCnltSeq().length() > 0){
			consultDetailDomain.setCnltDetailNo(consultDetailDomain.getCnltDetailNo()+1);
			baseDao.update("inbound.updateConsult", consultDetailDomain);
		}else{
			baseDao.insert("inbound.insertConsult", consultDetailDomain);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String today = sdf.format(new Date());
			String sequence = consultDetailDomain.getSeq().toString();
			consultDetailDomain.setCnltSeq(today+sequence);
			consultDetailDomain.setCnltDetailNo(1);
		}

		if(consultDetailDomain.getRecUrl().isEmpty() || consultDetailDomain.getRecUrl().equals("")){
			consultDetailDomain.setCallYn("N");
		}else{
			consultDetailDomain.setCallYn("Y");
		}
		baseDao.insert("inbound.insertConsultDetail", consultDetailDomain);
		// TODO 차세대 완료 후 주석 해제
		/*try{
			baseDao2.insert("kbizinbound.insertConsultDetail2", consultDetailDomain);
		}catch(Exception e){
			logger.debug("insertConsult 차세대 상담정보 INSERT 오류="+e);
		}*/
		if(consultDetailDomain.getCnltProcCd().equals("02")){
			insertRsrv(consultDetailDomain);
		}
		if("03,04,07".indexOf(consultDetailDomain.getCnltProcCd()) != -1){
			insertTran(consultDetailDomain);
		}
		if(consultDetailDomain.getSpclCont() != null && consultDetailDomain.getSpclCont().length() > 0){
			insertSpecial(consultDetailDomain);
		}
		return consultDetailDomain;
	}

	@Override
	public Integer insertRsrv(ConsultDetailDomain consultDetailDomain) {
		return (Integer)baseDao.insert("inbound.insertRsrv", consultDetailDomain);
	}

	@Override
	public Integer insertTran(ConsultDetailDomain consultDetailDomain) {
		return (Integer)baseDao.insert("inbound.insertTran", consultDetailDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<ConsultDetailDomain> selectTransList(ConsultDetailDomain consultDetailDomain) {
		consultDetailDomain.setTotalcnt((Integer)baseDao.getObject("inbound.transferTotalCount", consultDetailDomain));
		return baseDao.getList("inbound.selectTransList", consultDetailDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<CodeDomain> selectCode() {
		return baseDao.getList("inbound.selectCode");
	}


	@Override
	@SuppressWarnings("unchecked")
	public List<CodeDomain> selectChCode() {
		return baseDao.getList("inbound.selectChCode");
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<CodeDomain> selectLcode(CodeDomain codeDomain) {
		return baseDao.getList("inbound.selectLcode",codeDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<CodeDomain> selectMcode(CodeDomain codeDomain) {
		return  baseDao.getList("inbound.selectMcode",codeDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<CodeDomain> selectScode(CodeDomain codeDomain) {
		return  baseDao.getList("inbound.selectScode",codeDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<UserDomain> selectUserList() {
		return  baseDao.getList("inbound.selectUserList");
	}

	@Override
	public void insertSms(Map<String, String> map) {
		Map<String,String> map2 = new HashMap<String, String>();
		map2.put("tellNum", map.get("tellNum").replaceAll("-", ""));
		map2.put("content", map.get("content"));
		map2.put("userId", map.get("userId"));
		map2.put("title", map.get("title"));
		baseDao.insert("inbound.insertSms", map2);
	}

	@Override
	public void sendSms(Map<String, String> map) {
		baseDao3.insert("smsInterface.sendSms", map);
	}

	@Override
	public void sendSms2(Map<String, Object> map) {
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("tellNum", ((String) map.get("tellNum")).replaceAll("-", ""));
		map2.put("content", map.get("content"));
		map2.put("userId", map.get("userId"));
		map2.put("title", map.get("title"));
		baseDao3.insert("smsInterface.sendLms", map);
		if( map.get("id") != null){
			map2.put("id", map.get("id"));
		}
		baseDao3.insert("smsInterface.sendLms2", map2);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<InboundSpecialDomain> selectSpecial(ConsultDetailDomain cdd) {
		cdd.setTotalcnt((Integer)baseDao.getObject("inbound.specialTotalCnt", cdd));
		return baseDao.getList("inbound.selectSpecial", cdd);
	}

	@Override
	public void insertSpecial(ConsultDetailDomain consultDetailDomain) {
		baseDao.insert("inbound.insertSpecial", consultDetailDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<OrganizationDomain> selectOrganization(OrganizationDomain ornglDomain) {
		return baseDao.getList("inbound.selectOrganization", ornglDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<OrganizationDomain> orgnSearch(String kbizNm, String kbizId) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("kbizNm", kbizNm);
		map.put("kbizId", kbizId);
		return baseDao.getList("inbound.selectOrgn", map);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<OrganizationDomain> organizationSearch(OrganizationDomain ornglDomain) {
		List<OrganizationDomain> list = baseDao.getList("inbound.organizationSearch", ornglDomain);
		return list;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<OrganizationDomain> selectAdminList() {
		return baseDao.getList("inbound.selectAdminList");
	}

	@Override
	public void vocReg(VocDomain vocDomain) {
		baseDao.insert("inbound.vocReg", vocDomain);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<SmsDomain> smsList(SmsDomain smsDomain) {
		smsDomain.setTotalcnt((Integer)baseDao.getObject("inbound.smsTotalCnt", smsDomain));
		return baseDao.getList("inbound.smsList", smsDomain);
	}

	@Override
	public SmsDomain smsDetail(SmsDomain smsDomain) {
		return (SmsDomain)baseDao.getObject("inbound.smsDetail", smsDomain);
	}

	@Override
	public void insertMesg(MessengerDomain messengerDomain) {
		baseDao.insert("inbound.mesgSend", messengerDomain);
		AtMessenger7Communicator atmc = new AtMessenger7Communicator("172.30.2.54", 1234, 2);
		//atmc.addMessage("test1",  "김기정", messengerDomain.getMesgContent(),messengerDomain.getMesgUrl(),messengerDomain.getMesgTitle());
		atmc.addMessage(messengerDomain.getTranId(),  messengerDomain.getUserNm() , messengerDomain.getMesgContent(),messengerDomain.getMesgUrl(),messengerDomain.getMesgTitle());
		atmc.send();
	}
}