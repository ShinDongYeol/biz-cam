package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.UserDTO;
import ai.maum.biz.cams.mapper.UserMapper;
import ai.maum.biz.cams.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserSvcImpl implements UserSvc{
    @Autowired
    private UserMapper userMapper;

    @Override
    public int getUserListAllCount(UserVO userVO){
        return userMapper.getUserListAllCount(userVO);
    }

    @Override
    public List<UserDTO> getUserList(UserVO userVO){
        return userMapper.getUserList(userVO);
    }

    @Override
    public int addUserSave(UserVO userVO){
        return userMapper.addUserSave(userVO);
    }

    @Override
    public UserDTO getUserInfoByUserSer(UserVO userVO){
        return userMapper.getUserInfoByUserSer(userVO);
    }

    @Override
    public int modifyUserSave(UserVO userVO){
        return userMapper.modifyUserSave(userVO);
    }

    @Override
    public UserDTO getUserByName(UserVO userVO) {
        return userMapper.getUserByName(userVO);
    }

    @Override
    public UserDTO checkUserByName(UserVO userVO) {
        return userMapper.checkUserByName(userVO);
    }

    @Override
    public int delUsers(Map<String, Object> param) {
        return userMapper.delUsers(param);
    }
}
