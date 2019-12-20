package com.kzq.advance.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class WebWxConfig {




    @RequestMapping("img")
    public String img(HttpServletRequest request, ModelMap map){
        return "wx/saoyisao";
    }
}
