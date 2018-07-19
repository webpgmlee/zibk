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

import or.kr.kbiz.bo.admin.domain.ScriptDomain;
import or.kr.kbiz.bo.admin.service.ScriptService;
import or.kr.kbiz.serv.spring.mvc.BaseDao;
/**
 * <pre>스크립트 implement</pre>
 *
 * @author bsy
 * @since 2017.11.20
 * @version 1.0
 *
 */
@Service
public class ScriptServiceImpl implements ScriptService {
	private static final Logger logger = LoggerFactory.getLogger(ScriptServiceImpl.class);

	@Autowired(required=true)
	@Qualifier("apBaseDao")
	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List<ScriptDomain> selectScriptList(ScriptDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("script.selectScriptTotalCount", param));
		return baseDao.getList("script.select", param);
	}

	@SuppressWarnings("unchecked")
	public List<ScriptDomain> selectScriptList2(ScriptDomain param) {
		param.setTotalcnt((Integer) baseDao.getObject("script.selectScriptTotalCount2", param));
		return baseDao.getList("script.select2", param);
	}

	@Override
	public ScriptDomain selectScriptDetail(ScriptDomain param) {
		return (ScriptDomain) baseDao.getObject("script.selectDetail", param);
	}

	@Override
	public void saveScript(ScriptDomain param) {
		if(param.getScrpNo() == null){
			baseDao.insert("script.insertScript", param);
		}else{
			baseDao.update("script.updateScript", param);
		}
	}

	@Override
	public void scriptDelete(ScriptDomain param) {
		baseDao.delete("script.deleteScript", param);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<ScriptDomain> selectChCodeList(ScriptDomain param) {
		return baseDao.getList("script.selectChCodeList", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ScriptDomain> selectscriptLcodeList(ScriptDomain param) {
		return baseDao.getList("script.selectLcode", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ScriptDomain> selectscriptMcodeList(ScriptDomain param) {
		return baseDao.getList("script.selectMcode", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ScriptDomain> selectscriptScodeList(ScriptDomain param) {
		return baseDao.getList("script.selectScode", param);
	}

	public void uploadFile(Integer scrpNo, HttpServletRequest request) {
		int maxPostSize = 10 * 1024 * 1024;
		MultipartRequest multi;
		String fileName = "";
		FileOutputStream out;
		// String serverPath = request.getSession().getServletContext().getRealPath("/");
		String path1 = "D:\\upload\\script\\";
		String path2 = "D:\\upload\\temp\\";
		try {
			File dir = new File(path2);
			if(!dir.exists()){
				dir.mkdirs();
			}

			int seq = 0;
			if(scrpNo == null){
				seq = (Integer) baseDao.getObject("script.currScriptSeq");
			}else{
				seq = scrpNo;
			}

			multi = new MultipartRequest(request, path2, maxPostSize, "utf-8",new DefaultFileRenamePolicy());
			File file = multi.getFile("scrpFile");
			File file2 = new File(path1+(file.getName().replace(".", "_"+seq+".")));
			file.renameTo(file2);
			fileName = file.getName();
			out = new FileOutputStream(file);
			byte[] bytes = fileName.getBytes();
			out.write(bytes);
			out.close();
			file.delete();
			dir.delete();
			ScriptDomain sd = new ScriptDomain();
			sd.setScrpFile(file2.getName());
			sd.setScrpNo(seq);
			baseDao.update("script.updateFile", sd);
		} catch (IOException e) {
			logger.error("error : "+e);
		}
	}

	public void downloadFile(ScriptDomain scriptDomain, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileName = scriptDomain.getScrpFile();
		String reFileName =  URLEncoder.encode(scriptDomain.getScrpFile(),"UTF-8").replaceAll("\\+", "%20");
		File file = new File("D:\\upload\\script\\"+fileName);
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

	public void deleteFile(ScriptDomain scriptDomain) {
		String fileName = scriptDomain.getScrpFile();
        File file = new File("D:\\upload\\script\\"+fileName);
		if(file.exists()){
			file.delete();
		}
	}
}
