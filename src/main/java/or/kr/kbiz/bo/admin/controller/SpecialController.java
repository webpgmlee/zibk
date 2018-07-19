package or.kr.kbiz.bo.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.kbiz.bo.admin.domain.SpecialDomain;
import or.kr.kbiz.bo.admin.service.SpecialService;

@Controller
@RequestMapping(value="/admin")
public class SpecialController {

	private static final Logger logger = LoggerFactory.getLogger(SpecialController.class);

	private static String PREFIX = "admin";

	@Autowired
	private SpecialService specialService;

	@RequestMapping(value="/special")
	public String specialInit(@ModelAttribute SpecialDomain specialDomain, Model model) {
		//model.addAttribute("resultList", specialService.selectSpecialList(specialDomain));
		return PREFIX + "/special";
	}

	/**
	 * <pre>특이성향 리스트 조회</pre>
	 *
	 * @param specialList 템플릿 도메인
	 * @param model Model 객체
	 */
	@RequestMapping(value="/specialList", produces="text/html")
	public String specialList(@ModelAttribute SpecialDomain specialDomain, Model model) {
		model.addAttribute("pageDomain", specialDomain);
		model.addAttribute("resultList", specialService.selectSpecialList(specialDomain));
		return PREFIX + "/view/specialList";
	}

	/**
	 * <pre>특이성향 상세</pre>
	 *
	 * @param specialList 템플릿 도메인
	 * @param model Model 객체
	 */
	@RequestMapping(value="/specailDetail")
	public void consultDetail(@ModelAttribute SpecialDomain specialDomain, Model model) {
		model.addAttribute("result", specialService.selectSpecialDetail(specialDomain));
	}

	/**
	 * <pre>특이성향 수정</pre>
	 *
	 * @param specialList 템플릿 도메인
	 * @param model Model 객체
	 */
	@RequestMapping(value="/saveSpecial")
	public void saveSpecial(@ModelAttribute SpecialDomain selectspecialDetail, Model model) {
		specialService.saveSpecial(selectspecialDetail);
	}
}