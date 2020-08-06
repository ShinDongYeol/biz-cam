package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.*;
import ai.maum.biz.cams.vo.FrontConfVO;

import java.util.List;
import java.util.Map;

public interface ConfStatusSvc {
    /*
     * Desc : STT_META 테이블에서 stt_meta_ser 기준으로 한건 select
     * param :
     */
    SttMetaDTO getSttMetaOneByMetaId(FrontConfVO frontConfVO);

    /*
     * Desc : dashboard에서 사용하는 사이트 리스트를  minutes_site테이블 select
     * param :
     */
    List<MinutesSiteDTO> getSiteListAll();


    /*
     * Desc : dashboard에서 사용하는 해당 사이트의 미팅룸 수를 minutes_meetingroom 테이블에서 select
     * param : frontConfVO.site_ser
     */
    int getMeetingRoomTotalCountBySiteId(FrontConfVO frontConfVO);


    /*
     * Desc : dashboard에서 사용하는 해당 사이트의 미팅룸를 minutes_meetingroom 테이블에서 select
     * param : frontConfVO.site_ser
     */
    List<MinutesMeetingRoomDTO> getMeetingRoomListBySiteId(FrontConfVO frontConfVO);


    /*
     * Desc : dashboard에서 사용하는 회의목록를  minutes_site_ser값 기준으로 select
     * param
     *      frontConfVO.site_ser = minutes_site_ser 컬럼 값.
     */
    List<SttMetaDTO> getSttMetaListBySiteId(FrontConfVO frontConfVO);


    /*
     * Desc : dashboard에서 사용하는 회의목록를  minutes_site_ser값 기준으로 select한 전체 수
     * param
     *      frontConfVO.site_ser:사이트 pk minutes_site_ser 컬럼 값.
     */
    int getSttMetaListTotalCountBySiteId(FrontConfVO frontConfVO);


    /*
     * Desc : 회의현황.회의설정에 보이기 위한 마이크 리스트. minutes_site_ser, minutes_meetingroom_ser값 기준으로 select
     * param
     *      frontConfVO.site_ser = minutes_site_ser 컬럼 값.
     *      frontConfVO.room_ser = minutes_meetingroom_ser 컬럼 값.
     */
    List<MinutesMicDTO> getMicListBySiteIdRoomId(FrontConfVO frontConfVO);


    /*
     * Desc : 회의현황.회의설정에 보이기 위한 마이크 리스트. minutes_site_ser, minutes_meetingroom_ser, minutes_mic_ser값 기준으로 select
     * param
     *      frontConfVO.site_ser = minutes_site_ser 컬럼 값.
     *      frontConfVO.room_ser = minutes_meetingroom_ser 컬럼 값.
     *      frontConfVO.mic_ser = minutes_mic_ser 컬럼 값.
     */
    MinutesMicDTO getMicListBySiteIdRoomIdMicId(FrontConfVO frontConfVO);


    /*
     * Desc : 회의룸 설정 저장
     * param
     */
    int doConfSetUpSave(FrontConfVO frontConfVO);


    /*
     * Desc : 회의룸 마이크 설정 저장
     * param
     */
    int doSetUpMicSave(FrontConfVO frontConfVO);


    /*
     * Desc : 상세보기 페이징을 위한 전체 카운트. 검색 적용
     * param
     *       site_ser : 사이트 일련번호
     *       room_ser : 미팅룸 일련번호
     */
    int getDetailViewTotalCount(FrontConfVO frontConfVO);

    /*
     * Desc : 상세보기 전체 게시물 select. 검색 적용
     * param
     *       site_ser : 사이트 일련번호
     *       room_ser : 미팅룸 일련번호
     */
    List<SttMetaDTO> getDetailViewAllList(FrontConfVO frontConfVO);


    /*
     * Desc : 대시보드에서 '시작'버튼 클릭시 상태값 "회의중"으로 변경.
     *        stt_meta.rec_status = 'P' 업데이트
     *        stt_meta.rec_start_time 업데이트
     * param : stt_meta_ser : stt_meta_ser 일련번호
     */
    int doStartMeetingRoomStatus(FrontConfVO frontConfVO);



    /*
     * Desc : 대시보드에서 '시작'버튼 클릭시 상태값 "회의중"으로 변경.
     *        stt_meta.rec_end_time 업데이트
     * param : stt_meta_ser : stt_meta_ser 일련번호
     */
    int doEndMeetingRoomStatus(FrontConfVO frontConfVO);




    /*
     * Desc : '종료'버튼 클릭 후 rec_time(종료시간 - 시작시간) 업데이트
     * param : stt_meta_ser : stt_meta_ser 일련번호
     */
    int doRecTimeUpdate(FrontConfVO frontConfVO);




    /*
     * Desc : "실시간 녹음 회의록"에서 사용하는 회의에 대한 기본 정보 select
     * param
     *      frontConfVO.stt_meta_ser
     */
    SttMetaDTO getSttMetaOne(FrontConfVO frontConfVO);



    /*
     * Desc : "실시간 녹음 회의록"에서 사용하는 마이크 설정 정보
     * param
     *      frontConfVO
     */
    List<MinutesMicDTO> getMicSetInfo(FrontConfVO frontConfVO);



    /*
     * Desc : "실시간 녹음 회의록"에서 사용하는 회의의 대화내용 리스트
     * param
     *      frontConfVO.stt_meta_ser
     */
    List<SttResultDTO> getSttResultListByMetaId(FrontConfVO frontConfVO);


    /*
     * Desc : 실시간, 녹음된 회의록 메모 저장
     * param
     *      frontConfVO.stt_meta_ser
     *                 .memo
     */
    int doMemoSave(FrontConfVO frontConfVO);


    /*
     * Desc : 녹음된 회의록 문장 편집
     * param
     *      frontConfVO.stt_meta_ser
     *                 .minutes_mic_ser
     *                 .sntnc_no
     *                 .sntnc_desc
     */
    int doSntncSave(FrontConfVO frontConfVO);


    /*
     * Desc : stt_meta_ser로 STT_META 테이블에서 한건 삭제
     * param
     *      frontConfVO.stt_meta_ser
     */
    int doMeetingCancel(FrontConfVO frontConfVO);


    /*
     * Desc : stt_meta_ser로 MINUTES_MIC_HIST 테이블에서 n건 삭제
     * param
     *      frontConfVO.stt_meta_ser
     */
    int doMicHistDel(FrontConfVO frontConfVO);




    /*
     * Desc : stt_meta_ser로 마이크 IP, Port 정보 select
     * param
     *      frontConfVO.stt_meta_ser
     */
    List<MinutesMicDTO> getMicInfo(FrontConfVO frontConfVO);




    /*
     * Desc : MINUTES_USER table 전체 수. 검색 포함
     * param
     *      frontConfVO.schSel : 검색 조건. 이름, 부서, 직급, 사번
     *      frontConfVO.schWord : 검색어
     */
    int getMinutesUserTotalCount(FrontConfVO frontConfVO);


    /*
     * Desc : MINUTES_USER table 전체 리스트. 검색포함
     * param
     *      frontConfVO.schSel : 검색 조건. 이름, 부서, 직급, 사번
     *      frontConfVO.schWord : 검색어
     */
    List<MinutesEmployeeDTO> getMinutesUserAllList(FrontConfVO frontConfVO);



    int searchUserCnt(Map<String, Object> paramMap);

    /**
     * Desc : 회의록 예약시 사용자 검색
     * table: MINUTES_USER
     * @return
     */
    List<MinutesEmployeeDTO> searchUser(Map<String, Object> paramMap);


    /**
     * 회의실 상태 체크
     * @param frontConfVO
     * @return
     */
    MinutesMeetingRoomDTO checkMinutesStatus(FrontConfVO frontConfVO);
}
