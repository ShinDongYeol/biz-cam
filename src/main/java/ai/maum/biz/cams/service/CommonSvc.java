package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.CommonCodeDTO;
import ai.maum.biz.cams.dto.MinutesSiteDTO;
import ai.maum.biz.cams.dto.UserRoleDTO;

import java.util.HashMap;
import java.util.List;

public interface CommonSvc {
    //COMMON_CODE 테이블 전체 리스트 select
    List<CommonCodeDTO> getCommonCodeListAll();

    //COMMON_CODE 테이블에서 일부만 select
    List<CommonCodeDTO> getCommonCodeListPart(HashMap<String, String> codeMap);

    //MINUTES_SITE에서 전체 사이트 리스트 select
    List<MinutesSiteDTO> getSiteListAll();

    List<UserRoleDTO> getUserRole(HashMap<String, String> param);
}
