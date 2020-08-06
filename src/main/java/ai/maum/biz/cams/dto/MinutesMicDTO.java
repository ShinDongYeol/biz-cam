package ai.maum.biz.cams.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("minutesMicDTO")
public class MinutesMicDTO {
    private String minutes_mic_ser;                     //마이크 일련번호
    private String mic_name;                            //마이크명
    private String mic_ipaddr;                          //마이크 IP
    private String mic_port;                            //마이크 PORT
    private String mic_id;                              //마이크 ID
    private String used_flag;                           //사용 유/무
    private String minutes_site_ser;                    //사이트 일련번호 MINUTES_SITE Table의 MINUTES_SITE_SER와 동일
    private String minutes_meetingroom_ser;             //회의실 일련번호(룸 일련번호). MINUTES_MEETINGROOM Table의 ''MINUTES_EETINGROOM_SER'와 동일
    private String create_user;                         //생성자
    private String create_time;                         //생성일시
    private String update_user;                         //갱신자
    private String update_time;                         //갱신일시

    private String stt_meta_ser;                        //STT_META 일련번호
    private String minutes_id;                          //회의ID. SITEID_ROOMID_YYYYMMDDHH24miSS

    //MINUTES_MIC_HIST table 변수
    private String minutes_joined_name;                 //회의 참석자 이름(마이크 사용자 이름)
    private String mic_use_yn;                          //마이크 사용여부

    //MINUTES_MEETINGROOM table 변수
    private String meetingroom_name;                    //회의실명
}
