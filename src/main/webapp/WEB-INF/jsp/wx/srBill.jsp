<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../commons/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>进销存系统</title>

    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" name="viewport"/>
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style"/>
    <meta content="telephone=no" name="format-detection"/>
    <style>
        .cell-width {
            width: 80%;
        }
    </style>
</head>
<body>
<section class="g-flexview m-tab" data-ydui-tab>
    <div class="m-cell demo-small-pitch">
        <form id="searchForm" action="${path}/salesReturn" type="post">
            <div class="cell-item">
                <div class="cell-left cell-width">
                    <input type="text" id="search" value="${search}" name="search" class="cell-input"
                           placeholder="根据快递单号匹配" autocomplete="off"/>
                </div>
                <div class="cell-right">
                    <input type="submit" id="searchBtn" class="btn btn-primary" value="查询">&nbsp;&nbsp;&nbsp;
                    <a href="${path}/salesReturnAdd" class="btn btn-primary">新增</a>&nbsp;&nbsp;&nbsp;
                    <a href="${path}/img" target="_top" id="saoyisao" class="btn btn-primary">扫一扫</a>
                </div>
            </div>
        </form>
        <input type="hidden" value="${succeed}" id="succeed">
    </div>
    <ul class="tab-nav">
        <li class="tab-nav-item tab-active"><a href="javascript:;">全部</a></li>
        <li class="tab-nav-item"><a href="javascript:;">未处理</a></li>
        <li class="tab-nav-item"><a href="javascript:;">部分处理</a></li>
        <li class="tab-nav-item"><a href="javascript:;">已处理</a></li>
        <%--<li class="tab-nav-item"><a href="javascript:;">已入库</a></li>--%>
    </ul>

    <div class="g-scrollview">
        <div class="tab-panel">
            <div class="tab-panel-item tab-active">
                <div class="m-cell">
                    <c:forEach items="${srBills}" var="srBill">
                        <a href="${path}/salesReturnDetail/${srBill.id}?search=${search}" class="cell-item">

                            <div class="list-mes">
                                <div class="cell-left"> 退货单：${srBill.ref}</div>
                                <c:if test="${srBill.cpCode!=null and srBill.cpCode!=''}">
                                    <div class="list-mes-item"><span
                                            style="color: #0a95da">${srBill.cpCode}: ${srBill.expressNum}</span></div>
                                </c:if>
                                <div class="list-mes-item">
                                    <c:forEach items="${srBill.tsrBillDetail}" var="srDetail">
                                        ${srDetail.goodsName}* ${srDetail.goodsCount}&nbsp;&nbsp;&nbsp;
                                    </c:forEach>
                                </div>

                                <div class="list-mes-item">
                                    <fmt:formatDate value="${srBill.bizdt}" type="both"/>
                                </div>
                            </div>
                            <div class="cell-right cell-arrow">
                                <font style="color:red;">
                                    <c:if test="${srBill.billStatus==0}">未处理</c:if>
                                    <c:if test="${srBill.billStatus==1}">部分处理</c:if>
                                </font>
                                <c:if test="${srBill.billStatus==2}">已处理</c:if>
                                <c:if test="${srBill.billStatus==1000}">已入库</c:if>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
            <div class="tab-panel-item">
                <div class="m-cell">
                    <c:forEach items="${srBills}" var="srBill">
                        <c:if test="${srBill.billStatus==0}">
                            <a href="${path}/salesReturnDetail/${srBill.id}?search=${search}" class="cell-item">

                                <div class="list-mes">
                                    <div class="cell-left"> 退货单：${srBill.ref}</div>
                                    <c:if test="${srBill.cpCode!=null and srBill.cpCode!=''}">
                                        <div class="list-mes-item"><span
                                                style="color: #0a95da">${srBill.cpCode}: ${srBill.expressNum}</span>
                                        </div>
                                    </c:if>
                                    <div class="list-mes-item">
                                        <c:forEach items="${srBill.tsrBillDetail}" var="srDetail">
                                            ${srDetail.goodsName}* ${srDetail.goodsCount}&nbsp;&nbsp;&nbsp;
                                        </c:forEach>
                                    </div>

                                    <div class="list-mes-item">
                                        <fmt:formatDate value="${srBill.bizdt}" type="both"/>
                                    </div>
                                </div>
                                <div class="cell-right cell-arrow">
                                    <font style="color:red;">
                                        <c:if test="${srBill.billStatus==0}">未处理</c:if>
                                        <c:if test="${srBill.billStatus==1}">部分处理</c:if>
                                    </font>
                                    <c:if test="${srBill.billStatus==2}">已处理</c:if>
                                    <c:if test="${srBill.billStatus==1000}">已入库</c:if>
                                </div>
                            </a>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div class="tab-panel-item">
                <div class="m-cell">
                    <c:forEach items="${srBills}" var="srBill">
                        <c:if test="${srBill.billStatus==1}">
                            <a href="${path}/salesReturnDetail/${srBill.id}?search=${search}" class="cell-item">

                                <div class="list-mes">
                                    <div class="cell-left"> 退货单：${srBill.ref}</div>
                                    <c:if test="${srBill.cpCode!=null and srBill.cpCode!=''}">
                                        <div class="list-mes-item"><span
                                                style="color: #0a95da">${srBill.cpCode}: ${srBill.expressNum}</span>
                                        </div>
                                    </c:if>
                                    <div class="list-mes-item">
                                        <c:forEach items="${srBill.tsrBillDetail}" var="srDetail">
                                            ${srDetail.goodsName}* ${srDetail.goodsCount}&nbsp;&nbsp;&nbsp;
                                        </c:forEach>
                                    </div>

                                    <div class="list-mes-item">
                                        <fmt:formatDate value="${srBill.bizdt}" type="both"/>
                                    </div>
                                </div>
                                <div class="cell-right cell-arrow">
                                    <font style="color:red;">
                                        <c:if test="${srBill.billStatus==0}">未处理</c:if>
                                        <c:if test="${srBill.billStatus==1}">部分处理</c:if>
                                    </font>
                                    <c:if test="${srBill.billStatus==2}">已处理</c:if>
                                    <c:if test="${srBill.billStatus==1000}">已入库</c:if>
                                </div>
                            </a>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div class="tab-panel-item">
                <div class="m-cell">
                    <c:forEach items="${srBills}" var="srBill">
                        <c:if test="${srBill.billStatus==2}">
                            <a href="${path}/salesReturnDetail/${srBill.id}?search=${search}" class="cell-item">

                                <div class="list-mes">
                                    <div class="cell-left"> 退货单：${srBill.ref}</div>
                                    <c:if test="${srBill.cpCode!=null and srBill.cpCode!=''}">
                                        <div class="list-mes-item"><span
                                                style="color: #0a95da">${srBill.cpCode}: ${srBill.expressNum}</span>
                                        </div>
                                    </c:if>
                                    <div class="list-mes-item">
                                        <c:forEach items="${srBill.tsrBillDetail}" var="srDetail">
                                            ${srDetail.goodsName}* ${srDetail.goodsCount}&nbsp;&nbsp;&nbsp;
                                        </c:forEach>
                                    </div>

                                    <div class="list-mes-item">
                                        <fmt:formatDate value="${srBill.bizdt}" type="both"/>
                                    </div>
                                </div>
                                <div class="cell-right cell-arrow">
                                    <font style="color:red;">
                                        <c:if test="${srBill.billStatus==0}">未处理</c:if>
                                        <c:if test="${srBill.billStatus==1}">部分处理</c:if>
                                    </font>
                                    <c:if test="${srBill.billStatus==2}">已处理</c:if>
                                    <c:if test="${srBill.billStatus==1000}">已入库</c:if>
                                </div>
                            </a>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</section>
<script src="${staticPath }/static/js/ydui.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.4.0.js"></script>
<script type="application/javascript">
    $(function () {
        var succeed = $("#succeed").val();
        console.info("succeed:" + succeed);
        if (succeed!=null&&succeed!=''){
            if (succeed) {
                alert("操作成功");
            } else {
                alert("操作失败");
            }
        }
    });

    $('#search').bind('keypress', function (event) {   //回车事件绑定 
        if (event.keyCode == "13") {  //js监测到为为回车事件时 触发
            var form = document.getElementById('searchForm');
            form.submit();
        }
    });
    $("#searchBtn").click(function () {
        console.info("sub")
        var form = document.getElementById('searchForm');
        form.submit();
    });

</script>
</body>
</html>