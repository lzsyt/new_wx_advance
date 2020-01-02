package com.kzq.advance.mapper;

import com.kzq.advance.domain.TFinanceInputDetail;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface TFinanceInputDetailMapper {
    int deleteByPrimaryKey(Long id);

    int insert(TFinanceInputDetail record);

    int insertSelective(TFinanceInputDetail record);

    TFinanceInputDetail selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TFinanceInputDetail record);

    int updateByPrimaryKey(TFinanceInputDetail record);

    @Select("SELECT  shop," +
            "sum( withdraw_total ) as withdrawTotal, " +
            "sum( pay_total ) as payTotal, " +
            "sum( expend_total ) as expendTotal," +
            "sum(sum_total) as sumTotal " +
            "FROM t_finance_input_detail GROUP BY shop")
    public List<TFinanceInputDetail> find();
}