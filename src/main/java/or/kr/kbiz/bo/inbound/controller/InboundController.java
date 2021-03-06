package or.kr.kbiz.bo.inbound.controller;

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
import org.springframework.web.bind.annotation.RequestParam;

import or.kr.kbiz.bo.admin.domain.NoticeDomain;
import or.kr.kbiz.bo.admin.domain.ScriptDomain;
import or.kr.kbiz.bo.inbound.domain.CodeDomain;
import or.kr.kbiz.bo.inbound.domain.MessengerDomain;
import or.kr.kbiz.bo.inbound.domain.OrganizationDomain;
import or.kr.kbiz.bo.inbound.domain.SmsDomain;
import or.kr.kbiz.bo.inbound.service.InboundService;
import or.kr.kbiz.bo.main.service.MainService;


@Controller
@RequestMapping(value="/inbound")
public class InboundController {

	private static final Logger logger = LoggerFactory.getLogger(InboundController.class);

	private static String PREFIX = "inbound";

	@Autowired
	private InboundService inboundService;

	@Autowired
	private MainService mainService;

	@RequestMapping(value="/main.do")
	public String main(@RequestParam String chnlCode, @RequestParam String startCon, Model model){
		if(chnlCode != null){
			model.addAttribute("chnlCode", chnlCode);
		}
		if(startCon != null){
			model.addAttribute("startCon", startCon);
		}
		return PREFIX+"/main";
	}

	/**
	 * 스크립트 리스트
	 *
	 * @param codeDomain
	 * @return String
	 */
	@RequestMapping(value="/knowledge/view/knowledgeList.view")
	public String knowledgeList(Model model, @ModelAttribute CodeDomain codeDomain){
		if(codeDomain.getChnlCode() != null && codeDomain.getChnlCode().length() > 0){
			codeDomain.setChnlCode(codeDomain.getChnlCode());
		}else{
			codeDomain.setChnlCode("A");
		}
		model.addAttribute("script", inboundService.selectScript(codeDomain));
		model.addAttribute("pageDomain", codeDomain);
		return PREFIX+"/knowledge/view/knowledgeList";
	}

	/**
	 * 스크립트 리스트2
	 *
	 * @param CodeDomain
	 * @return String
	 */
	@RequestMapping(value="/knowledge/view/knowledgeList2.view")
	public String knowledgeList2(Model model, @ModelAttribute CodeDomain codeDomain){
		model.addAttribute("script2", inboundService.selectScript2(codeDomain));
		model.addAttribute("pageDomain", codeDomain);
		return PREFIX+"/knowledge/view/knowledgeList2";
	}

	/**
	 * 스크립트 상세
	 *
	 * @param CodeDomain
	 * @return String
	 */
	@RequestMapping(value="/knowledge/selectScriptDetail.json")
	public void selectScriptDetail(@RequestParam String scrpNo, Model model){
		model.addAttribute("scriptDetail", inboundService.selectScriptDetail(scrpNo));
	}

	/**
	 * 스크립트
	 *
	 * @param CodeDomain
	 * @return String
	 */
	/*@RequestMapping(value="/knowledge/knowledge.do")
	public String knowledge(@RequestParam String chnlCode, Model model){
		model.addAttribute("chCode", inboundService.selectChCode());
		return PREFIX+"/knowledge/knowledge";
	}*/

	/**
	 * 스크립트 첨부파일 다운로드
	 *
	 * @param codeDomain
	 * @return String
	 */
	@RequestMapping(value="/script/downloadFile.do")
	public void knowledge(@ModelAttribute ScriptDomain scriptDomain, HttpServletRequest request, HttpServletResponse response){
		try {
			inboundService.downloadFile(scriptDomain, request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 공지사항 리스트
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/notice/notice.do")
	public String notice(@ModelAttribute NoticeDomain noticeDomain, @RequestParam String chnlCode, Model model){
		model.addAttribute("chnlCode", chnlCode);
		model.addAttribute("chCode", inboundService.selectChCode());
		model.addAttribute("code", inboundService.selectCode());
		return PREFIX+"/notice/notice";
	}

	/**
	 * 공지사항뷰
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/notice/view/notice.view")
	public String noticeView(@ModelAttribute NoticeDomain noticeDomain, Model model){
		List<NoticeDomain> nd = mainService.selectNoticeList(noticeDomain);
		noticeDomain.setTotalcnt(mainService.selectNoticeTotalCnt(noticeDomain));
		model.addAttribute("noticeList", nd);
		model.addAttribute("pageDomain", noticeDomain);
		return PREFIX+"/notice/view/noticeView";
	}

	/**
	 * 공지사항 상세
	 *
	 * @param NoticeDomain.not_seq
	 * @return String
	 */
	@RequestMapping(value="/notice/noticeDetail.do")
	public String mainNoticeDetail(@ModelAttribute NoticeDomain noticeDomain, Model model) {
		model.addAttribute("noticeDetail", mainService.selectNoticeDetail(noticeDomain));
		return PREFIX+"/notice/noticeDetail";
	}

	/**
	 * SMS이력조회
	 *
	 * @param SmsDomain
	 * @return String
	 */
	@RequestMapping(value="/sms/view/smsList.view")
	public String smsList(@ModelAttribute SmsDomain smsDomain, Model model){
		model.addAttribute("smsList", inboundService.smsList(smsDomain));
		model.addAttribute("pageDomain", smsDomain);
		return PREFIX+"/sms/view/smsView";
	}

	/**
	 * SMS상세조회
	 *
	 * @param SmsDomain
	 * @return
	 */
	@RequestMapping(value="/sms/smsDetail.json")
	public void smsDetail(@ModelAttribute SmsDomain smsDomain, Model model){
		model.addAttribute("smsDetail", inboundService.smsDetail(smsDomain));
	}

	/**
	 * 메신저 팝업
	 *
	 * @param
	 * @return String
	 */
	@RequestMapping(value="/messenger/mesgPop.do")
	public String mesgPop(@ModelAttribute OrganizationDomain orngDomain,@ModelAttribute MessengerDomain messengerDomain, Model model){
		model.addAttribute("LoginUserNm", messengerDomain.getLoginUserNm());
		model.addAttribute("LoginUserId", messengerDomain.getLoginUserId());
		model.addAttribute("orng", inboundService.selectOrganization(orngDomain));
		return PREFIX+"/messenger/mesgPop";
	}

	/**
	 * 메신저 전송
	 *
	 * @param MessengerDomain
	 */
	@RequestMapping(value="/messenger/mesgSend.json", method = RequestMethod.POST)
	public void mesgSend(@ModelAttribute MessengerDomain messengerDomain, Model model){
		inboundService.insertMesg(messengerDomain);
	}

}
