package ai.maum.biz.cams.vo;

import ai.maum.biz.cams.dto.MinutesMicDTO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("frontConfVO")
public class FrontConfVO {
    private String meta_ser;                    //STT_META_SER 일련번호(PK)
    private String site_ser;                    //사이트 일련번호(PK)
    private String conf_num;                    //회의 일련번호(PK)
    private String room_ser;                    //회의룸 일련번호
    private String mic_ser;                     //MIC 일련번호

    private String recStatus;                   //STT를 위한 상태 업데이트
    private String meetStatus;                  //회의 상태
    private String recStartTime;                //회의 시작 시간
    private String recEndTime;                  //회의 종료 시간
    private String recTime;                     //회의 경과 시간

    private String create_user;                 //생성자 이름
    private String update_user;                 //갱신자 이름


    //페이징 관련 변수
    private String currentPage;                 //현재 페이지
    private int startRow;                       //페이지 시작 게시물 번호
    private int lastRow;                        //페이지 마지막 게시물 번호
    private int pageInitPerPage;                //페이지 당 게시물 수


    //setJoinedEmp. 직원검색 페이지 관련 변수
    private String schSel;                      //검색 조건 select box.
    private String schWord;                     //검색 키워드
    private String schField;                    //검색 조건에 따른 검색 필드명.
    private String checkedVal;                  //체크된 체크박스 값 리스트.


    //setUpConf. 회의설정 페이지 관련 변수
    private String mrName;                      //회의실명
    private String confName;                    //회의명
    private String confTime;                    //회의시간
    private String confTopic;                   //회의안건
    private String confJoinedEmpName;           //회의 참석자명
    private String confJoinedEmpId;             //회의 참석자 ID
    private String confJoinedCnt;               //회의 참석자 수

    private String minutes_id;                  //회의ID
    private String minutes_type;                //회의타입코드. default "COM"
    private String recSrcCd; // 녹음출처코드 사용자 U
    private String recFileName;
    private String recFileDnldPath;
    private String uploadFileName;  // 업로드 파일 이름
    private String uploadFilePath;  // 업로드 파일 경로


    //setUpMic. 마이크 1건 설정 페이지 관련 변수
    private String userName;                    //사용자
    private String micUseYn;                    //사용여부
    private String midx;                        //클릭한 마이크 index


    //회의 결과 검색 부분 변수
    private String confRoom;                    //회의룸
    private String confDateStart;               //회의일시 시작
    private String confDateEnd;                 //회의일시 종료
    private String joinedMem;                   //참석자
    private String confMemo;                    //회의메모
    private String other;                       //선택추가


    //실시간, 녹음된 회의록 메모 저장
    private String memo;                        //메모

    //녹음된 회의록 문장편집
    private String sntnc_no;                    //문장번호
    private String sntnc_desc;                  //문장내용

    private MinutesMicDTO[] mic;   // 마이크 세팅

    private String file_name; // 파일명
}
