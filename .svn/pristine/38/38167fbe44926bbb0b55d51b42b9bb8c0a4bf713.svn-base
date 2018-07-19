package or.kr.kbiz.bo.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.kbiz.bo.common.domain.CommonCodeDomain;
import or.kr.kbiz.bo.common.service.CommonService;

/**
 * <pre>공통 컨트롤러</pre>
 *
 * @author hyeok
 * @since 2017.12.04
 * @version 1.0
 *
 */

@Controller
@RequestMapping(value = "/common")
public class CommonController {

//	private static final Logger LOG = LoggerFactory.getLogger(CommonController.class);

	@Autowired
	CommonService commonService;

	@RequestMapping("/getServerDateTime")
	public void getServerDateTime(String format, Model model) {
		model.addAttribute("dateTime", commonService.getServerDateTime(format));
	}

	@RequestMapping("/getCommonCodeList")
	public void getCommonCodeList(@ModelAttribute CommonCodeDomain commonCodeDomain, Model model) {
		model.addAttribute("codeList", commonService.getCommonCodeList(commonCodeDomain));
	}

}
