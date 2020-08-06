package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.CommonCodeDTO;
import ai.maum.biz.cams.dto.MinutesSiteDTO;
import ai.maum.biz.cams.dto.UserRoleDTO;
import ai.maum.biz.cams.mapper.CommonMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class CommonSvcImpl implements CommonSvc{
    @Autowired
    CommonMapper commonMapper;

    @Override
    public List<CommonCodeDTO> getCommonCodeListAll() {
        return commonMapper.getCommonCodeListAll();
    }

    @Override
    public List<CommonCodeDTO> getCommonCodeListPart(HashMap<String, String> codeMap){
        return commonMapper.getCommonCodeListPart(codeMap);
    }

    @Override
    public List<MinutesSiteDTO> getSiteListAll(){
        return commonMapper.getSiteListAll();
    }

    @Override
    public List<UserRoleDTO> getUserRole(HashMap<String, String> param) {
        return commonMapper.getUserRole(param);
    }
}
