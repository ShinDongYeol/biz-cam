package ai.maum.biz.cams.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("minutesReplaceWordDTO")
public class MinutesReplaceWordDTO {
    private String minutes_replace_word_ser;    //STT치환사전 일련번호
    private String minutes_type;				//회의 타입 코드
    private String before_word;					//치환전단어
    private String after_word;					//치환후단어
    private String minutes_site_ser;            //사이트 일련번호
    private String create_user;					//생성자
    private String create_time;					//생성일시
    private String update_user;					//갱신자
    private String update_time;					//갱신일시
}
