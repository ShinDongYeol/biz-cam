package ai.maum.biz.cams.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("userDTO")
public class UserDTO {
    private String minutes_user_ser;
    private String minutes_site_ser;
    private String user_id;
    private String user_pw;
    private String user_name;
    private String cellphone_num;
    private String user_type;
    private String user_use_yn;
    private String user_last_login_dt;
    private String create_user;
    private String create_time;
    private String update_user;
    private String update_time;
    private String site_name;


}
