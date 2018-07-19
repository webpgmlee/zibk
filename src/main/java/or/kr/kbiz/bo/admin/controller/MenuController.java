package or.kr.kbiz.bo.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.kbiz.bo.admin.domain.AdminCodeDomain;
import or.kr.kbiz.bo.admin.domain.AdminMenuDomain;
import or.kr.kbiz.bo.admin.service.MenuService;

/**
 * <pre>MenuController</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */

@Controller
@RequestMapping(value="/admin")
public class MenuController {

	private static final Logger logger = LoggerFactory.getLogger(MenuController.class);

	private static String PREFIX = "admin";
	/**
	 * 공통코드 서비스
	 */
	@Autowired
	private MenuService menuService;

	/**
	 * <pre>공통코드 화면 호출</pre>
	 *
	 * @param codeInit 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/menu")
	public String codeInit(@ModelAttribute AdminMenuDomain menuDomain, Model model) {
		return PREFIX + "/menu";
	}

	/**
	 * <pre>대분류 조회</pre>
	 *
	 * @param channelLcode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/commFmenu")
	public void channelLcode(@ModelAttribute AdminMenuDomain menuDomain, Model model) {
		model.addAttribute("result", menuService.selectCommFMenuList(menuDomain));
	}
	
	/**
	 * <pre>공통코드 화면 호출</pre>
	 *
	 * @param menuList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/menuList")
	public String codeList(@ModelAttribute AdminMenuDomain menuDomain, Model model) {
		if(menuDomain.getSelMcode().equals("")){
			menuDomain.setSelMcode("000");
		}
		model.addAttribute("pageDomain", menuDomain);
		model.addAttribute("resultList", menuService.selectMenuList(menuDomain));
		return PREFIX + "/view/menuList";
	}

	/**
	 * <pre>공통코드 상세화면 호출</pre>
	 *
	 * @param menuDetail 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/menuDetail")
	public void menuDetail(@ModelAttribute AdminMenuDomain menuDomain, Model model) {
		model.addAttribute("result", menuService.selectMenuDetail(menuDomain));
	}
	
	
	
	/**
	 * <pre>공통코드 중복체크</pre>
	 *
	 * @param menuCheck 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	*/
	@RequestMapping(value="/menuCheck")
	public void menuCheck(@ModelAttribute AdminMenuDomain menuDomain, Model model) {
		//중분류, 소분류 '000'으로 셋팅
		/*
		if(codeDomain.getLcode().equals("000")){
			codeDomain.setLcode(codeDomain.getCode());
			codeDomain.setMcode("00");
		}else if(!codeDomain.getLcode().equals("000")){
			codeDomain.setMcode(codeDomain.getCode());
		}
		*/
		model.addAttribute("result", menuService.selectMenuCheck(menuDomain));
	}
	
	/**
	 * <pre>공통코드 저장 호출</pre>
	 *
	 * @param saveChannelCode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/saveMenu")
	public void saveMenu(@ModelAttribute AdminMenuDomain menuDomain, Model model) {
		menuService.saveMenu(menuDomain);
		//codeService.saveCode(codeDomain);
	}
	
	/**
	 * <pre>공통코드 수정 호출</pre>
	 *
	 * @param menuUpdate 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/menuUpdate")
	public void menuUpdate(@ModelAttribute AdminMenuDomain menuDomain, Model model) {
		//menuService.codeUpdate(codeDomain);
		menuService.menuUpdate(menuDomain);
	}
	
	/**
	 * <pre>공통코드 삭제 호출</pre>
	 *
	 * @param menuDelete 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/menuDelete")	
	public void menuDelete(@ModelAttribute AdminMenuDomain menuDomain, Model model) {
		menuService.menuDelete(menuDomain);
	}
	
}
