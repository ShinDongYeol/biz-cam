package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.ModelDTO;
import ai.maum.biz.cams.mapper.ModelMapper;
import ai.maum.biz.cams.vo.ModelVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ModelSvcImpl implements ModelSvc {

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public int modelListCount(ModelVO vo) {
        return modelMapper.modelListCount(vo);
    }

    @Override
    public List<ModelDTO> modelList(ModelVO vo) {
        return  modelMapper.modelList(vo);
    }

    @Override
    public ModelDTO getModel(ModelVO vo) {
        return modelMapper.getModel(vo);
    }

    @Override
    public int updateModel(ModelDTO dto) {
        return modelMapper.updateModel(dto);
    }

    @Override
    public int delModels(Map<String, Object> param) {
        return modelMapper.delModels(param);
    }

    @Override
    public int createModel(ModelDTO dto) {
        return modelMapper.createModel(dto);
    }

    @Override
    public int checkUsedSite(Map<String, Object> param) {
        return modelMapper.checkUsedSite(param);
    }
}
