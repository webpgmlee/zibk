package or.kr.kbiz.serv.exception;

public class BaseBizException extends BizException {

	private static final long serialVersionUID = 8292867052745483956L;

	public BaseBizException(String errorMessage) {
		super(errorMessage);
	}

	public BaseBizException(String errorMessage, String addMessage) {
		super(errorMessage, addMessage);
	}

	@Override
	public boolean hasErrorCode() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String getErrorCode() {
		// TODO Auto-generated method stub
		return null;
	}

}
