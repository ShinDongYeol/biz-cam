package ai.maum.biz.cams.mapper;

import ai.maum.biz.cams.dto.SttMetaDTO;
import ai.maum.biz.cams.vo.FrontFileUpConfVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ConfFileUploadMapper {

    int getUploadCount();

    List<SttMetaDTO> getUploadList(FrontFileUpConfVO frontFileUpConfVO);

    void saveFileUpload(FrontFileUpConfVO frontFileUpConfVO);

}
