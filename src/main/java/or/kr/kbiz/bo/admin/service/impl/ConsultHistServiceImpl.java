package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.ConsultHistDomain;
import or.kr.kbiz.bo.admin.service.ConsultHistService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>상담이력 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class ConsultHistServiceImpl implements ConsultHistService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<ConsultHistDomain> selectConsultHistList(ConsultHistDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("consultHist.selectConsultHistTotalCount", param));
		return baseDao.getList("consultHist.select", param);
	}

	public ConsultHistDomain selectConsultHistDetail(ConsultHistDomain param) {
		return (ConsultHistDomain) baseDao.getObject("consultHist.selectDetail", param);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<ConsultHistDomain> selectChCodeList(ConsultHistDomain param) {
		return baseDao.getList("consultHist.selectChCodeList", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ConsultHistDomain> selectconsultLcodeList(ConsultHistDomain param) {
		return baseDao.getList("consultHist.selectLcode", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ConsultHistDomain> selectconsultMcodeList(ConsultHistDomain param) {
		return baseDao.getList("consultHist.selectMcode", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ConsultHistDomain> selectconsultScodeList(ConsultHistDomain param) {
		return baseDao.getList("consultHist.selectScode", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ConsultHistDomain> selectConsultHistExcelList(ConsultHistDomain param) {
		return baseDao.getList("consultHist.selectExcel", param);
	}
}
