package or.kr.kbiz.bo.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import or.kr.kbiz.bo.admin.domain.TransferDomain;
import or.kr.kbiz.bo.admin.service.TransferService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>이관내역 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class TransferServiceImpl implements TransferService {

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<TransferDomain> selectTransferList(TransferDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("transfer.selectTransferTotalCount", param));
		return baseDao.getList("transfer.select", param);
	}

	@Override
	public TransferDomain transferDetail(TransferDomain param) {
		return (TransferDomain) baseDao.getObject("transfer.selectDetail", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TransferDomain> selectTransferExcelList(TransferDomain param) {
		return baseDao.getList("transfer.selectExcel", param);
	}
}
