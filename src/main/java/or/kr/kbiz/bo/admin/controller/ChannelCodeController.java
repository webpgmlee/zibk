package or.kr.kbiz.bo.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.kbiz.bo.admin.domain.ChannelCodeDomain;
import or.kr.kbiz.bo.admin.service.ChannelCodeService;

/**
 * <pre>ChannelCodeController</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */

@Controller
@RequestMapping(value="/admin")
public class ChannelCodeController {

	private static final Logger logger = LoggerFactory.getLogger(ChannelCodeController.class);

	private static String PREFIX = "admin";
	/**
	 * 인입채널코드 서비스
	 */
	@Autowired
	private ChannelCodeService channelCodeService;

	/**
	 * <pre>인입채널코드 화면 호출</pre>
	 *
	 * @param channelCodeInit 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/channelCode")
	public String channelCodeInit(@ModelAttribute ChannelCodeDomain channelCodeDomain, Model model) {
		//model.addAttribute("resultList", channelCodeService.selectChannelCodeList(channelCodeDomain));
		return PREFIX + "/channelCode";
	}

	/**
	 * <pre>인입채널코드 화면 호출</pre>
	 *
	 * @param channelCodeList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/channelCodeList")
	public String channelCodeList(@ModelAttribute ChannelCodeDomain channelCodeDomain, Model model) {
		model.addAttribute("pageDomain", channelCodeDomain);
		model.addAttribute("resultList", channelCodeService.selectChannelCodeList(channelCodeDomain));
		return PREFIX + "/view/channelCodeList";
	}

	/**
	 * <pre>인입채널코드 상세화면 호출</pre>
	 *
	 * @param channelCodeList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/channelCodeDetail")
	public void channelCodeDetail(@ModelAttribute ChannelCodeDomain channelCodeDomain, Model model) {
		model.addAttribute("result", channelCodeService.selectChannelCodeDetail(channelCodeDomain));
	}

	/**
	 * <pre>인입채널코드 중복체크</pre>
	 *
	 * @param channelCodeCheck 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/channelCodeCheck")
	public void channelCodeCheck(@ModelAttribute ChannelCodeDomain channelCodeDomain, Model model) {
		//중분류, 소분류 '00'으로 셋팅
		if(channelCodeDomain.getLcode().equals("00") && channelCodeDomain.getMcode().equals("00")){
			channelCodeDomain.setLcode(channelCodeDomain.getCode());
			channelCodeDomain.setScode("00");
		}else if(!channelCodeDomain.getLcode().equals("00") && channelCodeDomain.getMcode().equals("00")){
			channelCodeDomain.setMcode(channelCodeDomain.getCode());
			channelCodeDomain.setScode("00");
		}else if(!channelCodeDomain.getLcode().equals("00") && !channelCodeDomain.getMcode().equals("00")){
			channelCodeDomain.setScode(channelCodeDomain.getCode());
		}
		model.addAttribute("result", channelCodeService.selectChannelCodeCheck(channelCodeDomain));
	}

	/**
	 * <pre>인입채널코드 저장 호출</pre>
	 *
	 * @param saveChannelCode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/saveChannelCode")
	public void saveChannelCode(@ModelAttribute ChannelCodeDomain channelCodeDomain, Model model) {
		//중분류, 소분류 '00'으로 셋팅
		if(channelCodeDomain.getLcode().equals("00") && channelCodeDomain.getMcode().equals("00")){
			channelCodeDomain.setLcode(channelCodeDomain.getCode());
			channelCodeDomain.setScode("00");
		}else if(!channelCodeDomain.getLcode().equals("00") && channelCodeDomain.getMcode().equals("00")){
			channelCodeDomain.setMcode(channelCodeDomain.getCode());
			channelCodeDomain.setScode("00");
		}else if(!channelCodeDomain.getLcode().equals("00") && !channelCodeDomain.getMcode().equals("00")){
			channelCodeDomain.setScode(channelCodeDomain.getCode());
		}
		channelCodeService.saveChannelCode(channelCodeDomain);
	}

	/**
	 * <pre>인입채널코드 수정 호출</pre>
	 *
	 * @param channelCodeUpdate 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/channelCodeUpdate")
	public void channelCodeUpdate(@ModelAttribute ChannelCodeDomain channelCodeDomain, Model model) {
		 channelCodeService.channelCodeUpdate(channelCodeDomain);
	}

	/**
	 * <pre>대분류 조회</pre>
	 *
	 * @param channelLcode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/channelLcode")
	public void channelLcode(@ModelAttribute ChannelCodeDomain channelCodeDomain, Model model) {
		model.addAttribute("result", channelCodeService.selectchannelLcodeList(channelCodeDomain));
	}

	/**
	 * <pre>중분류 조회</pre>
	 *
	 * @param channelMcode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/channelMcode")
	public void channelMcode(@ModelAttribute ChannelCodeDomain channelCodeDomain, Model model) {
		model.addAttribute("result", channelCodeService.selectchannelMcodeList(channelCodeDomain));
	}

}
