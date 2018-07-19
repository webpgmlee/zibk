package or.kr.kbiz.bo.admin.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import or.kr.kbiz.bo.admin.domain.NoticeDomain;
/**
 * <pre>NoticeService</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
public interface NoticeService {

	/**
	 * 목록 조회 템플릿
	 *
	 * @param param
	 * @return List<NoticeDomain>
	 */
	abstract List<NoticeDomain> selectNoticeList(NoticeDomain param);

	/**
	 * 상세 조회 템플릿
	 *
	 * @param param
	 * @return NoticeDomain
	 */
	abstract NoticeDomain selectNoticeDetail(NoticeDomain param);

	/**
	 * 저장 템플릿
	 *
	 * @param param
	 * @return NoticeDomain
	 */
	abstract void insertNotice(NoticeDomain param);

	/**
	 * 파일업로드
	 *
	 * @param param
	 * @return NoticeDomain
	 */
	abstract void uploadFile(Integer notiSeq, HttpServletRequest request);

	/**
	 * 파일다운로드
	 *
	 * @param param
	 * @return NoticeDomain
	 */
	abstract void downloadFile(NoticeDomain noticeDomain, HttpServletRequest request, HttpServletResponse response)  throws Exception;

	/**
	 * 삭제 템플릿
	 *
	 * @param seq
	 * @return NoticeDomain
	 */
	abstract void noticeDelete(Integer seq);

	/**
	 * 파일삭제
	 *
	 * @param param
	 * @return NoticeDomain
	 */
	abstract void deleteFile(NoticeDomain noticeDomain);

	/**
	 * 상시공지 최대3개 체크
	 *
	 * @param param
	 */
	abstract NoticeDomain notiTypeMax(String notiType);
}
