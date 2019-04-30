package com.kzq.advance.mapper;

import com.kzq.advance.domain.JobState;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface JobStateMapper {
    int deleteByPrimaryKey(Integer id);

    int insertSelective(JobState record);

    int updateByPrimaryKeySelective(JobState record);

    List<JobState> selectAll(Integer id);


}