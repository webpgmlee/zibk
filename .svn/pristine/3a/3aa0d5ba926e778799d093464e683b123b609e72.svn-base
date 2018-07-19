package or.kr.kbiz.bo.mypage.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.kbiz.bo.mypage.domain.MypageDomain;
import or.kr.kbiz.bo.mypage.service.MypageService;
/**
 * <pre>MypageController</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
@Controller
@RequestMapping(value="/mypage")
public class MypageController {

	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);

	private static String PREFIX = "mypage";
	@Autowired
	private MypageService mypageService;

	/**
	 * <pre>mypage상담이력 화면 호출</pre>
	 *
	 * @param 콜백내역 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/mypage")
	public String mypageInit(@ModelAttribute MypageDomain mypageDomain, Model model) {
		//model.addAttribute("resultList", mypageService.selectMypageList(mypageDomain));
		//인입채널코드 조회
		model.addAttribute("selChCode", mypageService.selectChCodeList(mypageDomain));
		return PREFIX + "/mypage";
	}

	/**
	 * <pre>mypage상담이력 목록  호출</pre>
	 *
	 * @param mypageList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/mypageList", produces="text/html")
	public String mypageList(@ModelAttribute MypageDomain mypageDomain, Model model) {
		model.addAttribute("pageDomain", mypageDomain);
		model.addAttribute("resultList", mypageService.selectMypageList(mypageDomain));
		return PREFIX + "/view/mypageList";
	}

	/**
	 * <pre>mypage상담이력  상세 조회</pre>
	 *
	 * @param mypageDetail 템플릿 도메인
	 * @param model Model 객체
	 */
	@RequestMapping(value="/mypageDetail")
	public void mypageDetail(@ModelAttribute MypageDomain mypageDomain, Model model) {
		model.addAttribute("result", mypageService.selectMypageDetail(mypageDomain));
	}

	/**
	 * <pre>대분류 조회</pre>
	 *
	 * @param mypageLcode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/mypageLcode")
	public void mypageLcode(@ModelAttribute MypageDomain mypageDomain, Model model) {
		model.addAttribute("result", mypageService.selectMypageLcodeList(mypageDomain	));
	}

	/**
	 * <pre>중분류 조회</pre>
	 *
	 * @param mypageMcode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/mypageMcode")
	public void mypageMcode(@ModelAttribute MypageDomain mypageDomain, Model model) {
		model.addAttribute("result", mypageService.selectMypageMcodeList(mypageDomain));
	}

	/**
	 * <pre>소분류 조회</pre>
	 *
	 * @param mypageScode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/mypageScode")
	public void mypageScode(@ModelAttribute MypageDomain mypageDomain, Model model) {
		model.addAttribute("result", mypageService.selectMypageScodeList(mypageDomain));
	}
}
