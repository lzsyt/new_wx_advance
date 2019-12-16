<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../commons/global.jsp" %>

<html>
<head>
    <title>新增快递单</title>

    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" name="viewport"/>
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style"/>
    <meta content="telephone=no" name="format-detection"/>
    <link rel="stylesheet" href="${staticPath}/style/css/weui.css">
    <link rel="stylesheet" href="${staticPath}/style/css/weuix.css">

    <style>
        .ellipsis {
            overflow: hidden; /*自动隐藏文字*/
            text-overflow: ellipsis;/*文字隐藏后添加省略号*/
            white-space: nowrap;/*强制不换行*/
            width: 16em;/*不允许出现半汉字截断*/
        }
        body{
            font-size: 14px;
        }
        .m-cell{
            padding-top: 10px;
        }
    </style>
</head>
<body>



<section class="g-flexview">
    <div class="g-scrollview">


        <form name="serForm" action="${path}/saveAddSRBill" id="serForm" method="post"  onsubmit="return check()" enctype="multipart/form-data">
            <input name="search" value="${search}" type="hidden">
            <div class="m-cell demo-small-pitch">
                <div class="cell-item">
                    <div class="cell-left">快递公司：</div>
                    <div class="cell-right">
                        <input id="cpCode" name="cpCode"  type="text" class="cell-input"/>
                    </div>
                </div>
                <div class="cell-item">
                    <div class="cell-left">快递单号：</div>
                    <div class="cell-right">
                        <input id="expressNum" name="expressNum" type="text" class="cell-input"/>
                    </div>
                </div>

            </div>

            <div class="m-celltitle">商品详情</div>
            <div class="m-cell" id="contact_form">
                <%--发货商品--%>
                <div class="cell-item">
                    <div class="cell-left">发货商品：</div>
                    <div class="cell-right wrap">

                        <input id="txt_ide" name="tsrBillDetail[0].goodsName" type="text"  class="cell-input" />


                    </div>

                </div>
                <%--商品数量--%>
                <div class="cell-item">
                    <div class="cell-left">商品数量：</div>
                    <div class="cell-right "><input name="tsrBillDetail[0].goodsCount" type="number"  class="cell-input"/>


                    </div>
                </div>
                <%--产品状态--%>
                <div class="cell-item">
                    <div class="cell-left">产品状态：</div>
                    <label class="cell-right cell-arrow">
                        <input name="tsrBillDetail[0].status" type="text" class="cell-input"/>
                    </label>
                </div>



            </div>

            <a href="javascript:void(0);" class="weui-cell weui-cell_link">
                <div class="weui-cell__bd" onclick="addfrom()">添加商品</div>
            </a>


            <div class="m-cell">


                <div class="page-bd-15">


                    <div class="weui-uploader">
                        <div class="weui-uploader">

                            <div class="weui-uploader__hd">
                                <p class="weui-uploader__title">图片上传</p>
                            </div>
                            <div class="weui-uploader__bd">
                                <ul class="weui-uploader__files"  id="imgUl">
                                </ul>
                                <div class="weui-uploader__input-box">
                                    <input  id="imgUploaderInput" name="images" class="weui-uploader__input" accept="image/*" multiple="" type="file" onchange="echoimge()">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="weui-uploader">

                        <div class="weui-uploader__hd">
                            <p class="weui-uploader__title">视频上传</p>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="uploaderFiles">
                            </ul>
                            <div class="weui-uploader__input-box">
                                <input id="vdoUploaderInput" class="weui-uploader__input" type="file"
                                       name="vdos"
                                       accept="video/*" multiple="" onchange="echoVdo()">
                            </div>
                        </div>
                    </div>

                </div>


            <input type="submit" id="bnt" class="btn-block btn-primary"  value="提交"/>
            <input type="button" class="btn-block btn-warning" onclick="back()" id="sub" value="返回"/>
            </div>

        </form>
    </div>
</section>
<script type="text/javascript">
var check=function(){
    var cpCode = $("#cpCode").val();
    var expressNum = $("#expressNum").val();

    if(cpCode==""){
        console.log("cpCode:"+cpCode);

        $.toptip("快递公司不能为空");
        return false;
    }
    if(expressNum==""){

        $.toptip("快递单号不能为空");
        return false;

    }
    var flag=1;
    $.ajax({
        type: 'POST',
        async: false,
        url: "${path}/checkExpressNum",
        data: {"expressNum":expressNum},
        success: function (data) {
            if(data=="1"){
                //没有重复的快递单号
                $.toptip("快递单号不能重复");
                return;
            }
            flag=0;


        },
        dataType: "text"
    });
    console.log("flag:"+flag);

    if (flag==1){


        return false;
    }

        return true;


}




        function back() {
        location.href = "${path}/salesReturn?search=${search}";}


    function echoimge() {
        var f = document.getElementById('imgUploaderInput').files;
        var imageUl = $("#imgUl");
        for (var i = 0; i < f.length; i++) {
            var r = new FileReader();
            r.readAsDataURL(f[i]);
            r.onload = function (e) {
                var url = this.result;

                var imgLi = '<li  class="weui-uploader__file" style="background-image:url(' + url + ')"></li>';
                console.info(url);

                imageUl.append(imgLi);


            };
        }
    }

    function echoVdo() {
        var f = document.getElementById('vdoUploaderInput').files;
        var imageUl = $("#uploaderFiles");
        for (var i = 0; i < f.length; i++) {
            // var r = new FileReader();
            // r.readAsDataURL(f[i]);
            // r.onload = function (e) {
            //     console.info((f[i].name);
            //     var url = this.result;
            console.info(f[i].name);
            var string = '<li class="weui-uploader__file ellipsis">' + f[i].name + '</li>';
            imageUl.append(string);

            // };

        }
    }

    function addfrom() {
        var i=1;
        $("div[name='detail']").each(function () {
               i++;
        });
        var str = '<br/><div class="m-cell"  name="detail">\n' +
            '                <%--发货商品--%>\n' +
            '                <div class="cell-item">\n' +
            '                    <div class="cell-left">发货商品：</div>\n' +
            '                    <div class="cell-right"><input name="tsrBillDetail['+i+'].goodsName" type="text" class="cell-input"/></div>\n' +
            '                </div>\n' +
            '                <%--商品数量--%>\n' +
            '                <div class="cell-item">\n' +
            '                    <div class="cell-left">商品数量：</div>\n' +
            '                    <div class="cell-right"><input name="tsrBillDetail['+i+'].goodsCount" type="text" class="cell-input"/>\n' +
            '                    </div>\n' +
            '                </div>' +
            '                <%--产品状态--%>\n' +
            '                <div class="cell-item">\n' +
            '                    <div class="cell-left">产品状态：</div>\n' +
            '                    <label class="cell-right cell-arrow">\n' +
            '                        <input name="tsrBillDetail['+i+'].status" type="text" class="cell-input"/>\n' +
            '                    </label>\n' +
            '                </div>\n' +
            '                <%--检测情况--%>\n' +
            '                <div class="cell-item">\n' +
            '                    <div class="cell-left">检测情况：</div>\n' +
            '                    <div class="cell-right">\n' +
            '                        <input name="tsrBillDetail.detection" type="text" class="cell-input">\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>';
        $("#contact_form").append(str);}

</script>
<script src="${staticPath }/js/jquery.min.js"></script>
<script src="${staticPath }/js/zepto.min.js"></script>

<script src="${staticPath }/js/zepto.weui.js"></script>



</body>
</html>
