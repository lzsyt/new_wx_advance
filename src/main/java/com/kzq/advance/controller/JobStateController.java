package com.kzq.advance.controller;


import com.github.pagehelper.PageInfo;
import com.kzq.advance.domain.JobState;
import com.kzq.advance.service.JobStateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("jobState")
public class JobStateController {

    @Autowired
    private JobStateService jobStateService;

    @RequestMapping
    public ModelAndView index(){
        return new ModelAndView("quartz/JobSateManage");
    }

    @RequestMapping("queryJobState")
    public Map<String, Object> quaryJobState(Integer pageNum, Integer pageSize) {
        PageInfo<JobState> jobStatePageInfo = jobStateService.query(pageNum, pageSize);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("JobSate", jobStatePageInfo);
        map.put("number", jobStatePageInfo.getTotal());
        return map;
    }

    @RequestMapping("updateJobState")
    public void updateJobSate(@RequestParam("id") String id,
                              @RequestParam("sate") String sate,
                              String cronExpression) {
        jobStateService.updateState(id, cronExpression, Integer.valueOf(sate));
    }

    @RequestMapping("addJobState")
    public void addJobSate(String jobClass,
                           String jobGroup,
                           String cronExpression) {
        JobState jobState = new JobState(jobClass, jobGroup, cronExpression);
        jobState.setJobState(0);
        jobStateService.insertState(jobState);
    }

    @RequestMapping("inform")
    @ResponseBody
    public String inform(@RequestParam("id")String id){
        jobStateService.informUpdata(Integer.valueOf(id));
        return "0";
    }

}
