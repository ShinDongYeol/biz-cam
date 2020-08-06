package ai.maum.biz.cams.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("commonCodeDTO")
public class CommonCodeDTO {
    private String code_one;
    private String code_two;
    private String code_three;
    private String code_value;
    private String code_desc;
}
