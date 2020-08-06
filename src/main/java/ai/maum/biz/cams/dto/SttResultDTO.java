package ai.maum.biz.cams.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("sttResultDTO")
public class SttResultDTO {

    /* STT RESULT 일련번호 */
    private int stt_result_ser;
    /* STT META 일련번호 */
    private int stt_meta_ser;
    /* 생성자 */
    private String create_user;
    /* 생성일자 */
    private String create_time;
    /* 갱신자 */
    private String update_user;
    /* 갱신일시 */
    private String update_time;
    /* 사원정보 */
    private String minutes_employee;
    /* STT 결과 */
    private String stt_org_result;
    /* 사용자 변경 TEXT */
    private String stt_chg_result;
    /* STT 문장 시작 시간 */
    private String stt_result_start;
    /* STT 결과 */
    private String stt_result_end;
    /* STT stt_result_start - stt_result_end 시간차(초) */
    private int stt_diff_time;

}
