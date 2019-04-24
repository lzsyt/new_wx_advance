package com.kzq.advance.common.quartz.service;

import com.github.pagehelper.PageInfo;
import com.kzq.advance.common.quartz.model.JobAndTrigger;

/**
 * Created by haoxy on 2018/9/28.
 * E-mail:hxyHelloWorld@163.com
 * github:https://github.com/haoxiaoyong1014
 */
public interface IJobAndTriggerService {
    PageInfo<JobAndTrigger> getJobAndTriggerDetails(Integer pageNum, Integer pageSize);
}
