package com.kzq.advance.common.quartz.tool;

import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;

@Component
public class CronUtil {
    public String formatDateToCron(Date date) {
        String pattern = "ss mm HH * * ?";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        return simpleDateFormat.format(date);
    }
}
