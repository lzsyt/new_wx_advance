package com.kzq.advance.mapper;

import com.kzq.advance.domain.TWsBillDetail;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface TWsBillDetailMapper {
    int deleteByPrimaryKey(String id);

    int insert(TWsBillDetail record);

    int insertSelective(TWsBillDetail record);

    TWsBillDetail selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TWsBillDetail record);

    int updateByPrimaryKey(TWsBillDetail record);

    List<TWsBillDetail> selectBillDetailByBillId(String id);

    int countBillDetailByBillId(String id);

    TWsBillDetail findTwsBillDetailByBillId(String billId);

    List<TWsBillDetail> selectBillDetailByBillDetailId(List<String>list);

    int changeSendState(HashMap<String, Object> map);
}