package or.kr.kbiz.serv.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.Calendar;
import java.util.Vector;

public class AtMessenger7Communicator extends Thread
{
	String ip;
	int port;
	int time;

	char DOM = 15;

	Vector <String> uidAr;
	Vector <String> cntAr;
	Vector <String> urlAr;

	public AtMessenger7Communicator(String ip, int port, int time)
	{
		this.ip = ip;
		this.port = port;
		this.time = time * 1000;

		uidAr = new Vector<String>();
		cntAr = new Vector<String>();
		urlAr = new Vector<String>();
	}

	public void send()
	{
		this.start();
	}

	@Override
	public void run()
	{
		Socket sc = null;
		InputStreamReader ir = null;
		BufferedReader br = null;
		PrintWriter pw = null;

		try
		{
			sc = new Socket();
			sc.connect(new InetSocketAddress(ip, port), time);
			ir = new InputStreamReader(sc.getInputStream());
			br = new BufferedReader(ir);
			pw = new PrintWriter(sc.getOutputStream(), true);

			for ( int i = 0 ; i < uidAr.size() ; i++ )
			{
				StringBuffer sndMsg = new StringBuffer();

				sndMsg.append("SYSMSG");
				sndMsg.append("\t");
				sndMsg.append(uidAr.elementAt(i));
				sndMsg.append("\t");
				sndMsg.append(cntAr.elementAt(i));
				sndMsg.append("\t");
				sndMsg.append(urlAr.elementAt(i));
				sndMsg.append("\f");

                sc.getOutputStream().write((sndMsg.toString() + "\n").getBytes("UTF-8"));

				if ( !getMessage(br, "ok") ) throw new Exception("Cannot send message");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try { ir.close(); ir = null; } catch(Exception ee) {}
			try { br.close(); br = null; } catch(Exception ee) {}
			try { pw.close(); pw = null; } catch(Exception ee) {}
			try { sc.close(); sc = null; } catch(Exception ee) {}
		}
	}

	private boolean getMessage(BufferedReader br, String targetStr) throws Exception
	{
		char buf[] = new char[1024];
		int rcv = 0;

		StringBuffer str = new StringBuffer();

		while ( ( rcv = br.read(buf, 0, 1024) ) >= 0 )
		{
			str.append(new String(buf, 0, rcv));

			System.out.println("str: [" + str.toString() + "]");

			if ( str.indexOf(targetStr) >= 0 )
				return true;
		}

		return false;
	}

	public void addMessage(String _recipientUId, String sender, String _content, String _url, String _shortMessage)
	{
		char DOMMI = 15;

		Calendar cal = Calendar.getInstance();
		String sendedTime = cal.getTimeInMillis() + "";
		if (sendedTime.length() > 10)
			sendedTime = sendedTime.substring(0, 10);

		StringBuffer msg = new StringBuffer();
		msg.append("0");
		msg.append(DOMMI);
		msg.append("1");
		msg.append(DOMMI);
		msg.append("ALERTMSG");
		msg.append(DOMMI);
		msg.append(_url);
		msg.append(DOMMI);
		msg.append("Reserved");
		msg.append(DOMMI);
		msg.append(_recipientUId);
		msg.append(DOMMI);
		msg.append(sender);
		msg.append(DOMMI);
		msg.append("Reserved");
		msg.append(DOMMI);
		msg.append("Reserved");
		msg.append(DOMMI);
		msg.append("Reserved");
		msg.append(DOMMI);
		msg.append("2");
		msg.append(DOMMI);
		msg.append(sendedTime);
		msg.append(DOMMI);
		msg.append("0");
		msg.append(DOMMI);
		msg.append("Reserved");
		msg.append(DOMMI);
		// ���� �κ� �� ����Ǿ���ϴ�.
		/* ����
		msg.append(_content);
		msg.append(DOMMI);
		msg.append(_shortMessage);
		*/
		msg.append(_shortMessage);
		msg.append(DOMMI);
		msg.append(_content);

		uidAr.add(_recipientUId);
		cntAr.add(msg.toString());
		urlAr.add("SDS");
	}

	public static void main(String[] args)
	{

			AtMessenger7Communicator atmc = new AtMessenger7Communicator("10.0.0.80", 1234, 2);
			atmc.addMessage("u001",  "������", "����<br>���� ���� ���� ���� ����","http://www.naver.com","����<br>��������� ��� �����Դϴ�.");
			atmc.send();
	}
}
