package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.ModelDTO;
import ai.maum.biz.cams.vo.ModelVO;

import java.util.List;
import java.util.Map;

public interface ModelSvc {
     int modelListCount(ModelVO vo);
     List<ModelDTO> modelList(ModelVO vo);

     public ModelDTO getModel(ModelVO vo);
     public int updateModel(ModelDTO dto);
     public int delModels(Map<String, Object> param);
     public int createModel(ModelDTO dto);
     public int checkUsedSite(Map<String, Object> param);
}
