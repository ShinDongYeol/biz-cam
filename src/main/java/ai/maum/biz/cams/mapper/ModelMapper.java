package ai.maum.biz.cams.mapper;

import ai.maum.biz.cams.dto.ModelDTO;
import ai.maum.biz.cams.vo.ModelVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ModelMapper {
    public int modelListCount(ModelVO vo);
    public List<ModelDTO> modelList(ModelVO vo);
    public ModelDTO getModel(ModelVO vo);
    public int updateModel(ModelDTO dto);
    public int delModels(Map<String, Object> param);
    public int createModel(ModelDTO dto);
    public int checkUsedSite(Map<String, Object> param);
}

