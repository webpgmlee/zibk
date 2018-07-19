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

import or.kr.kbiz.bo.admin.domain.UserStatDomain;
import or.kr.kbiz.bo.admin.service.UserStatService;
import or.kr.kbiz.serv.util.WriteListToExcelFile;
/**
 * <pre>UserStatController</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
@Controller
@RequestMapping(value="/admin")
public class UserStatController {

	private static final Logger logger = LoggerFactory.getLogger(UserStatController.class);

	private static String PREFIX = "admin";
	@Autowired
	private UserStatService userStatService;
	/**
	 * <pre>상담원별통계 화면 호출</pre>
	 *
	 * @param userStatInit 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/userStat")
	public String userStatInit() {
		return PREFIX + "/userStat";
	}

	/**
	 * <pre>상담원별통계 화면 호출</pre>
	 *
	 * @param userStatList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/userStatList")
	public String userStatList(@ModelAttribute UserStatDomain userStatDomain, Model model) {
		model.addAttribute("pageDomain", userStatDomain);
		model.addAttribute("resultList", userStatService.selectUserStatList(userStatDomain));
		return PREFIX + "/view/userStatList";
	}

	/**
	 * Excel Down
	 *
	 * @param
	 * @return
	 */
	@RequestMapping(value="/userStat/excel")
	public void excelDown(@ModelAttribute UserStatDomain userStatDomain, HttpServletResponse response, Model model){
		List<UserStatDomain> userStatList = userStatService.selectUserStatExcelList(userStatDomain);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(new Date());
		String fileName = "상담원별통계_"+today;
		try {
			WriteListToExcelFile.writeUserStatListToFile(fileName+".xls", userStatList, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
