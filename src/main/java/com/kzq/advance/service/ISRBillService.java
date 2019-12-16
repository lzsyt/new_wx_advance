package com.kzq.advance.service;

import com.kzq.advance.domain.TSRBill;
import com.kzq.advance.domain.TSRBillDetail;
import com.kzq.advance.domain.TSRBillFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

public interface ISRBillService {
    List<TSRBill> find(TSRBill tsrBill);

    TSRBill findTsrDetail(TSRBill searchTsrBill);

    List<TSRBillDetail> findDetDetail(TSRBillDetail tsrBillDetail);

    Boolean save(TSRBill tsrBill, HttpServletRequest request) throws IOException;
    Boolean addSrBill(TSRBill tsrBill, HttpServletRequest request)throws IOException;
    List<TSRBillFile> findImages(String id);

    List<TSRBillFile> findVdo(String id);
}
