<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../commons/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>发货单详情</title>

    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" name="viewport"/>
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style"/>
    <meta content="telephone=no" name="format-detection"/>

</head>
<body>
<section class="g-flexview">


    <div class="g-scrollview">
        <form name="serForm" action="${path}/saveWsBill" id="serForm" method="post" enctype="multipart/form-data">
            <input name="search" value="${search}" type="hidden">
            <div class="m-cell demo-small-pitch">
                <div class="cell-item">
                    <div class="cell-left">订单号：</div>
                    <div class="cell-right">${wsBill.shopNum}<input name="id" type="hidden" value="${wsBill.id}"></div>
                </div>


                <div class="cell-item">
                    <div class="cell-left">收货地址：</div>
                    <div class="cell-right">${wsBill.dealAddress}</div>
                </div>
                <div class="cell-item">
                    <div class="cell-left">收货人：</div>
                    <div class="cell-right">${customer.name}</div>
                </div>
                <div class="cell-item">
                    <div class="cell-left">手机号：</div>
                    <div class="cell-right">${customer.mobile01}</div>
                </div>
                <div class="cell-item">
                    <div class="cell-left">备注：</div>
                    <div class="cell-right">${wsBill.memo}</div>
                </div>
                <%--总订单的物流单号，有就显示--%>
                <c:if test="${!empty wsBill.expressNum && !empty wsBill.expressCompany}">
                    <div class="cell-item">
                        <div class="cell-left">快递公司：</div>
                        <div class="cell-right">
                            <input type="text"  value="${wsBill.expressCompany}"
                                   class="cell-input"/>
                        </div>

                    </div>
                    <div class="cell-item">
                        <div class="cell-left">发货单号：</div>
                        <div class="cell-right">
                            <input type="text"  value="${wsBill.expressNum}" class="cell-input"/>
                        </div>
                    </div>
                </c:if>
            </div>
            <div class="m-celltitle">发货内容</div>

            <c:forEach items="${goodsList}" var="goods" varStatus="status">
                <div class="m-cell">
                    <label class="cell-item">
                        <span class="cell-left">${goods.goodsName}</span>
                        <label class="cell-right">
                                <%--多选框--%>
                            <c:if test="${wsBill.billStatus==1000||wsBill.billStatus==3001}">
                                <c:if test="${empty  goods.expressCompany}">
                                    <input type="checkbox" id="checkbox" name="checkbox" value="${goods.id}"/>
                                    <i class="cell-checkbox-icon"></i>
                                </c:if>
                            </c:if>
                            <c:if test="${wsBill.billStatus==3000}">
                                <%--<c:if test="${!empty  goods.expressCompany}">--%>
                                <span style="color: #ff5366">已发货</span>
                                <%--</c:if>--%>
                            </c:if>
                            <c:if test="${wsBill.billStatus==3001}">
                                <c:if test="${!empty  goods.expressCompany}">
                                    <span style="color: #ff5366">已发货</span>
                                </c:if>
                            </c:if>
                        </label>
                    </label>
                    <a class="cell-item" href="javascript:;">
                        <div class="cell-left"><i class="cell-icon icon-order"></i>个数</div>
                        <div class="cell-right cell-arrow">${goods.goodsCount} ${goods.unitName}</div>
                    </a>
                    <a class="cell-item" href="javascript:;">
                        <div class="cell-left"></i>发货仓库</div>
                        <div class="cell-right cell-arrow">${goods.warehouse} </div>
                    </a>
                    <c:if test="${!empty  goods.expressCompany}">
                        <a class="cell-item" href="javascript:;">
                            <div class="cell-left">快递公司</div>
                            <div class="cell-right cell-arrow">${goods.expressCompany}</div>
                        </a>
                        <a class="cell-item" href="javascript:;">
                            <div class="cell-left">快递单号</div>
                            <div class="cell-right cell-arrow">${goods.expressNum}</div>
                        </a>
                        <c:if test="${!empty goods.filePath}">
                            <a class="cell-item" href="javascript:;">
                                <div class="cell-left">产品图片</div>
                                <div class="cell-right cell-arrow">
                                    <img style="height:100px;width:100px" src="${path}/static${goods.filePath}">
                                </div>
                            </a>
                        </c:if>
                    </c:if>
                </div>
            </c:forEach>

            <div class="m-cell demo-small-pitch">
                <%--<c:if test="${wsBill.billStatus==3000}">--%>

                <%--<div class="cell-item">--%>
                <%--<div class="cell-left">快递公司：</div>--%>
                <%--<div class="cell-right">--%>
                <%--<input type="text" name="expressCompany"--%>
                <%--value="${wsBill.expressCompany}" class="cell-input" disabled/>--%>
                <%--</div>--%>

                <%--</div>--%>
                <%--<div class="cell-item">--%>
                <%--<div class="cell-left">发货单号：</div>--%>
                <%--<div class="cell-right">--%>
                <%--<input type="text" name="expressNum" value="${wsBill.expressNum}"--%>
                <%--class="cell-input" disabled/></div>--%>
                <%--</div>--%>

                <%--<div class="cell-item">--%>
                <%--<div class="cell-left">--%>
                <%--<c:if test="${not empty wsBill.filePath}">--%>
                <%--<img id="expressImg" src="${path}/static${wsBill.filePath}">--%>
                <%--</c:if>--%>
                <%--</div>--%>
                <%--<div class="cell-right"></div>--%>
                <%--</div>--%>
                <%--</c:if>--%>
                <c:if test="${wsBill.billStatus==1000||wsBill.billStatus==3001}">
                    <div class="cell-item">
                        <div class="cell-left">快递公司：</div>
                        <div class="cell-right">
                            <input type="text" name="expressCompany" id="expressCompany" value="" class="cell-input"/>
                        </div>

                    </div>
                    <div class="cell-item">
                        <div class="cell-left">发货单号：</div>
                        <div class="cell-right">
                            <input type="text" name="expressNum" id="expressNum" value="" class="cell-input"/></div>
                    </div>

                    <div class="cell-item">
                        <div class="cell-left">
                            <c:if test="${not empty wsBill.filePath}">
                                <img id="expressImg" src="${path}/static${wsBill.filePath}">
                            </c:if>
                        </div>
                        <div class="cell-right">
                            <input type="file" name="fileName" id="fileName" value="上传"/>
                            <input type="hidden" name="file"/>
                        </div>
                    </div>
                </c:if>
            </div>

            <c:if test="${wsBill.billStatus==1000||wsBill.billStatus==3001}">
                <input type="button" class="btn-block btn-primary" onclick="check()" id="sub" value="提交"/>
            </c:if>
            <input type="button" class="btn-block btn-warning" onclick="back()" id="sub" value="返回"/>
        </form>
    </div>

    <%@ include file="../commons/global.jsp" %>
</section>
<script type="application/javascript">
    function back() {
        location.href = "${path}/getContent?search=${search}";
    }

    function check() {
        var dialog = window.YDUI.dialog;
        var expressCompany = $("#expressCompany").val();
        var expressNum = $("#expressNum").val();
        var fileName = $("#fileName").val();
        var checkbox = $('input[type=checkbox]:checked').length;
        console.log(checkbox);
        console.log(checkboxIsNull());
        var form = document.serForm;
        console.log("fileName:" + fileName);
        var flag = 0;

        if (isNull(fileName) && isNull(expressNum) && isNull(expressCompany)) {
            dialog.alert("请填写或者上传单号");
            return false;
        } else if (isNull(expressNum) && !isNull(expressCompany)) {
            dialog.alert("请填写单号");
            return false;
        } else if (!isNull(expressNum) && isNull(expressCompany)) {
            dialog.alert("请填写快递公司");
            return false;
        } else if (checkboxIsNull()) {
            // var flag=confirm("你没有选择订单，是否全选")
            // if(flag){
            //     chexboxIsTrue()
            // }else{
            //     return false;
            // }
            console.log("------------------------------------------------")
            dialog.confirm("是否确认整单发货？", function () {
                $("input[name='checkbox']").attr("checked", "true");
                form.submit();
            });
            return false;
        }

        dialog.confirm("确定提交发货信息？", function () {
            form.submit();
        });
        return false;

    }

    function isNull(str) {
        if (str == null || $.trim(str) == "") {
            return true;
        }
        return false;
    }

    function checkboxIsNull() {
        var flag = $('input[type=checkbox]:checked').length;
        if (flag == 0) {
            return true;
        }
        return false;
    }

</script>


</body>
</html>