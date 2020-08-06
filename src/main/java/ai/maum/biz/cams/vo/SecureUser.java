package ai.maum.biz.cams.vo;

import ai.maum.biz.cams.dto.UserDTO;
import lombok.Data;
import org.apache.ibatis.type.Alias;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.ArrayList;
import java.util.List;

@Alias("secureUser")
public class SecureUser extends User {

    private static final String ROLE_PREFIX = "ROLE_";
    private static final long serialVersionUID = 1L;

    public SecureUser(UserDTO member) {
        super(member.getUser_id(), member.getUser_pw(), makeGrantedAuthority(member.getUser_type()));

    }

    private static List<GrantedAuthority> makeGrantedAuthority(String role){
        List<GrantedAuthority> list = new ArrayList<>();
        list.add(new SimpleGrantedAuthority(ROLE_PREFIX + role));
        return list;
    }
}
