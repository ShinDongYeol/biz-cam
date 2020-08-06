package ai.maum.biz.cams.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("frontMngVO")
public class FrontMngVO {
    private String meta_ser;                    //STT_META_SER 일련번호(PK)
    private String site_ser;                    //사이트 일련번호(PK)
    private String conf_num;                    //회의 일련번호(PK)
    private String room_ser;                    //회의룸 일련번호
    private String mic_ser;                     //MIC 일련번호
    private String emp_ser;                     //직원 일련번호

    private String create_user;                 //생성자
    private String update_user;                 //갱신자


    //empList.jsp 파일의 검색부분 관련 변수
    private String sch_siteName;                //사이트 이름
    private String sch_empNo;                   //사원번호
    private String sch_empName;                 //직원명
    private String sch_part;                    //부서
    private String sch_posi;                    //직급
    private String sch_useYn;                   //활성여부


    //직원 추가 관련 변수
    private String add_siteName;                //사이트 이름
    private String add_name;                    //직원명
    private String add_part;                    //부서
    private String add_posi;                    //직급
    private String add_useYn;                   //활성여부


    //직원 수정 관련 변수
    private String esnum;                       //minutes_employee_ser
    private String modi_siteName;               //minutes_site_ser
    private String modi_name;                   //이름
    private String modi_part;                   //부서
    private String modi_posi;                   //직급
    private String modi_useYn;                  //활성여부


    //페이징 관련 변수
    private String currentPage;                 //현재 페이지
    private int startRow;                       //페이지 시작 게시물 번호
    private int lastRow;                        //페이지 마지막 게시물 번호
    private int pageInitPerPage;                //페이지 당 게시물 수


}
