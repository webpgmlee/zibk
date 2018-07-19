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

import or.kr.kbiz.bo.admin.domain.TransferDomain;
import or.kr.kbiz.bo.admin.service.TransferService;
import or.kr.kbiz.serv.util.WriteListToExcelFile;
/**
 * <pre>TransferController</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
@Controller
@RequestMapping(value="/admin")
public class TransferController {

	private static final Logger logger = LoggerFactory.getLogger(TransferController.class);

	private static String PREFIX = "admin";
	/**
	 * 이관내역 서비스
	 */
	@Autowired
	private TransferService transferService;
	/**
	 * <pre>이관내역 화면 호출</pre>
	 *
	 * @param transferInit 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/transfer")
	public String transferInit(@ModelAttribute TransferDomain transferDomain, Model model) {
		//model.addAttribute("resultList", transferService.selectTransferList(transferDomain));
		return PREFIX + "/transfer";
	}
	/**
	 * <pre>이관내역 화면 호출</pre>
	 *
	 * @param transferList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/transferList", produces="text/html")
	public String transferList(@ModelAttribute TransferDomain transferDomain, Model model) {
		model.addAttribute("pageDomain", transferDomain);
		model.addAttribute("resultList", transferService.selectTransferList(transferDomain));
		return PREFIX + "/view/transferList";
	}

	/**
	 * <pre>이관내역  상세 조회</pre>
	 *
	 * @param transferDetail 템플릿 도메인
	 * @param model Model 객체
	 */
	@RequestMapping(value="/transferDetail")
	public void transferDetail(@ModelAttribute TransferDomain transferDomain, Model model) {
		model.addAttribute("result", transferService.transferDetail(transferDomain));
	}

	/**
	 * Excel Down
	 *
	 * @param
	 * @return
	 */
	@RequestMapping(value="/transfer/excel")
	public void excelDown(@ModelAttribute TransferDomain transferDomain, HttpServletResponse response, Model model){
		List<TransferDomain> transferList = transferService.selectTransferExcelList(transferDomain);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(new Date());
		String fileName = "이관내역_"+today;
		try {
			WriteListToExcelFile.writeTransferListToFile(fileName+".xls", transferList, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
