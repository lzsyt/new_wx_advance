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
                    <a href="javascript:;" id="searchBtn" class="btn btn-primary">查询</a>&nbsp;&nbsp;&nbsp;
                    <a href="javascript:;" id="addBtn" class="btn btn-primary">新增</a>
                    <%--&nbsp;&nbsp;&nbsp;<a href="${path}/img" id="saoyisao" class="btn btn-primary">扫一扫</a>--%>
                    &ndash;
                </div>
            </div>
        </form>
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
                                    <div class="list-mes-item"><span style="color: #0a95da">${srBill.cpCode}: ${srBill.expressNum}</span></div>
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
                                        <div class="list-mes-item"><span style="color: #0a95da">${srBill.cpCode}: ${srBill.expressNum}</span></div>
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
                                        <div class="list-mes-item"><span style="color: #0a95da">${srBill.cpCode}: ${srBill.expressNum}</span></div>
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
                                        <div class="list-mes-item"><span style="color: #0a95da">${srBill.cpCode}: ${srBill.expressNum}</span></div>
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
            <%--已入库--%>
            <%--<div class="tab-panel-item">--%>
                <%--<div class="m-cell">--%>
                    <%--<c:forEach items="${srBills}" var="srBill">--%>
                        <%--<c:if test="${srBill.billStatus==1000}">--%>
                            <%--<a href="${path}/salesReturnDetail/${srBill.id}?search=${search}" class="cell-item">--%>

                                <%--<div class="list-mes">--%>
                                    <%--<div class="cell-left"> 退货单：${srBill.ref}</div>--%>
                                    <%--<c:if test="${srBill.cpCode!=null and srBill.cpCode!=''}">--%>
                                        <%--<div class="list-mes-item"><span style="color: #0a95da">${srBill.cpCode}: ${srBill.expressNum}</span></div>--%>
                                    <%--</c:if>--%>
                                    <%--<div class="list-mes-item">--%>
                                        <%--<c:forEach items="${srBill.tsrBillDetail}" var="srDetail">--%>
                                            <%--${srDetail.goodsName}* ${srDetail.goodsCount}&nbsp;&nbsp;&nbsp;--%>
                                        <%--</c:forEach>--%>
                                    <%--</div>--%>

                                    <%--<div class="list-mes-item">--%>
                                        <%--<fmt:formatDate value="${srBill.bizdt}" type="both"/>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<div class="cell-right cell-arrow">--%>
                                    <%--<font style="color:red;">--%>
                                        <%--<c:if test="${srBill.billStatus==0}">未处理</c:if>--%>
                                        <%--<c:if test="${srBill.billStatus==1}">部分处理</c:if>--%>
                                    <%--</font>--%>
                                    <%--<c:if test="${srBill.billStatus==2}">已处理</c:if>--%>
                                    <%--<c:if test="${srBill.billStatus==1000}">已入库</c:if>--%>
                                <%--</div>--%>
                            <%--</a>--%>
                        <%--</c:if>--%>
                    <%--</c:forEach>--%>

                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    </div>
    <%--<jsp:include   page="footer.jsp" flush="true"/>--%>
</section>
<script src="${staticPath }/static/js/ydui.js"></script>

<script type="application/javascript">


    $(function () {
        // $("#search").bind('input change',function () {
        //     var text = $('#search').val();
        //     // $('#search').val(text.replace(/[^\d]/g,''))
        //     $("#searchForm").submit();
        // })
        $('#search').bind('keypress', function (event) {   //回车事件绑定 
            if (event.keyCode == "13") {  //js监测到为为回车事件时 触发
                var form = document.getElementById('searchForm');
                form.submit();
            }
        });
        $("#searchBtn").click(function () {
            var form = document.getElementById('searchForm');
            form.submit();
        })
        $("#addBtn").click(function () {
            console.info("$(\"#addBtn\").click");
            location.href='salesReturnAdd'
        })
    })

</script>
<style>
    .cell-width {
        width: 80%;
    }
</style>


</body>
</html>