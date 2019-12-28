package com.kzq.advance.controller;

import com.kzq.advance.domain.TSRBill;
import com.kzq.advance.service.ISRBillService;
import com.kzq.advance.wx.Sign;
import com.kzq.advance.wx.WxUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class WebWxConfig {

    @Autowired
    ISRBillService isrBillService;

    @GetMapping("img")
    public String img(){
        return "wx/saoyisao";
    }

    @GetMapping("saoyisaoSear")
    public String  saoyisao(@RequestParam(required = false) String expressNum){
        System.out.println("expressNum:" + expressNum);
        expressNum = expressNum.replaceAll("CODE_128,", "");
        TSRBill tsrBill = new TSRBill();
        tsrBill.setSearch(expressNum);
        List<TSRBill> list = isrBillService.find(tsrBill);
        if (list.size()>0){
            return "redirect:/salesReturnDetail/" + list.get(0).getId();
        }else{
            return "redirect:/salesReturnAdd?expressNum=" + expressNum;
        }
    }


    @ResponseBody
    @PostMapping("getWxConfig")
    public Map<String, Object> getWxConfig(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        String url = "http://" + WxUtils.APP_DOMAIN + request.getContextPath() + "/img";
        String ticket = WxUtils.getTicket();
        Map<String, String> sign = Sign.sign(ticket, url);
        for (Map.Entry entry : sign.entrySet()) {
            System.out.println(entry.getKey() + "," + entry.getValue());
        }
        map.put("wxConfig", sign);
        return map;
    }
}
