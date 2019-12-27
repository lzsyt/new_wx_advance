package com.kzq.advance.controller;

import com.kzq.advance.wx.Sign;
import com.kzq.advance.wx.WxUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
public class WebWxConfig {

    @RequestMapping("img")
    public String img(){
        return "wx/saoyisao";
    }


    @ResponseBody
    @PostMapping("getWxConfig")
    public Map<String, Object> getWxConfig(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        String url = "http://" + WxUtils.APP_DOMAIN + request.getContextPath() + "/index";
        String ticket = WxUtils.getTicket();
        Map<String, String> sign = Sign.sign(ticket, url);
        for (Map.Entry entry : sign.entrySet()) {
            System.out.println(entry.getKey() + "," + entry.getValue());
        }
        map.put("wxConfig", sign);
        return map;
    }
}
