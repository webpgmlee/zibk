package or.kr.kbiz.serv.spring.mvc;

import java.util.List;

/**
 * iBatis를 지원하기 위한  DAO
 *
 */
@SuppressWarnings({"rawtypes"})
public class BaseDaoIbatis extends BaseSqlSessionDaoSupport implements BaseDao {
//	private static final Logger LOG = LoggerFactory.getLogger(BaseDaoIbatis.class);

	@Override
	public Object getObject(String sqlId, Object param) {
		return this.getSqlSession().selectOne(sqlId, param);
	}

	@Override
	public Object getObject(String sqlId) {
		return this.getSqlSession().selectOne(sqlId);
	}

	@Override
	public List getList(String sqlId, Object param) {
		return this.getSqlSession().selectList(sqlId, param);
	}

	@Override
	public List getList(String sqlId) {
		return this.getSqlSession().selectList(sqlId);
	}

	@Override
	public Object insert(String sqlId, Object param) {
		return this.getSqlSession().insert(sqlId, param);
	}

	@Override
	public Object insert(String sqlId) {
		return this.getSqlSession().insert(sqlId, null);
	}

	@Override
	public int update(String sqlId, Object param) {
		return this.getSqlSession().update(sqlId, param);
	}

	@Override
	public int update(String sqlId) {
		return this.getSqlSession().update(sqlId);
	}

	@Override
	public int delete(String sqlId, Object param) {
		return this.getSqlSession().delete(sqlId, param);
	}

	@Override
	public int delete(String sqlId) {
		return this.getSqlSession().delete(sqlId);
	}

}
