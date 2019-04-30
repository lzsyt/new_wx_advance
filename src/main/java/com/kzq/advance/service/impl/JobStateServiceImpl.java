package com.kzq.advance.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kzq.advance.common.quartz.jops.Refresh;
import com.kzq.advance.domain.JobState;
import com.kzq.advance.mapper.JobStateMapper;
import com.kzq.advance.service.JobStateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class JobStateServiceImpl implements JobStateService {

    @Autowired
    private Refresh refresh;

    @Resource
    private JobStateMapper jobStateMapper;

    @Override
    public int updateState(String id,String cronExpression,Integer state){
        JobState jobState = new JobState();
        jobState.setId(Integer.valueOf(id));
        jobState.setJobState(state);
        jobState.setCronExpression(cronExpression);
        jobStateMapper.updateByPrimaryKeySelective(jobState);
        return 0;
    }

    @Override
    public int insertState(JobState jobState) {
        jobStateMapper.insertSelective(jobState);
        return 0;
    }

    @Override
    public int deleteState(Integer id) {
        jobStateMapper.deleteByPrimaryKey(id);
        return 0;
    }

    @Override
    public PageInfo<JobState> query(Integer pageNum, Integer pageSize){
        PageHelper.offsetPage(pageNum, pageSize);
        List<JobState> list = jobStateMapper.selectAll(null);
        PageInfo<JobState> jobStatePageInfo = new PageInfo<>(list);
        return jobStatePageInfo;
    }

    @Override
    public int informUpdata(Integer id) {
        refresh.upate(id);
        return 0;
    }

}
