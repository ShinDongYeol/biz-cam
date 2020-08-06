package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.SttMetaDTO;
import ai.maum.biz.cams.vo.FrontFileUpConfVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ConfFileUploadSvc {

    public int getUploadCount();

    public List<SttMetaDTO> getUploadList(FrontFileUpConfVO frontFileUpConfVO);

    public String uploadAndConvertForMeeting(List<MultipartFile> files, String[] minutesName, String[] startTime, String[] minutesTopic, String[] confJoinedEmpName, String[] confJoinedEmpId, String[] confJoinedCnt, String[] fileName,String[] minutesMeetingroom,String[] minutesMachine,int siteSer) throws Exception;

}
