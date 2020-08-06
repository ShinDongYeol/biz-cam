package ai.maum.biz.cams.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("frontDicVO")
public class FrontDicVO {
    private String site_ser;

    private String schWord;                     //치환사전 검색어

    //페이징 관련 변수
    private String currentPage;                 //현재 페이지
    private int startRow;                       //페이지 시작 게시물 번호
    private int lastRow;                        //페이지 마지막 게시물 번호
    private int pageInitPerPage;                //페이지 당 게시물 수
}
