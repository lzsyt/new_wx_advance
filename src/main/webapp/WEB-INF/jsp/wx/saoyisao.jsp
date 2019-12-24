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
    $(function () {
        console.info("url:" + location.href.split('#')[0]);
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
        wx.config({
            debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: "wx8148352aa79f60c7", // 必填，公众号的唯一标识
            timestamp: timestamp, // 必填，生成签名的时间戳
            nonceStr: nonceStr, // 必填，生成签名的随机串
            signature: signature,// 必填，签名，见附录1
            jsApiList: ['scanQRCode'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
        });
        wx.ready(function(){
            console.info("wx.ready:");
        });
        wx.error(function(res) {
            console.info("wx.error:"+res.errMsg);
        });
    });
    $("#train_signStatus").click(function() {
        wx.scanQRCode({
            needResult : 1,
            scanType: ["qrCode"],
            success : function(res) {
                var result = res.resultStr;
                alert(result);
            },
            error: function (res) {
                alert(JSON.stringify(res))
                if (res.errMsg.indexOf('function_not_exist') > 0) {
                    alert('版本过低请升级')
                }
            }
        });
    });
</script>
</html>
