package ai.maum.biz.cams.mapper;

import ai.maum.biz.cams.dto.UserDTO;
import ai.maum.biz.cams.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserMapper {

    int getUserListAllCount(UserVO userVO);

    List<UserDTO> getUserList(UserVO userVO);

    int addUserSave(UserVO userVO);

    UserDTO getUserInfoByUserSer(UserVO userVO);

    int modifyUserSave(UserVO userVO);

    UserDTO getUserByName(UserVO userVO);

    UserDTO checkUserByName(UserVO userVO);

    int delUsers(Map<String, Object> param);

}
