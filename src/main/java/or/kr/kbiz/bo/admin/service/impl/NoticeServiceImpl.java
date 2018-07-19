package or.kr.kbiz.bo.admin.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import or.kr.kbiz.bo.admin.domain.NoticeDomain;
import or.kr.kbiz.bo.admin.service.NoticeService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>공지사항 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class NoticeServiceImpl implements NoticeService {
	private static final Logger logger = LoggerFactory.getLogger(NoticeServiceImpl.class);

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<NoticeDomain> selectNoticeList(NoticeDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("notice.selectNoticeTotalCount", param));
		return baseDao.getList("notice.select", param);
	}

	public NoticeDomain selectNoticeDetail(NoticeDomain param) {
		return (NoticeDomain) baseDao.getObject("notice.selectDetail", param);
	}

	public void uploadFile(Integer notiSeq, HttpServletRequest request) {
		int maxPostSize = 10 * 1024 * 1024;
		MultipartRequest multi;
		String fileName = "";
		FileOutputStream out;
		// String serverPath = request.getSession().getServletContext().getRealPath("/");
		String path1 = "D:\\upload\\notice\\";
		String path2 = "D:\\upload\\temp\\";
		try {
			File dir = new File(path2);
			if(!dir.exists()){
				dir.mkdirs();
			}
			int seq = 0;
			if(notiSeq == null){
				seq = (Integer) baseDao.getObject("notice.currNoticeSeq");
			}else{
				seq = notiSeq;
			}

			multi = new MultipartRequest(request, path2, maxPostSize, "utf-8",new DefaultFileRenamePolicy());
			File file = multi.getFile("notiFile");
			File file2 = new File(path1+(file.getName().replace(".", "_"+seq+".")));
			file.renameTo(file2);
			fileName = file.getName();
			out = new FileOutputStream(file);
			byte[] bytes = fileName.getBytes();
			out.write(bytes);
			out.close();
			file.delete();
			dir.delete();
			NoticeDomain nd = new NoticeDomain();
			nd.setNotiFilename(file2.getName());
			nd.setNotiFilepath(path1+file2.getName());
			nd.setNotiSeq(seq);
			baseDao.update("notice.updateFile", nd);
		} catch (IOException e) {
			logger.error("error : "+e);
		}
	}

	public void downloadFile(NoticeDomain noticeDomain, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileName = noticeDomain.getNotiFilename();
		String reFileName =  URLEncoder.encode(noticeDomain.getNotiFilename(),"UTF-8").replaceAll("\\+", "%20");
		File file = new File("D:\\upload\\notice\\"+fileName);
		response.setContentLength((int)file.length());
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Disposition","attachment;filename=\"" +reFileName +"\";");
		response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
		InputStream in = null;
		OutputStream os = null;
		try{ // 파일을 읽어 스트림에 담기
			in = new FileInputStream(file);
			os = response.getOutputStream();
            byte b[] = new byte[(int)file.length()];
            int leng = 0;
            while( (leng = in.read(b)) > 0 ){
                os.write(b,0,leng);
            }
            in.close();
            os.close();
		}catch(Exception e){
			logger.error("error : "+e);
		}
	}

	public void deleteFile(NoticeDomain noticeDomain) {
		String fileName = noticeDomain.getNotiFilename();
        File file = new File("D:\\upload\\notice\\"+fileName);
		if(file.exists()){
			file.delete();
		}
	}

	public void insertNotice(NoticeDomain noticeDomain){
		if (noticeDomain.getNotiSeq()== null) {
			// 신규
			baseDao.insert("notice.insertNotice", noticeDomain);
		} else {
			// 수정
			baseDao.update("notice.updateNotice", noticeDomain);
		}
	}

	public void noticeDelete(Integer notiSeq) {
		baseDao.delete("notice.deleteNotice", notiSeq);

	}

	@Override
	public NoticeDomain notiTypeMax(String notiType) {
		return (NoticeDomain) baseDao.getObject("notice.notiTypeMax", notiType);
	}
}
