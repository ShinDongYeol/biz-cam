package ai.maum.biz.cams.mapper;

import ai.maum.biz.cams.dto.SttMetaDTO;
import ai.maum.biz.cams.vo.FrontMinutesCreateVO;
import ai.maum.biz.cams.vo.FrontMinutesUpdateVO;
import ai.maum.biz.cams.vo.FrontMinutesVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SttMetaMapper {

    SttMetaDTO getBySttMetaSer(FrontMinutesVO frontMinutesVO);

    List<SttMetaDTO> gets(FrontMinutesVO frontMinutesVO);

    int getMinutesCount(FrontMinutesVO frontMinutesVO);

    List<SttMetaDTO> getMinutesList(FrontMinutesVO frontMinutesVO);

    int delete(int sttMetaSer);

    int reg(FrontMinutesCreateVO frontMinutesCreateVO);

    int updateMinutesMeta(FrontMinutesUpdateVO frontMinutesUpdateVO);

    int updateMinutesId(FrontMinutesCreateVO frontMinutesCreateVO);

    int updateMemo(FrontMinutesUpdateVO frontMinutesUpdateVO);
}
