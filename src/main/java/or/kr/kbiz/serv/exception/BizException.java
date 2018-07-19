package or.kr.kbiz.serv.exception;


public abstract class BizException extends RuntimeException {

	private static final long serialVersionUID = -5570366572694397222L;

	protected String errorMessage;
	protected Object[] params;
	protected String addMessage;
	
	public BizException(String errorMessage) {
		this.errorMessage = errorMessage;
		this.addMessage = "";
	}
	
	public BizException(String errorMessage, String param) {
		this.errorMessage = errorMessage;
		this.addMessage = param;
	}

	public BizException(String errorMessage, Object[] params) {
		this.errorMessage = errorMessage;
		this.params = params;
	}
	
	public BizException(Throwable ex, String errorMessage) {
		super(errorMessage, ex);
	}

	public abstract boolean hasErrorCode();
	public abstract String getErrorCode();

	/**
	 * @return the params
	 */
	public Object[] getParams() {
		return params;
	}

	/**
	 * @return the errorMessage
	 */
	public String getErrorMessage() {
		return errorMessage;
	}
	
	public String getAddMessage() {
		return this.addMessage;
	}
	
	
}
