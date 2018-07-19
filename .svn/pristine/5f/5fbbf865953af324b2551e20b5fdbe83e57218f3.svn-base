package or.kr.kbiz.bo.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ksign.access.api.SSORspData;
import com.ksign.access.api.SSOService;
import com.ksign.access.sso.sso10.SSO10Conf;

import or.kr.kbiz.bo.login.domain.LoginUserDomain;
import or.kr.kbiz.bo.login.service.LoginUserService;

/**
 * <pre>로그인 컨트롤러</pre>
 *
 * @author hyeok
 * @since 2018.01.04
 * @version 1.0
 */

@Controller
public class LoginUserController {

//	private static final Logger LOG = LoggerFactory.getLogger(LoginUserController.class);

	@Autowired
	LoginUserService loginUserService;

	@RequestMapping(value={"/login", "/"})
	public String login(Model model) {
		return "login";
	}

	@RequestMapping(value="/execLogin")
	@ResponseBody
	public LoginUserDomain execLogin(@ModelAttribute LoginUserDomain loginUserDomain, HttpServletRequest request, HttpServletResponse response, Model model) {
		LoginUserDomain result = loginUserService.execLogin(loginUserDomain, request, response);
//		model.addAttribute("result", );
		return result;
	}

	@RequestMapping(value="/execLogout")
	public void execLogout(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		session.removeAttribute("id");
		session.removeAttribute("name");
		session.removeAttribute("callApGrade");
		session.removeAttribute("ctiDevice");
		session.invalidate();
	}

	@RequestMapping(value="/execChngPswd")
	public void execChngPswd(@ModelAttribute LoginUserDomain loginUserDomain, HttpServletRequest request, Model model) {
		model.addAttribute("result", loginUserService.execChngPswd(loginUserDomain));
	}

	@RequestMapping(value="/ssoTest")
	public String ssoTest(HttpServletRequest request, Model model) {
		SSORspData rspData = null;
		SSOService ssoService = SSOService.getInstance();
	    rspData = ssoService.ssoGetLoginData(request);
	    model.addAttribute("uid", rspData.getAttribute(SSO10Conf.UIDKey));
	    model.addAttribute("am", rspData.getAttribute(SSO10Conf.AMKey));
	    model.addAttribute("ts", rspData.getAttribute(SSO10Conf.TSKey));
	    model.addAttribute("cs", rspData.getAttribute(SSO10Conf.CPKey));
	    model.addAttribute("sysDscd", rspData.getAttribute("sysDscd"));
		return "ssoTest";
	}

}
