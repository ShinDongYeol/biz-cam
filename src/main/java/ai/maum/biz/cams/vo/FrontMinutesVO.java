package ai.maum.biz.cams.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("frontMinutesVO")
public class FrontMinutesVO {

    /* STT_META 일련번호 */
    private long sttMetaSer;

    private long minutesSiteSer;

    private String currentPage;
    private int startRow;
    private int lastRow;
    private int pageInitPerPage;

    private String searchStartDate; // 회의록 관리 > 날짜 검색 > 시작날짜
    private String searchEndDate;   // 회의록 관리 > 날짜 검색 > 종료날짜

    private String order;   // 정렬 순서

    private int[] sttMetaDelArr;    // 삭제 대상

    private String userType;    // USER TYPE

}
