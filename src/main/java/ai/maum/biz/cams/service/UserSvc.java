package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.UserDTO;
import ai.maum.biz.cams.vo.UserVO;

import java.util.List;
import java.util.Map;

public interface UserSvc {
    //리스트 전체 게시물 수. 검색 조건 적용
    int getUserListAllCount(UserVO userVO);

    //사용자 전체 리스트. 검색 조건 적용.
    List<UserDTO> getUserList(UserVO userVO);

    //사용가 추가 저장
    int addUserSave(UserVO userVO);

    //사용자 정보 수정. 사용자 PK번호로(minutes_user_ser) 사용자 정보 select
    UserDTO getUserInfoByUserSer(UserVO userVO);

    //사용자 정보 수정 저장
    int modifyUserSave(UserVO userVO);
    //로그인 시 유저 체크
    UserDTO getUserByName(UserVO userVO);
    //유저등록 시 체크
    UserDTO checkUserByName(UserVO userVO);
    //사용자 삭제
    int delUsers(Map<String, Object> param);
}
