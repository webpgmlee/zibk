package or.kr.kbiz.bo.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import or.kr.kbiz.bo.admin.domain.NoticeDomain;
import or.kr.kbiz.bo.admin.service.NoticeService;
import or.kr.kbiz.bo.common.domain.CommonMngtMenuDomain;
import or.kr.kbiz.bo.common.service.CommonService;

/**
 * <pre>NoticeController</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */

@Controller
@RequestMapping(value="/admin")
public class NoticeController {

	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

	private static String PREFIX = "admin";
	/**
	 * 공지사항 서비스
	 */
	@Autowired
	private NoticeService noticeService;

	@Autowired
	private CommonService commonService;

	@RequestMapping(value="/index")
	public String noticeIndex(@ModelAttribute CommonMngtMenuDomain commonMngtMenuDomain, Model model) {
		List<CommonMngtMenuDomain> firstMenuList = commonService.getFirstMngtMenuList(commonMngtMenuDomain);
		model.addAttribute("firstMenuList", firstMenuList);
		return PREFIX + "/index";
	}

	@RequestMapping(value="/secondMenuList")
	public void secondMenuList(Model model) {
		List<CommonMngtMenuDomain> secondMenuList = commonService.getSecondMngtMenuList(new CommonMngtMenuDomain());
		model.addAttribute("secondMenuList", secondMenuList);
	}

	/**
	 * <pre>공지사항 화면 호출</pre>
	 *
	 * @param noticeInit 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/notice")
	public String noticeInit(@ModelAttribute NoticeDomain noticeDomain, Model model) {
		//model.addAttribute("resultList", noticeService.selectNoticeList(noticeDomain));
		return PREFIX + "/notice";
	}
	/**
	 * <pre>공지사항 목록 조회</pre>
	 *
	 * @param noticeList 템플릿 도메인
	 * @param model Model 객체
	 * @return String 요청화면 url
	 */
	@RequestMapping(value="/noticeList", produces="text/html")
	public String noticeList(@ModelAttribute NoticeDomain noticeDomain, Model model) {
		model.addAttribute("pageDomain", noticeDomain);
		model.addAttribute("resultList", noticeService.selectNoticeList(noticeDomain));
		return PREFIX + "/view/noticeList";
	}
	/**
	 * <pre>공지사항  상세 조회</pre>
	 *
	 * @param noticeDetail 템플릿 도메인
	 * @param model Model 객체
	 */
	@RequestMapping(value="/noticeDetail")
	public void noticeDetail(@ModelAttribute NoticeDomain noticeDomain, Model model) {
		model.addAttribute("result", noticeService.selectNoticeDetail(noticeDomain));
	}

	/**
	 * <pre>공지사항 저장/수정</pre>
	 *
	 * @param noticeInsert 템플릿 도메인
	 * @param model Model 객체
	 */
	@RequestMapping(value="/noticeInsert", method = RequestMethod.POST)
	public void noticeInsert(@ModelAttribute NoticeDomain noticeDomain) {
		noticeService.insertNotice(noticeDomain);
	}

	/**
	 * <pre>공지사항파일업로드</pre>
	 *
	 * @param request
	 */
	@RequestMapping(value="/notice/uploadFile", method = RequestMethod.POST)
	public String uploadFile(Integer notiSeq, HttpServletRequest request) {
		noticeService.uploadFile(notiSeq,request);
		return PREFIX + "/notice";
	}

	/**
	 * <pre>공지사항파일다운로드</pre>
	 *
	 * @param request
	 */
	@RequestMapping(value="/notice/downloadFile")
	public void downloadFile(@ModelAttribute NoticeDomain noticeDomain, HttpServletRequest request, HttpServletResponse response) throws Exception{
		noticeService.downloadFile(noticeDomain, request, response);
	}

	/**
	 * <pre>공지사항파일삭제</pre>
	 *
	 * @param noticeDetail 템플릿 도메인
	 */
	@RequestMapping(value="/notice/deleteFile")
	public String deleteFile(@ModelAttribute NoticeDomain noticeDomain) {
		noticeService.deleteFile(noticeDomain);
		return PREFIX + "/notice";
	}

	/**
	 * <pre>공지사항 삭제</pre>
	 *
	 * @param noticeDelete 템플릿 도메인
	 * @param model Model 객체
	 */
	@RequestMapping(value="/noticeDelete")
	public void noticeDelete(@ModelAttribute NoticeDomain noticeDomain) {
		noticeService.noticeDelete(noticeDomain.getNotiSeq());
	}

	/**
	 * <pre>공지사항 상시등록 최대3개 체크</pre>
	 *
	 * @param notiTypeMax 템플릿 도메인
	 * @param model Model 객체
	 */
	@RequestMapping(value="/notiTypeMax")
	public void notiTypeMax(@ModelAttribute NoticeDomain noticeDomain, Model model) {
		model.addAttribute("result", noticeService.notiTypeMax("07"));
	}

}
