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

            직원 정보 수정
            <div class="tbl">
<%--
                <div class="row">
                    <div class="cell">사이트명</div>
                    <div class="cell">
                        <select id="modi_siteName" name="modi_siteName">
                            <option value="0">--선택--</option>
                            ${siteListTag}
                        </select>
                    </div>
                </div>
--%>
                <div class="row">
                    <div class="cell">이름</div>
                    <div class="cell">
                        <input type="text" id="modi_name" name="modi_name" value="${empInfo.name}">
                    </div>
                </div>
                <div class="row">
                    <div class="cell">부서</div>
                    <div class="cell">
                        <select id="modi_part" name="modi_part">
                            <option value="0">-- 선택 --</option>
                            ${empPartTag}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="cell">직급</div>
                    <div class="cell">
                        <select id="modi_posi" name="modi_posi">
                            <option value="0">-- 선택 --</option>
                            ${empPositionTag}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="cell">활성여부</div>
                    <div class="cell">
                        <select id="modi_useYn" name="modi_useYn">
                            <option value="0">--선택--</option>
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

            <input type="hidden" id="esnum" name="esnum" value="${empInfo.minutes_employee_ser}">
        </form>
    </body>

    <script type="text/javascript" src="<c:url value='/resources/js/jquery-3.4.1.min.js'/>"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            <%--let siteName = '<c:out value="${empInfo.minutes_site_ser}" />';--%>
            let part = '<c:out value="${empInfo.part}" />';
            let posi = '<c:out value="${empInfo.position}" />';
            let useYn = '<c:out value="${empInfo.useYn}" />';

            // $('#modi_siteName').val(siteName);
            $('#modi_part').val(part);
            $('#modi_posi').val(posi);
            $('#modi_useYn').val(useYn);
        });

        function doOk(){
            let esnum = $('#esnum').val();
            // let siteName = $('#modi_siteName').val();
            const siteName = 1; // 고정값
            let name = $('#modi_name').val();
            let part = $('#modi_part').val();
            let posi = $('#modi_posi').val();
            let useYn = $('#modi_useYn').val();

            // if( siteName == '0' ){
            //     alert("사이트명을 선택하시기 바랍니다.");
            //     $('#modi_siteName').focus();
            //
            //     return false;
            // }
            if( name.length < 1 ){
                alert("이름을 입력하시기 바랍니다.");
                $('#modi_name').focus();

                return false;
            }
            if( part === '0' ) {
                alert("부서를 선택하시기 바랍니다.");
                $('#modi_part').focus();

                return false;
            }
            if( posi === '0' ){
                alert("직급을 선택하시기 바랍니다.");
                $('#modi_posi').focus();

                return false;
            }
             if( useYn === '0' ){
                alert("활성여부를 선택하시기 바랍니다.");
                $('#modi_useYn').focus();

                return false;
            }

            $.ajax({
                url : "/empModifyOk",
                data : {
                    esnum:esnum
                    , modi_siteName:siteName
                    , modi_name:name
                    , modi_part:part
                    , modi_posi:posi
                    , modi_useYn:useYn
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
