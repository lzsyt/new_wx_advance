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
    <link rel="stylesheet" href="${staticPath}/style/css/weui.css">
    <link rel="stylesheet" href="${staticPath}/style/css/weuix.css">
    <style>

       .m-cell{
            padding-top: 10px;
        }
       .ellipsis {
           overflow: hidden; /*自动隐藏文字*/
           text-overflow: ellipsis;/*文字隐藏后添加省略号*/
           width: 16em;/*不允许出现半汉字截断*/
       }
        body{
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

                <c:if test="${not empty srBill.tid}">
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

            <div class="m-celltitle">详情</div>
            <div class="m-cell">

            <c:forEach items="${billDetailList}" var="billDetail" varStatus="status">
                <input name="tsrBillDetail[${status.index}].id" value="${billDetail.id}" type="hidden">
                        <%--发货商品--%>
                    <div class="cell-item">
                        <div class="cell-left">发货商品：</div>
                        <div class="cell-right">${billDetail.goodsName} * <fmt:formatNumber type="number" value="${billDetail.goodsCount}" maxFractionDigits="0" pattern="0" />
                           </div>
                    </div>

                        <%--产品状态--%>
                    <div class="cell-item">
                        <div class="cell-left">产品状态：</div>
                        <label class="cell-right">
                                <input name="tsrBillDetail[${status.index}].status"
                                       type="text" class="cell-input"value="${billDetail.status}"/>

                        </label>
                    </div>
                        <%--检测情况--%>
                    <div class="cell-item">
                        <div class="cell-left">检测情况：</div>
                        <div class="cell-right">

                                <input  name="tsrBillDetail[${status.index}].detection"
                                       type="text" class="cell-input" value="${billDetail.detection}"/>


                        </div>
                    </div>
            </c:forEach>

            </div>


                <%--未处理--%>
                <c:if test="${srBill.billStatus==1||srBill.billStatus==0}">
                <div class="m-cell">


                <div class="page-bd-15">

                <div class="weui-uploader">
                    <div class="weui-uploader__hd">
                        <p class="weui-uploader__title">图片上传</p>
                        <input type="button" class="weui-uploader__info" id="imgDel">删除</input>
                    </div>
                    <div class="weui-uploader__bd">
                        <ul class="weui-uploader__files" id="imgeFiles">

                        </ul>

                        <div class="weui-uploader__input-box">
                            <input id="imgUploaderInput" class="weui-uploader__input" type="file"
                                   name="images"
                                   accept="image/*" multiple="" onchange="echoimge()">
                        </div>
                    </div>
                </div>

                <div class="weui-uploader">
                    <div class="weui-uploader__hd">
                        <p class="weui-uploader__title">视频上传</p>
                        <div class="weui-uploader__info" id="vdoDel">删除</div>
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
                                <ul class="weui-uploader__files" >
                                    <c:if test="${images!=null and images.size()!=0}">
                                        <c:forEach items="${images}" var="img">
                                            <li class="weui-uploader__file" ><img  class="weui-uploader__file"  src="${img.filePath}"/></li>
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

                <input type="submit" class="btn-block btn-primary" <%--onclick="check()" --%>id="sub" value="提交"/>

            <input type="button" class="btn-block btn-warning" onclick="back()" id="sub" value="返回"/>
        </form>
    </div>

</section>
<script type="application/javascript">

    function back() {
        location.href = "${path}/salesReturn?search=${search}";
    }

    var imgindex = 0;
    var vdoindex = 0;

    function echoimge() {
        var f = document.getElementById('imgUploaderInput').files;
        var imageUl = $("#imgeFiles");
        for (var i = 0; i < f.length; i++) {
            var r = new FileReader();
            r.readAsDataURL(f[i]);
            r.onload = function (e) {
                var url = this.result;
                console.log("url:"+url);
                var string = '<li class="weui-uploader__file" style="background-image:url(' + url + '"></li>';
                imageUl.append(string);
                imgindex++;
            };
        }
    }

    function echoVdo() {
        var f = document.getElementById('vdoUploaderInput').files;
        var imageUl = $("#vdoFiles");
        for (var i = 0; i < f.length; i++) {
            console.info(f[i].name);
            var string = '<li class="weui-uploader__file ellipsis">' + f[i].name + '</li>';
            imageUl.append(string);
        }
    }

    $(function () {
        $("#imgDel").click(function() { //这部分刚才放错地方了，放到$(function(){})外面去了
            console.log('删除');
            console.log(imgindex);
            console.log($("#imgeFiles").children("li").length);
            // $("#vdoFiles").find("li").eq(imgindex-1).remove();
            $("#imgeFiles li").eq(imgindex).siblings().remove();
        });
        $("#vdoDel").click(function() { //这部分刚才放错地方了，放到$(function(){})外面去了
            console.log('删除');
            $("#vdoFiles").find("li").eq(vdoindex).remove();
        });
    })
</script>
<script src="${staticPath }/js/jquery.min.js"></script>
<script src="${staticPath }/js/zepto.min.js"></script>

<script src="${staticPath }/js/zepto.weui.js"></script>
</body>
</html>