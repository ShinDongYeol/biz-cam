package ai.maum.biz.cams.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.util.Date;

@Data
@Alias("frontMinutesCreateVO")
public class FrontMinutesCreateVO {

    /* STT_META 일련번호 */
    private long sttMetaSer;
    /* USER 일련번호 */
    private int minutesUserSer;
    /* 사이트 일련번호 */
    private int minutesSiteSer;
    /* 회의실 정보 */
    private String minutesMeetingroom;
    /* 회의장비 정보 */
    private String minutesMachine;
    /* 회의ID */
    private String minutesId;
    /* 회의명 */
    private String minutesName;
    /* 회의 예약 일시 */
    private Date minutesStartDate;
    /* 회의 안건 */
    private String minutesTopic;
    /* 회의 참석자 */
    private String minutesJoinedMem;
    /* 회의 참석자 수 */
    private int minutesJoinedCnt;
    /* 회의 상태 */
    private String minutesStatus;
    /* 녹음출저코드 */
    private String recSrcCd;
    /* 음성파일 이름 */
    private String fileName;
    /* 음성파일 다운로드 경로 */
    private String filePath;
    /* 회의시작시간 */
    private String startTime;
    /* 회의종료시간 */
    private String endTime;
    /* 녹음 시간 */
    private int recTime;
    /* 메모 */
    private String memo;
    /* 생성자 */
    private String createUser;
    /* 갱신자 */
    private String updateUser;






}
