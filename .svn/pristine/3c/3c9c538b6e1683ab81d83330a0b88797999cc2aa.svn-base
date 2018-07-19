package or.kr.kbiz.bo.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.kbiz.bo.admin.domain.ChannelStatDomain;
import or.kr.kbiz.bo.admin.service.ChannelStatService;
/**
 * <pre>ChannelStatController</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
@Controller
@RequestMapping(value="/admin")
public class ChannelStatController {

	private static final Logger logger = LoggerFactory.getLogger(ChannelStatController.class);

	private static String PREFIX = "admin";
	@Autowired
	private ChannelStatService channelStatService;
	/**
	 * <pre>인입채널별통계 화면 호출</pre>
	 *
	 * @param channelStatInit 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/channelStat")
	public String channelStatInit() {
		return PREFIX + "/channelStat";
	}

	/**
	 * <pre>인입채널별 코드</pre>
	 *
	 * @param channelStatCode 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/channelStatCodeList")
	public void channelStatCodeList(@ModelAttribute ChannelStatDomain channelStatDomain, Model model) {
		model.addAttribute("codeList", channelStatService.selectChannelStatCodeList(channelStatDomain));
	}

	/**
	 * <pre>인입채널별 조회</pre>
	 *
	 * @param channelCodeList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/channelStatList")
	public void channelCodeList(@ModelAttribute ChannelStatDomain channelStatDomain, Model model) {
		model.addAttribute("result", channelStatService.selectChannelStatList(channelStatDomain));
	}
}
