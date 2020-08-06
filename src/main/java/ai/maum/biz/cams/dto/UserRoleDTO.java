package ai.maum.biz.cams.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("userRoleDTO")
public class UserRoleDTO {

    private int role_ser;
    private String role_type;
    private String role_desc;
    private int role_order;
    private String create_user;
    private String create_time;
    private String update_user;
    private String update_time;
}
