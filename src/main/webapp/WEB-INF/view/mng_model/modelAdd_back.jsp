<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <title>Title</title>
    </head>

    <body>
        <form id="mainFrm" name="mainFrm">
            <div class="tbl">
                <div class="row">
                    <div class="cell">Type</div>
                    <div class="cell">
                        <select id="deepLearnType" name="deepLearnType">
                            <option value="0" selected>-- 선택 --</option>
                            <option value="CNN">CNN</option>
                            <option value="DNN">DNN</option>
                            <option value="LSTM">LSTM</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="cell">모델명</div>
                    <div class="cell">
                        <input type="text" id="model_name" name="model_name" value="">
                    </div>
                </div>
                <div class="row">
                <div class="cell">Model Language</div>
                <div class="cell">
                    <select id="model_lang" name="model_lang">
                        <option value="0">--선택--</option>
                        <option value="kor">한글</option>
                        <option value="eng">영어</option>
                    </select>
                </div>
                </div>
                <div class="row">
                    <div class="cell">Rate</div>
                    <div class="cell">
                        <input type="text" id="model_rate" name="model_rate" value="">
                    </div>
                </div>
                <div class="row">
                    <div class="cell">모델설명</div>
                    <div class="cell">
                        <input type="text" id="model_desc" name="model_desc" value="">
                    </div>
                </div>

            </div>


            <div class="top_margin20 tbl">
                <div class="row">
                    <div class="btn row">
                        <input type="button" value="Cancel" onclick="doCancel();">
                        <input type="button" value="OK" onclick="doOk();">
                    </div>
                </div>
            </div>
        </form>
    </body>

    <script type="text/javascript" src="<c:url value='/resources/js/jquery-3.4.1.min.js'/>"></script>
    <script type="text/javascript">
        $(document).ready(function(){

        });

        function doOk() {

            var modelName = $('#model_name').val();
            var modelType = $('#deepLearnType option:selected').val();
            var modelLang = $('#model_lang option:selected').val();
            var modelRate = $('#model_rate').val();
            var modelDesc = $('#model_desc').val();

            if( modelType == '0' ){
                alert("deep learning Type을 선택해주세요.");
                $('#deepLearnType').focus();
                return false;
            }



            if($.trim(modelName).length == 0) {
                alert("모델이름을 입력하십시오.");
                $('#model_lang').focus();
                return false;
            }

            if( modelLang == '0' ){
                alert("언어를 선택해주세요.");
                $('#model_lang').focus();
                return false;
            }

            if($.trim(modelRate).length == 0) {
                alert("Rate를 입력하십시오.");
                $('#model_rate').focus();
                return false;
            }

            if($.trim(modelDesc).length == 0) {
                alert("모델 설명을 입력하십시오.");
                $('#model_desc').focus();
                return false;
            }

            var param = {
                stt_model_name: modelName,
                stt_model_lang: modelLang,
                deep_learning_type: modelType,
                stt_model_rate: modelRate,
                model_desc: modelDesc
            };

            $.ajax({
                url : "/createModel",
                data :param,
                type : "POST"
            }).done(function(data){
                console.log(data);
                if(data.resultCode == 200) {
                    alert("저장되었습니다");
                    opener.location.reload();
                    self.close();
                }else{
                    alert("저장이 실패하였습니다.");
                    return false;
                }
            }).fail(function(data){
                console.log("### FAIL : " + data);
                alert("저장 실패했습니다. 다시 시도해 보시기 바랍니다.");
                return false;
            });

        }

        function doCancel(){
            self.close();
        }

    </script>

    <style type="text/css">
        .top_margin20 {
            margin-top: 20px;
        }

        .tbl{
            display: table;
            width: 100%;
        }

        .row{
            display: table-row;
        }

        .head_cell{
            display: table-cell;
            padding: 0px 5px;
            height: 50px;
            border: 1px solid black;
            vertical-align: middle;
            text-align: center;
            font-weight: bold;
        }

        .cell{
            display: table-cell;
            padding: 0px 5px;
            height: 50px;
            border: 1px solid black;
            vertical-align: middle;
            text-align: center;
        }

        .row.btn{
            display: inline-block;
            float: right;
        }
    </style>

</html>
