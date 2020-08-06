package ai.maum.biz.cams.mapper;

import ai.maum.biz.cams.dto.CommonCodeDTO;
import ai.maum.biz.cams.dto.MinutesSiteDTO;
import ai.maum.biz.cams.dto.UserRoleDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface CommonMapper {
    List<CommonCodeDTO> getCommonCodeListAll();

    List<CommonCodeDTO> getCommonCodeListPart(HashMap<String, String> codeMap);

    List<MinutesSiteDTO> getSiteListAll();

    List<UserRoleDTO> getUserRole(HashMap<String, String> paramMap);
}
