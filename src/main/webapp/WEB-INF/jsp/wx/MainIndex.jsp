<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        .myheight{
            height: fit-content;
        }
    </style>
</head>
<body>

<section class="g-flexview">
    <iframe src="${path}/${fristUrl}" name="myiframe" frameborder="0" width="100%" height="100%" scrolling="no" id="iframe"></iframe>

    <footer class="m-tabbar">

        <c:if test="${foot1}">
            <a href="${path}/getContent" class="tabbar-item" target="myiframe">
            <span class="tabbar-icon">
                <i class="icon-order"></i>
            </span>
                <span class="tabbar-txt">发货单</span>
            </a>
        </c:if>
        <c:if test="${foot2}">
            <a href="${path}/pwBillList" class="tabbar-item" target="myiframe">
            <span class="tabbar-icon">
                <i class="icon-feedback"></i>
            </span>
                <span class="tabbar-txt">采购订单</span>
            </a>
        </c:if>
        <a href="${path}/userInfo" class="tabbar-item" target="myiframe">
            <span class="tabbar-icon">
                <i class="icon-ucenter-outline"></i>
            </span>
            <span class="tabbar-txt">个人中心</span>
        </a>
    </footer>
</section>
<script>
    $("#iframe")[0].onload = function () {
        iosIframeWidthBug();
    };
    function iosIframeWidthBug() {
        if (!navigator.userAgent.match(/iPad|iPhone/i)) {
            return false;
        }
        var iframebody = document.getElementById('iframe').contentWindow.document.body;
        iframebody.style.width = document.body.clientWidth + 'px';
    }
</script>
</body>
</html>