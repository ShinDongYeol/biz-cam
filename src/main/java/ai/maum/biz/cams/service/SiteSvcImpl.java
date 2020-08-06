package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.MngSiteDTO;
import ai.maum.biz.cams.dto.ModelDTO;
import ai.maum.biz.cams.mapper.SiteMapper;
import ai.maum.biz.cams.vo.MngSiteVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SiteSvcImpl implements SiteSvc {

    @Autowired
    private SiteMapper mapper;

    @Override
    public int getSiteListCnt(MngSiteVO vo){
        return mapper.getSiteListCnt(vo);
    }

    @Override
    public  List<MngSiteDTO> getSiteList(MngSiteVO vo){
        return mapper.getSiteList(vo);
    }

    @Override
    public List<ModelDTO> getModelbox() {
        return mapper.getModelbox();
    }

    @Override
    public int createSite(MngSiteDTO dto) {
        return mapper.createSite(dto);
    }

    @Override
    public MngSiteDTO getSiteDetail(MngSiteVO vo) {
        return mapper.getSiteDetail(vo);
    }

    @Override
    public int updateSiteInfo(MngSiteDTO dto) {
        return mapper.updateSiteInfo(dto);
    }

    @Override
    public int delSites(Map<String, Object> param) {
        return mapper.delSites(param);
    }

    @Override
    public int checkIncludeUser(Map<String, Object> param) {
        return mapper.checkIncludeUser(param);
    }
}
