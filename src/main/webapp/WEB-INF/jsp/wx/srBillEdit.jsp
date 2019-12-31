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
        <form name="serForm" action="${path}/saveSRBill" id="serForm" method="post" enctype="multipart/form-data"
              onsubmit="return sub()">
            <input name="search" value="${search}" type="hidden">

            <div class="m-cell demo-small-pitch">
                <input name="id" id="id" type="hidden" value="${srBill.id}">

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
                        <div class="cell-right">
                            <input name="memo" id="memo" type="text" class="cell-input" value="${srBill.memo}">
                        </div>
                    </div>
                    <div class="cell-item">
                        <div class="cell-left">修改人：</div>
                        <div class="cell-right">
                            ${srBill.bizUserName}
                        </div>
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
                    <input name="tsrBillDetail[${status.index}].id" id="tsrBillDetail[${status.index}].id"
                           value="${billDetail.id}" type="hidden">
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
                                <%--<c:if test="${billDetail.status ==null|| billDetail.status ==''}">--%>
                            <div class="cell-right">
                                <select name="tsrBillDetail[${status.index}].status"
                                        id="tsrBillDetail[${status.index}].status" class="cell-select">
                                    <option value="1" <c:if test="${billDetail.status =='1'}">selected</c:if>>好</option>
                                    <option value="2" <c:if test="${billDetail.status =='2'}">selected</c:if>>坏</option>
                                    <option value="3" <c:if test="${billDetail.status =='3'}">selected</c:if>>电池坏
                                    </option>
                                    <c:if test="${billDetail.status !='1' and  billDetail.status !='2'and  billDetail.status !='3'}">
                                        <option value="${billDetail.status}" selected>${billDetail.status}</option>
                                    </c:if>
                                </select>
                            </div>
                        </div>
                    </div>
                        <%--检测情况--%>
                    <div class="cell-item">
                        <div class="cell-left">检测情况：</div>
                            <%--<c:if test="${billDetail.detection ==null || billDetail.detection ==''}">--%>
                        <div class="cell-right">
                            <input name="tsrBillDetail[${status.index}].detection"
                                   id="tsrBillDetail[${status.index}].detection"
                                   type="text" class="cell-input" value="${billDetail.detection}"/>
                        </div>
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
                            <div class="weui-uploader__input-box" id="inputbox">
                                <input id="uploaderInput0" class="weui-uploader__input"
                                       name="images[0]" type="file" accept="image/*" multiple="">
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
                <c:if test="${(images!=null and images.size()!=0)||(vdos!=null and vdos.size()!=0)}">
                    <div class="page-bd-15">
                        <div class="weui-uploader">
                            <div class="weui-uploader__bd">
                                <ul class="weui-uploader__files">
                                    <c:if test="${images!=null and images.size()!=0}">
                                        <c:forEach items="${images}" var="img">
                                            <li class="weui-uploader__file">
                                                <img class="weui-uploader__file" ondblclick="delimg(this,${img.id})"
                                                     src="${img.filePath}"/>
                                            </li>
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
                </c:if>
            </div>
            <%--<c:if test="${srBill.billStatus==0||srBill.billStatus==1}">--%>
            <input type="submit" class="btn-block btn-primary" id="btn" value="提交"/>
            <%--</c:if>--%>
            <input type="button" class="btn-block btn-warning" onclick="back()" value="返回"/>
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

    function delimg(obj, id) {
        $.ajax({
            url: "${path}/delImg?imgId=" + id,
            success: function (result) {
                if (result) {
                    obj.remove();
                }
            }
        });
    }

    function back() {
        location.href = "${path}/salesReturn?search=${search}";
    }

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

    function delVdo(obj) {
        $(obj).parent().remove();
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

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.1/js/jquery-weui.min.js"></script>
</body>
</html>