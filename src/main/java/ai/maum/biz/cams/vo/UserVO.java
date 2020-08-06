package ai.maum.biz.cams.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("userVO")
public class UserVO {
    //userList.jsp 파일의 검색부분 관련 변수
    private String sch_siteName;
    private String sch_userId;
    private String sch_userName;
    private String sch_right;
    private String sch_useYn;
    private String sch_lastLogin;


    //userList.jsp 파일의 페이징 관련 변수
    private String currentPage;                 // 현재 페이지
    private int startRow;                       // 페이지 시작 게시물 번호
    private int lastRow;                        // 페이지 마지막 게시물 번호
    private int pageInitPerPage;                // 페이지 당 게시물 수


    private String add_siteName;
    private String add_userId;
    private String add_userName;
    private String add_password;
    private String add_cellphone;
    private String add_userRight;
    private String add_useYn;


    //사용자 정보 수정 관련 변수
    private String unum;                        //사용자 수정을 위해 받는 minutes_user_ser
    private String modi_siteName;
    private String modi_userId;
    private String modi_userName;
    private String modi_password;
    private String modi_cellphone;
    private String modi_userRight;
    private String modi_useYn;
}
