package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.SttResultDTO;
import ai.maum.biz.cams.mapper.SttResultMapper;
import ai.maum.biz.cams.utils.CommonExcelComponent;
import ai.maum.biz.cams.utils.CommonUtils;
import ai.maum.biz.cams.vo.FrontFileUpConfVO;
import ai.maum.biz.cams.vo.FrontMinutesUpdateVO;
import ai.maum.biz.cams.vo.FrontMinutesVO;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SttResultSvcImpl implements SttResultSvc {

    private Logger logger = LoggerFactory.getLogger(SttResultSvcImpl.class);

    @Autowired
    private SttResultMapper sttResultMapper;

    @Autowired
    CommonUtils cUtils;


    @Autowired
    CommonExcelComponent excelComponent;

    @Override
    public List<SttResultDTO> gets(FrontMinutesVO frontMinutesVO) throws Exception{

        String logTitle = "gets/"+frontMinutesVO;

        List<SttResultDTO> result = null;
        try{
            result = sttResultMapper.gets(frontMinutesVO);
        }catch (Exception e){
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            e.printStackTrace();
            throw new Exception(e);
        }finally {
            String resultTitle = result == null ? "not found" : String.valueOf(result.size());
            logger.info("[ == RESULT == ]/{}{}", logTitle, resultTitle);
        }
        return result;
    }

    @Override
    public List<SttResultDTO> getsGroupByEmployee(FrontMinutesVO frontMinutesVO) throws Exception{

        String logTitle = "getsGroupByEmployee/"+frontMinutesVO;

        List<SttResultDTO> result = null;
        try{
            result = sttResultMapper.getsGroupByEmployee(frontMinutesVO);
        }catch (Exception e){
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            e.printStackTrace();
            throw new Exception(e);
        }finally {
            String resultTitle = result == null ? "not found" : String.valueOf(result.size());
            logger.info("[ == RESULT == ]/{}{}", logTitle, resultTitle);
        }
        return result;
    }

    @Override
    public String updateMinutesAllEmployee(FrontMinutesUpdateVO frontMinutesUpdateVO) throws Exception {
        String logTitle = "updateMinutesAllEmployee/"+frontMinutesUpdateVO;

        String result = "SUCCESS";
        int updateResult = 0;

        try{
            updateResult = sttResultMapper.updateMinutesAllEmployee(frontMinutesUpdateVO);
            if(updateResult <= 0){
                result = "업데이트 된 데이터가 없습니다.";
            }
        }catch (Exception e){
            result = "FAIL";
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            e.printStackTrace();
            throw new Exception(e);
        }finally {
            logger.info("[ == RESULT == ]/{}{}", logTitle, result);
        }
        return result;
    }

    @Override
    public String updateSttResult(FrontMinutesUpdateVO frontMinutesUpdateVO) throws Exception {
        String logTitle = "updateSttResult/"+frontMinutesUpdateVO;

        String result = "SUCCESS";
        int updateResult = 0;
        try{
            updateResult = sttResultMapper.updateSttResult(frontMinutesUpdateVO);
            if(updateResult <= 0){
                result = "업데이트 된 데이터가 없습니다.";
            }
        }catch (Exception e){
            result = "FAIL";
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            e.printStackTrace();
            throw new Exception(e);
        }finally {
            logger.info("[ == RESULT == ]/{}{}", logTitle, result);
        }
        return result;
    }

    @Override
    public String updateEmptyToNullBySttChgResult(FrontMinutesUpdateVO frontMinutesUpdateVO) throws Exception {
        String logTitle = "updateEmptyToNullBySttChgResult/"+frontMinutesUpdateVO;

        String result = "SUCCESS";
        int updateResult = 0;
        try{
            updateResult = sttResultMapper.updateEmptyToNullBySttChgResult(frontMinutesUpdateVO);
            if(updateResult <= 0){
                result = "업데이트 된 데이터가 없습니다.";
            }
        }catch (Exception e){
            result = "FAIL";
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            e.printStackTrace();
            throw new Exception(e);
        }finally {
            logger.info("[ == RESULT == ]/{}{}", logTitle, result);
        }
        return result;
    }

    @Override
    public Workbook createExcel(int sttMetaSer) {
        //워크북
        Workbook workbook;

        //칼럼별 width
        int[] columnWiths ={1000,1000, 5000,5000,5000,20000,20000};

        //엑셀 컴포넌트 초기화
        excelComponent.init();

        //프린트 세팅...기본적으로 A4..
        excelComponent.setSheetPrintSetting();

        //워크북 객체 받아오기..
        workbook = excelComponent.getWorkBook();

        //컬럼 width 세팅
        excelComponent.setColumnWidth(columnWiths);

        String[] columnMap = new String[]{"No", "STT 문장 시작 시간","STT 문장 종료 시간","사원 정보","STT결과","사용자 변경 TEXT"};

        //TODO 리스트 불러오는 부분 작업 예정
        FrontFileUpConfVO frontFileUpConfVO = new FrontFileUpConfVO();
        frontFileUpConfVO.setSttMetaSer(sttMetaSer);
        List<SttResultDTO> list = sttResultMapper.getSttExcelResultListByMetaId(frontFileUpConfVO);

        int rowCount = excelComponent.getRowCount();

        excelComponent.createColumnRow(rowCount, columnMap);

        int i = 0;

        for (SttResultDTO resultDTO : list) {
            i++;
            String[] data = {
                    String.valueOf(i),
                    resultDTO.getStt_result_start(),
                    resultDTO.getStt_result_end(),
                    resultDTO.getMinutes_employee(),
                    resultDTO.getStt_org_result(),
                    resultDTO.getStt_chg_result()
            };
            excelComponent.createDataRow(data,columnMap.length);
        }

        if(list.size() == 0){
            excelComponent.createDataRow(new String[0],columnMap.length);
        }

        return workbook;
    }

}
