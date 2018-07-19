package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.ChannelStatDomain;
import or.kr.kbiz.bo.admin.service.ChannelStatService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>인입채널별통계 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class ChannelStatServiceImpl implements ChannelStatService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<ChannelStatDomain> selectChannelStatList(ChannelStatDomain param) {
		return baseDao.getList("channelStat.select",param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ChannelStatDomain> selectChannelStatCodeList(ChannelStatDomain param) {
		return baseDao.getList("channelStat.selectCode",param);
	}
}
