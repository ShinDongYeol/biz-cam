package ai.maum.biz.cams.mapper;

import ai.maum.biz.cams.dto.MinutesReplaceWordDTO;
import ai.maum.biz.cams.dto.SttMetaDTO;
import ai.maum.biz.cams.vo.FrontConfVO;
import ai.maum.biz.cams.vo.FrontDicVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ConfResultMapper {
    int getConfResultListTotalCount(FrontConfVO frontConfVO);

    List<SttMetaDTO> getConfResultListAll(FrontConfVO frontConfVO);

    int getDicReplaceTotalCount(FrontDicVO frontDicVO);

    List<MinutesReplaceWordDTO> getDicReplaceAllList(FrontDicVO frontDicVO);
}
