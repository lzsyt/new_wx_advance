<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../commons/global.jsp" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.3/style/weui.min.css">
</head>
<body>
<div class="weui-loadmore">
    <i class="weui-loading"></i>
    <span class="weui-loadmore__tips">正在加载</span>
</div>
<%--<button id="train_signStatus" class="btn-block btn-primary">调用扫一扫</button>--%>
</body>
<script src="http://res.wx.qq.com/open/js/jweixin-1.4.0.js"></script>
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.1/js/jquery-weui.min.js"></script>
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
            success: function (data) {
                // timestamp = data.wxConfig.timestamp;
                // nonceStr = data.wxConfig.nonceStr;
                // signature = data.wxConfig.signature;
                wx.config({
                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: "wx8148352aa79f60c7", // 必填，公众号的唯一标识
                    timestamp: data.wxConfig.timestamp, // 必填，生成签名的时间戳
                    nonceStr: data.wxConfig.nonceStr, // 必填，生成签名的随机串
                    signature: data.wxConfig.signature,// 必填，签名，见附录1
                    jsApiList: ['scanQRCode'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                });
                wx.ready(function () {
                    // console.info("wx.ready:");
                    // wx.checkJsApi({
                    //     jsApiList: ['scanQRCode'],
                    //     success: function (res) {
                    //     }
                    // });
                    wx.scanQRCode({
                        needResult: 1,
                        scanType: ["qrCode"],
                        success: function (res) {
                            console.log(res)
                            //扫描返回的数据
                            var result = res.resultStr;
                            console.info(result)
                            location.href = "${path}/saoyisaoSear?expressNum=" + result;
                        },
                        fail: function (res) {
                            console.info("res:" + res);
                        }
                    });
                });
                wx.error(function (res) {
                    console.info("wx.error:" + res.errMsg);
                });
            }
        });
    });


    function saoyisao(){
        wx.scanQRCode({
            needResult: 1,
            scanType: ["qrCode"],
            success: function (res) {
                console.log(res)
                //扫描返回的数据
                var result = res.resultStr;
                console.info(result)
                location.href = "${path}/saoyisaoSear?expressNum=" + result;
            },
            fail: function (res) {
                console.info("res:" + res);
            }
        });
    }
    $("#train_signStatus").click(function () {
        saoyisao();
    });
</script>
</html>
