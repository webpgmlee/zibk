package or.kr.kbiz.bo.inbound.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import or.kr.kbiz.bo.common.domain.LoginSessDomain;
import or.kr.kbiz.bo.inbound.domain.CallbackDomain;
import or.kr.kbiz.bo.inbound.domain.ConsultDetailDomain;
import or.kr.kbiz.bo.inbound.domain.CustomerDomain;
import or.kr.kbiz.bo.inbound.service.InboundService;

@Controller
@RequestMapping("/inbound/customer")
public class CustomerController {

	private static final Logger logger = LoggerFactory.getLogger(InboundController.class);

	private static String PREFIX = "inbound/customer";

	@Autowired
	private InboundService inboundService;

	/**
	 * 기업/개인 고객
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/custInfo.do")
	public String custInfo(@RequestParam String startCon, Model model){
		if(startCon != null && startCon.length() > 0){
			model.addAttribute("startCon", startCon);
		}
		return PREFIX+"/custInfo";
	}

	/**
	 * 기업/개인 고객 검색
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/csSearch.json")
	public void csSearch(@ModelAttribute CustomerDomain custDomain, Model model){
		model.addAttribute("csList", inboundService.selectCsSearch(custDomain));
	}

	/**
	 * INBOUND 기업/개인 고객 검색
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/custInbound.json")
	public void custInbound(@ModelAttribute CustomerDomain custDomain, Model model){
		model.addAttribute("totList",inboundService.selectCustomerCount(custDomain));
	}

	/**
	 * 1건 고객 검색 상담시작
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/custSearch.json")
	public void custSearch(@ModelAttribute CustomerDomain custDomain, Model model){
		CustomerDomain cd = inboundService.selectStartCon(custDomain);
		if(cd != null){
			cd.setSpclAppvYn(inboundService.selectSpclAppvYn(cd.getUntyCsno()));
		}
		model.addAttribute("totList", cd);
	}

	/**
	 * 0건 고객 특이성향 여부 확인
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/spclSearch.json")
	public void spclSearch(@ModelAttribute CustomerDomain custDomain, Model model){
		model.addAttribute("spclAppvYn", inboundService.selectSpclAppvYn2(custDomain.getTlno()));
	}

	/**
	 * 기업/개인 고객 검색(inbound팝업)
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/custSearch.do")
	public String custSearch1(@ModelAttribute CustomerDomain custDomain, @RequestParam String opener, Model model){
		model.addAttribute("code", inboundService.selectCustCode());
		model.addAttribute("custList",inboundService.selectCustomer(custDomain));
		model.addAttribute("opener", opener);
		return PREFIX+"/custSearch";
	}

	/**
	 * 기업/개인 고객 검색(inbound팝업)
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/custSearch2.json")
	public void custSearch2(@ModelAttribute CustomerDomain custDomain, Model model){
		CustomerDomain cd = inboundService.selectCustomer2(custDomain);
		/*List<CodeDomain> co = inboundService.selectCustCode();
		for(int i=0; i<co.size(); i++){
			if(cd.getCsDscd().equals(co.get(i).getMcode())){
				cd.setCodeName(co.get(i).getCodeName());
			}
		}*/
		model.addAttribute("custList2", cd);
	}

	/**
	 * 기업/개인 고객 검색
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/cntrSearch.json")
	public void cntrSearch(@ModelAttribute CustomerDomain custDomain, Model model){
		model.addAttribute("cntrList",inboundService.selectContract(custDomain));
	}

	/**
	 * 기업/개인 고객 검색
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/cntrDetail.json")
	public void cntrDetail(@ModelAttribute CustomerDomain custDomain, Model model){
		custDomain = inboundService.selectCntrDetail(custDomain);
		custDomain.setSpclAppvYn(inboundService.selectSpclAppvYn(custDomain.getUntyCsno()));
		model.addAttribute("cntrDetail", custDomain);
	}

	/**
	 * 콜백선점여부조회
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/callbackYn.json")
	public void callbackYn(@ModelAttribute CallbackDomain cbd, Model model){
		model.addAttribute("callYn", inboundService.callbackYn(cbd.getCallbackSeq()));
	}

	/**
	 * 콜백선점ID체크(로그인아이디와 일치하는지)
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/callbackModYn.json")
	public void callbackModYn(@ModelAttribute CallbackDomain cbd, Model model){
		model.addAttribute("modYn", inboundService.callbackModYn(cbd));
	}

	/**
	 * 특이성향 검색 팝업
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/specialPop.do")
	public String custSpecial(@ModelAttribute ConsultDetailDomain ccd, Model model){
		model.addAttribute("custInfo", ccd);
		return PREFIX+"/specialPop";
	}

	/**
	 * 특이성향리스트 조회
	 *
	 * @param ConsultDetailDomain
	 * @return String
	 */
	@RequestMapping(value="/view/specialView.view")
	public String consultInfoSearch(@ModelAttribute ConsultDetailDomain ccd, Model model){
		model.addAttribute("spec", inboundService.selectSpecial(ccd));
		model.addAttribute("pageDomain", ccd);
		return PREFIX+"/view/specialView";
	}

	/**
	 * SMS 팝업
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/smsPop.do")
	public String smsPop(@RequestParam String tlno, Model model){
		model.addAttribute("tlno", tlno);
		return PREFIX+"/smsPop";
	}

	/**
	 * SMS 전송
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/smsSend.do")
	public String smsSend(@RequestParam String [] arr, @RequestParam String content, @ModelAttribute LoginSessDomain lsd){
		Map<String, String> map;
		for(int i=0;i<arr.length;i++){
			map = new HashMap<String, String>();
			map.put("tellNum", arr[i]);
			map.put("content", content);
			map.put("userId", lsd.getLoginUserId());
			inboundService.insertSms(map); // APPDB INSERT
			inboundService.sendSms(map); // SMSDB(MARIA) INSERT
		}
		return PREFIX+"/smsPop";
	}

	/**
	 * LMS 전송
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/smsSend2.do")
	public String smsSend2(@RequestParam String [] arr, @RequestParam String content, @RequestParam String title, @ModelAttribute LoginSessDomain lsd){
		Map<String, String> map;
		Map<String, Object> map2;
		for(int i=0;i<arr.length;i++){
			map = new HashMap<String, String>();
			map.put("tellNum", arr[i]);
			map.put("content", content);
			map2 = new HashMap<String, Object>();
			map2.put("tellNum", arr[i]);
			map2.put("content", content);
			try {
				map.put("title", URLDecoder.decode(title, "UTF-8"));
				map2.put("title", URLDecoder.decode(title, "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				logger.debug("DECODE ERROR:"+e);
			}
			map.put("userId", lsd.getLoginUserId());
			inboundService.insertSms(map); // APPDB INSERT
			inboundService.sendSms2(map2);
		}
		return PREFIX+"/smsPop";
	}

	/**
	 * SMS 전송(2차인증)
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/smsSend2.json")
	public void smsSend2(@RequestParam String tellNum, @RequestParam String content, @ModelAttribute LoginSessDomain lsd, Model model){
		Map<String, String> map = new HashMap<String, String>();
		map.put("tellNum", tellNum);
		map.put("content", content);
		map.put("userId", lsd.getLoginUserId());
		inboundService.insertSms(map);
		inboundService.sendSms(map);
	}

	@RequestMapping(value="/testCustomer.do")
	public String testCustomer(@RequestParam String tlno, Model model){
		model.addAttribute("tlno", tlno);
		return PREFIX+"/testCustomer";
	}

}
