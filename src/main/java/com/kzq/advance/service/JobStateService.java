package com.kzq.advance.service;

import com.github.pagehelper.PageInfo;
import com.kzq.advance.domain.JobState;

public interface JobStateService {

    public int updateState(String id, String cronExpression, Integer sate);

    public int insertState(JobState jobState);

    public int deleteState(Integer id);

    public PageInfo<JobState> query(Integer pageNum, Integer pageSize);

    public int informUpdata(Integer id);


}
