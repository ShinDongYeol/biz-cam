package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.MinutesReplaceWordDTO;
import ai.maum.biz.cams.dto.SttMetaDTO;
import ai.maum.biz.cams.mapper.ConfResultMapper;
import ai.maum.biz.cams.vo.FrontConfVO;
import ai.maum.biz.cams.vo.FrontDicVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ConfResultSvcImpl implements ConfResultSvc {
    @Autowired
    ConfResultMapper confResultMapper;

    @Override
    public int getConfResultListTotalCount(FrontConfVO frontConfVO){
        return confResultMapper.getConfResultListTotalCount(frontConfVO);
    }

    @Override
    public List<SttMetaDTO> getConfResultListAll(FrontConfVO frontConfVO){
        return confResultMapper.getConfResultListAll(frontConfVO);
    }

    @Override
    public int getDicReplaceTotalCount(FrontDicVO frontDicVO){
        return confResultMapper.getDicReplaceTotalCount(frontDicVO);
    }

    @Override
    public List<MinutesReplaceWordDTO> getDicReplaceAllList(FrontDicVO frontDicVO){
        return confResultMapper.getDicReplaceAllList(frontDicVO);
    }
}
