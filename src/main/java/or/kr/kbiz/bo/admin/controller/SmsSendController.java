package or.kr.kbiz.bo.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.kbiz.bo.admin.domain.SmsSendDomain;
import or.kr.kbiz.bo.admin.service.SmsSendService;

@Controller
@RequestMapping(value="/admin")
public class SmsSendController {

	private static final Logger logger = LoggerFactory.getLogger(SmsSendController.class);

	private static String PREFIX = "admin";

	@Autowired
	private SmsSendService smsSendService;

	@RequestMapping(value="/smsSend")
	public String smsSendInit(@ModelAttribute SmsSendDomain smsSendDomain, Model model) {
		//model.addAttribute("resultList", smsSendService.selectSmsSendList(smsSendDomain));
		return PREFIX + "/smsSend";
	}

	/**
	 * <pre>SMS 리스트 조회</pre>
	 *
	 * @param smsSendList 템플릿 도메인
	 * @param model Model 객체
	 */
	@RequestMapping(value="/smsSendList", produces="text/html")
	public String smsSendList(@ModelAttribute SmsSendDomain smsSendDomain, Model model) {
		model.addAttribute("pageDomain", smsSendDomain);
		model.addAttribute("resultList", smsSendService.selectSmsSendList(smsSendDomain));
		return PREFIX + "/view/smsSendList";
	}

	/**
	 * <pre>SMS  상세 조회</pre>
	 *
	 * @param smsSendDetail 템플릿 도메인
	 * @param model Model 객체
	 */
	@RequestMapping(value="/smsSendDetail")
	public void smsSendDetail(@ModelAttribute SmsSendDomain smsSendDomain, Model model) {
		model.addAttribute("result", smsSendService.selectSmsSendDetail(smsSendDomain));
	}
}
