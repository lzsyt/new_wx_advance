package com.kzq.advance.controller;


import com.kzq.advance.common.advanced.model.WeixinOauth2Token;
import com.kzq.advance.common.advanced.util.OAuthUtil;
import com.kzq.advance.common.base.BaseController;
import com.kzq.advance.common.utils.HttpUtils;
import com.kzq.advance.domain.*;
import com.kzq.advance.domain.vo.PwBillVo;
import com.kzq.advance.domain.vo.Warehouse;
import com.kzq.advance.service.ISRBillService;
import com.kzq.advance.service.IWxService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

/**
 * @description：用户管理
 * @author：zhixuan.wang
 * @date：2015/10/1 14:51
 */
@Controller
public class WxController extends BaseController {
    @Autowired
    private IWxService wxService;
    @Autowired
    ISRBillService isrBillService;
    private String AppID = "wx8148352aa79f60c7";
    private String AppSecret = "e55265afba1663a40388496d39641cb9";

    /**
     * 进入微信登录界面
     *
     * @return
     */
    @GetMapping("/")
    public String login(HttpServletRequest request, String code) {
        HttpSession session = request.getSession();

        try {
            //公众号点击登录
            if (StringUtils.isNotBlank(code)) {
                WeixinOauth2Token wx = OAuthUtil.getOauth2AccessToken(AppID, AppSecret, code);
                TUser user = wxService.findUserByOpenId(wx.getOpenId());
                session.setAttribute("openId", wx.getOpenId());

                if (user != null && user.getId() != null) {
                    session.setAttribute("user", user);
                    //查询所有出库单
                    List<TWsBill> list = wxService.findTWsBill(null);

                    request.setAttribute("wsBills", list);
                    return redirect("/index");
                }
            }
            //通知的链接过来的可以直接登陆
            String openId = request.getParameter("openId");
            if (StringUtils.isNotBlank(openId)) {
                session.setAttribute("openId", openId);

                TUser user = wxService.findUserByOpenId(openId);
                if (user != null && user.getId() != null) {
                    session.setAttribute("user", user);
                    //查询所有出库单
                    List<TWsBill> list = wxService.findTWsBill(null);

                    request.setAttribute("wsBills", list);
                    return redirect("/index");

                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "wx/login";

    }

    @RequestMapping("/login")
    public String login(HttpServletRequest request) {

        return "wx/login";

    }

    /***
     * 微信登录验证
     * @return
     */

    @PostMapping("/doLogin")
    @ResponseBody
    public Object doLogin(String name, String password, Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        logger.info("登录名为：" + name + "的用户登录");
        String openId = (String) session.getAttribute("openId");

        if (wxService.doLogin(name, password, "") == 1) {
            if (openId != null && StringUtils.isNotBlank(openId)) {
                TUser u = new TUser();
                u.setLoginName(name);
                u.setOpenId(openId);
                wxService.updateUserOpenId(u);
            }
            TUser user = wxService.findUserByloginName(name);
            //判断是否是仓库管理员
            Warehouse wareInfo = wxService.isWarehouse(user.getId());
            if (wareInfo != null && StringUtils.isNotBlank(wareInfo.getId())) {
                session.setAttribute("warehouseId", wareInfo.getId());
                session.setAttribute("warehouse", wareInfo);

            }
            session.setAttribute("user", user);
            return renderSuccess();
        }
        return renderError("用户名密码错误");

    }

    /**
     * 首页列表
     *
     * @param request
     * @return
     */
    @RequestMapping("index")
    public String newIndex(HttpServletRequest request,@RequestParam(required = false) String flag) {

        TUser user = (TUser) request.getSession().getAttribute("user");
        Warehouse wareInfo = (Warehouse) request.getSession().getAttribute("warehouse");
        if (wareInfo != null && StringUtils.isNotBlank(wareInfo.getId())) {
            //如果是仓管
            //本地仓：天马，只显示退货
            if (wareInfo.getName().contains("天马")) {
                request.setAttribute("fristUrl", "salesReturn");

                //退货
                request.setAttribute("foot3", true);
                request.setAttribute("foot2", false);
                request.setAttribute("foot1", false);

            } else {
                //异地仓：显示全部

                request.setAttribute("fristUrl", "getContent");
                request.setAttribute("foot1", true);
                request.setAttribute("foot2", true);
                request.setAttribute("foot3", true);

            }

        } else {
            //非仓库管理员拥有所有foot页面，跳转到发货界面
            request.setAttribute("foot1", true);
            request.setAttribute("foot2", true);
            request.setAttribute("foot3", true);
            request.setAttribute("fristUrl", "getContent");
        }
        if (StringUtils.isNotBlank(flag)&&flag.equals("flag")){
            request.setAttribute("fristUrl", "salesReturn");
        }
        return "wx/mainIndex";
    }

    /**
     * 主界面
     *
     * @param search
     * @return
     */
    @RequestMapping("/getContent")
    public String index(String search, HttpServletRequest request) {
        if (StringUtils.isNotBlank(search)) {
            request.setAttribute("search", search);
        }
        HttpSession session = request.getSession();
        String warehouseId = (String) session.getAttribute("warehouseId");
        //判断是否是仓库管理员
        if (StringUtils.isNotBlank(warehouseId)) {
            logger.info("仓库：" + warehouseId);
            List<TWsBill> list = wxService.getBillByWarehouse(warehouseId, search);
            if (request.getAttribute("wsBills") != null) {
                request.removeAttribute("wsBills");
            }
            request.setAttribute("wsBills", list);
            return "wx/windex";
        } else {
            List<TWsBill> list = wxService.findTWsBillbyCondition(search);
            if (request.getAttribute("wsBills") != null) {
                request.removeAttribute("wsBills");
            }
            request.setAttribute("wsBills", list);
            return "wx/index";
        }
    }

    /**
     * 原来的 发货单
     */
    @GetMapping("/orderDetail/{id}")
    public String orderDetail(@PathVariable("id") String id, HttpServletRequest request, String search) {
        if (StringUtils.isNotBlank(search))
            request.setAttribute("search", search);
        //发货详细单
        TWsBill wsBill = wxService.findDetailById(id);
        wsBill.setId(id);
        //logger.info("company:"+wsBill.getShopNum());
        //商品详细信息
        List<TWsBill> goodsList = wxService.findGoodsByBillId(id);
        //客户信息
        TCustomer customer = wxService.findCustomerById(wsBill.getCustomerId());

        request.setAttribute("goodsList", goodsList);
        request.setAttribute("wsBill", wsBill);
        request.setAttribute("customer", customer);

        return "wx/edit";


    }
    //检查是否登录

    public boolean getLoginUser(HttpServletRequest request, TUser user) {

        HttpSession session = request.getSession();
        user = (TUser) session.getAttribute("user");
        if (user != null) {

            return true;

        }
        return false;
    }

    /**
     * 新的发货详单
     */
    @GetMapping("/orderDetailForWarehouse/{id}")
    public String orderDetailForWarehouse(@PathVariable("id") String id, HttpServletRequest request, String search) {
        if (StringUtils.isNotBlank(search)) {
            request.setAttribute("search", search);
        }
        TUser user = new TUser();
        getLoginUser(request, user);
        if (getLoginUser(request, user)) {
            String userId = user.getId();


        } else {

            return "wx/login";
        }
        HttpSession session = request.getSession();
        String warehouseId = (String) session.getAttribute("warehouseId");


        //发货详细单
        TWsBill wsBill = wxService.findDetailById(id);
        wsBill.setId(id);
        //商品详细信息
        List<TWsBill> goodsList = wxService.getBillDetailByWarehouse(id, warehouseId);
        //客户信息
        TCustomer customer = wxService.findCustomerById(wsBill.getCustomerId());
        request.setAttribute("goodsList", goodsList);
        request.setAttribute("wsBill", wsBill);
        request.setAttribute("customer", customer);
//      request.setAttribute("billstatus", billStatus(goodsList));
        if (StringUtils.isNotBlank(warehouseId)) {
            return "wx/newEditDeliver";
        } else {
            return "wx/editDeliver";
        }

    }


    private boolean billStatus(List<TWsBill> tWsBills) {
        boolean flag = false;
        for (TWsBill tws : tWsBills) {
            if (StringUtils.isBlank(tws.getExpressNum())) {
                flag = true;
            }
        }
        return flag;
    }

    /**
     * 保存出库单
     */
    @PostMapping("/saveWsBill")
    public String saveWsBill(String expressCompany, String expressNum, String id, String[] checkbox, HttpServletRequest request, String search) {

        long startTime = System.currentTimeMillis();
        logger.info("expressCompany:" + expressCompany + ", expressNum:" + expressNum);
        //将当前上下文初始化给  CommonsMutipartResolver （多部分解析器）
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
                request.getSession().getServletContext());
        //检查form中是否有enctype="multipart/form-data"
        String filePath = "";

        if (multipartResolver.isMultipart(request)) {
            //将request变成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            //获取multiRequest 中所有的文件名
            Iterator iter = multiRequest.getFileNames();
            String path = "";
            while (iter.hasNext()) {
                //一次遍历所有文件
                MultipartFile multiRequestFile = multiRequest.getFile(iter.next().toString());
                //logger.info("item:"+iter.next().toString());
                if (multiRequestFile != null && StringUtils.isNotBlank(multiRequestFile.getOriginalFilename())) {
                    filePath = "/wxUpload/" + multiRequestFile.getOriginalFilename();
                    path = request.getServletContext().getRealPath("/static") + "/wxUpload/" + multiRequestFile.getOriginalFilename();
                    logger.info("path:" + path);
                    //上传
                    try {
                        File file = new File(path);
                        if (!file.getParentFile().exists()) {
                            file.getParentFile().mkdirs();
                        }
                        multiRequestFile.transferTo(file);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
//            //保存数据库
//            TWsBill bill = new TWsBill();
//            bill.setId(id);
//            bill.setExpressCompany(expressCompany);
//            bill.setExpressNum(expressNum);
//            bill.setFilePath(filePath);
//            wxService.updateTWsBill(bill);
        }

        if (checkbox != null) {
            TWsBillDetail tWsBillDetail = null;
            for (int i = 0; i < checkbox.length; i++) {
                tWsBillDetail = new TWsBillDetail();
                tWsBillDetail.setId(checkbox[i]);
                tWsBillDetail.setExpressCompany(expressCompany);
                tWsBillDetail.setExpressNum(expressNum);
                if (StringUtils.isNotBlank(filePath)) {
                    tWsBillDetail.setFilePath(filePath);
                }
                logger.info("id:     " + tWsBillDetail.getId() + "     插入expressNum:     " + tWsBillDetail.getExpressNum() + "     expressCompany:" + tWsBillDetail.getExpressCompany());
                wxService.update(tWsBillDetail);
            }
        }

        long endTime = System.currentTimeMillis();
        System.out.println("方法三的运行时间：" + String.valueOf(endTime - startTime) + "ms");
//        //查询所有出库单
//        List<TWsBill> list = wxService.findTWsBill(null);
//        logger.info("list-----------" + list.size());
//        request.setAttribute("wsBills", list);
//        return redirect("/wx/index");
        logger.info("更改bill的状态");
        wxService.changebillstatus(id);
        logger.info("执行发货方法");
//        boolean flag = wxService.send(id, checkbox);

        if (StringUtils.isNotBlank(search)) {
            return "redirect:/getContent?search=" + search;
        } else {
            return "redirect:/getContent";
        }


    }


    /**
     * 采购列表
     */
    @RequestMapping("/pwBillList")
    public String pwBillList(String keyword, HttpServletRequest request) {
        if (StringUtils.isNotBlank(keyword))
            request.setAttribute("keyword", keyword);
        List<PwBillVo> list = null;
        HttpSession session = request.getSession();
        logger.info("采购列表");
        String warehouseId = (String) session.getAttribute("warehouseId");
        //判断是否是仓库管理员
        if (StringUtils.isNotBlank(warehouseId)) {
            logger.info("仓库：" + warehouseId);
            list = wxService.findPwBillList(keyword, warehouseId);
            request.setAttribute("pwBills", list);
            return "wx/newPwBill";
        } else {
            list = wxService.findPwBillList(keyword, null);
            request.setAttribute("pwBills", list);
            return "wx/pwBill";
        }

    }

    /**
     * 入库单详情
     */
    @RequestMapping("/pwBillInfo/{id}")
    public String pwBillInfo(@PathVariable("id") String id, HttpServletRequest request, String keyword) {
        if (StringUtils.isNotBlank(keyword)) {
            request.setAttribute("keyword", keyword);
        }
        HttpSession session = request.getSession();
        TUser user = (TUser) session.getAttribute("user");
        if (user == null) {
            return "wx/newEditPwBill";


        }
        String userId = user.getId();
        PwBillVo tPwBill = wxService.findTPwBillById(id);
        tPwBill.setId(id);
        logger.info("采购详情");
        logger.info("采购详情:" + tPwBill.getGoodsMoney());

        //入库单商品列表
        List<PwBillVo> goodsList = wxService.findPwBillDetailById(id);

        request.setAttribute("pwBill", tPwBill);
        request.setAttribute("goodsList", goodsList);

        String warehouseid = (String) session.getAttribute("warehouseId");
        if (StringUtils.isNotBlank(warehouseid)) {
            return "wx/newEditPwBill";
        } else {
            return "wx/editPwBill";
        }
    }

    /**
     * 提交入库单
     */
    @RequestMapping("/subPwBill")
    @ResponseBody
    public String subPwBill(String id, HttpServletRequest request) {
        HttpSession session = request.getSession();
        TUser u = new TUser();
        try {
            u = (TUser) session.getAttribute("user");
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (u != null && StringUtils.isNotBlank(u.getId())) {
            String param = "id=" + id + "&userId=" + u.getId();
            logger.info("param:" + param);

            String sr = HttpUtils.sendPost("http://localhost/web/Home/Purchase/commitPWBillint", param);
            logger.info("post提交出库单：" + sr);

        } else {//没有登录
            return "-1";
        }


        return "1";
    }


    /**
     * 用户中心
     */
    @GetMapping("/userInfo")
    public String userInfo(HttpServletRequest request) {
        HttpSession session = request.getSession();
        TUser user = (TUser) session.getAttribute("user");
        if (user != null && user.getId() != null) {
            request.setAttribute("name", user.getName());
            request.setAttribute("loginName", user.getLoginName());
        }
        String warehouseId = (String) session.getAttribute("warehouseId");
        if (StringUtils.isNotBlank(warehouseId)) {
            return "/wx/newUserInfo";
        } else {
            return "/wx/userInfo";
        }
    }

    /**
     * 退出登录
     */
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
        return "wx/login";
    }


    /**
     * 退货列表
     *
     * @return
     */
    @RequestMapping("salesReturn")
    public String salesReturn(HttpServletRequest request,@RequestParam(required = false)String succeed) {
        HttpSession session = request.getSession();
        if (request.getAttribute("srBills") != null) {
            request.removeAttribute("srBills");
        }
        TSRBill tsrBill = new TSRBill();
        String search = request.getParameter("search");
        if (!StringUtils.isBlank(search)) {
            request.setAttribute("search", search);
        }
        tsrBill.setSearch(search);
        //判断是否是仓库管理员
        String warehouseId = (String) session.getAttribute("warehouseId");
        if (StringUtils.isNotBlank(warehouseId)) {
            logger.info("仓库：" + warehouseId);
            //查询条件
            tsrBill.setWarehouseId(warehouseId);
        }
        List<TSRBill> list = isrBillService.find(tsrBill);
        request.setAttribute("srBills", list);
        if (succeed != null) {
            request.setAttribute("succeed",succeed);
        }
        return "/wx/srBill";
    }

    /**
     * 查看单个退货单
     *
     * @param id
     * @param request
     * @return
     */
    @RequestMapping("salesReturnDetail/{id}")
    public String salesReturnDetail(@PathVariable("id") String id, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String search = request.getParameter("search");
        if (StringUtils.isNotBlank(search)) {
            request.setAttribute("search", search);
        }
        String warehouseId = (String) session.getAttribute("warehouseId");
        TSRBill searchTsrBill = new TSRBill();
        searchTsrBill.setId(id);
        searchTsrBill.setWarehouseId(warehouseId);
        TSRBill tsrBill = isrBillService.findTsrDetail(searchTsrBill);
        TSRBillDetail tsrBillDetail = new TSRBillDetail();
        tsrBillDetail.setSrbillId(id);
        List<TSRBillDetail> tsrBillDetails = isrBillService.findDetDetail(tsrBillDetail);
        request.setAttribute("srBill", tsrBill);
        request.setAttribute("billDetailList", tsrBillDetails);
        List<TSRBillFile> imgs = isrBillService.findImages(id);
        List<TSRBillFile> videos = isrBillService.findVdo(id);
        request.setAttribute("images", imgs);
        request.setAttribute("vdos", videos);
        return "/wx/srBillEdit";
    }


    /**
     * 保存退货单
     *
     * @param tsrBill
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("saveSRBill")
    public String saveSRBill(TSRBill tsrBill, HttpServletRequest request) throws IOException {
        Boolean flag = isrBillService.save(tsrBill, request);
        if (flag)
            return "redirect:/salesReturn?succeed=true";
        else
            return "redirect:/salesReturn?succeed=false";
    }

    /**
     * 新建退货单
     *
     * @return
     */
    @RequestMapping("salesReturnAdd")
    public String salesReturnAdd(@RequestParam(required = false,value = "expressNum")String expressNum,HttpServletRequest request) {
        if(StringUtils.isNotBlank(expressNum)){
            TSRBill tsrBill = new TSRBill();
            tsrBill.setExpressNum(expressNum);
            request.setAttribute("tsrbill", tsrBill);
        }
        return "/wx/srbilladd";
    }

    /*

    检查快递单是否重复
    1:为重复 0：为不重复
     */
    @ResponseBody
    @RequestMapping("checkExpressNum")
    public String checkExpressNum(String expressNum) {
        TSRBill bill = new TSRBill();
        bill.setExpressNum(expressNum);
        List<TSRBill> list = isrBillService.find(bill);
        if (list != null && list.size() > 0) {
            return "1";
        }
        return "0";

    }


    /**
     * 保存新的退货单
     *
     * @param tsrBill
     * @param request
     * @return
     */

    @RequestMapping("saveAddSRBill")
    public String saveAddSRBill(TSRBill tsrBill, HttpServletRequest request) {
        Boolean flag = false;
        try {
            flag = isrBillService.addSrBill(tsrBill, request);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //返回到退货列表
        return "redirect:/salesReturn?succeed=" + true;
    }


    @RequestMapping("delImg")
    @ResponseBody
    public String delImg(@RequestParam Long imgId){
        return isrBillService.delImg(imgId) > 0 ? "true" : "false";
    }


}