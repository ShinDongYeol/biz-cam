package ai.maum.biz.cams.mapper;

import ai.maum.biz.cams.dto.MngSiteDTO;
import ai.maum.biz.cams.dto.ModelDTO;
import ai.maum.biz.cams.vo.MngSiteVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface SiteMapper {

    int getSiteListCnt(MngSiteVO vo);
    List<MngSiteDTO> getSiteList(MngSiteVO vo);
    //리스트박스 만들 모델 리스트가져오기
    List<ModelDTO> getModelbox();
    //사이트 생성
    int createSite(MngSiteDTO dto);
    //수정용 사이트 정보가져오기
    MngSiteDTO getSiteDetail(MngSiteVO vo);
    //사이트 정보 업데이트
    int updateSiteInfo(MngSiteDTO dto);
    //사이트 삭제
    int delSites(Map<String, Object> param);
    //사이트 하위 사용자 체크
    int checkIncludeUser(Map<String, Object> param);
}
