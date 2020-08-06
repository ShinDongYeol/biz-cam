package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.SttResultDTO;
import ai.maum.biz.cams.vo.FrontMinutesUpdateVO;
import ai.maum.biz.cams.vo.FrontMinutesVO;
import org.apache.poi.ss.usermodel.Workbook;

import java.util.List;


public interface SttResultSvc {

    public List<SttResultDTO> gets(FrontMinutesVO frontMinutesVO) throws Exception;

    public List<SttResultDTO> getsGroupByEmployee(FrontMinutesVO frontMinutesVO) throws Exception;

    public String updateMinutesAllEmployee(FrontMinutesUpdateVO frontMinutesUpdateVO) throws Exception;

    public String updateSttResult(FrontMinutesUpdateVO frontMinutesUpdateVO) throws Exception;

    public String updateEmptyToNullBySttChgResult(FrontMinutesUpdateVO frontMinutesUpdateVO) throws Exception;

    Workbook createExcel(int sttMetaSer);
}
