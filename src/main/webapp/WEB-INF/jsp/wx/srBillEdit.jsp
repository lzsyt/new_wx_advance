<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../commons/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>退货单详情</title>

    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" name="viewport"/>
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style"/>
    <meta content="telephone=no" name="format-detection"/>
    <%--<link rel="stylesheet" href="${staticPath}/style/css/weui.css">--%>
    <%--<link rel="stylesheet" href="${staticPath}/style/css/weuix.css">--%>
    <link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.3/style/weui.min.css">
    <style>

        .m-cell {
            padding-top: 10px;
        }

        .page-bd-15 {
            padding-left: 0.24rem;
        }

        .ellipsis {
            overflow: hidden; /*自动隐藏文字*/
            text-overflow: ellipsis; /*文字隐藏后添加省略号*/
            width: 16em; /*不允许出现半汉字截断*/
        }

        body {
            font-size: 14px;
        }
    </style>
</head>
<body>
<section class="g-flexview">
    <div class="g-scrollview">
        <form name="serForm" action="${path}/saveSRBill" id="serForm" method="post" enctype="multipart/form-data">
            <input name="search" value="${search}" type="hidden">

            <div class="m-cell demo-small-pitch">
                <input name="id" type="hidden" value="${srBill.id}">

                <c:if test="${not empty srBill.id}">
                    <div class="cell-item">
                        <div class="cell-left">订单号：</div>
                        <div class="cell-right">${srBill.tid}</div>
                    </div>
                    <div class="cell-item">
                        <div class="cell-left">退货原因：</div>
                        <div class="cell-right">${srBill.reason}</div>
                    </div>
                    <div class="cell-item">
                        <div class="cell-left">所属店铺：</div>
                        <div class="cell-right">${srBill.customerName}</div>
                    </div>
                    <div class="cell-item">
                        <div class="cell-left">客户ID：</div>
                        <div class="cell-right">${srBill.buyerNick}</div>
                    </div>
                    <div class="cell-item">
                        <div class="cell-left">售后状态：</div>
                        <div class="cell-right">
                            <c:if test="${srBill.maintainSale ==1}">维修</c:if>
                            <c:if test="${srBill.maintainSale ==2}">退货</c:if></div>
                    </div>
                    <div class="cell-item">
                        <div class="cell-left">备注：</div>
                        <div class="cell-right">${srBill.memo}</div>
                    </div>
                </c:if>

                <!--<editor-fold desc="快递公司和快递信息">-->
                <div class="cell-item">
                    <div class="cell-left">快递公司：</div>
                    <div class="cell-right">
                        ${srBill.cpCode}
                    </div>
                </div>
                <div class="cell-item">
                    <div class="cell-left">退货快递单号：</div>
                    <div class="cell-right">
                        ${srBill.expressNum}
                    </div>
                </div>
                <!--</editor-fold>-->
            </div>
            <c:if test="${billDetailList!=null && billDetailList.size()!=0}">
                <div class="m-celltitle">详情</div>
            </c:if>
            <c:forEach items="${billDetailList}" var="billDetail" varStatus="status">
                <div class="m-cell">


                    <input name="tsrBillDetail[${status.index}].id" value="${billDetail.id}" type="hidden">
                        <%--发货商品--%>
                    <div class="cell-item">
                        <div class="cell-left">发货商品：</div>
                        <div class="cell-right">${billDetail.goodsName} * <fmt:formatNumber type="number"
                                                                                            value="${billDetail.goodsCount}"
                                                                                            maxFractionDigits="0"
                                                                                            pattern="0"/>
                        </div>
                    </div>
                        <%--产品状态--%>
                    <div class="cell-item">
                        <div class="cell-left">产品状态：</div>
                        <div class="cell-right">
                            <c:if test="${billDetail.status ==null||billDetail.status ==''}">
                                <div class="cell-right">
                                <select name="tsrBillDetail[${status.index}].status" class="cell-select">
                                    <option value="1">好</option>
                                    <option value="2">坏</option>
                                    <option value="3">电池</option>
                                </select>
                                </div>
                            </c:if>

                            <c:if test="${billDetail.status !=null && billDetail.status !=''}">
                                <c:choose >
                                    <c:when test="${billDetail.status =='1'}">
                                        <div class="cell-right"><input name="tsrBillDetail[${status.index}].status" value="1" class="cell-input">好</div>
                                    </c:when>
                                    <c:when test="${billDetail.status =='2'}">
                                        <div class="cell-right"><input name="tsrBillDetail[${status.index}].status" value="2" class="cell-input">坏</div>
                                    </c:when>
                                    <c:when test="${billDetail.status =='3'}">
                                        <div class="cell-right"><input name="tsrBillDetail[${status.index}].status" value="3" class="cell-input">电池</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="cell-right"><input type="hidden" name="tsrBillDetail[${status.index}].status" value="${billDetail.status}" class="cell-input">${billDetail.status}</div>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>

                        </div>
                    </div>
                        <%--检测情况--%>
                    <div class="cell-item">
                        <div class="cell-left">检测情况：</div>
                        <c:if test="${billDetail.detection ==null || billDetail.detection ==''}">
                            <div class="cell-right">
                                <input name="tsrBillDetail[${status.index}].detection"
                                       type="text" class="cell-input" value=""/>
                            </div>
                        </c:if>
                        <c:if test="${billDetail.detection !=null && billDetail.detection !=''}">
                            <div class="cell-right">
                                <input name="tsrBillDetail[${status.index}].detection"
                                       type="hidden" class="cell-input" value="${billDetail.detection}"/>
                                    ${billDetail.detection}
                            </div>
                        </c:if>
                    </div>


                </div>
            </c:forEach>

            <%--未处理--%>
            <c:if test="${srBill.billStatus==1||srBill.billStatus==0}">
            <div class="m-cell">
                <div class="page-bd-15">
                    <div class="weui-uploader">
                        <div class="weui-uploader__hd">
                            <p class="weui-uploader__title">图片上传</p>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="uploaderFiles">
                            </ul>
                            <div class="weui-uploader__input-box">
                                <input id="uploaderInput" class="weui-uploader__input"
                                       name="images" type="file" accept="image/*" multiple="">
                            </div>
                        </div>
                    </div>

                    <div class="weui-uploader">
                        <div class="weui-uploader__hd">
                            <p class="weui-uploader__title">视频上传</p>
                                <%--<div class="weui-uploader__info" id="vdoDel">删除</div>--%>
                        </div>
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files" id="vdoFiles">
                            </ul>
                            <div class="weui-uploader__input-box">
                                <input id="vdoUploaderInput" class="weui-uploader__input" type="file"
                                       name="vdos"
                                       accept="video/*" multiple="" onchange="echoVdo()">
                            </div>
                        </div>
                    </div>
                </div>
                </c:if>
                <%--处理完--%>
                <c:if test="${srBill.billStatus>1}">
                <div class="page-bd-15">
                    <div class="weui-uploader">
                        <div class="weui-uploader__bd">
                            <ul class="weui-uploader__files">
                                <c:if test="${images!=null and images.size()!=0}">
                                    <c:forEach items="${images}" var="img">
                                        <li class="weui-uploader__file">
                                            <img class="weui-uploader__file" src="${img.filePath}"/></li>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${vdos!=null and vdos.size()!=0}">
                                    <c:forEach items="${vdos}" var="vdo">
                                        <li class="weui-uploader__file ellipsis">${vdo.fileName}</li>
                                    </c:forEach>
                                </c:if>
                            </ul>


                        </div>
                    </div>
                </div>
            </div>
            </c:if>
            <%--<c:if test="${srBill.billStatus==0||srBill.billStatus==1}">--%>
            <input type="submit" class="btn-block btn-primary" <%--onclick="check()" --%>id="sub" value="提交"/>
            <%--</c:if>--%>
            <input type="button" class="btn-block btn-warning" onclick="back()" id="sub" value="返回"/>
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
<script type="application/javascript">

    function back() {
        location.href = "${path}/salesReturn?search=${search}";
    }

    // function echoimge() {
    //     var f = document.getElementById('imgUploaderInput').files;
    //     var imageUl = $("#imgeFiles");
    //     for (var i = 0; i < f.length; i++) {
    //         var r = new FileReader();
    //         r.readAsDataURL(f[i]);
    //         r.onload = function (e) {
    //             var url = this.result;
    //             console.log("url:" + url);
    //             var string = '<div class="weui-uploader__file" style="display: flex;flex-direction: row; height: 109px;margin:0 0;">';
    //             string += '<li style="display: flex;flex-direction: column;">';
    //             string += '<img class="weui-uploader__file" src="' + url + '"/>';
    //             string += '<button onclick="delImage(this)"  type="button" style="width: 79px;">删除</button>';
    //             string += '</li>';
    //             string += '</div>';
    //             imageUl.append(string);
    //         };
    //     }
    // }

    function echoVdo() {
        var f = document.getElementById('vdoUploaderInput').files;
        var imageUl = $("#vdoFiles");
        for (var i = 0; i < f.length; i++) {
            console.info(f[i].name);
            var string = '<li class="weui-uploader__file ellipsis">' + f[i].name + '<br>' +
                '<button onclick="delVdo(this)"  type="button" style="width: 79px;">删除</button></li>';
            imageUl.append(string);
        }
    }

    function delImage(obj) {
        $(obj).parent().parent().remove();
    }

    function delVdo(obj) {
        $(obj).parent().remove();
    }
</script>
<%--<script src="${staticPath }/js/jquery.min.js"></script>--%>
<%--<script src="${staticPath }/js/zepto.min.js"></script>--%>

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.1/js/jquery-weui.min.js"></script>
</body>
</html>
<script>
    $(function () {

        $("#uploaderInput").change(function () {
            var file = $("#uploaderInput").get(0).files[0];
            var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onloadend = function () {
             //   $("#Image1").attr("src", reader.result);
            }

            var path=$("#uploaderInput").val();
            console.log("path："+path);
            alert(path);

        });
        var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#)"></li>',
            $gallery = $("#gallery"),
            $galleryImg = $("#galleryImg"),
            $uploaderInput = $("#uploaderInput"),
            $uploaderFiles = $("#uploaderFiles");
        $uploaderInput.on("change", function (e) {
            var src, url = window.URL || window.webkitURL || window.mozURL,
                files = e.target.files;
            for (var i = 0, len = files.length; i < len; ++i) {
                var file = files[i];
                if (url) {
                    src = url.createObjectURL(file);
                } else {
                    src = e.target.result;
                }
                $uploaderFiles.append($(tmpl.replace('#url#', src)));
            }
        });
        var index; //第几张图片
        $uploaderFiles.on("click", "li", function () {
            index = $(this).index();
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
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