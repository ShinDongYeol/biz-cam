package ai.maum.biz.cams.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("frontUploadVO")
public class FrontUploadVO {


    private String rec_file_name;
    private String rec_time;
    private String site_name;
    private String meetingroom_name;
    private String minutes_name;
    private String rec_date;
    private String rec_start_time;
    private String rec_end_time;

    private String currentPage;
    private int startRow;
    private int lastRow;
    private int pageInitPerPage;

}
