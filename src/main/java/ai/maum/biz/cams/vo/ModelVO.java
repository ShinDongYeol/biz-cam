package ai.maum.biz.cams.vo;


import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("modelVO")
public class ModelVO {

    //modelList.jsp 파일의 검색부분 관련 변수
    private String sch_Name;
    private String sch_deepLearnType;
    private String sch_Lang;
    private String sch_Rate;
    private String sch_modelDesc;


    //modelList.jsp 파일의 페이징 관련 변수
    private String currentPage;                 // 현재 페이지
    private int startRow;                       // 페이지 시작 게시물 번호
    private int lastRow;                        // 페이지 마지막 게시물 번호
    private int pageInitPerPage;                // 페이지 당 게시물 수



    private Integer model_ser;
    private String modelDesc;
    private String modelName;
    private String modelType;
    private String deepLearnType;
    private String modelLang;
    private String modelRate;

}
