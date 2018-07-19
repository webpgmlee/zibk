package or.kr.kbiz.serv.exception;

import or.kr.kbiz.serv.web.converter.MessageConverter;

public class CommonWarning extends RuntimeException{

	/**
	 *
	 */
	private static final long serialVersionUID = 2846155501300238733L;
	public final static int MSG = 0;
	public final static int WARNING = 1;
	public final static int ERROR = 2;
	private String message;
	private String msg_code;
	private String msg_xml;

	/**
     * Construct a new Warning with no detailed message.
	 */
	public CommonWarning() {
		super();
	}

	public CommonWarning(String code) {
		this(code, MessageConverter.getMessage(code));
	}
	public CommonWarning(String code, String message) {
		this.msg_code = code;
		this.message = message;
		this.msg_xml = "<common_message><message>"+message+"</message><msg_code>"+code+"</msg_code></common_message>";
	}

	@Override
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getMsg_code() {
		return msg_code;
	}
	public void setMsg_code(String msg_code) {
		this.msg_code = msg_code;
	}
	public String getMsg_xml() {
		return msg_xml;
	}
	public void setMsg_xml(String msg_xml) {
		this.msg_xml = msg_xml;
	}
}
