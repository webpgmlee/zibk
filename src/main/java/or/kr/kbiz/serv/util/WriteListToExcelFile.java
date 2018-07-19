package or.kr.kbiz.serv.util;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import or.kr.kbiz.bo.admin.domain.AdminCallbackDomain;
import or.kr.kbiz.bo.admin.domain.ConsultHistDomain;
import or.kr.kbiz.bo.admin.domain.NoticeDomain;
import or.kr.kbiz.bo.admin.domain.ReserveCallDomain;
import or.kr.kbiz.bo.admin.domain.TransferDomain;
import or.kr.kbiz.bo.admin.domain.UserStatDomain;
import or.kr.kbiz.serv.web.tags.ElTag;

@SuppressWarnings("serial")
public class WriteListToExcelFile extends ElTag{

    public static void writeNoticeListToFile(String fileName, List<NoticeDomain> consultHistList, HttpServletResponse response) throws Exception{
        Workbook workbook = null;
        OutputStream os = null;
        response.setHeader("Content-Disposition", "attachment filename="+fileName);
        if(fileName.endsWith("xlsx")){
            workbook = new XSSFWorkbook();
        }else if(fileName.endsWith("xls")){
            workbook = new HSSFWorkbook();
        }else{
            throw new Exception("invalid file name, should be xls or xlsx");
        }

        Sheet sheet = workbook.createSheet("TestSheet");

        int excelname=0; // 처음에는 ID 학번등 고정값을 넣기 위해 사용한 변수
        String labels[] = { "번호", "제목", "공지구분", "내용", "첨부파일명", "게시일자", "삭제여부", "등록자ID", "등록일자", "수정자ID", "수정일자" };
        for(int i=0;i<consultHistList.size()+1;i++){
            Row row = sheet.createRow(i);
            if(excelname==0){
            	Cell cell = null;
            	for(int c=0;c<labels.length;c++){
            		cell = row.createCell(c);
            		cell.setCellValue(labels[c]);
            	}
            }else{
            	NoticeDomain consultHist = consultHistList.get(i-1);
            	Cell cell = null;
        		cell = row.createCell(0);
            	cell.setCellValue(consultHist.getNotiSeq());
            	cell = row.createCell(1);
            	cell.setCellValue(consultHist.getNotiTitle());
            	cell = row.createCell(2);
            	cell.setCellValue(consultHist.getNotiTypeCd());
            	cell = row.createCell(3);
            	cell.setCellValue(consultHist.getNotiContents());
            	cell = row.createCell(4);
            	cell.setCellValue(consultHist.getNotiFilename());
            	cell = row.createCell(5);
            	cell.setCellValue(consultHist.getNotiDispDate());
            	cell = row.createCell(6);
            	cell.setCellValue(consultHist.getNotiDelYn());
            	cell = row.createCell(7);
            	cell.setCellValue(consultHist.getRegId());
            	cell = row.createCell(8);
            	cell.setCellValue(consultHist.getRegDate());
            	cell = row.createCell(9);
            	cell.setCellValue(consultHist.getModId());
            	cell = row.createCell(10);
            	cell.setCellValue(consultHist.getModDate());
            }
            excelname++;
        }
        response.setHeader("Content-Disposition", "attachment; filename="+fileName);
        response.setContentType("application/vnd.ms.excel");
        os = response.getOutputStream();
		workbook.write(os);
	    workbook.close();
		os.flush();
    }
    /**
	 * <pre>상담이력 엑셀</pre>
	 */
	@SuppressWarnings("deprecation")
	public static void writeConsultHIstListToFile(String fileName, List<ConsultHistDomain> consultHistList, HttpServletResponse response) throws Exception{
		String reFileName =  URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
		Workbook workbook = null;
		OutputStream os = null;
        if(fileName.endsWith("xlsx")){
            workbook = new XSSFWorkbook();
        }else if(fileName.endsWith("xls")){
            workbook = new HSSFWorkbook();
        }else{
            throw new Exception("invalid file name, should be xls or xlsx");
        }
        Sheet sheet = workbook.createSheet("상담 이력");
        int excelname=0; // 처음에는 ID 학번등 고정값을 넣기 위해 사용한 변수
        String labels[] = { "상담일시", "상담사", "고객명", "연락처", "계약번호","인입구분", "인입채널", "대분류", "중분류", "소분류",  "처리구분", "처리담당자", "예약일시", "문의", "답변" };

		//셀 스타일 및 폰트 설정
		CellStyle styleOfBoardFillFontBlackBold1 = workbook.createCellStyle();
		styleOfBoardFillFontBlackBold1.setAlignment(CellStyle.ALIGN_CENTER);
		styleOfBoardFillFontBlackBold1.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데

		String ioType = "";

        for(int i=0;i<consultHistList.size()+1;i++){
            Row row = sheet.createRow(i);
            if(excelname==0){
            	Cell cell = null;
            	for(int c=0;c<labels.length;c++){
                    sheet.autoSizeColumn((short)c);
                    sheet.setColumnWidth(c, (sheet.getColumnWidth(c))+2500);
            		cell = row.createCell(c);
            		cell.setCellValue(labels[c]);
            		cell.setCellStyle(styleOfBoardFillFontBlackBold1);
            	}
            }else{
            	ConsultHistDomain consultHist = consultHistList.get(i-1);
            	if(consultHist.getIoType() == null){
            		ioType = "";
            	}else{
	            	if(consultHist.getIoType().equals("I")){
	            		ioType = "IN";
	            	}else if(consultHist.getIoType().equals("O")){
	            		ioType = "OUT";
	            	}else if(consultHist.getIoType().equals("C")){
	            		ioType = "CALLBACK";
	            	}else{
	            		ioType = "";
	            	}
            	}
            	Cell cell = null;
        		cell = row.createCell(0);
            	cell.setCellValue(getDateTime(consultHist.getCnltDate()));
            	cell = row.createCell(1);
            	cell.setCellValue(consultHist.getUserNm());
            	cell = row.createCell(2);
            	cell.setCellValue(consultHist.getCustNm());
            	cell = row.createCell(3);
            	cell.setCellValue(getTellNumber(consultHist.getTellNum()));
            	cell = row.createCell(4);
            	cell.setCellValue(consultHist.getCntrNo());
            	cell = row.createCell(5);
            	cell.setCellValue(ioType);
            	cell = row.createCell(6);
            	cell.setCellValue(consultHist.getChnlCodeName());
            	cell = row.createCell(7);
            	cell.setCellValue(consultHist.getLcodeName());
            	cell = row.createCell(8);
            	cell.setCellValue(consultHist.getMcodeName());
            	cell = row.createCell(9);
            	cell.setCellValue(consultHist.getScodeName());
            	cell = row.createCell(10);
            	cell.setCellValue(consultHist.getCnltProcNm());
            	cell = row.createCell(11);
            	cell.setCellValue(consultHist.getTranNm());
            	cell = row.createCell(12);
            	cell.setCellValue(getDateTime(consultHist.getRsrvDate()));
            	cell = row.createCell(13);
            	cell.setCellValue(consultHist.getRecvNote());
            	cell = row.createCell(14);
            	cell.setCellValue(consultHist.getProcNote());


            }
            excelname++;
        }
        response.setHeader("Content-Disposition", "attachment; filename="+reFileName);
        response.setContentType("application/vnd.ms.excel");
        os = response.getOutputStream();
        workbook.write(os);
        workbook.close();
        os.close();
        os.flush();
	}
	 /**
	 * <pre>예약내역 엑셀</pre>
	 */
	@SuppressWarnings("deprecation")
	public static void writeReserverCallListToFile(String fileName, List<ReserveCallDomain> reserveCallList,HttpServletResponse response) throws Exception{
		String reFileName =  URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
		Workbook workbook = null;
		OutputStream os = null;
        if(fileName.endsWith("xlsx")){
            workbook = new XSSFWorkbook();
        }else if(fileName.endsWith("xls")){
            workbook = new HSSFWorkbook();
        }else{
            throw new Exception("invalid file name, should be xls or xlsx");
        }
        Sheet sheet = workbook.createSheet("예약 내역");
        int excelname=0; // 처음에는 ID 학번등 고정값을 넣기 위해 사용한 변수
        String labels[] = { "상담일시", "상담사", "고객명", "연락처", "계약번호","인입구분", "인입채널", "대분류", "중분류", "소분류",  "예약일시", "예약전화번호", "문의", "답변"};

      //셀 스타일 및 폰트 설정
  		CellStyle styleOfBoardFillFontBlackBold1 = workbook.createCellStyle();
  		styleOfBoardFillFontBlackBold1.setAlignment(CellStyle.ALIGN_CENTER);
		styleOfBoardFillFontBlackBold1.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데

		String ioType ="";
        for(int i=0;i<reserveCallList.size()+1;i++){
            Row row = sheet.createRow(i);
            if(excelname==0){
            	Cell cell = null;
            	for(int c=0;c<labels.length;c++){
                    sheet.autoSizeColumn((short)c);
                    sheet.setColumnWidth(c, (sheet.getColumnWidth(c))+2500);
            		cell = row.createCell(c);
            		cell.setCellValue(labels[c]);
            		cell.setCellStyle(styleOfBoardFillFontBlackBold1);
            	}
            }else{
            	ReserveCallDomain reserveCall = reserveCallList.get(i-1);
            	if(reserveCall.getIoType() == null){
            		ioType = "";
            	}else{
	            	if(reserveCall.getIoType().equals("I")){
	            		ioType = "IN";
	            	}else if(reserveCall.getIoType().equals("O")){
	            		ioType = "OUT";
	            	}else if(reserveCall.getIoType().equals("C")){
	            		ioType = "CALLBACK";
	            	}else{
	            		ioType = "";
	            	}
            	}
            	Cell cell = null;
        		cell = row.createCell(0);
            	cell.setCellValue(getDateTime(reserveCall.getCnltDate()));
            	cell = row.createCell(1);
            	cell.setCellValue(reserveCall.getUserNm());
            	cell = row.createCell(2);
            	cell.setCellValue(reserveCall.getCustNm());
            	cell = row.createCell(3);
            	cell.setCellValue(getTellNumber(reserveCall.getTellNum()));
            	cell = row.createCell(4);
            	cell.setCellValue(reserveCall.getCntrNo());
            	cell = row.createCell(5);
            	cell.setCellValue(ioType);
            	cell = row.createCell(6);
            	cell.setCellValue(reserveCall.getChnlCodeName());
            	cell = row.createCell(7);
            	cell.setCellValue(reserveCall.getLcodeName());
            	cell = row.createCell(8);
            	cell.setCellValue(reserveCall.getMcodeName());
            	cell = row.createCell(9);
            	cell.setCellValue(reserveCall.getScodeName());
            	cell = row.createCell(10);
            	cell.setCellValue(getDateTime(reserveCall.getRsrvDate()));
            	cell = row.createCell(11);
            	cell.setCellValue(getTellNumber(reserveCall.getRsrvTellNum()));
            	cell = row.createCell(12);
            	cell.setCellValue(reserveCall.getRecvNote());
            	cell = row.createCell(13);
            	cell.setCellValue(reserveCall.getProcNote());
            }
            excelname++;
        }
        response.setHeader("Content-Disposition", "attachment; filename="+reFileName);
        response.setContentType("application/vnd.ms.excel");
        os = response.getOutputStream();
        workbook.write(os);
        workbook.close();
        os.close();
        os.flush();
	}
	/**
	 * <pre>이관내역 엑셀</pre>
	 */
	@SuppressWarnings("deprecation")
	public static void writeTransferListToFile(String fileName, List<TransferDomain> transferList,HttpServletResponse response) throws Exception{
		String reFileName =  URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
		Workbook workbook = null;
		OutputStream os = null;
        if(fileName.endsWith("xlsx")){
            workbook = new XSSFWorkbook();
        }else if(fileName.endsWith("xls")){
            workbook = new HSSFWorkbook();
        }else{
            throw new Exception("invalid file name, should be xls or xlsx");
        }
        Sheet sheet = workbook.createSheet("이관 내역");
        int excelname=0; // 처음에는 ID 학번등 고정값을 넣기 위해 사용한 변수
        String labels[] = { "상담일시", "상담사", "고객명", "연락처", "계약번호", "인입구분","인입채널", "대분류", "중분류", "소분류",  "처리담당자", "문의", "답변"};

        //셀 스타일 및 폰트 설정
		CellStyle styleOfBoardFillFontBlackBold1 = workbook.createCellStyle();
		styleOfBoardFillFontBlackBold1.setAlignment(CellStyle.ALIGN_CENTER);
		styleOfBoardFillFontBlackBold1.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데

		String ioType ="";

        for(int i=0;i<transferList.size()+1;i++){
            Row row = sheet.createRow(i);
            if(excelname==0){
            	Cell cell = null;
            	for(int c=0;c<labels.length;c++){
                    sheet.autoSizeColumn((short)c);
                    sheet.setColumnWidth(c, (sheet.getColumnWidth(c))+2500);
            		cell = row.createCell(c);
            		cell.setCellValue(labels[c]);
            		cell.setCellStyle(styleOfBoardFillFontBlackBold1);
            	}
            }else{
            	TransferDomain transfer = transferList.get(i-1);
            	if(transfer.getIoType() == null){
            		ioType = "";
            	}else{
	            	if(transfer.getIoType().equals("I")){
	            		ioType = "IN";
	            	}else if(transfer.getIoType().equals("O")){
	            		ioType = "OUT";
	            	}else if(transfer.getIoType().equals("C")){
	            		ioType = "CALLBACK";
	            	}else{
	            		ioType = "";
	            	}
            	}
            	Cell cell = null;
        		cell = row.createCell(0);
            	cell.setCellValue(getDateTime(transfer.getCnltDate()));
            	cell = row.createCell(1);
            	cell.setCellValue(transfer.getUserNm());
            	cell = row.createCell(2);
            	cell.setCellValue(transfer.getCustNm());
            	cell = row.createCell(3);
            	cell.setCellValue(getTellNumber(transfer.getTellNum()));
            	cell = row.createCell(4);
            	cell.setCellValue(transfer.getCntrNo());
            	cell = row.createCell(5);
            	cell.setCellValue(ioType);
            	cell = row.createCell(6);
            	cell.setCellValue(transfer.getChnlCodeName());
            	cell = row.createCell(7);
            	cell.setCellValue(transfer.getLcodeName());
            	cell = row.createCell(8);
            	cell.setCellValue(transfer.getMcodeName());
            	cell = row.createCell(9);
            	cell.setCellValue(transfer.getScodeName());
            	cell = row.createCell(10);
            	cell.setCellValue(transfer.getTranNm());
            	cell = row.createCell(11);
            	cell.setCellValue(transfer.getRecvNote());
            	cell = row.createCell(12);
            	cell.setCellValue(transfer.getProcNote());
            }
            excelname++;
        }
        response.setHeader("Content-Disposition", "attachment; filename="+reFileName);
        response.setContentType("application/vnd.ms.excel");
        os = response.getOutputStream();
        workbook.write(os);
        workbook.close();
        os.close();
        os.flush();
	}
	/**
	 * <pre>콜백 엑셀</pre>
	 */
	@SuppressWarnings("deprecation")
	public static void writeCallbackListToFile(String fileName, List<AdminCallbackDomain> callbackList,HttpServletResponse response) throws Exception{
		String reFileName =  URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
		Workbook workbook = null;
		OutputStream os = null;
        if(fileName.endsWith("xlsx")){
            workbook = new XSSFWorkbook();
        }else if(fileName.endsWith("xls")){
            workbook = new HSSFWorkbook();
        }else{
            throw new Exception("invalid file name, should be xls or xlsx");
        }
        Sheet sheet = workbook.createSheet("콜백 내역");
        int excelname=0; // 처음에는 ID 학번등 고정값을 넣기 위해 사용한 변수
        String labels[] = {  "콜백인입일시", "인입전화번호","콜백요청 전화번호", "대표번호", "처리여부", "선점자ID", "처리구분","상담일시", "상담사", "고객명", "계약번호", "인입채널", "대분류", "중분류", "소분류", "문의", "답변"};

        //셀 스타일 및 폰트 설정
		CellStyle styleOfBoardFillFontBlackBold1 = workbook.createCellStyle();
		styleOfBoardFillFontBlackBold1.setAlignment(CellStyle.ALIGN_CENTER);
		styleOfBoardFillFontBlackBold1.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데

        for(int i=0;i<callbackList.size()+1;i++){
            Row row = sheet.createRow(i);
            if(excelname==0){
            	Cell cell = null;
            	for(int c=0;c<labels.length;c++){
                    sheet.autoSizeColumn((short)c);
                    sheet.setColumnWidth(c, (sheet.getColumnWidth(c))+2500);
            		cell = row.createCell(c);
            		cell.setCellValue(labels[c]);
            		cell.setCellStyle(styleOfBoardFillFontBlackBold1);
            	}
            }else{
            	AdminCallbackDomain callback = callbackList.get(i-1);
            	Cell cell = null;
        		cell = row.createCell(0);
        		cell.setCellValue(getDateTime(callback.getCallbackDate()));
            	cell = row.createCell(1);
            	cell.setCellValue(getTellNumber(callback.getTellNum()));
            	cell = row.createCell(2);
            	cell.setCellValue(getTellNumber(callback.getCallbackNum()));
            	cell = row.createCell(3);
            	cell.setCellValue(callback.getDnis());
            	cell = row.createCell(4);
            	cell.setCellValue(callback.getProcYn());
            	cell = row.createCell(5);
            	cell.setCellValue(callback.getModId());
            	cell = row.createCell(6);
            	cell.setCellValue(callback.getCnltProcNm());
            	cell = row.createCell(7);
            	cell.setCellValue(getDateTime(callback.getCnltDate()));
            	cell = row.createCell(8);
            	cell.setCellValue(callback.getUserNm());
            	cell = row.createCell(9);
            	cell.setCellValue(callback.getCustNm());
            	cell = row.createCell(10);
            	cell.setCellValue(callback.getCntrNo());
            	cell = row.createCell(11);
            	cell.setCellValue(callback.getChnlCodeName());
            	cell = row.createCell(12);
            	cell.setCellValue(callback.getLcodeName());
            	cell = row.createCell(13);
            	cell.setCellValue(callback.getMcodeName());
            	cell = row.createCell(14);
            	cell.setCellValue(callback.getScodeName());
            	cell = row.createCell(15);
            	cell.setCellValue(callback.getRecvNote());
            	cell = row.createCell(16);
            	cell.setCellValue(callback.getProcNote());
            }
            excelname++;
        }
        response.setHeader("Content-Disposition", "attachment; filename="+reFileName);
        response.setContentType("application/vnd.ms.excel");
        os = response.getOutputStream();
        workbook.write(os);
        workbook.close();
        os.close();
        os.flush();
	}

	/**
	 * <pre>상담원별통계 엑셀</pre>
	 */
	@SuppressWarnings("deprecation")
	public static void writeUserStatListToFile(String fileName, List<UserStatDomain> userStatList,HttpServletResponse response) throws Exception{
		String reFileName =  URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
		Workbook workbook = null;
		OutputStream os = null;
        if(fileName.endsWith("xlsx")){
            workbook = new XSSFWorkbook();
        }else if(fileName.endsWith("xls")){
            workbook = new HSSFWorkbook();
        }else{
            throw new Exception("invalid file name, should be xls or xlsx");
        }
        Sheet sheet = workbook.createSheet("상담원별통계");
        int rowCount = 0;
        int cellCount = 0;
        Cell cell = null;
        Row row = null;
        String labels[] = {"상담사명","처리구분","합계"};
        String labels2[] = {"처리완료", "예약","이관-상담사","이관-관리자","이관-VOC", "호전환", "부재중"};

        //셀 스타일 및 폰트 설정
		CellStyle styleOfBoardFillFontBlackBold1 = workbook.createCellStyle();
		styleOfBoardFillFontBlackBold1.setAlignment(CellStyle.ALIGN_CENTER);
		styleOfBoardFillFontBlackBold1.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데

        sheet.addMergedRegion(new CellRangeAddress(0,1,0,0));
        sheet.addMergedRegion(new CellRangeAddress(0,0,1,7));
        sheet.addMergedRegion(new CellRangeAddress(0,1,8,8));

        row = sheet.createRow(rowCount++);

        cell = row.createCell(cellCount++);
		cell.setCellValue(labels[0]);
		cell.setCellStyle(styleOfBoardFillFontBlackBold1);
		cell = row.createCell(cellCount++);
		cell.setCellValue(labels[1]);
		cell.setCellStyle(styleOfBoardFillFontBlackBold1);
		cell = row.createCell(cellCount++);
		cell = row.createCell(cellCount++);
		cell = row.createCell(cellCount++);
		cell = row.createCell(cellCount++);
		cell = row.createCell(cellCount++);
		cell = row.createCell(cellCount++);
		cell = row.createCell(cellCount++);
		cell.setCellValue(labels[2]);
		cell.setCellStyle(styleOfBoardFillFontBlackBold1);

        /*for(int c=0;c<labels.length;c++){
            sheet.autoSizeColumn((short)c);
            sheet.setColumnWidth(c, (sheet.getColumnWidth(c))+1500);
    		cell = row.createCell(c);
    		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+labels[c]);
    		cell.setCellValue(labels[c]);
    	}*/
       row = sheet.createRow(rowCount++);
       cell = row.createCell(0);
        for(int c=0;c<labels2.length;c++){
            sheet.autoSizeColumn((short)c);
            sheet.setColumnWidth(c, (sheet.getColumnWidth(c))+1500);
    		cell = row.createCell((c+1));
    		cell.setCellValue(labels2[c]);
    		cell.setCellStyle(styleOfBoardFillFontBlackBold1);
    	}
         for(int i=0;i<userStatList.size();i++){
            	UserStatDomain userStat = userStatList.get(i);
        	    row = sheet.createRow(rowCount++);
        		cell = row.createCell(0);
        		cell.setCellValue(userStat.getUserNm());
            	cell = row.createCell(1);
        		cell.setCellValue(userStat.getaCnt());
            	cell = row.createCell(2);
        		cell.setCellValue(userStat.getbCnt());
            	cell = row.createCell(3);
        		cell.setCellValue(userStat.getgCnt());
            	cell = row.createCell(4);
        		cell.setCellValue(userStat.getcCnt());
            	cell = row.createCell(5);
        		cell.setCellValue(userStat.getdCnt());
            	cell = row.createCell(6);
        		cell.setCellValue(userStat.geteCnt());
            	cell = row.createCell(7);
        		cell.setCellValue(userStat.getfCnt());
            	cell = row.createCell(8);
        		cell.setCellValue(userStat.getSumCnt());
        		//rowCount++;
        }
        response.setHeader("Content-Disposition", "attachment; filename="+reFileName);
        response.setContentType("application/vnd.ms.excel");
        os = response.getOutputStream();
        workbook.write(os);
        workbook.close();
        os.close();
        os.flush();
	}
}