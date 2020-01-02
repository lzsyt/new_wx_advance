
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../commons/global.jsp" %>
<html>
<head>
    <title>财务统计</title>
</head>
<body>
<!DOCTYPE html>
<html>
<head>
    <title>jQuery WeUI</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

    <meta name="description" content="">

    <link rel="stylesheet" href="${path}/static/lib/weui.min.css">
    <link rel="stylesheet" href="${path}/static/css/jquery-weui.css">
    <link rel="stylesheet" href="${path}/static/css/demos.css">

    <style>
        .placeholder {
            margin: 2px;
            padding: 0 2px;
            background-color: #fbfbff;
            height: 2.3em;
            line-height: 2.3em;
            text-align: center;
            color: #060606;
        }
    </style>
</head>

<body ontouchstart>
<div class="weui-flex">
    <div class="weui-flex__item"><div class="placeholder">店铺</div></div>
    <div class="weui-flex__item"><div class="placeholder">提现合计</div></div>
    <div class="weui-flex__item"><div class="placeholder">充值合计</div></div>
    <div class="weui-flex__item"><div class="placeholder">支出合计</div></div>
    <div class="weui-flex__item"><div class="placeholder">总计</div></div>
</div>

<c:forEach items="${details}" var="detail">
<div class="weui-flex">
    <div class="weui-flex__item"><div class="placeholder">${detail.shop}</div></div>
    <div class="weui-flex__item"><div class="placeholder">${detail.withdrawTotal}</div></div>
    <div class="weui-flex__item"><div class="placeholder">${detail.payTotal}</div></div>
    <div class="weui-flex__item"><div class="placeholder">${detail.expendTotal}</div></div>
    <div class="weui-flex__item"><div class="placeholder">${detail.sumTotal}</div></div>
</div>
</c:forEach>
<a href="javascript:;" onclick="reload()" class="weui-btn weui-btn_primary">刷新</a>
<script src="${path}/static/lib/jquery-2.1.4.js"></script>
<script src="${path}/static/lib/fastclick.js"></script>
<script>
    $(function() {
        FastClick.attach(document.body);
    });
    function reload(){
        location.reload()
    }

</script>
<script src="${path}/static/js/jquery-weui.js"></script>

</body>
</html>

</body>
</html>
