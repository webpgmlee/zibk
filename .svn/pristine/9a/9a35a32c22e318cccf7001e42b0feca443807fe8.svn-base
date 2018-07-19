/**
 *
 */
package or.kr.kbiz.bo.login.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ksign.access.api.SSOService;

import or.kr.kbiz.bo.login.domain.LoginUserDomain;
import or.kr.kbiz.bo.login.service.LoginUserService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
import or.kr.kbiz.serv.util.SecureUtil;

/**
 * 로그인 서비스 구현체
 *
 * @author hyeok
 * @since 2018.01.09
 * @version 1.0
 */
@Service
public class LoginUserServiceImpl implements LoginUserService {

	private static final Logger LOG = LoggerFactory.getLogger(LoginUserServiceImpl.class);

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	BaseDao apBaseDao;

	@Override
	public LoginUserDomain execLogin(LoginUserDomain loginUserDomain, HttpServletRequest request, HttpServletResponse response) {
		LoginUserDomain compDomain = (LoginUserDomain) apBaseDao.getObject("loginUser.selectLoginUserInfo", loginUserDomain.getUserId());
		LoginUserDomain result = new LoginUserDomain();

		/* 사용자 존재여부 */
		if (compDomain != null) {
			/* 사용자 계정 잠금 여부 */
			if ("Y".equals(compDomain.getAcctLockedYn())) {
				result.setResultCode("11");
				result.setResultMsg("최종 로그인 후 3개월이 초과하여 계정이 잠겼습니다.\n관리자에게 문의하세요.");
				return result;
			}

			/* 사용자 비밀번호 관리자에의해 초기화 여부 */
			if ("Y".equals(compDomain.getInitPswdYn())) {
				result.setResultCode("12");
				result.setResultMsg("관리자에의하여 비밀번호가 초기화 되었습니다.\n비밀번호를 변경 후 로그인하세요.");
				return result;
			}

			/* 사용자 비밀번호 변경 3개월 초과 여부 */
			if ("Y".equals(compDomain.getPswdChngYn())) {
				result.setResultCode("13");
				result.setResultMsg("비밀번호 변경 후 3개월이 지났습니다.\n비밀번호를 변경해주세요.");
				return result;
			}

			/* 사용자 로그인 시도 5회 초과 여부 */
			if (compDomain.getLognAtmpCont() >= 5) {
				result.setResultCode("14");
				result.setResultMsg("비밀번호를 5회 잘못 입력하였습니다.\n관리자에게 비밀번호 초기화 요청 후 사용하세요.");
				return result;
			}

			/* 로그인 성공 */
			if (SecureUtil.encrypt(loginUserDomain.getPswd()).equals(compDomain.getPswd())) {
				result.setResultCode("01");
				result.setResultMsg("로그인에 성공하였습니다.");
				result.setLastLognDtm(compDomain.getLastLognDtm());

				/* 로그인 성공 처리 */
				/* 1. 로그인 시도횟수 초기화 */
				apBaseDao.update("loginUser.updateSuccessLogin", loginUserDomain.getUserId());
				/* 2. CTI 로그인 요청 시 로그인 사용자의 CTI CALL 번호 수정 */
				if (loginUserDomain.getCtiYn() != null && loginUserDomain.getCtiYn().equals("Y")) {
					apBaseDao.update("loginUser.updateCtiCallNum", loginUserDomain);
				}


				/* AP 세션 설정 */
				HttpSession session = request.getSession();
				session.setAttribute("id", compDomain.getUserId());
				session.setAttribute("name", compDomain.getUserNm());
				session.setAttribute("callApGrade", compDomain.getCallApGrade());
				session.setAttribute("apLoginYn", "Y");
				if (loginUserDomain.getCtiDevice() != null && !"".equals(loginUserDomain.getCtiDevice().trim())) {
					session.setAttribute("ctiDevice", loginUserDomain.getCtiDevice());
				}
				session.setMaxInactiveInterval(32000);

				/* [S] SSO 설정 */
				/* SSO 서비스 객체 획득 */
				SSOService ssoService = SSOService.getInstance();
				String avps = "pgmId=123$sysDscd=00900003$";

				/* 인증 토큰 생성 요청 */
//				String reqCtx = request.getContextPath();
//				String returnUrl = "https://" + request.getServerName()+":"+ request.getServerPort() + reqCtx + "/sso/index.jsp";
				StringBuffer paramStr = new StringBuffer();
				if (loginUserDomain.getCtiYn() != null && loginUserDomain.getCtiYn().equals("Y")) {
					paramStr.append("?ctiYn=");
					paramStr.append(loginUserDomain.getCtiYn());
					paramStr.append("&ctiDevice=");
					paramStr.append(loginUserDomain.getCtiDevice());
				}
				String returnUrl = "https://" + request.getServerName() + ":" + request.getServerPort() + "/index.do" + paramStr;
//				String returnUrl = "https://dportal.9988.or.kr/ssoAgent/kbizSSORlnlPage.jsp";
				String agentIp = request.getLocalAddr();

//				String issue =
//				ssoService.ssoReqIssueTokenToString(
//										  request,	            	// 서블릿 요청 객체
//			        				      response,					// 서블릿 응답 객체
//			                              "form-based",				// 인증 방법
//			                              compDomain.getUserId(),				    	// 아이디
//			                              avps,		            	// 인증토큰 : 추가 속성정보 설정
//			                              returnUrl,            	// return url
//			                              request.getRemoteAddr(),	// client ip
//			                              agentIp);					// agent ip

				/* SSO 세션 설정 */
				session.setAttribute("ssoLoginYn", "N");
				result.setResultMsg("사용자 인증토큰 요청정보 생성에 실패 하여 AP 시스템만 로그인 사용 가능합니다.\n차세대 시스템 이용 시 추가적인 로그인이 필요합니다.");
				result.setResultUrl("/index.do" + paramStr);
//				if (issue == null) {
//					/* SSO 세션 설정 */
//					session.setAttribute("ssoLoginYn", "N");
//					result.setResultMsg("사용자 인증토큰 요청정보 생성에 실패 하여 AP 시스템만 로그인 사용 가능합니다.\n차세대 시스템 이용 시 추가적인 로그인이 필요합니다.");
//					result.setResultUrl("/index.do" + paramStr);
//				} else {
//					/* SSO 세션 설정 */
//					session.setAttribute("ssoLoginYn", "Y");
//					result.setResultUrl(issue);
//				}

				/* [E] SSO 설정 */
			} else {
				/* 로그인 실패 */
				result.setResultCode("02");
				result.setResultMsg("로그인에 실패하였습니다.");
				apBaseDao.update("loginUser.updateFailLogin", loginUserDomain.getUserId());
			}
		} else {
			result.setResultCode("51");
			result.setResultMsg("로그인에 실패하였습니다.");
		}

		return result;
	}

	@SuppressWarnings("unchecked")
	public LoginUserDomain execChngPswd(LoginUserDomain loginUserDomain) {
		LoginUserDomain compDomain = (LoginUserDomain) apBaseDao.getObject("loginUser.selectLoginUserInfo", loginUserDomain.getChngUserId());
		LoginUserDomain result = new LoginUserDomain();

		/* 사용자 존재여부 */
		if (compDomain != null) {
			/* 사용자 계정 잠금 여부 */
			if ("Y".equals(compDomain.getAcctLockedYn())) {
				result.setResultCode("11");
				result.setResultMsg("최종 로그인 후 3개월이 초과하여 계정이 잠겼습니다.\n관리자에게 문의하세요.");
				return result;
			}

			/* 사용자 로그인 시도 5회 초과 여부 */
			if (compDomain.getLognAtmpCont() >= 5) {
				result.setResultCode("14");
				result.setResultMsg("비밀번호를 5회 잘못 입력하였습니다.\n관리자에게 비밀번호 초기화 요청 후 사용하세요.");
				return result;
			}

			/* 기존 비밀번호 확인 성공 */
			if (SecureUtil.encrypt(loginUserDomain.getChngPswd()).equals(compDomain.getPswd())) {
				/* 최근 사용한 3건의 비밀번호 동일여부 확인 */
				List<LoginUserDomain> resultList = apBaseDao.getList("loginUser.selectThUserPswdByUser", loginUserDomain.getChngUserId());
				if (resultList != null) {
					for (int i = 0; i < resultList.size(); i++) {
						LoginUserDomain t = resultList.get(i);
						if (i < 3) {
							if (SecureUtil.encrypt(loginUserDomain.getChngNewPswd()).equals(t.getPswd())) {
								result.setResultCode("31");
								result.setResultMsg("최근 사용한 비밀번호와 동일합니다.\n최근 3회동안 사용하지 않은 비밀번호로 변경하세요.");
								return result;
							}
							if (i == 2) {
								/* 최근 사용한 비밀번호 변경 이력이 3건이라면 첫 번째 1건 삭제 */
								apBaseDao.delete("loginUser.deleteThUserPswdByMinChngDate", loginUserDomain.getChngUserId());
							}
						} else {
							/* 최근 사용한 비밀번호 변경 이력이 3건을 초과할 경우 해당 이력 삭제
							 * 관리자가 비밀번호 초기화한 경우 제외 비밀번호 이력은 최대 3건만 저장 유지 */
							apBaseDao.delete("loginUser.deleteThUserPswdByMinChngDate", loginUserDomain.getChngUserId());
						}
					}
				}

				/* 사용자 이전 비밀번호 미사용 처리 */
				apBaseDao.update("loginUser.updateNotUsePrePswd", loginUserDomain.getChngUserId());
				/* 사용자 변경 비밀번호 저장 */
				loginUserDomain.setChngNewPswd(SecureUtil.encrypt(loginUserDomain.getChngNewPswd()));
				apBaseDao.insert("loginUser.insertThUserPswd", loginUserDomain);
				loginUserDomain.setChngNewPswd("");
				/* 비밀번호 초기화 데이터 삭제 */
				apBaseDao.delete("loginUser.deleteThUserPswdByInitPswd", loginUserDomain.getChngUserId());

				result.setResultCode("01");
				result.setResultMsg("정상적으로 비밀번호를 변경하였습니다.\n변경된 비밀번호로 다시 로그인해주세요.");
			} else {
				/* 기존 비밀번호 확인 실패 */
				result.setResultCode("02");
				result.setResultMsg("비밀번호 변경에 실패하였습니다.");
				apBaseDao.update("loginUser.updateFailLogin", loginUserDomain.getUserId());
			}
		} else {
			result.setResultCode("51");
//			result.setResultMsg("사용자가 존재하지 않습니다.");
			result.setResultMsg("비밀번호 변경에 실패하였습니다.");
		}

		return result;
	}
}
