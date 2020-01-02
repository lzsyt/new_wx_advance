package com.kzq.advance.service.impl;

import com.kzq.advance.domain.TFinanceInputDetail;
import com.kzq.advance.mapper.TFinanceInputDetailMapper;
import com.kzq.advance.service.IFinanceInputDetailService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class IFinanceInputDetailServiceImpl implements IFinanceInputDetailService {

    @Resource
    private TFinanceInputDetailMapper inputDetailMapper;

    @Override
    public List<TFinanceInputDetail> find() {
        return inputDetailMapper.find();
    }
}
