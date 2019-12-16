package com.kzq.advance.mapper;

import com.kzq.advance.domain.TSRBillDetail;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TSRBillDetailMapper {
    int deleteByPrimaryKey(String id);

    int insert(TSRBillDetail record);

    int insertSelective(TSRBillDetail record);

    TSRBillDetail selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TSRBillDetail record);

    int updateByPrimaryKey(TSRBillDetail record);

    List<TSRBillDetail> findDetDetail(TSRBillDetail tsrBillDetail);
}