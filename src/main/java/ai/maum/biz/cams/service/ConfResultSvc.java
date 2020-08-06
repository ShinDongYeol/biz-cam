package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.MinutesReplaceWordDTO;
import ai.maum.biz.cams.dto.SttMetaDTO;
import ai.maum.biz.cams.vo.FrontConfVO;
import ai.maum.biz.cams.vo.FrontDicVO;

import java.util.List;

public interface ConfResultSvc {
    /*
     * Desc : 회의결과 페이지 페이징을 위한 전체 게시물 카운트. 검색 적용
     * param :
     */
    int getConfResultListTotalCount(FrontConfVO frontConfVO);


    /*
     * Desc : 회의결과 페이지 전체 리스트 select. 검색 적용.
     */
    List<SttMetaDTO> getConfResultListAll(FrontConfVO frontConfVO);


    /*
     * Desc : 치환사전 페이지 페이징을 위한 전체 게시물 카운트. 검색 적용
     * param :
     */
    int getDicReplaceTotalCount(FrontDicVO frontDicVO);


    /*
     * Desc : 치환사전 페이지 전체 리스트 select. 검색 적용.
     */
    List<MinutesReplaceWordDTO> getDicReplaceAllList(FrontDicVO frontDicVO);
}
