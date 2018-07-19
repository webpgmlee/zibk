package or.kr.kbiz.bo.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.kbiz.bo.admin.domain.AdminCodeDomain;
import or.kr.kbiz.bo.admin.service.CodeService;

/**
 * <pre>CodeController</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */

@Controller
@RequestMapping(value="/admin")
public class CodeController {

	private static final Logger logger = LoggerFactory.getLogger(CodeController.class);

	private static String PREFIX = "admin";
	/**
	 * 공통코드 서비스
	 */
	@Autowired
	private CodeService codeService;

	/**
	 * <pre>공통코드 화면 호출</pre>
	 *
	 * @param codeInit 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/code")
	public String codeInit(@ModelAttribute AdminCodeDomain codeDomain, Model model) {
		//model.addAttribute("resultList", codeService.selectCodeList(codeDomain));
		return PREFIX + "/code";
	}

	/**
	 * <pre>공통코드 화면 호출</pre>
	 *
	 * @param codeList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/codeList")
	public String codeList(@ModelAttribute AdminCodeDomain codeDomain, Model model) {
		if(codeDomain.getSelLcode().equals("")){
				codeDomain.setSelLcode("001");
		}
		model.addAttribute("pageDomain", codeDomain);
		model.addAttribute("resultList", codeService.selectCodeList(codeDomain));
		return PREFIX + "/view/codeList";
	}

	/**
	 * <pre>대분류 조회</pre>
	 *
	 * @param channelLcode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/commLcode")
	public void channelLcode(@ModelAttribute AdminCodeDomain codeDomain, Model model) {
		model.addAttribute("result", codeService.selectCommLcodeList(codeDomain));
	}

	/**
	 * <pre>중분류 조회</pre>
	 *
	 * @param channelMcode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/commMcode")
	public void channelMcode(@ModelAttribute AdminCodeDomain codeDomain, Model model) {
		model.addAttribute("result", codeService.selectCommMcodeList(codeDomain));
	}

	/**
	 * <pre>공통코드 상세화면 호출</pre>
	 *
	 * @param codeDetail 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/codeDetail")
	public void codeDetail(@ModelAttribute AdminCodeDomain codeDomain, Model model) {
		model.addAttribute("result", codeService.selectCodeDetail(codeDomain));
	}

	/**
	 * <pre>공통코드 저장 호출</pre>
	 *
	 * @param saveChannelCode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/saveCode")
	public void saveCode(@ModelAttribute AdminCodeDomain codeDomain, Model model) {
		//중분류, 소분류 '000'으로 셋팅
		if(codeDomain.getLcode().equals("000")){
			codeDomain.setLcode(codeDomain.getCode());
			codeDomain.setMcode("00");
		}else if(!codeDomain.getLcode().equals("000")){
			codeDomain.setMcode(codeDomain.getCode());
		}
		codeService.saveCode(codeDomain);
	}


	/**
	 * <pre>공통코드 중복체크</pre>
	 *
	 * @param codeCheck 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	*/
	@RequestMapping(value="/codeCheck")
	public void codeCheck(@ModelAttribute AdminCodeDomain codeDomain, Model model) {
		//중분류, 소분류 '000'으로 셋팅
		if(codeDomain.getLcode().equals("000")){
			codeDomain.setLcode(codeDomain.getCode());
			codeDomain.setMcode("00");
		}else if(!codeDomain.getLcode().equals("000")){
			codeDomain.setMcode(codeDomain.getCode());
		}
		model.addAttribute("result", codeService.selectCodeCheck(codeDomain));
	}


	/**
	 * <pre>공통코드 수정 호출</pre>
	 *
	 * @param codeUpdate 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/codeUpdate")
	public void codeUpdate(@ModelAttribute AdminCodeDomain codeDomain, Model model) {
		 codeService.codeUpdate(codeDomain);
	}
}
