package ai.maum.biz.cams.mapper;

import ai.maum.biz.cams.dto.*;
import ai.maum.biz.cams.vo.FrontConfVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ConfStatusMapper {
    SttMetaDTO getSttMetaOneByMetaId(FrontConfVO frontConfVO);

    List<MinutesSiteDTO> getSiteListAll();

    int getMeetingRoomTotalCountBySiteId(FrontConfVO frontConfVO);

    List<MinutesMeetingRoomDTO> getMeetingRoomListBySiteId(FrontConfVO frontConfVO);

    List<SttMetaDTO> getSttMetaListBySiteId(FrontConfVO frontConfVO);

    int getSttMetaListTotalCountBySiteId(FrontConfVO frontConfVO);

    List<MinutesMicDTO> getMicListBySiteIdRoomId(FrontConfVO frontConfVO);

    MinutesMicDTO getMicListBySiteIdRoomIdMicId(FrontConfVO frontConfVO);

    int doConfSetUpSave(FrontConfVO frontConfVO);

    int doSetUpMicSave(FrontConfVO frontConfVO);

    int getDetailViewTotalCount(FrontConfVO frontConfVO);

    List<SttMetaDTO> getDetailViewAllList(FrontConfVO frontConfVO);

    int doStartMeetingRoomStatus(FrontConfVO frontConfVO);

    int doEndMeetingRoomStatus(FrontConfVO frontConfVO);

    int doRecTimeUpdate(FrontConfVO frontConfVO);

    SttMetaDTO getSttMetaOne(FrontConfVO frontConfVO);

    List<MinutesMicDTO> getMicSetInfo(FrontConfVO frontConfVO);

    List<SttResultDTO> getSttResultListByMetaId(FrontConfVO frontConfVO);

    int doMemoSave(FrontConfVO frontConfVO);

    int doSntncSave(FrontConfVO frontConfVO);

    int doMeetingCancel(FrontConfVO frontConfVO);

    int doMicHistDel(FrontConfVO frontConfVO);

    List<MinutesMicDTO> getMicInfo(FrontConfVO frontConfVO);

    int getMinutesUserTotalCount(FrontConfVO frontConfVO);

    List<MinutesEmployeeDTO> getMinutesUserAllList(FrontConfVO frontConfVO);


    int searchUserCnt(Map<String, Object> paramMap);

    List<MinutesEmployeeDTO> searchUser(Map<String, Object> paramMap);

    MinutesMeetingRoomDTO checkMinutesStatus(FrontConfVO frontConfVO);
}
