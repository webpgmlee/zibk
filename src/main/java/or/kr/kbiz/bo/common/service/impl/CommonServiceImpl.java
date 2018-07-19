package or.kr.kbiz.bo.common.service.impl;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.common.domain.BatchLogDomain;
import or.kr.kbiz.bo.common.domain.CommonCodeDomain;
import or.kr.kbiz.bo.common.domain.CommonMngtMenuDomain;
import or.kr.kbiz.bo.common.service.CommonService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;

@Service
public class CommonServiceImpl implements CommonService {

//	private static final Logger LOG = LoggerFactory.getLogger(CommonServiceImpl.class);

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	public String getServerDateTime(String format) {
		Date d = new Date(((Timestamp) baseDao.getObject("common.selectServerDateTime")).getTime());
		if (format == null || format.trim().equals("")) {
			format = "yyyyMMddhhmmss";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(d);
	}

	@SuppressWarnings("unchecked")
	public List<CommonCodeDomain> getCommonCodeList(CommonCodeDomain commonCodeDomain) {
		return baseDao.getList("common.selectCommonCodeList", commonCodeDomain);
	}

	public CommonCodeDomain getCommonCodeOne(CommonCodeDomain commonCodeDomain) {
		return (CommonCodeDomain) baseDao.getObject("common.selectCommonCodeOne", commonCodeDomain);
	}

	@SuppressWarnings("unchecked")
	public List<CommonMngtMenuDomain> getFirstMngtMenuList(CommonMngtMenuDomain commonMngtMenuDomain) {
		return baseDao.getList("common.selectFirstMngtMenu", commonMngtMenuDomain);
	}

	@SuppressWarnings("unchecked")
	public List<CommonMngtMenuDomain> getSecondMngtMenuList(CommonMngtMenuDomain commonMngtMenuDomain) {
		return baseDao.getList("common.selectSecondMngtMenu", commonMngtMenuDomain);
	}

	public void insertBatchLog(BatchLogDomain batchLogDomain) {
		baseDao.insert("common.insertBatchLog", batchLogDomain);
	}

}
