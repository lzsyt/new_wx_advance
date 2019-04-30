package com.kzq.advance.common.quartz.jops;


import com.kzq.advance.common.quartz.model.BaseJob;
import com.kzq.advance.common.quartz.tool.JobUtil;
import com.kzq.advance.common.util.SpringUtil;
import com.kzq.advance.domain.JobState;
import com.kzq.advance.mapper.JobStateMapper;
import org.quartz.JobExecutionContext;
import org.quartz.Scheduler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;

@Component
public class Refresh implements BaseJob {


    Logger logger = LoggerFactory.getLogger(Refresh.class);

    public int upate(Integer id) {
        JobStateMapper jobStateMapper = (JobStateMapper) SpringUtil.getBean("jobStateMapper");
        JobState jobState = selectJobState(id);
        if (jobState.getJobState() > 0) {
            try {
                updateState(jobState);
                jobState.setJobState(0);
                jobStateMapper.updateByPrimaryKeySelective(jobState);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }


    public JobState selectJobState(Integer id) {
        JobStateMapper jobStateMapper = (JobStateMapper) SpringUtil.getBean("jobStateMapper");
        return jobStateMapper.selectAll(id).get(0);
    }

    public void updateState(JobState jobState) throws Exception {
        Scheduler scheduler = (Scheduler) SpringUtil.getBean("Scheduler");

        switch (jobState.getJobState()) {
            //暂停
            case 1: {
                JobUtil.jobPause(jobState.getJobClass(), jobState.getJobGroup(), scheduler);
                logger.info(jobState.getJobClass() + "已暂停");
                break;
            }
            //恢复
            case 2: {
                JobUtil.jobresume(jobState.getJobClass(), jobState.getJobGroup(), scheduler);
                logger.info(jobState.getJobClass() + "已恢复");
                break;
            }
            //更新
            case 3: {
                String jobStateDate = jobState.getCronExpression();
                try {
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    simpleDateFormat.parse(jobStateDate);
                } catch (Exception e) {
                    throw new RuntimeException("jobState日期格式有误：" + jobStateDate + ";jobState详细信息为" + jobState.toString());
                }
                JobUtil.jobreschedule(jobState.getJobClass(), jobState.getJobGroup(), jobStateDate, scheduler);
                logger.info(jobState.getJobClass() + "表达式已更改:" + jobState.getCronExpression());
                break;
            }
        }
    }

    @Override
    public void execute(JobExecutionContext context) {
        upate(null);
    }
}
