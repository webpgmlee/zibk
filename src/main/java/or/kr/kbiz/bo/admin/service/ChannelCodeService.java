package or.kr.kbiz.bo.admin.service;

import java.util.List;

import or.kr.kbiz.bo.admin.domain.ChannelCodeDomain;
/**
 * <pre>ChannelCodeService</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
public interface ChannelCodeService {

	/**
	 * 목록 조회 템플릿
	 *
	 * @param param
	 * @return List<ChannelCodeDomain>
	 */
	abstract List<ChannelCodeDomain> selectChannelCodeList(ChannelCodeDomain param);

	/**
	 * 상세목록 조회 템플릿
	 *
	 * @param param
	 * @return ChannelCodeDomain
	 */
	abstract ChannelCodeDomain selectChannelCodeDetail(ChannelCodeDomain param);

	/**
	 * 입력값 중복조회 템플릿
	 *
	 * @param param
	 * @return ChannelCodeDomain
	 */
	abstract ChannelCodeDomain selectChannelCodeCheck(ChannelCodeDomain channelCodeDomain);

	/**
	 * 저장 템플릿
	 *
	 * @param param
	 * @return ChannelCodeDomain
	 */
	abstract void saveChannelCode(ChannelCodeDomain channelCodeDomain);

	/**
	 * 수정 템플릿
	 *
	 * @param param
	 * @return ChannelCodeDomain
	 */
	abstract void channelCodeUpdate(ChannelCodeDomain channelCodeDomain);

	/**
	 * 대분류코드 템플릿
	 *
	 * @param param
	 * @return ChannelCodeDomain
	 */
	abstract  List<ChannelCodeDomain> selectchannelLcodeList(ChannelCodeDomain param);

	/**
	 * 중분류코드 템플릿
	 *
	 * @param param
	 * @return ChannelCodeDomain
	 */
	abstract List<ChannelCodeDomain> selectchannelMcodeList(ChannelCodeDomain param);

}
