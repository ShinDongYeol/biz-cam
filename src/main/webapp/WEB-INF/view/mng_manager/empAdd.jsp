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

        직원 정보 추가
        <div class="tbl">
<%--
            <div class="row">
                <div class="cell">사이트명</div>
                <div class="cell">
                    <select id="add_siteName" name="add_siteName">
                        <option value="0">-- 선택 --</option>
                        ${siteListTag}
                    </select>
                </div>
            </div>
--%>
            <div class="row">
                <div class="cell">이름</div>
                <div class="cell">
                    <input type="text" id="add_name" name="add_name">
                </div>
            </div>
            <div class="row">
                <div class="cell">부서</div>
                <div class="cell">
                    <select id="add_part" name="add_part">
                        <option value="0">-- 선택 --</option>
                        ${empPartTag}
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="cell">직급</div>
                <div class="cell">
                    <select id="add_posi" name="add_posi">
                        <option value="0">-- 선택 --</option>
                        ${empPositionTag}
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="cell">활성여부</div>
                <div class="cell">
                    <select id="add_useYn" name="add_useYn">
                        <option value="0">-- 선택 --</option>
                        <option value="Y">Y</option>
                        <option value="N">N</option>
                    </select>
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
        function doOk(){
            // let siteName = $('#add_siteName').val();
            const siteName = 1;     // 고정값
            let name = $('#add_name').val();
            let part = $('#add_part').val();
            let posi = $('#add_posi').val();
            let useYn = $('#add_useYn').val();

            // if( siteName == '0' ){
            //     alert("사이트명을 선택하시기 바랍니다.");
            //     $('#add_siteName').focus();
            //
            //     return false;
            // }
            if( name.length < 1 ){
                alert("이름을 입력하시기 바랍니다.");
                $('#add_name').focus();

                return false;
            }
            if( part === '0' ){
                alert("부서를 선택하시기 바랍니다.");
                $('#add_part').focus();

                return false;
            }
            if( posi === '0' ){
                alert("직급을 선택하시기 바랍니다.");
                $('#add_posi').focus();

                return false;
            }
            if( useYn === '0' ){
                alert("활성여부를 선택하시기 바랍니다.");
                $('#add_useYn').focus();

                return false;
            }

            $.ajax({
                url : "/empAddOk",
                data : {
                    add_siteName:siteName
                    , add_name:name
                    , add_part:part
                    , add_posi:posi
                    , add_useYn:useYn
                },
                type : "POST"
            }).done(function(data){
                console.log("### SUCC : " + data);
                alert("저장되었습니다");

                opener.location.reload();
                self.close();
            }).fail(function(data){
                console.log("### FAIL : " + data);
                alert("저장 실패했습니다. 다시 시도해 보시기 바랍니다.");

                opener.location.reload();
                self.close();
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
