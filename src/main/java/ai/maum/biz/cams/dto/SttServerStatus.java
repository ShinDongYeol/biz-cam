package ai.maum.biz.cams.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("sttServerStatus")
public class SttServerStatus {
    private String stt_server_status_ser;       //서버정보 일련번호
    private String server_name;                 //서버명
    private String server_ipaddr;               //서버 IP
    private String server_cpu_rate;             //CPU 사용율
    private String server_ram_rate;             //RAM 사용율
    private String server_hdd_rate;             //HDD 사용율
    private String cpu_alarm_rate;              //CPU 알람 비율
    private String ram_alarm_rate;              //RAM 알람 비율
    private String hdd_alarm_rate;              //HDD 알람 비율
    private String create_user;                 //생성자
    private String create_time;                 //생성일시
    private String update_user;                 //갱신자
    private String update_time;                 //갱신일시
}
