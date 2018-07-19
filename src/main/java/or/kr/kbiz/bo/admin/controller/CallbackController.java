package or.kr.kbiz.bo.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.kbiz.bo.admin.domain.AdminCallbackDomain;
import or.kr.kbiz.bo.admin.service.CallbackService;
import or.kr.kbiz.serv.util.WriteListToExcelFile;
/**
 * <pre>CallbackController</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
@Controller
@RequestMapping(value="/admin")
public class CallbackController {

	private static final Logger logger = LoggerFactory.getLogger(CallbackController.class);

	private static String PREFIX = "admin";
	/**
	 * 콜백내역 서비스
	 */
	@Autowired
	private CallbackService callbackService;
	/**
	 * <pre>콜백내역 화면 호출</pre>
	 *
	 * @param 콜백내역 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/callback")
	public String callbackInit(@ModelAttribute AdminCallbackDomain callbackDomain, Model model) {
		//model.addAttribute("resultList", callbackService.selectCallbackList(callbackDomain));
		//인입채널코드 조회
		model.addAttribute("selChCode", callbackService.selectChCodeList(callbackDomain));
		return PREFIX + "/callback";
	}
	/**
	 * <pre>콜백내역 화면 호출</pre>
	 *
	 * @param callbackList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/callbackList", produces="text/html")
	public String callbackList(@ModelAttribute AdminCallbackDomain callbackDomain, Model model) {
		model.addAttribute("pageDomain", callbackDomain);
		model.addAttribute("resultList", callbackService.selectCallbackList(callbackDomain));
		return PREFIX + "/view/callbackList";
	}

	/**
	 * <pre>콜백내역 상세화면 호출</pre>
	 *
	 * @param callbackDetail 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/callbackDetail")
	public void callbackDetail(@ModelAttribute AdminCallbackDomain callbackDomain, Model model) {
		model.addAttribute("result", callbackService.selectCallbackDetail(callbackDomain));
	}

	/**
	 * Excel Down
	 *
	 * @param
	 * @return
	 */
	@RequestMapping(value="/callback/excel")
	public void excelDown(@ModelAttribute AdminCallbackDomain callbackDomain, HttpServletResponse response, Model model){
		List<AdminCallbackDomain> callbackList = callbackService.selectCallbackExcelList(callbackDomain);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(new Date());
		String fileName = "콜백내역_"+today;
		try {
			WriteListToExcelFile.writeCallbackListToFile(fileName+".xls", callbackList, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
