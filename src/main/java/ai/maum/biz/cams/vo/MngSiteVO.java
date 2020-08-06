package ai.maum.biz.cams.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("mngSiteVO")
public class MngSiteVO {
    //검색용 사이트 이름
    private String sch_site_name;

    //modelList.jsp 파일의 페이징 관련 변수
    private String currentPage;                 // 현재 페이지
    private int startRow;                       // 페이지 시작 게시물 번호
    private int lastRow;                        // 페이지 마지막 게시물 번호
    private int pageInitPerPage;                // 페이지 당 게시물 수

    //상세/삭제용 사이트 번호
    private int minutes_site_ser;
}
