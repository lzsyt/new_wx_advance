package com.kzq.advance.mapper;

import com.kzq.advance.domain.TSRBillFile;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TSRBillFileMapper {
    int deleteByPrimaryKey(Long id);

    int insert(TSRBillFile record);

    int insertSelective(TSRBillFile record);

    TSRBillFile selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TSRBillFile record);

    int updateByPrimaryKey(TSRBillFile record);

    List<TSRBillFile> find(TSRBillFile record);

}