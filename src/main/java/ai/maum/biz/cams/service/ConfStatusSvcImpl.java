package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.*;
import ai.maum.biz.cams.mapper.ConfStatusMapper;
import ai.maum.biz.cams.vo.FrontConfVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ConfStatusSvcImpl implements ConfStatusSvc{
    @Autowired
    ConfStatusMapper confStatusMapper;

    @Override
    public SttMetaDTO getSttMetaOneByMetaId(FrontConfVO frontConfVO){
        return confStatusMapper.getSttMetaOne(frontConfVO);
    }

    @Override
    public List<MinutesSiteDTO> getSiteListAll(){
        return confStatusMapper.getSiteListAll();
    }

    @Override
    public int getMeetingRoomTotalCountBySiteId(FrontConfVO frontConfVO){
        return confStatusMapper.getMeetingRoomTotalCountBySiteId(frontConfVO);
    }

    @Override
    public List<MinutesMeetingRoomDTO> getMeetingRoomListBySiteId(FrontConfVO frontConfVO){
        return confStatusMapper.getMeetingRoomListBySiteId(frontConfVO);
    }

    @Override
    public List<SttMetaDTO> getSttMetaListBySiteId(FrontConfVO frontConfVO){
        return confStatusMapper.getSttMetaListBySiteId(frontConfVO);
    }

    @Override
    public int getSttMetaListTotalCountBySiteId(FrontConfVO frontConfVO){
        return confStatusMapper.getSttMetaListTotalCountBySiteId(frontConfVO);
    }

    @Override
    public List<MinutesMicDTO> getMicListBySiteIdRoomId(FrontConfVO frontConfVO){
        return confStatusMapper.getMicListBySiteIdRoomId(frontConfVO);
    }

    @Override
    public MinutesMicDTO getMicListBySiteIdRoomIdMicId(FrontConfVO frontConfVO){
        return confStatusMapper.getMicListBySiteIdRoomIdMicId(frontConfVO);
    }

    @Override
    public int doConfSetUpSave(FrontConfVO frontConfVO){
        return confStatusMapper.doConfSetUpSave(frontConfVO);
    }

    @Override
    public int doSetUpMicSave(FrontConfVO frontConfVO){
        return confStatusMapper.doSetUpMicSave(frontConfVO);
    }

    @Override
    public int getDetailViewTotalCount(FrontConfVO frontConfVO){
        return confStatusMapper.getDetailViewTotalCount(frontConfVO);
    }

    @Override
    public List<SttMetaDTO> getDetailViewAllList(FrontConfVO frontConfVO){
        return confStatusMapper.getDetailViewAllList(frontConfVO);
    }

    @Override
    public int doStartMeetingRoomStatus(FrontConfVO frontConfVO){
        return confStatusMapper.doStartMeetingRoomStatus(frontConfVO);
    }

    @Override
    public int doEndMeetingRoomStatus(FrontConfVO frontConfVO){
        return confStatusMapper.doEndMeetingRoomStatus(frontConfVO);
    }

    @Override
    public int doRecTimeUpdate(FrontConfVO frontConfVO){
        return confStatusMapper.doRecTimeUpdate(frontConfVO);
    }

    @Override
    public SttMetaDTO getSttMetaOne(FrontConfVO frontConfVO){
        return confStatusMapper.getSttMetaOne(frontConfVO);
    }

    @Override
    public List<MinutesMicDTO> getMicSetInfo(FrontConfVO frontConfVO){
        return confStatusMapper.getMicSetInfo(frontConfVO);
    }

    @Override
    public List<SttResultDTO> getSttResultListByMetaId(FrontConfVO frontConfVO){
        return confStatusMapper.getSttResultListByMetaId(frontConfVO);
    }

    @Override
    public int doMemoSave(FrontConfVO frontConfVO){
        return confStatusMapper.doMemoSave(frontConfVO);
    }

    @Override
    public int doSntncSave(FrontConfVO frontConfVO){
        return confStatusMapper.doSntncSave(frontConfVO);
    }

    @Override
    public int doMeetingCancel(FrontConfVO frontConfVO){
        return confStatusMapper.doMeetingCancel(frontConfVO);
    }

    @Override
    public int doMicHistDel(FrontConfVO frontConfVO){
        return confStatusMapper.doMicHistDel(frontConfVO);
    }

    @Override
    public List<MinutesMicDTO> getMicInfo(FrontConfVO frontConfVO){
        return confStatusMapper.getMicInfo(frontConfVO);
    }

    @Override
    public int getMinutesUserTotalCount(FrontConfVO frontConfVO){
        return confStatusMapper.getMinutesUserTotalCount(frontConfVO);
    }

    @Override
    public List<MinutesEmployeeDTO> getMinutesUserAllList(FrontConfVO frontConfVO){
        return confStatusMapper.getMinutesUserAllList(frontConfVO);
    }

    @Override
    public int searchUserCnt(Map<String, Object> paramMap) {
        return confStatusMapper.searchUserCnt(paramMap);
    }

    @Override
    public List<MinutesEmployeeDTO> searchUser(Map<String, Object> paramMap) {
        return confStatusMapper.searchUser(paramMap);
    }

    @Override
    public MinutesMeetingRoomDTO checkMinutesStatus(FrontConfVO frontConfVO) {
        return confStatusMapper.checkMinutesStatus(frontConfVO);
    }
}
