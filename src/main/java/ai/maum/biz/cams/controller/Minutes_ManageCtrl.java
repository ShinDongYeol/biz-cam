package ai.maum.biz.cams.controller;

import ai.maum.biz.cams.dto.SttMetaDTO;
import ai.maum.biz.cams.dto.SttResultDTO;
import ai.maum.biz.cams.dto.UserDTO;
import ai.maum.biz.cams.service.ConfStatusSvc;
import ai.maum.biz.cams.service.SttMetaSvc;
import ai.maum.biz.cams.service.SttResultSvc;
import ai.maum.biz.cams.utils.CommonUtils;
import ai.maum.biz.cams.utils.ExcelView;
import ai.maum.biz.cams.vo.FrontMinutesCreateVO;
import ai.maum.biz.cams.vo.FrontMinutesUpdateVO;
import ai.maum.biz.cams.vo.FrontMinutesVO;
import ai.maum.biz.cams.vo.PagingVO;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/minutes/manage/")
public class Minutes_ManageCtrl {

    private Logger logger = LoggerFactory.getLogger(Minutes_ManageCtrl.class);

    @Autowired
    private SttMetaSvc sttMetaSvc;

    @Autowired
    private SttResultSvc sttResultSvc;

    @Autowired
    private ConfStatusSvc confStatusSvc;

    @Autowired
    private CommonUtils cUtils;

    @RequestMapping(value="minutesList")
    public String minutesList(HttpServletRequest request,FrontMinutesVO frontMinutesVO, Model model){

        String logTitle = "minutesList";
        logger.info("[ == START == ]/{}",frontMinutesVO);
        PagingVO pagingVO = new PagingVO();
        List<SttMetaDTO> result = null;

        try{

            HttpSession session = request.getSession();
            UserDTO userInfo = cUtils.getUserInfo();
            int siteSer = Integer.parseInt(userInfo.getMinutes_site_ser());
            frontMinutesVO.setMinutesSiteSer(siteSer);
            frontMinutesVO.setUserType(userInfo.getUser_type());
            pagingVO = new PagingVO();
            pagingVO.setTotalCount( sttMetaSvc.getMinutesCount(frontMinutesVO) );
            pagingVO.setCurrentPage( frontMinutesVO.getCurrentPage() );
            frontMinutesVO.setStartRow( pagingVO.getStartRow() );
            frontMinutesVO.setLastRow( pagingVO.getLastRow() );
            frontMinutesVO.setPageInitPerPage( pagingVO.getCOUNT_PER_PAGE() );
            result = sttMetaSvc.getMinutesList(frontMinutesVO);
            model.addAttribute("result", result);
            model.addAttribute("frontMinutesVO", frontMinutesVO);
            model.addAttribute("paging", pagingVO);

        }catch (Exception e){
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());

        }finally {
            String resultTitle = result == null? "not found" : String.valueOf(result.size());
            logger.info("[ == END == ]/{}/{}/{}",resultTitle,frontMinutesVO,pagingVO);
        }

        return "/minutes/manage/minutesList";

    }

    @RequestMapping(value="minutesCreate")
    public String minutesCreate(){

        String logTitle = "minutesCreate";
        logger.info("[ == START == ]");

        try{

        }catch (Exception e){
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());

        }finally {
            logger.info("[ == END == ]/{}",logTitle);
        }

        return "/minutes/manage/minutesCreate";

    }

    @RequestMapping(value = "minutesReg",method= RequestMethod.POST)
    @ResponseBody
    public String minutesReg(HttpServletRequest request,
                             @RequestParam("uploadFile") MultipartFile uploadFile, FrontMinutesCreateVO frontMinutesCreateVO, Model model)
    {


        String logTitle = "minutesReg/"+frontMinutesCreateVO;
        logger.info("[ == START == ]");
        String result = "SUCCESS";

        try{

            HttpSession session = request.getSession();

            if(session.getAttribute("userInfo") != null){
                int pos = uploadFile.getOriginalFilename().lastIndexOf( "." );
                String ext = uploadFile.getOriginalFilename().substring( pos + 1 );

                if(!"wav".equals(ext)){
                    throw new Exception("파일 확장자가 잘못되었습니다.");
                }
                UserDTO userInfo = cUtils.getUserInfo();
                int minutesUserSer = Integer.parseInt(userInfo.getMinutes_user_ser());
                int siteSer = Integer.parseInt(userInfo.getMinutes_site_ser());
                String createUser = userInfo.getUser_id();
                frontMinutesCreateVO.setMinutesUserSer(minutesUserSer);
                frontMinutesCreateVO.setMinutesSiteSer(siteSer);
                frontMinutesCreateVO.setCreateUser(createUser);
                result = sttMetaSvc.reg(uploadFile,frontMinutesCreateVO);
            }else{
                throw new Exception("로그인 정보가 없습니다.");
            }

        }catch (Exception e){
            result = e.getMessage();
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());

        }finally {
            logger.info("[ == END == ]/{}",logTitle);
        }

        return result;


    }

    @RequestMapping(value = "minutesDel")
    @ResponseBody
    public String minutesDel(FrontMinutesVO frontMinutesVO, Model model){

        String logTitle = "minutesDel";
        logger.info("[ == START == ]/{}",frontMinutesVO);

        String result = "SUCCESS";

        try{
            result = sttMetaSvc.delete(frontMinutesVO);
        }catch (Exception e){
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
            result = "FAIL";
        }finally {
            logger.info("[ == END == ]/{}",result);
        }


        return result;
    }

    @RequestMapping(value="recordScript")
    public String recordScript(FrontMinutesVO frontMinutesVO, Model model){

        String logTitle = "recordScript";
        logger.info("[ == START == ]/{}",frontMinutesVO);
        SttMetaDTO sttMeta = new SttMetaDTO();
        List<SttResultDTO> sttResult = null;
        List<SttResultDTO> employeeResult = null;
        try{
            sttMeta = sttMetaSvc.getBySttMetaSer(frontMinutesVO);
            sttResult = sttResultSvc.gets(frontMinutesVO);
            employeeResult = sttResultSvc.getsGroupByEmployee(frontMinutesVO);
            model.addAttribute("frontMinutesVO", frontMinutesVO);
            model.addAttribute( "sttMeta", sttMeta);
            model.addAttribute("sttResult", sttResult);
            model.addAttribute("employee",employeeResult);
        }catch (Exception e){
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
        }finally {
            String sttResultTitle = sttResult == null ? "not found" : String.valueOf(sttResult.size());
            String employeeResultTitle = employeeResult == null ? "not found" : String.valueOf(employeeResult.size());
            logger.info("[ == END == ]/{}{}",sttMeta,sttResultTitle,employeeResultTitle);
        }

        return "/minutes/record/recordedScript";

    }

    @RequestMapping(value="recordEditScript")
    public String recordEditScript(FrontMinutesVO frontMinutesVO, Model model){

        String logTitle = "recordEditScript";
        logger.info("[ == START == ]/{}",frontMinutesVO);
        SttMetaDTO sttMeta = new SttMetaDTO();
        List<SttResultDTO> sttResult = null;
        List<SttResultDTO> employeeResult = null;
        try{
            sttMeta = sttMetaSvc.getBySttMetaSer(frontMinutesVO);
            sttResult = sttResultSvc.gets(frontMinutesVO);
            employeeResult = sttResultSvc.getsGroupByEmployee(frontMinutesVO);
            model.addAttribute("frontMinutesVO", frontMinutesVO);
            model.addAttribute( "sttMeta", sttMeta);
            model.addAttribute("sttResult", sttResult);
            model.addAttribute("employee",employeeResult);
        }catch (Exception e){
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
        }finally {
            String sttResultTitle = sttResult == null ? "not found" : String.valueOf(sttResult.size());
            String employeeResultTitle = employeeResult == null ? "not found" : String.valueOf(employeeResult.size());
            logger.info("[ == END == ]/{}{}",sttMeta,sttResultTitle,employeeResultTitle);
        }

        return "/minutes/record/recordedEditScript";

    }

    @RequestMapping(value="/updateMinutesMeta",method = RequestMethod.POST)
    @ResponseBody
    public String updateMinutesMeta(HttpServletRequest request,FrontMinutesUpdateVO frontMinutesUpdateVO){

        String logTitle = "updateMinutesMeta/"+frontMinutesUpdateVO;
        logger.info("[ == START == ]");
        String result = "SUCCESS";

        try{

            HttpSession session = request.getSession();

            if(session.getAttribute("userInfo") != null){
                UserDTO userInfo = cUtils.getUserInfo();
                String updateUser = userInfo.getUser_id();
                frontMinutesUpdateVO.setUpdateUser(updateUser);
                result = sttMetaSvc.updateMinutesMeta(frontMinutesUpdateVO);
            }else{
                throw new Exception("로그인 정보가 없습니다.");
            }

        }catch (Exception e){
            result = e.getMessage();
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());

        }finally {
            logger.info("[ == END == ]/{}{}",logTitle,result);
        }

        return result;

    }

    @RequestMapping(value = "/updateMinutesAllEmployee",method= RequestMethod.POST)
    @ResponseBody
    public String updateMinutesAllEmployee(
            HttpServletRequest request,
            FrontMinutesUpdateVO frontMinutesUpdateVO
    )
    {
        String logTitle = "updateMinutesAllEmployee/"+frontMinutesUpdateVO;
        logger.info("[ == START == ]");
        String result = "SUCCESS";

        try{

            HttpSession session = request.getSession();

            if(session.getAttribute("userInfo") != null){
                UserDTO userInfo = cUtils.getUserInfo();
                String updateUser = userInfo.getUser_id();
                frontMinutesUpdateVO.setUpdateUser(updateUser);
                result = sttResultSvc.updateMinutesAllEmployee(frontMinutesUpdateVO);
            }else{
                throw new Exception("로그인 정보가 없습니다.");
            }

        }catch (Exception e){
            result = e.getMessage();
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());

        }finally {
            logger.info("[ == END == ]/{}{}",logTitle,result);
        }

        return result;
    }

    @RequestMapping("/updateSttResult")
    @ResponseBody
    public String updateSttResult(
            HttpServletRequest request,
            FrontMinutesUpdateVO frontMinutesUpdateVO
    )
    {
        String logTitle = "updateSttResult/"+frontMinutesUpdateVO;
        logger.info("[ == START == ]");
        String result = "SUCCESS";

        try{

            HttpSession session = request.getSession();

            if(session.getAttribute("userInfo") != null){
                UserDTO userInfo = cUtils.getUserInfo();
                String updateUser = userInfo.getUser_id();
                frontMinutesUpdateVO.setUpdateUser(updateUser);
                result = sttResultSvc.updateSttResult(frontMinutesUpdateVO);
            }else{
                throw new Exception("로그인 정보가 없습니다.");
            }

        }catch (Exception e){
            result = e.getMessage();
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());

        }finally {
            logger.info("[ == END == ]/{}{}",logTitle,result);
        }

        return result;
    }

    @RequestMapping("/updateEmptyToNullBySttChgResult")
    @ResponseBody
    public String updateEmptyToNullBySttChgResult(
            HttpServletRequest request,
            FrontMinutesUpdateVO frontMinutesUpdateVO
    )
    {
        String logTitle = "updateEmptyToNullBySttChgResult/"+frontMinutesUpdateVO;
        logger.info("[ == START == ]");
        String result = "SUCCESS";

        try{

            HttpSession session = request.getSession();

            if(session.getAttribute("userInfo") != null){
                UserDTO userInfo = cUtils.getUserInfo();
                String updateUser = userInfo.getUser_id();
                frontMinutesUpdateVO.setUpdateUser(updateUser);
                result = sttResultSvc.updateEmptyToNullBySttChgResult(frontMinutesUpdateVO);
            }else{
                throw new Exception("로그인 정보가 없습니다.");
            }

        }catch (Exception e){
            result = e.getMessage();
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());

        }finally {
            logger.info("[ == END == ]/{}{}",logTitle,result);
        }

        return result;
    }

    @RequestMapping("/updateMemo")
    @ResponseBody
    public String updateMemo(
            HttpServletRequest request,
            FrontMinutesUpdateVO frontMinutesUpdateVO
    )
    {
        String logTitle = "updateMemo/"+frontMinutesUpdateVO;
        logger.info("[ == START == ]");
        String result = "SUCCESS";

        try{

            HttpSession session = request.getSession();

            if(session.getAttribute("userInfo") != null){
                UserDTO userInfo = cUtils.getUserInfo();
                String updateUser = userInfo.getUser_id();
                frontMinutesUpdateVO.setUpdateUser(updateUser);
                result = sttMetaSvc.updateMemo(frontMinutesUpdateVO);
            }else{
                throw new Exception("로그인 정보가 없습니다.");
            }

        }catch (Exception e){
            result = e.getMessage();
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());

        }finally {
            logger.info("[ == END == ]/{}{}",logTitle,result);
        }

        return result;
    }

    @RequestMapping("/getsEmployee")
    @ResponseBody
    public String getsEmployee(FrontMinutesVO frontMinutesVO, Model model){

        String logTitle = "getsEmployee";
        logger.info("[ == START == ]/{}",frontMinutesVO);

        List<SttResultDTO> employeeResult = null;
        JSONObject obj = new JSONObject();

        try{
            employeeResult = sttResultSvc.getsGroupByEmployee(frontMinutesVO);
            obj.put("employee", employeeResult);
        }catch (Exception e){
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
        }finally {

            logger.info("[ == END == ]/{}",logTitle,obj.toString());
        }

        return obj.toString();
    }


    @RequestMapping("/excelDown")
    @ResponseBody
    public ModelAndView excelDown(
            @RequestParam(name = "sttMetaSer") int sttMetaSer
    ){

        String logTitle = "excelDown";
        logger.info("[ == START == ]/{}",sttMetaSer);

        String fileName =  "";

        ModelAndView view = new ModelAndView();

        try {
            fileName = "STT_RESULT_"+ cUtils.getTodate() + ".xlsx";
            Workbook book = sttResultSvc.createExcel(sttMetaSer);

            view.addObject("workBook", book);
            view.addObject("fileName", fileName);

            view.setView(new ExcelView());

        } catch (Exception e) {
            e.printStackTrace();
            logger.info("[ == ERROR == ]/{}{}", logTitle, e.getMessage());
        }finally {
            logger.info("[ == END == ]/{}{}",fileName);
        }

        return view;
    }



}
