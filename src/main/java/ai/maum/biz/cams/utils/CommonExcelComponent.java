package ai.maum.biz.cams.utils;

import lombok.Getter;
import lombok.Setter;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.extensions.XSSFCellBorder;
import org.springframework.stereotype.Component;

@Component
public class CommonExcelComponent {

    //workbook 생성
    private SXSSFWorkbook workbook;
    // Sheet 생성
    private Sheet sheet;

    private @Getter
    @Setter
    int rowCount;
    private Cell cell;
    private CellStyle dataStyle;
    private CellStyle columeStyle;
    private CellStyle titleStyle;
    private CellStyle subTitleStyle;


    public void init(){
        workbook = new SXSSFWorkbook(100);
        sheet = workbook.createSheet("sheet");

        this.dataStyle = getDataStyle();
        this.columeStyle = getColumeStyle();
        this.titleStyle = getTitleStyle();
        this.subTitleStyle = getSubTitleStyle();


        rowCount = 0;
    }

    public Row createRow(int  rowHeight){
        rowCount++;
        Row row  = sheet.createRow(rowCount);
        row.setHeightInPoints(rowHeight);

        return row;
    }

    public void createTitle(String value, int startCol, int endCol){
        //rowCount++;
        Row row  = sheet.createRow(rowCount);
        row.setHeightInPoints(25);
        createMergedRow(rowCount, rowCount, startCol, endCol);
        cell = row.createCell(1);
        cell.setCellValue(value);
        cell.setCellStyle(titleStyle); // 셀 스타일 적용

    }

    private  void createMergedRow(int startRow, int endRow , int startCol, int endCol){
        sheet.addMergedRegion(new CellRangeAddress(startRow, endRow, startCol, endCol));
    }


    // row 를 1줄만 띌게 아니라면.... 값을 주고 1줄간격이면 null 주면됨...
    public void createColumnRow(Integer rowCount, String[] columnMap){

        if(rowCount !=null ){
            this.rowCount= rowCount;
        }else{
            this.rowCount = this.rowCount +1;
        }

        Row row  = sheet.createRow(rowCount);
        row.setHeightInPoints(13.5f);

        for(int i = 0 ;i < columnMap.length ; i ++){
            cell = row.createCell((i+1));
            cell.setCellStyle(columeStyle);
            cell.setCellValue(columnMap[i]);
        }
    }

    public void createDataRow(String[] data,int titleColumnCnt){
        rowCount= rowCount + 1;
        Row row  = sheet.createRow(rowCount);

        if(data.length == 0){

            for(int i=0; i<titleColumnCnt; i++){
                cell = row.createCell(i+1);
                cell.setCellStyle(dataStyle);
                cell.setCellValue("No data available in table");
            }
            createMergedRow(rowCount,rowCount,1,titleColumnCnt);

        }else{

            for(int j = 0 ;j < data.length; j ++){
                cell = row.createCell((j+1));
                cell.setCellStyle(dataStyle);
                cell.setCellValue(data[j]);
            }

        }

    }



    public void createCell(Row row, int pos, String value, XSSFCellStyle style){
        cell = row.createCell(pos);
        cell.setCellValue(value);
        cell.setCellStyle(style); // 셀 스타일 적용
    }



    /**
     * 프린트 설정.
     */
    public void setSheetPrintSetting(){
        sheet.getPrintSetup().setPaperSize(PrintSetup.A4_PAPERSIZE);
        sheet.getPrintSetup().setLandscape(false);
        sheet.getPrintSetup().setScale((short)100);
        sheet.getPrintSetup().setHeaderMargin(0.1);
        sheet.getPrintSetup().setFooterMargin(0.1);
        sheet.setMargin(Sheet.LeftMargin, 0.20);
        sheet.setMargin(Sheet.RightMargin, 0.20);
        sheet.setMargin(Sheet.TopMargin, 0.20);
        sheet.setMargin(Sheet.BottomMargin, 0.20);
        sheet.setPrintGridlines(false);
        sheet.setDisplayGridlines(true);
        sheet.setAutobreaks(true);
        sheet.setHorizontallyCenter(true);
    }

    public void setColumnWidth(int[] columnWiths){
        for(int i = 0; i < columnWiths.length ; i++){
            sheet.setColumnWidth(i, columnWiths[i]);
        }
    }




    public XSSFCellStyle getColumeStyle() {
        Font columeFont = workbook.createFont();
        columeFont.setFontName("굴림");
        columeFont.setFontHeight((short) 220);
        columeFont.setBold(true);

        XSSFCellStyle columeCs = (XSSFCellStyle) workbook.createCellStyle();
        columeCs.setFont(columeFont);
        columeCs.setAlignment(HorizontalAlignment.CENTER);
        columeCs.setVerticalAlignment(VerticalAlignment.CENTER);
        //  columeCs.setFillForegroundColor(new XSSFColor(Color.YELLOW));
        columeCs.setFillForegroundColor(new XSSFColor(new java.awt.Color(255, 255, 0)));
        columeCs.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        columeCs.setBorderLeft(BorderStyle.THIN);
        columeCs.setBorderRight(BorderStyle.THIN);
        columeCs.setBorderTop(BorderStyle.THIN);
        columeCs.setBorderBottom(BorderStyle.THIN);

        columeCs.setBorderColor(XSSFCellBorder.BorderSide.LEFT, new XSSFColor(java.awt.Color.BLACK));
        columeCs.setBorderColor(XSSFCellBorder.BorderSide.RIGHT, new XSSFColor(java.awt.Color.BLACK));
        columeCs.setBorderColor(XSSFCellBorder.BorderSide.TOP, new XSSFColor(java.awt.Color.BLACK));
        columeCs.setBorderColor(XSSFCellBorder.BorderSide.BOTTOM, new XSSFColor(java.awt.Color.BLACK));
        return columeCs;
    }

    public XSSFCellStyle getSubTitleStyle() {
        Font subMaiFont = workbook.createFont();
        subMaiFont.setFontName("굴림");
        subMaiFont.setFontHeight((short) 260);
        subMaiFont.setBold(true);

        XSSFCellStyle subMainCs = (XSSFCellStyle) workbook.createCellStyle();
        subMainCs.setFont(subMaiFont);
        subMainCs.setAlignment(HorizontalAlignment.LEFT);
        subMainCs.setVerticalAlignment(VerticalAlignment.CENTER);
        subMainCs.setFillForegroundColor(new XSSFColor(java.awt.Color.WHITE));
        subMainCs.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        return subMainCs;
    }

    public XSSFCellStyle getTitleStyle() {
        Font mainFont = workbook.createFont();
        mainFont.setFontName("굴림");
        mainFont.setFontHeight((short) 360);
        mainFont.setBold(true);

        XSSFCellStyle mainCs = (XSSFCellStyle) workbook.createCellStyle();
        mainCs.setFont(mainFont);
        mainCs.setAlignment(HorizontalAlignment.CENTER);
        mainCs.setVerticalAlignment(VerticalAlignment.CENTER);
        mainCs.setFillForegroundColor(new XSSFColor(java.awt.Color.WHITE));
        mainCs.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        return mainCs;
    }



    public XSSFCellStyle getDataStyle() {
        Font dataFont = workbook.createFont();
        dataFont.setFontName("굴림");
        dataFont.setFontHeight((short) 200);

        XSSFCellStyle dataCs = (XSSFCellStyle) workbook.createCellStyle();
        dataCs.setFont(dataFont);
        dataCs.setAlignment(HorizontalAlignment.CENTER);
        dataCs.setVerticalAlignment(VerticalAlignment.CENTER);
        dataCs.setFillForegroundColor(new XSSFColor(java.awt.Color.WHITE));
        dataCs.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        dataCs.setWrapText(true);

        dataCs.setBorderLeft(BorderStyle.THIN);
        dataCs.setBorderRight(BorderStyle.THIN);
        dataCs.setBorderTop(BorderStyle.THIN);
        dataCs.setBorderBottom(BorderStyle.THIN);

        dataCs.setBorderColor(XSSFCellBorder.BorderSide.LEFT, new XSSFColor(java.awt.Color.BLACK));
        dataCs.setBorderColor(XSSFCellBorder.BorderSide.RIGHT, new XSSFColor(java.awt.Color.BLACK));
        dataCs.setBorderColor(XSSFCellBorder.BorderSide.TOP, new XSSFColor(java.awt.Color.BLACK));
        dataCs.setBorderColor(XSSFCellBorder.BorderSide.BOTTOM, new XSSFColor(java.awt.Color.BLACK));
        return dataCs;
    }


    public Workbook getWorkBook(){
        return this.workbook;
    }

}
