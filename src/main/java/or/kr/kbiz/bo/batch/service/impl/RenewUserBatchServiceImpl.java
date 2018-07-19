package or.kr.kbiz.bo.batch.service.impl;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import or.kr.kbiz.bo.batch.domain.RenewOrngDomain;
import or.kr.kbiz.bo.batch.domain.RenewUserDomain;
import or.kr.kbiz.bo.batch.service.RenewUserBatchService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
import or.kr.kbiz.serv.util.SecureUtil;

@Component(value="renewUserBatchService")
public class RenewUserBatchServiceImpl implements RenewUserBatchService {
//	private final Logger LOG = LoggerFactory.getLogger(getClass());

	@Autowired(required=true)
	@Qualifier(value="oraintBaseDao")
	private BaseDao oraintBaseDao;

	@Autowired(required=true)
	@Qualifier(value="apBaseDao")
	private BaseDao apBaseDao;

	@SuppressWarnings("unchecked")
	public List<RenewUserDomain> selectOraintUserList() {
		return oraintBaseDao.getList("oraintInterface.selectOraintUser");
	}

	@SuppressWarnings("unchecked")
	public List<RenewOrngDomain> selectOraintOrngList() {
		return oraintBaseDao.getList("oraintInterface.selectOraintOrng");
	}

	public String saveOrng(RenewOrngDomain renewOrngDomain) {
		String result = "";

		if (renewOrngDomain.getUpperDeptCd() != null) {

			if ("009910".equals(renewOrngDomain.getUpperDeptCd()) || "009906".equals(renewOrngDomain.getUpperDeptCd())
					|| "000101".equals(renewOrngDomain.getUpperDeptCd()) || "007770".equals(renewOrngDomain.getUpperDeptCd())
					|| "009902".equals(renewOrngDomain.getUpperDeptCd()) || "000103".equals(renewOrngDomain.getUpperDeptCd())
					|| "000301".equals(renewOrngDomain.getUpperDeptCd()) || "000510".equals(renewOrngDomain.getUpperDeptCd())
					|| "000207".equals(renewOrngDomain.getUpperDeptCd()) || "000310".equals(renewOrngDomain.getUpperDeptCd())
					|| "003510".equals(renewOrngDomain.getUpperDeptCd()) || "000604".equals(renewOrngDomain.getUpperDeptCd())
					|| "000304".equals(renewOrngDomain.getUpperDeptCd()) || "000220".equals(renewOrngDomain.getUpperDeptCd())
					|| "009904".equals(renewOrngDomain.getUpperDeptCd()) || "009920".equals(renewOrngDomain.getUpperDeptCd())) {
				renewOrngDomain.setLevl("7");
			}

			if ("000200".equals(renewOrngDomain.getUpperDeptCd()) || "003100".equals(renewOrngDomain.getUpperDeptCd())
					|| "007700".equals(renewOrngDomain.getUpperDeptCd()) || "009995".equals(renewOrngDomain.getUpperDeptCd())
					|| "009900".equals(renewOrngDomain.getUpperDeptCd()) || "000100".equals(renewOrngDomain.getUpperDeptCd())
					|| "005100".equals(renewOrngDomain.getUpperDeptCd()) || "005000".equals(renewOrngDomain.getUpperDeptCd())
					|| "004510".equals(renewOrngDomain.getUpperDeptCd()) || "000500".equals(renewOrngDomain.getUpperDeptCd())
					|| "000700".equals(renewOrngDomain.getUpperDeptCd()) || "007110".equals(renewOrngDomain.getUpperDeptCd())
					|| "006100".equals(renewOrngDomain.getUpperDeptCd()) || "000300".equals(renewOrngDomain.getUpperDeptCd())
					|| "000400".equals(renewOrngDomain.getUpperDeptCd()) || "008110".equals(renewOrngDomain.getUpperDeptCd())
					|| "008120".equals(renewOrngDomain.getUpperDeptCd()) || "004500".equals(renewOrngDomain.getUpperDeptCd())
					|| "000600".equals(renewOrngDomain.getUpperDeptCd()) || "000800".equals(renewOrngDomain.getUpperDeptCd())
					) {
				renewOrngDomain.setLevl("6");
			}

			if ("999999".equals(renewOrngDomain.getDeptCd())) {
				renewOrngDomain.setLevl("1");
			} else if ("A00000".equals(renewOrngDomain.getDeptCd())) {
				renewOrngDomain.setLevl("2");
			}

			if ("00000".equals(renewOrngDomain.getUpperDeptCd().substring(1, 6))) {
				if ("A00000".equals(renewOrngDomain.getUpperDeptCd())) {
					renewOrngDomain.setLevl("3");
				} else {
					renewOrngDomain.setLevl("4");
				}
			}

			// 중앙회OB
			if ("B00001".equals(renewOrngDomain.getUpperDeptCd())) {
				renewOrngDomain.setLevl("4");
			}

			// 임원실, 삭제부서
			if ("000000".equals(renewOrngDomain.getUpperDeptCd())
					|| "008888".equals(renewOrngDomain.getUpperDeptCd())) {
				renewOrngDomain.setLevl("5");
			}
		}

		if (apBaseDao.getObject("renewUserBatch.selectExistOrngYn", renewOrngDomain.getDeptCd()).equals("Y")) {
			/* 조직정보 존재 - 수정 */
			result = "U";
			apBaseDao.update("renewUserBatch.updateIfCoOrngMa", renewOrngDomain);
			apBaseDao.update("renewUserBatch.updateIfCoOrngHi", renewOrngDomain);
		} else {
			/* 조직정보 미존재 - 추가 */
			result = "I";

			/* 부서유형구분 코드 (0:중소기업중앙회, 1:위탁조합) */
			if (renewOrngDomain.getReserved1() != null
					&& "B".equals(renewOrngDomain.getReserved1())) {
				renewOrngDomain.setDeptTypeDscd("0");
			} else {
                /*
                 * 008888:삭제부서,   999999:중소기업그룹, A00000:중소기업,     acube000:SB-Net, B00604:통합콜센터,
                 * B00603:공제상담사, B00002:중앙회OB,     B00602:외국인력통역, 007779:신규직원, C00000:중소기업연구원
                 * B00001:중우회,     000000:홍보실
                */
				if ("008888".equals(renewOrngDomain.getDeptCd()) || "999999".equals(renewOrngDomain.getDeptCd())
						|| "A00000".equals(renewOrngDomain.getDeptCd()) || "acube000".equals(renewOrngDomain.getDeptCd())
						|| "B00604".equals(renewOrngDomain.getDeptCd()) || "B00603".equals(renewOrngDomain.getDeptCd())
						|| "B00002".equals(renewOrngDomain.getDeptCd()) || "B00602".equals(renewOrngDomain.getDeptCd())
						|| "007779".equals(renewOrngDomain.getDeptCd()) || "C00000".equals(renewOrngDomain.getDeptCd())
						|| "B00001".equals(renewOrngDomain.getDeptCd()) || "000000".equals(renewOrngDomain.getDeptCd())) {
					renewOrngDomain.setDeptTypeDscd("0");
				}
			}

			apBaseDao.insert("renewUserBatch.insertIfCoOrngMa", renewOrngDomain);
			apBaseDao.insert("renewUserBatch.insertIfCoOrngHi", renewOrngDomain);
		}

		return result;
	}

	public String saveUser(RenewUserDomain renewUserDomain) {
		String result = "";
		boolean isExist = true;

		RenewUserDomain cDomain = (RenewUserDomain) apBaseDao.getObject("renewUserBatch.selectExistIfCoUserMaInfo", renewUserDomain.getUserId());
		if (cDomain == null) {
			isExist = false;
			String deptCd = (String) apBaseDao.getObject("renewUserBatch.selectDeptTypeDscd", renewUserDomain.getDeptCd());
			/* 부서 조회결과 없을 경우 입력 실패 */
			if (deptCd == null) {
				return "F";
			}
			renewUserDomain.setUserTypeDscd(deptCd);
		}

		if (isExist) {
			/* 중앙회 사용자가 보증 시스템에 동일한 ID가 존재 할 경우 update */
			result = "U";
			renewUserDomain.setUserSno(cDomain.getUserSno());
			apBaseDao.update("renewUserBatch.updateIfCoUserMa", renewUserDomain);

			/* 사용자 권한은 이전 권한 유지 */
			renewUserDomain.setCallApGrade(cDomain.getCallApGrade());
			if ((cDomain.getRspofc() != null && !cDomain.getRspofc().equals(renewUserDomain.getRspofc()))
					|| (cDomain.getOfcps() != null && !cDomain.getOfcps().equals(renewUserDomain.getOfcps()))
					|| (cDomain.getDeptCd() != null && !cDomain.getDeptCd().equals(renewUserDomain.getDeptCd()))) {
				/* 사용자 직위, 직책, 부서 변경 시 */
				apBaseDao.update("renewUserBatch.updateIfCoUserHiLastYn", renewUserDomain);
				apBaseDao.insert("renewUserBatch.insertIfCoUserHi", renewUserDomain);
			} else {
				/* 사용자 직위, 직책, 부서 변경안됨 */
				if ("N".equals(cDomain.getRtrmYn())) {
					/* 현재 재직시 */
					apBaseDao.update("renewUserBatch.updateIfCoUserHi", renewUserDomain);
				} else {
					/* 퇴사 후 재 입사 시 */
					apBaseDao.update("renewUserBatch.updateIfCoUserMaIsDeleted", renewUserDomain);
					apBaseDao.update("renewUserBatch.updateIfCoUserHiLastYn", renewUserDomain);
					apBaseDao.insert("renewUserBatch.insertIfCoUserHi", renewUserDomain);
				}
			}
		} else {
			/* 사용자 추가되었을 경우 */
			result = "I";
			/* 사용자 권한은 상담원 */
			renewUserDomain.setCallApGrade("03");
			apBaseDao.insert("renewUserBatch.insertIfCoUserMa", renewUserDomain);
			renewUserDomain.setPswd(SecureUtil.encrypt(renewUserDomain.getUserId() + "1234!"));
			apBaseDao.insert("renewUserBatch.insertUserPswd", renewUserDomain);
			renewUserDomain.setUserSno("0");
			apBaseDao.insert("renewUserBatch.insertIfCoUserHi", renewUserDomain);
		}

		return result;
	}
}
