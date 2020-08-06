package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.MinutesEmployeeDTO;
import ai.maum.biz.cams.dto.SttServerStatus;
import ai.maum.biz.cams.mapper.ManagerMapper;
import ai.maum.biz.cams.vo.FrontMngVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ManagerSvcImpl implements ManagerSvc{
    @Autowired
    ManagerMapper mngMapper;

    @Override
    public int getEmpListAllCount(FrontMngVO frontMngVO){
        return mngMapper.getEmpListAllCount(frontMngVO);
    }

    @Override
    public List<MinutesEmployeeDTO> getEmpList(FrontMngVO frontMngVO){
        return mngMapper.getEmpList(frontMngVO);
    }

    @Override
    public int doEmpAddSave(FrontMngVO frontMngVO){
        return mngMapper.doEmpAddSave(frontMngVO);
    }

    @Override
    public MinutesEmployeeDTO getEmpInfoByEmpSer(FrontMngVO frontMngVO){
        return mngMapper.getEmpInfoByEmpSer(frontMngVO);
    }

    @Override
    public int doEmpModifySave(FrontMngVO frontMngVO){
        return mngMapper.doEmpModifySave(frontMngVO);
    }

    @Override
    public List<SttServerStatus> getSvrList(FrontMngVO frontMngVO){
        return mngMapper.getSvrList(frontMngVO);
    }
}
