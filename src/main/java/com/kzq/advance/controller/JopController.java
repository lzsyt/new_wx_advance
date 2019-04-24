package com.kzq.advance.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("quartz")
public class JopController {
    @GetMapping
    public String toJopManager(){
        return "quartz/jopManager";
    }
}
