package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.SttMetaDTO;
import ai.maum.biz.cams.mapper.ConfStatusMapper;
import ai.maum.biz.cams.mapper.ConfFileUploadMapper;
import ai.maum.biz.cams.utils.CommonExcelComponent;
import ai.maum.biz.cams.utils.CommonUtils;
import ai.maum.biz.cams.vo.FrontFileUpConfVO;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.sound.sampled.AudioFileFormat;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioSystem;
import java.io.File;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

@Service
public class ConfFileUploadSvcImpl implements ConfFileUploadSvc {

    @Autowired
    private ConfFileUploadMapper confUploadMapper;

    @Autowired
    ConfStatusMapper confStatusMapper;


    @Autowired
    CommonUtils cUtils;


    @Autowired
    CommonExcelComponent excelComponent;

    @Value("${repository.rootPath}")
    private String rootPath;

    @Value("${repository.uploadPath}")
    private String uploadPath;

    //private String FILE_UPLOAD_MINUTES_FOLDER = "/DATE";

    @Override
    public int getUploadCount() {
        return confUploadMapper.getUploadCount();
    }

    @Override
    public List<SttMetaDTO> getUploadList(FrontFileUpConfVO frontFileUpConfVO) {
        return confUploadMapper.getUploadList(frontFileUpConfVO);
    }

    @Override
    @Transactional(rollbackFor = {Exception.class})
    public String uploadAndConvertForMeeting(
            List<MultipartFile> files,
            String[] paramMinutesName,
            String[] paramStartTime,
            String[] paramMinutesTopic,
            String[] paramConfJoinedEmpName,
            String[] paramConfJoinedEmpId,
            String[] paramConfJoinedCnt,
            String[] paramFileName,
            String[] paramMinutesMeetingroom,
            String[] paramMinutesMachine,
            int siteSer
    ) throws Exception{

        String result = "SUCCESS";



        String minutesMeetingRoom = "";
        String minutesMachine = "";
        String minutesId = "";
        String minutesName = "";
        String recSrcCd = "";
        String startTime = "";
        String endTime = "";
        String minutesTopic = "";
        String minutesJoinedMem = "";
        String minutesJoinedCnt = "";
        String minutesStatus = "";
        try{

            for(int i=0; i<paramFileName.length; i++){

                minutesMeetingRoom = paramMinutesMeetingroom[i];
                minutesMachine = paramMinutesMachine[i];
                minutesId = siteSer + "_"  + cUtils.getTodate();
                minutesName = paramMinutesName[i];
                recSrcCd = "0"; // 0 : file upload , 1: REALTIME
                startTime = paramStartTime[i];
                endTime = paramStartTime[i];
                minutesTopic = paramMinutesTopic[i];
                minutesJoinedMem = paramConfJoinedEmpName[i].replaceAll("/",",");
                minutesJoinedCnt = paramConfJoinedCnt[i].replaceAll("/",",");
                minutesStatus = "0";

                String fileName = paramFileName[i];
                List<MultipartFile> fileFilterList = files.stream()
                        .filter(s->s.getOriginalFilename().equals(fileName))
                        .collect(Collectors.toList());

                if(fileFilterList.size() == 1){
                    String fileNm = siteSer +"_" + "8_"+ cUtils.getTodate()+"_"+getRandomNum()+".wav";
                    String filePath = rootPath + uploadPath + "/" + siteSer+ "/" +cUtils.getDate()+"/"+ fileNm;
                    //String filePath = "E:/" +FILE_UPLOAD_MINUTES_FOLDER+ "/" + fileNm;
                    File file = new File(filePath);

                    if(file.getParentFile().exists()){

                    }else{
                        file.getParentFile().mkdirs();
                    }

                    fileFilterList.get(0).transferTo(file);

                    int duration = getWavDuration(file);

                    FrontFileUpConfVO frontFileUpConfVO = new FrontFileUpConfVO();
                    // TODO 추후 로그인 된 정보로 변경
                    frontFileUpConfVO.setMinutesUserSer(1);
                    frontFileUpConfVO.setMinutesSiteSer(siteSer);
                    frontFileUpConfVO.setMinutesMeetingroom(minutesMeetingRoom);
                    frontFileUpConfVO.setMinutesMachine(minutesMachine);
                    frontFileUpConfVO.setMinutesId(minutesId);
                    frontFileUpConfVO.setMinutesName(minutesName);
                    frontFileUpConfVO.setMinutesTopic(minutesTopic);
                    frontFileUpConfVO.setMinutesJoinedMem(minutesJoinedMem);
                    frontFileUpConfVO.setMinutesJoinedCnt(Integer.valueOf(minutesJoinedCnt));
                    frontFileUpConfVO.setMinutesStatus(minutesStatus);
                    frontFileUpConfVO.setRecSrcCd(recSrcCd);
                    frontFileUpConfVO.setFileName(fileNm);
                    frontFileUpConfVO.setFilePath(filePath);
                    frontFileUpConfVO.setStartTime(startTime);
                    frontFileUpConfVO.setEndTime(endTime);
                    frontFileUpConfVO.setRecTime(duration);
                    frontFileUpConfVO.setCreateUser("123");

                    confUploadMapper.saveFileUpload(frontFileUpConfVO);
                }

            }

        }catch (Exception e){
            e.printStackTrace();
            throw new Exception();
        }
        return result;
    }


    public static byte[] base64Enc(byte[] buffer) {
        return Base64.encodeBase64(buffer);
    }

    public int getWavDuration(File file) throws Exception{

        AudioFileFormat aff = AudioSystem.getAudioFileFormat(file);
        AudioFormat af = aff.getFormat();
        int calcDuration = (int) Math.floor(aff.getFrameLength() / af.getFrameRate());
        return calcDuration;

    }

    public String getRandomNum(){

        Random random = new Random();

        StringBuilder result = new StringBuilder();

        for (int i=0; i<3; i++){
            int tempVal = random.nextInt(9)+1;
            result.append(String.valueOf(tempVal));
        }

        return result.toString();

    }

}
