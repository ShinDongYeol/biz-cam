package ai.maum.biz.cams.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("mngSiteDTO")
public class MngSiteDTO {

    private int minutes_site_ser;
    private int stt_model_ser;
    private String create_user;
    private String create_time;
    private String update_user;
    private String update_time;
    private String site_name;
    private int max_meeting_room_cnt;
    private int max_mic_cnt;
    private String model_desc;
}
