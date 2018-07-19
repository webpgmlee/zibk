package or.kr.kbiz.bo.admin.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import or.kr.kbiz.bo.admin.domain.ScriptDomain;
/**
 * <pre>ScriptService</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
public interface ScriptService {

	/**
	 * 목록 조회 템플릿
	 *
	 * @param param
	 * @return List<ScriptDomain>
	 */
	abstract List<ScriptDomain> selectScriptList(ScriptDomain param);

	/**
	 * 목록 조회 템플릿
	 *
	 * @param param
	 * @return List<ScriptDomain>
	 */
	abstract List<ScriptDomain> selectScriptList2(ScriptDomain param);

	/**
	 * 상세목록 조회 템플릿
	 *
	 * @param param
	 * @return ScriptDomain
	 */
	abstract ScriptDomain selectScriptDetail(ScriptDomain param);

	/**
	 * 저장 템플릿
	 *
	 * @param param
	 * @return ScriptDomain
	 */
	abstract void saveScript(ScriptDomain scriptDomain);

	/**
	 * 삭제 템플릿
	 *
	 * @param param
	 * @return ScriptDomain
	 */
	abstract void scriptDelete(ScriptDomain param);

	/**
	 * 대분류코드 템플릿
	 *
	 * @param param
	 * @return ScriptDomain
	 */
	abstract  List<ScriptDomain> selectscriptLcodeList(ScriptDomain param);

	/**
	 * 중분류코드 템플릿
	 *
	 * @param param
	 * @return ScriptDomain
	 */
	abstract List<ScriptDomain> selectscriptMcodeList(ScriptDomain param);

	/**
	 * 인입채널 조회 템플릿
	 *
	 * @param param
	 * @return List<ScriptDomain>
	 */
	abstract List<ScriptDomain> selectChCodeList(ScriptDomain param);

	/**
	 * 소분류 조회 템플릿
	 *
	 * @param param
	 * @return List<ScriptDomain>
	 */
	abstract List<ScriptDomain> selectscriptScodeList(ScriptDomain param);

	/**
	 * 파일업로드
	 *
	 * @param param
	 */
	abstract void uploadFile(Integer scrpNo,HttpServletRequest request);

	/**
	 * 파일다운로드
	 *
	 * @param param
	 * @return ChannelCodeDomain
	 */
	abstract void downloadFile(ScriptDomain param, HttpServletRequest request, HttpServletResponse response)  throws Exception;

	/**
	 * 삭제 템플릿
	 *
	 * @param seq
	 * @return NoticeDomain
	 */
	abstract void deleteFile(ScriptDomain param);

}
