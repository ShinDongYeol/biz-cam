package ai.maum.biz.cams.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.util.Date;

@Data
@Alias("sttMetaDTO")
public class SttMetaDTO {

    //STT_META table.
    private int stt_meta_ser;
    private int minutes_user_ser;
    private int minutes_site_ser;
    private String create_user;
    private String create_time;
    private String update_user;
    private String update_time;
    private String minutes_meetingroom;
    private String minutes_machine;
    private String minutes_id;
    private String minutes_name;
    private Date minutes_start_date;
    private String minutes_topic;
    private String minutes_joined_mem;
    private String[] minutes_joined_mem_arr;
    private int minutes_joined_cnt;
    private String minutes_status;
    private String minutes_status_name;
    private String rec_src_cd;
    private String file_name;
    private String file_path;
    private String file_url;
    private String minutes_date;
    private String start_time;
    private String end_time;
    private String rec_time;
    private String memo;


    //STT_RESULT Table.
    private String minutes_mic_ser;             //마이크 일련번호
    private String sntnc_desc;                  //문장내용
    private String sntnc_start_time;            //문장시작시각
    private String sntnc_end_time;              //문장종료시각
    private String order_ms;                    //순서구분자 (ms)


    //MINUTES_MEETINGROOM Table 관련 변수
    private String meetingroom_name;            //회의실명.


    //MINUTES_MIC_HIST table 변수
    private String minutes_joined_name;                 //회의 참석자 이름(마이크 사용자 이름)
    private String mic_use_yn;                          //마이크 사용여부

    //재생 청취용 시간 변수
    private String msg_start_time;                      //재생 청취용 페이지 좌착 시간 표시용 변수


    private String rec_start_time_sec;             // rec_start_time 밀리세컨드로 변경.

    private String rec_date;                            // 회의 일자
    private String site_name;                           // 사이트명

    private String user_name;
}
