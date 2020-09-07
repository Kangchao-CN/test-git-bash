<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    long token=System.currentTimeMillis();    //产生时间戳的token
    session.setAttribute("token",token);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <base href="<%=basePath %>">
    <meta charset="utf-8"/>
    <title>水专项过程管理系统</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link rel="stylesheet" href="../../../../static/ace/css/bootstrap.css"/>
    <link rel="stylesheet" href="../../../../static/ace/css/bootstrap-datetimepicker.min.css"/>
    <link rel="stylesheet" href="../../../../css/public.css"/>
    <link rel="stylesheet" href="../../../../css/table.css"/>
    <!-- webuploader上传插件css -->
    <link rel="stylesheet" type="text/css" href="plugins/webuploader/webuploader.css" />
    <link rel="stylesheet" href="../../../../css/mergeStyle.css"/>
    <%--<script src="js/progressReport/progressReportListOld.js"  type="text/javascript"></script>--%>
    <%-- <link href="<%=basePath %>base/assets/admin/pages/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath %>base/assets/admin/pages/css/rangeslider.css" rel="stylesheet" type="text/css"/> --%>
    <%--<link rel="stylesheet" href="static/ace/css/bootstrap.css"/>--%>
    <!-- END THEME STYLES -->
    <%--<link rel="shortcut icon" href="favicon.ico"/>--%>
    <style>

        @-moz-document url-prefix() {
           .textarea{height: 400%!important;}
           /*#ANNUAL_RESULTS{height: 400%!important;}*/

        }
    </style>
</head>

<body class="page-header-fixed page-quick-sidebar-over-content">
<!-- BEGIN HEADER -->



<!-- END HEADER -->
<div class="clearfix">
</div>
<div class="page-container" style="width:98%;margin:auto;">
    <div class="page-content-wrapper ">
        <div class="page-content">
            <div class="navDiv"></div>
            <div class="clearfix">
            </div>
            <input type="hidden" id="quarterlyNum" name="quarterlyNum" value="${pd.quarterlyNum}">
            <input type="hidden" id="subId" name="subId" value="${pd.subId}">
            <input type="hidden" id="tab" name="tab" value="${pd.tab}">
            <input type="hidden" id="dateYear" name="dateYear" value="${pd.year}">
            <input type="hidden" id="reportFlag" name="reportFlag" value="${reportFlag}">
            <input type="hidden" id="isActiviti" name="isActiviti" value="${pd.isActiviti}">

            <!--从待办事项跳转过来有这两个参数，该审批被驳回到起始发起人--->
            <input type="hidden" id="processId" name="processId" value="${pd.processId}">
            <input type="hidden" id="taskId" name="taskId" value="${pd.taskId}">

            <!-- 空iframe，用于协助处理form提交后不进行页面跳转的问题 -->
            <iframe id="iframe_display" name="iframe_display" style="display: none;"></iframe>
            <div class="row">
                <div class="listcontentform">
                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
                    <div class="listform">
                        <!-- tab头开始 -->
                        <ul id="myTab" class="nav nav-tabs">
                            <%--<li class="active"id="li5"><a href="#summarize" myattr="5" data-toggle="tab">项目（独立课题）概述</a></li>--%>
                            <li class="active" id="li1"><a id = "projectProgressBtn" href="#projectProgress" myattr="1" data-toggle="tab">项目（课题）任务完成进度和实施进展</a></li>
                            <li id="li2"><a href="#engineeringProgress" id = "engineeringProgressBtn" myattr="2" data-toggle="tab">示范工程进展</a></li>
                            <%--<li id="li3"><a href="#projectManagement" myattr="3" data-toggle="tab">项目管理情况</a></li>--%>
                            <li id="li4"><a href="#fininshed" myattr="4" data-toggle="tab">资金投入和管理</a></li>
                            <li id="li5"><a href="#resultsSummary" myattr="5" data-toggle="tab">成果成效小结</a></li>
                        </ul>
                        <c:if test="${read==null || read!='read'}">
                        <div style="width:100%"><button id="createReportButton" type="button" onclick="createReport('pdf')" class="btn btn-default btn-info mybtn" style="float:right;margin-right:9%;margin-top:30px;">
                            <i class="fa fa-save"></i> &nbsp;生成PDF报告</button></div>
                            <div style="width:100%"><button id="createReportButton1" type="button" onclick="createReport('word')" class="btn btn-default btn-info mybtn" style="float:right;margin-right:9%;margin-top:30px;">
                            <i class="fa fa-save"></i> &nbsp;生成WORD报告</button></div>
                        </c:if>
                        <div id="myTabContent" class="tab-content" style="min-width:1600px;">
                            <div id="subTitle" style="text-align:center;margin-top:45px;margin-bottom:45px;color:#595959;font-size:18px"></div>

                            <div  class="tab-pane fade in active" id="projectProgress">
                                <div class="contentform">
                                    <!-- <div class="divTip">*为必填选项</div> -->
                                    <div class="formbody" >
                                        <div class="portlet-body form">
                                            <!-- BEGIN FORM-->
                                            <%--<form action="progressreportproject/createProjectProgress" name="form1" id="projectProgressForm" class="form-horizontal" method="post" style="width:100%;margin:auto;" target="iframe_display" onsubmit="return progressInfo()">--%>
                                            <!--1--><form action="progressreportproject/createProjectProgress" name="form1" id="projectProgressForm" class="form-horizontal" method="post" style="width:100%;margin:auto;" target="iframe_display" >
                                                <input type="hidden" value="<%=token %>" id="token" name="token"/>   <!-- 作为hidden提交 -->
                                                <input type="hidden" name="sub_id" value="${pd.subId}"/>
                                                <input type="hidden" name="quarterly_index" value="${pd.quarterlyNum }" >
                                                <%--<input type="hidden" name="isAdd" value="${pd.isAdd }" >--%>
                                                <input type="hidden" name="year" value="${pd.year}">
                                                <input type="hidden" name="subject_name" value="${pd.subject_name}">
                                                <div style="width:90%;margin:auto;">
                                                    <h3 class="text-center">项目（独立课题）支撑标志性成果情况表</h3>
                                                    <div class="row clear" style="padding: 15px 0">
                                                        <div class="left text-center"  style="margin-left:15px;">项目(独立课题)名称:<span class="subTxt"></span></div>
                                                        <div class="right text-center">统计时段:<span>${pd.time}</span></div>
                                                    </div>
                                                    <div class="">
                                                        <table class="table table-bordered">
                                                            <thead class="text-center">
                                                            <tr class="row">
                                                                <td class="col-md-1">序号</td>
                                                                <td class="col-md-2">本年度支撑标志性成果的核心成果产出</td>
                                                                <td class="col-md-4" colspan="2">季度核心成果产出</td>
                                                                <td class="col-md-2">本季度任务进展情况</td>
                                                                <td class="col-md-1">本季度任务完成程度(%)</td>
                                                                <td class="col-md-2">未完成原因</td>
                                                                <td class="col-md-1">累计完成程度(%)</td>
                                                                <td>操作</td>
                                                            </tr>
                                                            </thead>
                                                            <tbody class="text-center" id="reportProgress">
                                                            <tr>
                                                                <td class="col-md-1" rowspan="4">1</td>
                                                                <td class="col-md-2" rowspan="4"><textarea rows="3" cols="20" name="ANNUAL_RESULTS"></textarea></td>
                                                                <td class="col-md-1">第一季度</td>
                                                                <td class="col-md-3"><input type="text" name="FIRST_QUARTER"></td>
                                                                <td class="col-md-2" rowspan="4"><textarea rows="3" cols="20" name="COMPLETE_SITUATION"></textarea></td>
                                                                <td class="col-md-1" rowspan="4"><textarea rows="3" cols="20" name="TASK_COMPLETE_DEGREE"></textarea></td>
                                                                <td class="col-md-2" rowspan="4"><textarea rows="3" cols="20" name="UNFINISHED_CAUSE"></textarea></td>
                                                                <td class="col-md-1" rowspan="4"><textarea rows="3" cols="20" name="CUMULATIVE_COMPLETE_DEGREE"></textarea></td>
                                                                <td class="col-md-1" rowspan="4"></td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-md-1">第二季度</td>
                                                                <td class="col-md-2"><input type="text" name="SECOND_QUARTER"></td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-md-1">第三季度</td>
                                                                <td class="col-md-2"><input type="text" name="THIRD_QUARTER"></td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-md-1">第四季度</td>
                                                                <td class="col-md-2"><input type="text" name="FOURTH_QUARTER"></td>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                        <c:if test="${read==null || read!='read'}">
                                                        <div class="clear">
                                                            <button type="button" onclick="addTabTr()" class="btn btn-primary" style="width:100px;height:40px;float:right;">添加</button>
                                                        </div>
                                                        </c:if>
                                                        <div>
                                                            <ul style="padding-left:0;">
                                                                <li>注：</li>
                                                                <li>1.与标志性成果责任专家、办公室项目主管同志共同商讨确定该项目支撑标志性成果的核心成果产出，细化到具体的技术、示范工程、标准规范、产品装备等,当年的核心成果产出必须细化到季度，且逐条填写。</li>
                                                                <li>2.“本季度任务完成情况”栏中需对标本季度的核心成果产出，逐条说明本季度任务的完成情况，与此无关的内容无需填写。</li>
                                                                <li>3.“累计完成程度”填写截至本季度累计完成任务量占项目（课题）执行期内总任务量的百分数。</li>
                                                            </ul>
                                                        </div>
                                                    </div>


                                                    <div class="form-actions" style="background-color:#fff;border:0;padding-top: 20px;">
                                                        <div class="psubmitButton" id="reportButton">
                                                            <%--<button type="submit" class="btn btn-primary mysubmit" style="width:100px;height:40px">保存</button>--%>
                                                                <c:if test="${read==null || read!='read'}">
                                                            <button type="button" class="btn btn-default" style="width:100px;height:40px">保存</button>
                                                                </c:if>
                                                            <button type="button" class="btn btn-default" name="btnback" style="width:100px;height:40px"onclick="toManage()">返回</button>
                                                        </div>
                                                    </div>
                                                </div>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div  class="tab-pane fade" id="engineeringProgress">
                                <div class="contentform">
                                    <!-- <div class="divTip">*为必填选项</div> -->
                                    <div class="formbody" >
                                        <div class="portlet-body form">
                                            <!-- BEGIN FORM-->
                                            <%--<form action="progressreportengineering/createEngineeringProgress" id="engineeringProgressForm" method="post"  target="iframe_display" onSubmit="return checkForm()">--%>
                                            <!--1--><form action="progressreportengineering/createEngineeringProgress" id="engineeringProgressForm" target="iframe_display" >
                                                <input type="hidden" value="<%=token %>" id="token" name="token"/>   <!-- 作为hidden提交 -->
                                                <input type="hidden" id="quarterly_index" name="quarterly_index" value="${pd.quarterlyNum }" >
                                                <input type="hidden" id="isAdd" name="isAdd" value="${pd.isAdd }" >
                                                <input type="hidden" id="year" name="year" value="${pd.year}">
                                                <input type="hidden" name="sub_id" value="${pd.subId}"/>
                                                <%--========================================== 示范工程进展情况 ===================================================--%>
                                                <div style="width:90%;margin:auto;">
                                                    <h3 class="text-center">项目（独立课题）示范工程进展情况统计表</h3>
                                                    <div class="row clear" style="padding: 15px 0;">
                                                        <div class="left text-center" id ="epTitle" style="margin-left: 15px;">项目(独立课题)名称:<span id="project_name" class="subTxt">${pd.subject_name}</span></div>
                                                        <div class="right text-center" id ="epTime">统计时段:<span>${pd.time}</span></div>
                                                    </div>
                                                    <div class="" id="enginePro">
                                                    </div>
                                                    <div>
                                                        <ul style="padding-left:0;margin-top: 20px;">
                                                            <li>注：示范工程地点具体到市、区（县）、乡镇、村 。</li>
                                                        </ul>
                                                    </div>

                                                    <div class="form-actions" style="background-color:#fff;border:0">
                                                        <div class="esubmitButton" style="margin-top: 20px">
                                                            <c:if test="${read==null || read!='read'}">
                                                            <%--<button type="submit" class="btn btn-primary mysubmit" style="width:100px;height:40px;" >保存</button>--%>
                                                            <button type="button" class="btn btn-primary" style="width:auto;height:40px;" onclick="enSubmit()">保存示范工程进展</button>
                                                            </c:if>
                                                            <button type="button" class="btn btn-default" name="btnback" style="width:100px;height:40px"onclick="toManage()">返回</button>
                                                        </div>
                                                    </div>
                                                </div>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div  class="tab-pane fade" id="projectManagement">
                                <div class="contentform">
                                    <!-- <div class="divTip">*为必填选项</div> -->
                                    <div class="formbody" >
                                        <div class="portlet-body form">
                                            <!-- BEGIN FORM-->
                                            <!--1--><form action="projectmanagement/createProjectManagement" class="form-horizontal" id="projectManagementForm"  method="post" target="iframe_display" >
                                                <input type="hidden" value="<%=token %>" id="token" name="token"/>   <!-- 作为hidden提交 -->
                                                <input type="hidden" id="sub_id" name="sub_id" value="${pd.subId}"/>
                                                <input type="hidden" id="quarterly_index" name="quarterly_index" value="${pd.quarterlyNum }" >
                                                <input type="hidden" id="id" name="id" >
                                                <input type="hidden" id="year" name="date_year" value="${pd.year}">
                                                <%--============================================= 项目管理情况 ==============================================--%>
                                                <div style="width:90%;margin:auto;">
                                                    <h3 class="text-center">项目（课题）管理情况统计表</h3>
                                                    <div class="row clear">
                                                        <div class="col-md-3 left text-center">项目(独立课题)名称:<span id="project_name2" class="subTxt"></span></div>
                                                        <div class="col-md-3 right text-center">统计时段:<span>${pd.time}</span></div>
                                                    </div>
                                                    <div class="">
                                                        <table class="table table-striped table-bordered smlProjectManager ">
                                                            <thead class="text-center">
                                                            <tr>
                                                                <td>序号</td>
                                                                <td>课题编号</td>
                                                                <td>课题名称</td>
                                                                <td>课题启动会是否召开</td>
                                                                <td>课题启动会召开时间</td>
                                                                <td>项目启动会是否召开</td>
                                                                <td>项目启动会召开时间</td>
                                                                <td>承担单位法人责任落实情况</td>
                                                                <td>项目内部交流与协作</td>
                                                            </tr>
                                                            </thead>
                                                            <tbody class="text-center" id="projectManage">

                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div style="width:80%;">
                                                        <p>其他情况说明：</p>
                                                        <div>
                                                            <textarea id="projectManagementContent" name="CONTENT" style="width:95%;height:100px;"></textarea>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <ul>
                                                            <li>注：</li>
                                                            <li>项目内部交流与协作:逐条填写组织召开的内部交流会，研讨会，形成了哪些工作简报，会议纪要等</li>
                                                        </ul>
                                                    </div>

                                                    <div class="form-actions" style="background-color:#fff;border:0">
                                                        <div class="" style="margin-top: 25px">
                                                            <c:if test="${read==null || read!='read'}">
                                                            <button type="submit" class="btn btn-primary mysubmit" style="width:100px;height:40px">保存</button>
                                                            </c:if>
                                                            <button type="button" class="btn btn-default" name="btnback" style="width:100px;height:40px"onclick="toManage()">返回</button>
                                                        </div>
                                                    </div>
                                                </div>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div  class="tab-pane fade" id="fininshed">
                                <div class="contentform">
                                    <!-- <div class="divTip">*为必填选项</div> -->
                                    <div class="formbody" >
                                        <div class="portlet-body form">
                                            <!-- BEGIN FORM-->
                                            <!--1--><form action="capitalManagement/createCapitalManagement" id="finManage"  method="post" onsubmit="return projectinfo()">
                                                <input type="hidden" value="<%=token %>" id="token" name="token"/>   <!-- 作为hidden提交 -->
                                                <input type="hidden" id="sub_id" name="sub_id" value="${pd.subId}"/>
                                                <input type="hidden" id="quarterly_index" name="quarterly_index" value="${pd.quarterlyNum }" >
                                                <input type="hidden" id="isAdd" name="isAdd" value="${pd.isAdd }" >
                                                <input type="hidden" id="year" name="year" value="${pd.year}">
                                                <input type="hidden" id="subject_name" name="subject_name" value="${pd.subject_name}">
                                                <%--=======================================   资金投入和管理情况 =========================================================--%>
                                                <div style="width:90%;margin:auto;">
                                                    <h3 class="text-center">资金投入和管理使用情况统计表</h3>
                                                    <div class="row clear" style="padding: 15px 0">
                                                        <div class="left text-center" style="margin-left: 15px;">项目(独立课题)名称:<span class="subTxt"></span></div>
                                                        <div class="right text-center">统计时段:<span>${pd.time}</span></div>
                                                    </div>
                                                    <div class="">
                                                        <table class="table table-striped table-bordered smlProjectManager">
                                                            <thead class="text-center">
                                                            <tr>
                                                                <td>序号</td>
                                                                <td>课题编号</td>
                                                                <td style="min-width:300px;">课题名称</td>
                                                                <td>中央财政预算(万元)</td>
                                                                <td>到位金额(万元)</td>
                                                                <td style="max-width:150px;">资金是否拨付至参与单位</td>
                                                                <td style="max-width:150px;">是否足额拨付</td>
                                                                <td style="min-width:240px;">未拨付/未足额拨付原因</td>
                                                                <td>当季支出金额(万元)</td>
                                                                <td>之前<span id="isTB">未填报</span>季度的总共累计支出金额(万元)</td>
                                                                <td>总累计支出金额(万元)</td>
                                                                <td>占到位资金的累计执行率（%)</td>
                                                                <td>占中央财政预算的累计执行率（%）</td>
                                                            </tr>
                                                            </thead>
                                                            <tbody class="text-center manage" id="projectCapital">
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div style="width:80%;">
                                                        <p>其他情况说明：</p>
                                                        <div id="capitalManagementContent">
                                                            <textarea name="REMARK" style="width:95%;height:100px;resizr:none;"></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="form-actions" style="background-color:#fff;border:0">
                                                        <div class="msubmitButton" style="padding-top: 15px;">
                                                            <c:if test="${read==null || read!='read'}">
                                                            <button type="submit" id="submitCapital" class="btn btn-primary mysubmit" style="width:auto;height:40px;">保存资金投入和管理</button>
                                                            </c:if>
                                                            <button type="button" class="btn btn-default" name="btnback" style="width:100px;height:40px"onclick="toManage()">返回</button>
                                                        </div>
                                                    </div>
                                                </div>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div  class="tab-pane fade" id="resultsSummary">
                                <div class="contentform">
                                    <!-- <div class="divTip">*为必填选项</div> -->
                                    <div class="formbody" >
                                        <div class="portlet-body form">
                                            <form action="capitalManagement/saveSummary" id="resSummary"  method="post">
                                                <input type="hidden" name="SUB_ID" value="${pd.subId}"/>
                                                <input type="hidden" name="YEAR" value="${pd.year}">
                                                <input type="hidden" name="QUARTER" value="${pd.quarterlyNum}">
                                                <div style="width:90%;margin:auto;">
                                                    <h3 class="text-center">成果成效小结</h3>
                                                    <div class="row clear" style="padding: 15px 0">
                                                        <div class="left text-center" style="margin-left: 15px;">项目(独立课题)名称:<span class="subTxt"></span></div>
                                                        <div class="right text-center">统计时段:<span>${pd.time}</span></div>
                                                    </div>
                                                    <div class="">
                                                        <table class="table table-striped table-bordered">
                                                            <thead class="text-center">
                                                                <tr>
                                                                    <td style="width: 5%">序号</td>
                                                                    <td style="width: 12%">项目（独立课题）编号</td>
                                                                    <td style="width: 30%">项目（独立课题）名称</td>
                                                                    <td>成果成效小结</td>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="summaryBodyd">
                                                                <tr>
                                                                    <td>1</td>
                                                                    <td><input name="PROJECT_NUMBER" value=编号></td>
                                                                    <td><input name="PROJECT_NAME" value="名称"></td>
                                                                    <td><textarea name="SUMMARY" onkeyup="" rows="3" cols="" ></textarea></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                        <p>注意：成果成效小结（技术研究进展、工程示范效果、推广应用情况、支撑地方管理情况等），内容要求简洁精炼，避免过程性描述，字数500字以内</p>

                                                    </div>
                                                    <div class="form-actions" style="background-color:#fff;border:0">
                                                        <div class="ssubmitButton" style="padding-top: 15px;">
                                                            <c:if test="${read==null || read!='read'}">
                                                                <button type="submit" id="summarySubmit" class="btn btn-primary mysubmit" style="width:auto;height:40px;">保存成果成效小结</button>
                                                            </c:if>
                                                            <button type="button" class="btn btn-default" name="btnback" style="width:100px;height:40px"onclick="toManage()">返回</button>
                                                        </div>
                                                        <%--<button type="button" class="btn btn-default" name="" style="width:100px;height:40px"onclick="uoUpload()">上传成果小结</button>--%>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- END EXAMPLE TABLE PORTLET-->
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" tabindex="-1" role="dialog" id="uploadModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">上传成果小结文件</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="upload_id">
                <div id="uploader" class="wu-example">
                    <!--用来存放文件信息-->
                    <div id="thelist" class="uploader-list"></div>
                    <div>
                        <div id="picker">
                            <button class="btn btn-info">选择文件</button>
                            <input type="file">
                        </div>
                        <button id="ctlBtn" class="btn btn-warning">开始上传</button>

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">关闭</button>
                <button id="upload_save" type="button" class="btn btn-sm btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<a href="javascript:;" class="page-quick-sidebar-toggler"><i class="icon-close"></i></a>
<script type="text/javascript" src="../../../../static/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="../../../../static/js/jquery-migrate-1.2.1.js"></script>
<%--<script type="text/javascript" src="../../../../static/ace/js/bootstrap.js"></script>--%>
<%--<script type="text/javascript" src="../../../../static/ace/js/bootstrap-datetimepicker.min.js"></script>--%>
<%--<script type="text/javascript" src="../../../../static/ace/js/bootstrap-datetimepicker.zh-CN.js"></script>--%>
<script src="../../../../js/laydate/laydate.js"></script>
<script type="text/javascript" src="../../../../js/progressReport/numeration.js"></script>
<script src="../../../../js/progressReport/progressReportList.js"  type="text/javascript"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>

<!-- webuploader上传插件js -->
<script type="text/javascript" src="plugins/webuploader/webuploader.js"></script>
<script>
    var basepath="<%=basePath%>";
    jQuery(document).ready(function() {
        var flag = $("#reportFlag").val();
        var createReportButton = document.getElementById("createReportButton");
        if(createReportButton!=null){
            if(flag=='false'){
                createReportButton.style.display = "none";
            }
        }
        showTable();
        bindTabEvent();
        // //判断是否已提交
        // if ($("#isActiviti").val() == "1") {
        //     disableAllInput();
        // }
    });
    //返回

    if(!window.localStorage){
        alert("浏览器支持localstorage");
    }else{
        var TitSub=window.localStorage.getItem("titSub");
        $(".subTxt").text(TitSub);
        // window.localStorage.clear();
    }
function toUpload() {
    $("#uploadModal").modal("show");
}
    function uploader() {
        var $ = jQuery,
            $list = $('#thelist'),
            $btn = $('#ctlBtn'),
            state = 'pending',
            uploader;
        $btn.attr("disabled","disabled");
        uploader = WebUploader.create({

            // swf文件路径
            swf: 'plugins/webuploader/Uploader.swf',

            // 文件接收服务端。
            server: '<%=basePath%>progressreportproject/uploadSummaryFile?SUB_ID='+$("#SUB_ID").val()+"&YEAR="+$("#YEAR").val()+"&QUARTER="+$("#QUARTER").val(),
            threads:'1',

            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: {id:'#picker',multiple:false},

            // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
            resize: false
        });

        // 当有文件被添加进队列的时候
        uploader.on( 'fileQueued', function( file ) {
            $list.append( '<div id="' + file.id + '" class="item">' +
                '<h4 class="info">' + file.name + '</h4>' +
                '<p class="state">等待上传...</p>' +
                '</div>' );
            $btn.removeAttr("disabled");
        });

        // 文件上传过程中创建进度条实时显示。
        uploader.on( 'uploadProgress', function( file, percentage ) {
            var $li = $( '#'+file.id ),
                $percent = $li.find('.progress .progress-bar');

            // 避免重复创建
            if ( !$percent.length ) {
                $percent = $('<div class="progress progress-striped active">' +
                    '<div class="progress-bar" role="progressbar" style="width: 0%">' +
                    '</div>' +
                    '</div>').appendTo( $li ).find('.progress-bar');
            }

            $li.find('p.state').text('上传中');

            $percent.css( 'width', percentage * 100 + '%' );
        });


        uploader.on( 'uploadSuccess', function( file ) {
            $( '#'+file.id ).find('p.state').text('已上传');
        });

        uploader.on( 'uploadError', function( file ) {
            $( '#'+file.id ).find('p.state').text('上传出错');
        });

        uploader.on( 'uploadComplete', function( file ) {
            $( '#'+file.id ).find('.progress').fadeOut();
        });

        uploader.on( 'all', function( type ) {
            if ( type === 'startUpload' ) {
                state = 'uploading';
            } else if ( type === 'stopUpload' ) {
                state = 'paused';
            } else if ( type === 'uploadFinished' ) {
                state = 'done';
            }

            if ( state === 'uploading' ) {
                $btn.text('暂停上传');
            } else {
                $btn.text('开始上传');
            }
        });
        $btn.on( 'click', function() {
            if ( state === 'uploading' ) {
                uploader.stop();
            } else {
                uploader.upload();
                $btn.attr("disabled","disabled");
                $btn.text('已上传');
            }
        });
    }

    function toManage(){
        var subId = $('#subId').val();
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
        if(userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1){
            window.navigate("progressreportproject.do?subId="+subId);//页面跳转
        }
        else if(userAgent.indexOf("Trident") > -1){
            window.navigate("progressreportproject.do?subId="+subId);//页面跳转
        }
        else{
            JavaScript:window.location.href = "progressreportproject/progressreportproject.do?subId="+subId;
        }
    }
    $(document).ready(function () {
        /**
            * 切换标签时提醒用户保存本页内容
            * @param null
            * @return
            * @author TH-CK
            * @date 2020/5/28 10:36
        */
        $("#myTab a").click(function (e) {

            var r=confirm("请确认是否已经保存本页内容，如果没有保存内容，离开本页后内容将丢失。是否离开本页？")
            if (r == true) {
                e.preventDefault();
                // $(this).tab("show");
                let href = $(this).attr("href");
                console.log($("#myTabContent "+href));
                $("#myTabContent "+href).addClass("active").addClass("in").siblings().removeClass("active").removeClass("in");
                $(this).parent().addClass("active").siblings().removeClass("active");
            }
            else {
                return false;
            }
        });

    })
</script>
</body>
</html>