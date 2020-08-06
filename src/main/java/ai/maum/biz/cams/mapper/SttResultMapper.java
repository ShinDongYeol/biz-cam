package ai.maum.biz.cams.mapper;

import ai.maum.biz.cams.dto.SttResultDTO;
import ai.maum.biz.cams.vo.FrontFileUpConfVO;
import ai.maum.biz.cams.vo.FrontMinutesUpdateVO;
import ai.maum.biz.cams.vo.FrontMinutesVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface SttResultMapper {

    List<SttResultDTO> gets(FrontMinutesVO frontMinutesVO);

    List<SttResultDTO> getsGroupByEmployee(FrontMinutesVO frontMinutesVO);

    int updateMinutesAllEmployee(FrontMinutesUpdateVO frontMinutesUpdateVO);

    int updateSttResult(FrontMinutesUpdateVO frontMinutesUpdateVO);

    int updateEmptyToNullBySttChgResult(FrontMinutesUpdateVO frontMinutesUpdateVO);

    int delete(int sttMetaSer);

    List<SttResultDTO> getSttExcelResultListByMetaId(FrontFileUpConfVO frontFileUpConfVO);
}
