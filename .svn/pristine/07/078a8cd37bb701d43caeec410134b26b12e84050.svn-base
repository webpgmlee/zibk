package or.kr.kbiz.bo.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import or.kr.kbiz.bo.admin.domain.ScriptDomain;
import or.kr.kbiz.bo.admin.service.ScriptService;

/**
 * <pre>SciptController</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */

@Controller
@RequestMapping(value="/admin")
public class SciptController {

	private static final Logger logger = LoggerFactory.getLogger(SciptController.class);

	private static String PREFIX = "admin";
	/**
	 * 스크립트 서비스
	 */
	@Autowired
	private ScriptService sciptService;

	/**
	 * <pre>스크립트 화면 호출</pre>
	 *
	 * @param scriptInit 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/script")
	public String scriptInit(@ModelAttribute ScriptDomain scriptDomain, Model model) {
		//model.addAttribute("resultList", sciptService.selectScriptList(scriptDomain));
		//인입채널코드 조회
		model.addAttribute("selChCode", sciptService.selectChCodeList(scriptDomain));
		return PREFIX + "/script";
	}

	/**
	 * <pre>스크립트 화면 호출</pre>
	 *
	 * @param sciptList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/scriptList")
	public String sciptList(@ModelAttribute ScriptDomain scriptDomain, Model model) {
		model.addAttribute("pageDomain", scriptDomain);
		model.addAttribute("resultList", sciptService.selectScriptList(scriptDomain));
		return PREFIX + "/view/scriptList";
	}

	/**
	 * <pre>스크립트 화면 호출</pre>
	 *
	 * @param sciptList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/scriptList2")
	public String sciptList2(@ModelAttribute ScriptDomain scriptDomain, Model model) {
		model.addAttribute("pageDomain", scriptDomain);
		model.addAttribute("resultList", sciptService.selectScriptList2(scriptDomain));
		return PREFIX + "/view/scriptList2";
	}

	/**
	 * <pre>스크립트 상세화면 호출</pre>
	 *
	 * @param sciptList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/scriptDetail")
	public void sciptDetail(@ModelAttribute ScriptDomain scriptDomain, Model model) {
		model.addAttribute("result", sciptService.selectScriptDetail(scriptDomain));
	}

	/**
	 * <pre>스크립트 저장 호출</pre>
	 *
	 * @param saveScript 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/saveScript")
	public void saveScript(@ModelAttribute ScriptDomain scriptDomain) {
		 sciptService.saveScript(scriptDomain);
	}

	/**
	 * <pre>스크립트 삭제 호출</pre>
	 *
	 * @param scriptDelete 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/scriptDelete")
	public void scriptDelete(@ModelAttribute ScriptDomain scriptDomain) {
		 sciptService.scriptDelete(scriptDomain);
	}

	/**
	 * <pre>대분류 조회</pre>
	 *
	 * @param channelLcode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/scriptLcode")
	public void channelLcode(@ModelAttribute ScriptDomain scriptDomain, Model model) {
		model.addAttribute("result", sciptService.selectscriptLcodeList(scriptDomain));
	}

	/**
	 * <pre>중분류 조회</pre>
	 *
	 * @param channelMcode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/scriptMcode")
	public void channelMcode(@ModelAttribute ScriptDomain scriptDomain, Model model) {
		model.addAttribute("result", sciptService.selectscriptMcodeList(scriptDomain));
	}

	/**
	 * <pre>소분류 조회</pre>
	 *
	 * @param channelScode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/scriptScode")
	public void channelScode(@ModelAttribute ScriptDomain scriptDomain, Model model) {
		model.addAttribute("result", sciptService.selectscriptScodeList(scriptDomain));
	}

	/**
	 * <pre>스크립트 파일업로드</pre>
	 *
	 * @param request
	 */
	@RequestMapping(value="/script/uploadFile", method = RequestMethod.POST)
	public String uploadFile(@ModelAttribute ScriptDomain scriptDomain, Integer scrpNo, HttpServletRequest request,Model model) {
		model.addAttribute("selChCode", sciptService.selectChCodeList(scriptDomain));
		sciptService.uploadFile(scrpNo,request);
		return PREFIX + "/script";
	}

	/**
	 * <pre>스크립트 파일다운로드</pre>
	 *
	 * @param request
	 */
	@RequestMapping(value="/script/downloadFile")
	public void downloadFile(@ModelAttribute ScriptDomain scriptDomain, HttpServletRequest request, HttpServletResponse response) throws Exception{
		sciptService.downloadFile(scriptDomain, request, response);
	}

	/**
	 * <pre>스크립트 파일삭제</pre>
	 *
	 * @param deleteFile 템플릿 도메인
	 */
	@RequestMapping(value="/script/deleteFile")
	public String deleteFile(@ModelAttribute ScriptDomain scriptDomain,Model model) {
		model.addAttribute("selChCode", sciptService.selectChCodeList(scriptDomain));
		sciptService.deleteFile(scriptDomain);
		return PREFIX + "/script";
	}

}
