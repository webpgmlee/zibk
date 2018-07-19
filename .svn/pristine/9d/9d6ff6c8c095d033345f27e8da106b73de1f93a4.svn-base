package or.kr.kbiz.bo.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.kbiz.bo.admin.domain.CnltProcStatDomain;
import or.kr.kbiz.bo.admin.service.CnltProcStatService;
/**
 * <pre>CnltProcStatController</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
@Controller
@RequestMapping(value="/admin")
public class CnltProcStatController {

	private static final Logger logger = LoggerFactory.getLogger(CnltProcStatController.class);

	private static String PREFIX = "admin";
	@Autowired
	private CnltProcStatService cnltProcStatService;
	/**
	 * <pre>처리구분별통계 화면 호출</pre>
	 *
	 * @param cnltProcInit 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/cnltProcStat")
	public String cnltProcInit() {
		return PREFIX + "/cnltProcStat";
	}

	/**
	 * <pre>처리구분별 화면 호출</pre>
	 *
	 * @param channelCodeList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/cnltProcStatList")
	public void cnltProcList(@ModelAttribute CnltProcStatDomain cnltProcStatDomain, Model model) {
		model.addAttribute("result", cnltProcStatService.selectCnltProcStatList(cnltProcStatDomain));
	}
}
