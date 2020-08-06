package ai.maum.biz.cams.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("minutesSiteDTO")
public class MinutesSiteDTO {
    private String minutes_site_ser;
    private String site_name;
    private String max_meeting_room_cnt;
    private String max_mic_cnt;
    private String create_user;
    private String create_time;
    private String update_user;
    private String update_time;
}
