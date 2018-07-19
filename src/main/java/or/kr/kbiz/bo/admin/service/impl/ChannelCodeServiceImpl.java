package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.ChannelCodeDomain;
import or.kr.kbiz.bo.admin.service.ChannelCodeService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>인입채널코드 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class ChannelCodeServiceImpl implements ChannelCodeService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<ChannelCodeDomain> selectChannelCodeList(ChannelCodeDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("channelCode.selectChnlCodeTotalCount", param));
		return baseDao.getList("channelCode.select", param);
	}

	@Override
	public ChannelCodeDomain selectChannelCodeDetail(ChannelCodeDomain param) {
		return (ChannelCodeDomain) baseDao.getObject("channelCode.selectDetail", param);
	}

	@Override
	public ChannelCodeDomain selectChannelCodeCheck(ChannelCodeDomain param) {
		return (ChannelCodeDomain) baseDao.getObject("channelCode.selectCheck", param);
	}

	@Override
	public void saveChannelCode(ChannelCodeDomain param) {
		baseDao.insert("channelCode.insertChannelCode", param);
	}

	@Override
	public void channelCodeUpdate(ChannelCodeDomain param) {
		baseDao.update("channelCode.updateChannelCode", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ChannelCodeDomain> selectchannelLcodeList(ChannelCodeDomain param) {
		return baseDao.getList("channelCode.selectLcode", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ChannelCodeDomain> selectchannelMcodeList(ChannelCodeDomain param) {
		return baseDao.getList("channelCode.selectMcode", param);
	}
}
