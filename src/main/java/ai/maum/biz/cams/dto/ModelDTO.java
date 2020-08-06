package ai.maum.biz.cams.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("modelDTO")
public class ModelDTO {

    private int stt_model_ser;
    private String create_user;
    private String create_time;
    private String update_user;
    private String update_time;
    private String deep_learning_type;
    private String stt_server_ip;
    private String stt_server_port;
    private String stt_model_name;
    private String stt_model_lang;
    private String stt_model_rate;
    private String model_desc;


}
