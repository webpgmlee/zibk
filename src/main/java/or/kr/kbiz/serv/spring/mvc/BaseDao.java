package or.kr.kbiz.serv.spring.mvc;

import java.util.List;

@SuppressWarnings("rawtypes")
public interface BaseDao {

	/**
	 * 상세 조회
	 * 
	 * @param sqlId
	 * @param param
	 * @return
	 */
	public abstract Object getObject(String sqlId, Object param);

	public abstract Object getObject(String sqlId);

	/**
	 * 목록 조회
	 * 
	 * @param sqlId
	 * @param param
	 * @return
	 */
	public abstract List getList(String sqlId, Object param);

	public abstract List getList(String sqlId);

	/**
	 * 등록
	 * 
	 * @param sqlId
	 * @param param
	 * @return
	 */
	public abstract Object insert(String sqlId, Object param);

	public abstract Object insert(String sqlId);

	/**
	 * 수정
	 * 
	 * @param sqlId
	 * @param param
	 * @return
	 */
	public abstract int update(String sqlId, Object param);

	public abstract int update(String sqlId);

	/**
	 * 삭제
	 * 
	 * @param sqlId
	 * @param param
	 */
	public abstract int delete(String sqlId, Object param);

	public abstract int delete(String sqlId);

}