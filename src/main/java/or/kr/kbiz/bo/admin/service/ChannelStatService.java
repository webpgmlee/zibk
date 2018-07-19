package or.kr.kbiz.bo.admin.service;

import java.util.List;

import or.kr.kbiz.bo.admin.domain.ChannelStatDomain;
/**
 * <pre>ChannelStatService</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 */
public interface ChannelStatService {

	/**
	 * 목록 조회 템플릿
	 *
	 * @param param
	 * @return List<ChannelStatDomain>
	 */
	abstract List<ChannelStatDomain>  selectChannelStatList(ChannelStatDomain param);

	/**
	 * 코드 조회 템플릿
	 *
	 * @param param
	 * @return List<ChannelStatDomain>
	 */
	abstract List<ChannelStatDomain>  selectChannelStatCodeList(ChannelStatDomain param);

}
