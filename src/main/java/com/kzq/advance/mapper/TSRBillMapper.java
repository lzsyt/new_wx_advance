package com.kzq.advance.mapper;

import com.kzq.advance.domain.TSRBill;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TSRBillMapper {
    int deleteByPrimaryKey(String id);

    int insert(TSRBill record);

    int insertSelective(TSRBill record);

    TSRBill selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TSRBill record);

    int updateByPrimaryKey(TSRBill record);

    public List<TSRBill> find(TSRBill tsrBill);

    public TSRBill findDetail(TSRBill tsrBill);

}