package ai.maum.biz.cams.service;

import ai.maum.biz.cams.dto.SttMetaDTO;
import ai.maum.biz.cams.mapper.SttMetaMapper;
import ai.maum.biz.cams.mapper.SttResultMapper;
import ai.maum.biz.cams.utils.CommonUtils;
import ai.maum.biz.cams.vo.FrontMinutesCreateVO;
import ai.maum.biz.cams.vo.FrontMinutesUpdateVO;
import ai.maum.biz.cams.vo.FrontMinutesVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

@Service
public class SttMetaSvcImpl implements SttMetaSvc {

    private Logger logger = LoggerFactory.getLogger(SttMetaSvcImpl.class);

    @Autowired
    CommonUtils cUtils;

    @Autowired
    private SttMetaMapper sttMetaMapper;

    @Autowired
    private SttResultMapper sttResultMapper;

    @Value("${repository.rootPath}")
    private String rootPath;

    @Value("${repository.uploadPath}")
    private String uploadPath;


    @Override
    public SttMetaDTO getBySttMetaSer(FrontMinutesVO frontMinutesVO) throws Exception{

        SttMetaDTO sttMetaDTO = new SttMetaDTO();
        String logTitle = "getBySttMetaSer/"+frontMinutesVO;
        try{
            sttMetaDTO = sttMetaMapper.getBySttMetaSer(frontMinutesVO);
            String replacePath = rootPath+ uploadPath;
            String fileUrl = sttMetaDTO.getFile_path().replace(replacePath,"/repository");
            sttMetaDTO.setFile_url(fileUrl);

            String[] minutesJoinedMemArr = sttMetaDTO.getMinutes_joined_mem().split(",");
            sttMetaDTO.setMinutes_joined_mem_arr(minutesJoinedMemArr);
        }catch (Exception e){
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            e.printStackTrace();
            throw new Exception(e);
        }finally {
            logger.info("[ == RESULT == ]/{}{}", logTitle, sttMetaDTO);
        }
        return sttMetaDTO;
    }

    @Override
    public List<SttMetaDTO> gets(FrontMinutesVO frontMinutesVO){
        return sttMetaMapper.gets(frontMinutesVO);
    }

    @Override
    public int getMinutesCount(FrontMinutesVO frontMinutesVO) throws Exception{

        String logTitle = "getMinutesCount/"+frontMinutesVO;
        int result = 0;
        try{
            result = sttMetaMapper.getMinutesCount(frontMinutesVO);
        }catch (Exception e){
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            e.printStackTrace();
            throw new Exception(e);
        }finally {
            logger.info("[ == RESULT == ]/{}{}", logTitle, result);
        }
        return result;
    }


    @Override
    public List<SttMetaDTO> getMinutesList(FrontMinutesVO frontMinutesVO) throws Exception{

        List<SttMetaDTO> result = null;

        String logTitle = "getMinutesList/"+frontMinutesVO;

        try{
            result = sttMetaMapper.getMinutesList(frontMinutesVO);
        }catch (Exception e){
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            e.printStackTrace();
            throw new Exception(e);
        }finally {
            logger.info("[ == RESULT == ]/{}{}", logTitle, result == null ? "not found" : result.size());
        }
        return result;
    }


    @Override
    @Transactional(rollbackFor = {Exception.class})
    public String delete(FrontMinutesVO frontMinutesVO) throws Exception{

        int[] deleteTargetList = frontMinutesVO.getSttMetaDelArr();
        String logTitle = "delete/"+frontMinutesVO+"/";

        String result = "SUCCESS";
        int sttMetaDeleteCnt = 0;
        int sttResultDeleteCnt = 0;
        int sttMetaFileDeleteCnt = 0;

        try{

            for(int i =0; i<deleteTargetList.length; i++){

                FrontMinutesVO getFrontMinutesVO = new FrontMinutesVO();
                getFrontMinutesVO.setSttMetaSer(deleteTargetList[i]);
                SttMetaDTO sttMetaDTO = sttMetaMapper.getBySttMetaSer(getFrontMinutesVO);
                String filePath = sttMetaDTO.getFile_path();

                File file = new File(filePath);
                if( file.exists() ){
                    if(file.delete()){
                        sttMetaFileDeleteCnt++;
                    }
                }

                sttResultDeleteCnt += sttResultMapper.delete(deleteTargetList[i]);
                sttMetaDeleteCnt += sttMetaMapper.delete(deleteTargetList[i]);

            }

        }catch (Exception e){
            result = "FAIL";
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            throw new Exception();
        }finally {
            logger.info("[ == RESULT == ]/{}{}{}{}", logTitle, sttMetaDeleteCnt,sttResultDeleteCnt,sttMetaFileDeleteCnt);
        }

        return result;
    }

    @Override
    @Transactional(rollbackFor = {Exception.class})
    public String reg(MultipartFile uploadFile, FrontMinutesCreateVO frontMinutesCreateVO) throws Exception{

        String logTitle = "reg/"+frontMinutesCreateVO+"/";
        String result = "SUCCESS";

        String minutesId = "";
        String recSrcCd = "";
        int minutesJoinedCnt = 0;
        String minutesStatus = "";

        try{

            int siteSer = frontMinutesCreateVO.getMinutesSiteSer();
            String createUser = frontMinutesCreateVO.getCreateUser();
            String fileNm = siteSer +"_" + "8_"+ cUtils.getTodate()+"_"+getRandomNum()+".wav";
            String filePath = rootPath + uploadPath + "/" + siteSer+ "/" +cUtils.getDate()+"/"+ fileNm;

            File file = new File(filePath);

            if(file.getParentFile().exists()){

            }else{
                file.getParentFile().mkdirs();
            }

            uploadFile.transferTo(file);

            int recTime = getWavDuration(file);
            minutesJoinedCnt = frontMinutesCreateVO.getMinutesJoinedMem().split(",").length;
            recSrcCd = "0"; // 0 : file upload , 1: REALTIME
            minutesStatus = "0";

            frontMinutesCreateVO.setMinutesId("");
            frontMinutesCreateVO.setFileName(fileNm);
            frontMinutesCreateVO.setFilePath(filePath);
            frontMinutesCreateVO.setRecTime(recTime);
            frontMinutesCreateVO.setMinutesJoinedCnt(minutesJoinedCnt);
            frontMinutesCreateVO.setRecSrcCd(recSrcCd);
            frontMinutesCreateVO.setMinutesStatus(minutesStatus);
            frontMinutesCreateVO.setCreateUser(createUser);

            sttMetaMapper.reg(frontMinutesCreateVO);

            minutesId = siteSer + "_"  + frontMinutesCreateVO.getSttMetaSer() +"_"+cUtils.getTodate();
            frontMinutesCreateVO.setMinutesId(minutesId);
            sttMetaMapper.updateMinutesId(frontMinutesCreateVO);

        }catch (Exception e){
            result = "FAIL";
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            throw new Exception();
        }finally {
            logger.info("[ == RESULT == ]/{}", logTitle);
        }


        return result;
    }

    @Override
    @Transactional(rollbackFor = {Exception.class})
    public String updateMinutesMeta(FrontMinutesUpdateVO frontMinutesUpdateVO) throws Exception{

        String logTitle = "updateMinutesMeta/"+frontMinutesUpdateVO+"/";
        String result = "SUCCESS";
        int updateResult = 0;

        int minutesJoinedCnt = 0;

        try{

            String updateUser = frontMinutesUpdateVO.getUpdateUser();

            minutesJoinedCnt = frontMinutesUpdateVO.getMinutesJoinedMem().split(",").length;

            frontMinutesUpdateVO.setMinutesJoinedCnt(minutesJoinedCnt);
            frontMinutesUpdateVO.setUpdateUser(updateUser);

            updateResult = sttMetaMapper.updateMinutesMeta(frontMinutesUpdateVO);

            if(updateResult <= 0){
                result = "FAIL";
            }

        }catch (Exception e){
            result = "FAIL";
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            throw new Exception();
        }finally {
            logger.info("[ == RESULT == ]/{}{}", logTitle,result);
        }

        return result;
    }

    @Override
    @Transactional(rollbackFor = {Exception.class})
    public String updateMemo(FrontMinutesUpdateVO frontMinutesUpdateVO) throws Exception{

        String logTitle = "updateMemo/"+frontMinutesUpdateVO+"/";
        String result = "SUCCESS";
        int updateResult = 0;

        try{
            updateResult = sttMetaMapper.updateMemo(frontMinutesUpdateVO);
            if(updateResult <= 0){
                result = "FAIL";
            }
        }catch (Exception e){
            result = "FAIL";
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            throw new Exception();
        }finally {
            logger.info("[ == RESULT == ]/{}", logTitle,updateResult);
        }

        return result;
    }

    public int getWavDuration(File file){
        int calcDuration = 0;
        try{
            AudioFileFormat aff = AudioSystem.getAudioFileFormat(file);
            AudioFormat af = aff.getFormat();
            calcDuration = (int) Math.floor(aff.getFrameLength() / af.getFrameRate());
        }catch (Exception e){
            e.printStackTrace();
        }

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
