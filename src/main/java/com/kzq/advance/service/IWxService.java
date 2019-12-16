package com.kzq.advance.service;


import com.kzq.advance.domain.*;
import com.kzq.advance.domain.vo.PwBillVo;
import com.kzq.advance.domain.vo.Warehouse;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zmn
 * @since 2018-08-16
 */
public interface IWxService {
    /**
     * 登录验证
     */
    public int doLogin(String name, String password, String openId);
    /**
     * 出库单
     */
    public List<TWsBill> findTWsBill(Integer status);

    public TWsBill findDetailById(String id);

    public TCustomer findCustomerById(String id);

    public int updateTWsBill(TWsBill wsBill);

    public List<TWsBill> findGoodsByBillId(String id);

    public void updateUserOpenId(TUser u);

    public TUser findUserByOpenId(String openId);

    public TUser findUserByloginName(String loginName);

    public   List<PwBillVo> PWBillList();

    public PwBillVo findTPwBillById(String id);

    public List<PwBillVo> findPwBillDetailById(String id);

    public void updateTPwBill(TPwBill bill);

    public List<TWsBill> findTWsBillbyCondition(String condition);

    public  List<PwBillVo> findPwBillList(String keyword,String warehouseid);
    /**
     * 判断是否是仓库管理员
     */
    public Warehouse isWarehouse(String userId);
    /**
     * 根据warehouse查询出库单总单
     */
    public List<TWsBill> getBillByWarehouse(String id,String condition);
    /**
     * 根据warehouse查询出库单详单
     */
    public List<TWsBill> getBillDetailByWarehouse(String id,String warehouseId);

    public int update(TWsBillDetail list) ;

    public void changebillstatus(String id);

    public boolean send(String billId,String[]billDetailIds);

    public List<String> findPermissionByUserId(String userId);



}
