package ai.maum.biz.cams.mapper;

import ai.maum.biz.cams.dto.MinutesEmployeeDTO;
import ai.maum.biz.cams.dto.SttServerStatus;
import ai.maum.biz.cams.vo.FrontMngVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ManagerMapper {
    int getEmpListAllCount(FrontMngVO frontMngVO);

    List<MinutesEmployeeDTO> getEmpList(FrontMngVO frontMngVO);

    int doEmpAddSave(FrontMngVO frontMngVO);

    MinutesEmployeeDTO getEmpInfoByEmpSer(FrontMngVO frontMngVO);

    int doEmpModifySave(FrontMngVO frontMngVO);

    List<SttServerStatus> getSvrList(FrontMngVO frontMngVO);
}
