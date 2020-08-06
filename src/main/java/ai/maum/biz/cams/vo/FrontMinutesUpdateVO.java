package ai.maum.biz.cams.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("frontMinutesUpdateVO")
public class FrontMinutesUpdateVO {

    private long sttMetaSer;
    /* USER 일련번호 */
    private int minutesUserSer;
    /* 사이트 일련번호 */
    private int minutesSiteSer;
    /* 수정자 */
    private String updateUser;

    //////////// 회의정보 수정 ////////////

    /* 회의실 정보 */
    private String minutesMeetingroom;
    /* 회의명 */
    private String minutesName;
    /* 회의시작시간 */
    private String startTime;
    /* 회의종료시간 */
    private String endTime;
    /* 회의 안건 */
    private String minutesTopic;
    /* 회의 참석자 */
    private String minutesJoinedMem;
    /* 회의 참석자 수 */
    private int minutesJoinedCnt;

    /* 마이크 사용자 리스트 수정 */
    private String beforeMinutesEmployee;
    private String afterMinutesEmployee;

    //////////// STT RESULT 수정 ////////////
    private long sttResultSer;
    private String minutesEmployee;
    private String sttChgResult;

    //////////// MEMO 수정 ////////////
    private String memo;
}
