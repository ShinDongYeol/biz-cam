package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.SttMetaDTO;
import ai.maum.biz.cams.vo.FrontMinutesCreateVO;
import ai.maum.biz.cams.vo.FrontMinutesUpdateVO;
import ai.maum.biz.cams.vo.FrontMinutesVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


public interface SttMetaSvc {


    public SttMetaDTO getBySttMetaSer(FrontMinutesVO frontMinutesVO) throws Exception;

    public List<SttMetaDTO> gets(FrontMinutesVO frontMinutesVO);

    public int getMinutesCount(FrontMinutesVO frontMinutesVO) throws Exception;

    public List<SttMetaDTO> getMinutesList(FrontMinutesVO frontMinutesVO) throws Exception;

    String delete(FrontMinutesVO frontMinutesVO) throws Exception;

    String reg(MultipartFile uploadFile, FrontMinutesCreateVO frontMinutesCreateVO) throws Exception;

    String updateMinutesMeta(FrontMinutesUpdateVO frontMinutesUpdateVO) throws Exception;

    String updateMemo(FrontMinutesUpdateVO frontMinutesUpdateVO) throws Exception;
}
