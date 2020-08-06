package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.UserDTO;
import ai.maum.biz.cams.mapper.UserMapper;
import ai.maum.biz.cams.vo.SecureUser;
import ai.maum.biz.cams.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class SecureUserSVCImpl implements SecureUserSVC {

    @Autowired
    UserMapper mapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserVO vo = new UserVO();
        vo.setSch_userId(username);
        UserDTO user = mapper.getUserByName(vo);
        return Optional.ofNullable(user)
                .map(m -> new SecureUser(m)).get();
    }


}
