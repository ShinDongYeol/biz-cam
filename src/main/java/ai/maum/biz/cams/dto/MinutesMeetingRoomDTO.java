package ai.maum.biz.cams.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("minutesMeetingRoomDTO")
public class MinutesMeetingRoomDTO {
    private String minutes_meetingroom_ser;
    private String meetingroom_name;
    private String used_flag;
    private String minutes_site_ser;
    private String state_flag;
    private String create_user;
    private String create_time;
    private String update_user;
    private String update_time;

    private int ing_cnt;                //대시보드 녹음상태.회의중 카운트
    private String ing_mr_ser;          //대시보드 녹음상태.회의중 회의실 번호
    private int res_cnt;                //대시보드 녹음상태.회의예약 카운트
    private String res_mr_ser;          //대시보드 녹음상태.회의예약 회의실 번호

}
