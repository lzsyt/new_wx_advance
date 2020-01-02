package com.kzq.advance.mapper;

import com.kzq.advance.domain.TFinanceInput;

public interface TFinanceInputMapper {
    int deleteByPrimaryKey(Long id);

    int insert(TFinanceInput record);

    int insertSelective(TFinanceInput record);

    TFinanceInput selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TFinanceInput record);

    int updateByPrimaryKey(TFinanceInput record);
}