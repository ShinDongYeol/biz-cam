package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.MinutesEmployeeDTO;
import ai.maum.biz.cams.dto.SttServerStatus;
import ai.maum.biz.cams.vo.FrontMngVO;

import java.util.List;

public interface ManagerSvc {
    //직원관리. 리스트 전체 게시물 수. 검색 조건 적용
    int getEmpListAllCount(FrontMngVO frontMngVO);

    //직원관리. 직원 전체 리스트. 검색 조건 적용.
    List<MinutesEmployeeDTO> getEmpList(FrontMngVO frontMngVO);

    //직원관리.직원 추가 저장
    int doEmpAddSave(FrontMngVO frontMngVO);

    //직원관리.직원 정보 수정. 직원 PK번호로(minutes_emp_ser) 직원 정보
    MinutesEmployeeDTO getEmpInfoByEmpSer(FrontMngVO frontMngVO);

    //직원관리.직원 정보 수정 저장
    int doEmpModifySave(FrontMngVO frontMngVO);


    //시스템관리.서버모니터링 전체 리스트
    List<SttServerStatus> getSvrList(FrontMngVO frontMngVO);
}
