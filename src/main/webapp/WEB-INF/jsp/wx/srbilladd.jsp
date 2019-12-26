<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../commons/global.jsp" %>

<html>
<head>
    <title>新增快递单</title>

    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" name="viewport"/>
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style"/>
    <meta content="telephone=no" name="format-detection"/>
    <%--<link rel="stylesheet" href="${staticPath}/style/css/weui.css">--%>
    <%--<link rel="stylesheet" href="${staticPath}/style/css/weuix.css">--%>
    <link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.3/style/weui.min.css">
    <style>
        .ellipsis {
            overflow: hidden; /*自动隐藏文字*/
            text-overflow: ellipsis; /*文字隐藏后添加省略号*/
            white-space: nowrap; /*强制不换行*/
            width: 16em; /*不允许出现半汉字截断*/
        }

        body {
            font-size: 14px;
        }

        .m-cell {
            padding-top: 10px;
        }

        .page-bd-15 {
            padding-left: 0.24rem;
        }
    </style>
</head>
<body>


<section class="g-flexview">
    <div class="g-scrollview">


        <form name="serForm" action="${path}/saveAddSRBill" id="serForm" method="post" onsubmit="return check()"
              enctype="multipart/form-data">
            <input name="search" value="${search}" type="hidden">
            <div class="m-cell demo-small-pitch">
                <div class="cell-item">
                    <div class="cell-left">快递公司：</div>
                    <div class="cell-right">
                        <input id="cpCode" name="cpCode" type="text" class="cell-input"/>
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
                        <input id="txt_ide" name="tsrBillDetail[0].goodsName" type="text" class="cell-input"/>
                    </div>
                </div>
                <%--商品数量--%>
                <div class="cell-item">
                    <div class="cell-left">商品数量：</div>
                    <div class="cell-right ">
                        <input name="tsrBillDetail[0].goodsCount" type="number" class="cell-input"/>
                    </div>
                </div>
                <%--产品状态--%>
                <div class="cell-item">
                    <div class="cell-left">产品状态：</div>
                    <div class="cell-right">
                        <select name="tsrBillDetail[0].status" class="cell-select">
                            <option value="好">好</option>
                            <option value="坏">坏</option>
                            <option value="电池坏">电池坏</option>
                        </select>
                    </div>
                </div>
            </div>

            <a href="javascript:void(0);" class="weui-cell weui-cell_link">
                <div class="weui-cell__bd" onclick="addfrom()">添加商品</div>
            </a>


            <div class="m-cell">
                <div class="page-bd-15">
                    <div class="weui-uploader">
                        <div class="weui-uploader__hd">
                            <p class="weui-uploader__title">图片上传</p>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="uploaderFiles">
                            </ul>
                            <div class="weui-uploader__input-box" id="inputbox">
                                <input id="uploaderInput0" class="weui-uploader__input"
                                       name="images[0]" type="file" accept="image/*" multiple="">
                            </div>
                        </div>
                    </div>

                    <div class="weui-uploader">

                        <div class="weui-uploader__hd">
                            <p class="weui-uploader__title">视频上传</p>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="vdoUploaderFiles">
                            </ul>
                            <div class="weui-uploader__input-box">
                                <input id="vdoUploaderInput" class="weui-uploader__input" type="file"
                                       name="vdos"
                                       accept="video/*" multiple="" onchange="echoVdo()">
                            </div>
                        </div>
                    </div>

                </div>


                <input type="submit" id="bnt" class="btn-block btn-primary" value="提交"/>
                <input type="button" class="btn-block btn-warning" onclick="back()" id="sub" value="返回"/>
                <%--<a href="${path}/img">扫一扫</a>--%>
            </div>

        </form>
    </div>
    <div class="weui-gallery" id="gallery">
        <span class="weui-gallery__img" id="galleryImg"></span>
        <div class="weui-gallery__opr">
            <a href="javascript:" rel="external nofollow" class="weui-gallery__del">
                <i class="weui-icon-delete weui-icon_gallery-delete"></i>
            </a>
        </div>
    </div>
</section>
<%@ include file="../commons/global.jsp" %>
<script type="text/javascript">
    var check = function () {
        var cpCode = $("#cpCode").val();
        var expressNum = $("#expressNum").val();
        if (cpCode == "") {
            console.log("cpCode:" + cpCode);
            $.toptip("快递公司不能为空");
            return false;
        }
        if (expressNum == "") {
            $.toptip("快递单号不能为空");
            return false;
        }
        var flag = 1;
        $.ajax({
            type: 'POST',
            async: false,
            url: "${path}/checkExpressNum",
            data: {"expressNum": expressNum},
            success: function (data) {
                if (data == "1") {
                    //没有重复的快递单号
                    $.toptip("快递单号不能重复");
                    return;
                }
                flag = 0;
            },
            dataType: "text"
        });
        console.log("flag:" + flag);
        if (flag == 1) {
            return false;
        }
        return true;
    }


    function back() {
        location.href = "${path}/salesReturn?search=${search}";
    }
    function echoVdo() {
        var f = document.getElementById('vdoUploaderInput').files;
        var imageUl = $("#vdoUploaderFiles");
        for (var i = 0; i < f.length; i++) {
            console.info(f[i].name);
            var string = '<li class="weui-uploader__file ellipsis">' + f[i].name + '<br>' +
                '<button onclick="delVdo(this)"  type="button" style="width: 79px;">删除</button></li>';
            imageUl.append(string);
        }
    }

    function delVdo(obj) {
        $(obj).parent().remove();
    }

    function addfrom() {
        var i = 1;
        $("div[name='detail']").each(function () {
            i++;
        });
        var str = '<br/><div class="m-cell" name="detail">\n' +
            '                <%--发货商品--%>\n' +
            '                <div class="cell-item">\n' +
            '                    <div class="cell-left">发货商品：</div>\n' +
            '                    <div class="cell-right wrap">\n' +
            '                        <input id="txt_ide" name="tsrBillDetail[' + i + '].goodsName" type="text" class="cell-input"/>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '                <%--商品数量--%>\n' +
            '                <div class="cell-item">\n' +
            '                    <div class="cell-left">商品数量：</div>\n' +
            '                    <div class="cell-right ">\n' +
            '                        <input name="tsrBillDetail[' + i + '].goodsCount" type="number" class="cell-input"/>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '                <%--产品状态--%>\n' +
            '                <div class="cell-item">\n' +
            '                    <div class="cell-left">产品状态：</div>\n' +
            '                    <div class="cell-right">\n' +
            '                        <select name="tsrBillDetail[' + i + '].status" class="cell-select">\n' +
            '                            <option value="好">好</option>\n' +
            '                            <option value="坏">坏</option>\n' +
            '                            <option value="电池坏">电池坏</option>\n' +
            '                        </select>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>';
        $("#contact_form").append(str);
    }


    $(function () {
        var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#)"></li>',
            $gallery = $("#gallery"),
            $galleryImg = $("#galleryImg"),
            $uploaderFiles = $("#uploaderFiles");


        var imageIndex = 0;

        function jsFileChange(event) {
            console.info("jsFileChange run")
            var src, url = window.URL || window.webkitURL || window.mozURL,
                files = event.target.files;
            for (var i = 0, len = files.length; i < len; ++i) {
                var file = files[i];
                if (url) {
                    src = url.createObjectURL(file);
                } else {
                    src = event.target.result;
                }
                $uploaderFiles.append($(tmpl.replace('#url#', src)));
            }
            $("#uploaderInput" + imageIndex).css('display', 'none');
            imageIndex++;
            var imgInputStr = '<input id="uploaderInput' + imageIndex + '" class="weui-uploader__input" name="images[' + imageIndex + ']" type="file" accept="image/*" multiple="">';
            $("#inputbox").append(imgInputStr);
            $("#uploaderInput" + imageIndex).on("change", jsFileChange);
        }


        $("#uploaderInput0").on("change", jsFileChange);

        var index; //第几张图片
        $uploaderFiles.on("click", "li", function () {
            index = $(this).index();
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
            $("#inputbox input:eq(" + index + ")").remove();
        });
        $gallery.on("click", function () {
            $gallery.fadeOut(100);
        });

        //删除图片 删除图片的代码也贴出来。
        $(".weui-gallery__del").click(function () {
            console.log('删除');
            $uploaderFiles.find("li").eq(index).remove();
        });
    });

</script>
<%--<script src="${staticPath }/js/jquery.min.js"></script>--%>
<%--<script src="${staticPath }/js/zepto.min.js"></script>--%>

<%--<script src="${staticPath }/js/zepto.weui.js"></script>--%>

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.1/js/jquery-weui.min.js"></script>
</body>
</html>