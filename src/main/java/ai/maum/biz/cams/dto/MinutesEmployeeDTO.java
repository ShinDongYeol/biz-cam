package ai.maum.biz.cams.dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("minutesEmployeeDTO")
public class MinutesEmployeeDTO {
    private String minutes_employee_ser;	// 사원 일련번호
    private String name;					// 이름
    private String part;					// 부서
    private String position;				// 직급
    private String useYn;                   // 사용여부
    private String minutes_site_ser;		// 사이트 일련번호. MINUTES_SITE Table의 MINUTES_SITE_SER와 동일
    private String create_user;				// 생성자
    private String create_time;				// 생성일시
    private String update_user;				// 갱신자
    private String update_time;				// 갱신일시

    private String desc_part;               // 코드값 변환된 변수
    private String desc_position;           // 코드값 변환된 변수


    //MINUTES_SITE table
    private String site_name;               //사이트 명
    private String max_meeting_room_cnt;    //사이트별 미팅룸 최대 개수
    private String max_mic_cnt;             //사이트별 마이크 최대 개수
}
