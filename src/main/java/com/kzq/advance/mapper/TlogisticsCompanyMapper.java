package com.kzq.advance.mapper;

import com.kzq.advance.domain.TlogisticsCompany;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TlogisticsCompanyMapper {
    int insert(TlogisticsCompany record);

    int insertSelective(TlogisticsCompany record);

    TlogisticsCompany findByCompany(String company);
}