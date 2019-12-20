<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../commons/global.jsp" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<button id="train_signStatus">调用扫一扫</button>
</body>
<script src="http://res.wx.qq.com/open/js/jweixin-1.4.0.js"></script>
<script type="text/javascript">
    var timestamp = "";
    var nonceStr = "";
    var signature = "";
    <%--$.ajax({--%>
        <%--url:"${path}/getWxConfig",--%>
        <%--data:{},--%>
        <%--type:"POST",--%>
        <%--dataType:"json",--%>
        <%--async:false,--%>
        <%--cache:false,--%>
        <%--success:function(data){--%>
            <%--timestamp = data.wxConfig.timestamp;--%>
            <%--nonceStr = data.wxConfig.nonceStr;--%>
            <%--signature = data.wxConfig.signature;--%>
        <%--}--%>
    <%--});--%>

    $(function () {
        $.ajax({
            type: 'POST',
            async: false,
            url: "${path}/getWxConfig",
            data: {},
            success: function (data) {
                timestamp = data.wxConfig.timestamp;
                nonceStr = data.wxConfig.nonceStr;
                signature = data.wxConfig.signature;
            }
        });

    })
    console.info(timestamp);
    console.info(nonceStr);
    console.info(signature);
    wx.config({
        debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        appId: "wx8148352aa79f60c7", // 必填，公众号的唯一标识
        timestamp: '1576749283', // 必填，生成签名的时间戳
        nonceStr: '56b5351740d843c693cf2a32b89a9962', // 必填，生成签名的随机串
        signature: '13e98d1b0f7c1effb92f42934186cfc822c7f1fb',// 必填，签名，见附录1
        jsApiList: ['scanQRCode'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
    });
    console.info("config run()");
    wx.ready(function(){
        //验证成功
        console.info("wx.ready:"+res.errMsg);
        // alert("出错了：" + res.errMsg);
    });
    console.info("ready run()");
    wx.error(function(res) {
        console.info("wx.error:"+res.errMsg);
        // alert("出错了：" + res.errMsg);
    });
    console.info("error run()");



    $("#train_signStatus").click(function() {
        wx.scanQRCode({
            needResult : 1,
            desc : 'scanQRCode desc',
            success : function(res) {
                var result = res.resultStr;
                alert(result);
            }
        });
    });
</script>
</html>
