package or.kr.kbiz.bo.mypage.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.mypage.domain.MypageDomain;
import or.kr.kbiz.bo.mypage.service.MypageService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>MYPAGE implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class MypageServiceImpl implements MypageService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<MypageDomain> selectMypageList(MypageDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("mypage.selectMypageTotalCount", param));
		return baseDao.getList("mypage.select", param);
	}

	public MypageDomain selectMypageDetail(MypageDomain param) {
		return (MypageDomain) baseDao.getObject("mypage.selectDetail", param);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<MypageDomain> selectChCodeList(MypageDomain param) {
		return baseDao.getList("mypage.selectChCodeList", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MypageDomain> selectMypageLcodeList(MypageDomain param) {
		return baseDao.getList("mypage.selectLcode", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MypageDomain> selectMypageMcodeList(MypageDomain param) {
		return baseDao.getList("mypage.selectMcode", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MypageDomain> selectMypageScodeList(MypageDomain param) {
		return baseDao.getList("mypage.selectScode", param);
	}
}
