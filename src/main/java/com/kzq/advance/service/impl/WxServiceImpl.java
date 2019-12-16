package com.kzq.advance.service.impl;


import com.kzq.advance.common.utils.MD5Util;
import com.kzq.advance.common.utils.TbaoUtils;
import com.kzq.advance.domain.*;
import com.kzq.advance.domain.vo.PwBillVo;
import com.kzq.advance.domain.vo.Warehouse;
import com.kzq.advance.mapper.*;
import com.kzq.advance.service.IWxService;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.support.ManagedMap;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.beans.Transient;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author zmn
 * @since 2018-08-16
 */

@Service("IWxService")
public class WxServiceImpl implements IWxService {
    protected Logger logger = LogManager.getLogger(getClass());
    @Resource
    private TUserMapper userMapper;
    @Resource
    private TWsBillMapper wsBillMapper;
    @Resource
    private TPwBillMapper tpwBillMapper;
    @Resource
    private TWsBillDetailMapper tWsBillDetailMapper;
    @Resource
    private TWsBillMapper tWsBillMapper;
    @Resource
    private TlogisticsCompanyMapper tlogisticsCompanyMapper;

    /**
     * 登录验证
     *
     * @param name
     * @param password
     * @param openId
     * @return
     */
    public int doLogin(String name, String password, String openId) {
        if (StringUtils.isNotBlank(name)) {
            String tpassword = userMapper.doLogin(name);
            MD5Util md5 = new MD5Util();
            if (md5.encryption(password).equals(tpassword)) {
                return 1;
            }

        } else if (StringUtils.isNotBlank(openId)) {
            TUser user = findUserByOpenId(openId);
            if (StringUtils.isNotBlank(user.getId())) {
                return 1;
            }
        }

        return 0;
    }

    /**
     * 根据微信openid获取用户
     *
     * @param openId
     * @return
     */
    public TUser findUserByOpenId(String openId) {
        TUser u = new TUser();
        u.setOpenId(openId);
        return userMapper.findUser(u);
    }

    public TUser findUserByloginName(String loginName) {
        TUser u = new TUser();
        u.setLoginName(loginName);
        return userMapper.findUser(u);
    }

    public void updateUserOpenId(TUser u) {
        userMapper.updateUserOpenId(u);
    }

    /**
     * 出库单列表
     */

    public List<TWsBill> findTWsBill(Integer status) {
        return wsBillMapper.findTWsBill(status);
    }

    public TWsBill findDetailById(String id) {
        return wsBillMapper.findDetailById(id);
    }

    public TCustomer findCustomerById(String id) {
        return wsBillMapper.findCustomerById(id);
    }

    public int updateTWsBill(TWsBill wsBill) {
        try {
            wsBillMapper.updateTWsBill(wsBill);
            return 1;
        } catch (Exception e) {

            e.printStackTrace();
        }
        return 0;
    }

    public List<TWsBill> findGoodsByBillId(String id) {
        return wsBillMapper.findGoodsByBillId(id);
    }

    /**
     * 查询采购入库单
     */

    public List<PwBillVo> PWBillList() {

        return tpwBillMapper.findPwBillList(null, null);
    }

    public PwBillVo findTPwBillById(String id) {
        return tpwBillMapper.findTPwBillById(id);
    }

    public List<PwBillVo> findPwBillDetailById(String id) {
        return tpwBillMapper.findDetailById(id);
    }

    public void updateTPwBill(TPwBill bill) {
        tpwBillMapper.updateTPwBill(bill);

    }


    public List<TWsBill> findTWsBillbyCondition(String condition) {
        return wsBillMapper.findTWsBillbyCondition(condition);
    }

    public List<PwBillVo> findPwBillList(String keyword, String wareHouseId) {
        return tpwBillMapper.findPwBillList(keyword, wareHouseId);
    }

    /**
     * 判断是否是仓库管理员
     */
    public Warehouse isWarehouse(String userId) {
        //查询该用户的部门名称是否有所对应的仓库

        return userMapper.findUserWarehouse(userId);


    }

    /**
     * 根据warehouse查询出库单总单
     */
    public List<TWsBill> getBillByWarehouse(String id, String condition) {
        Map<String, String> map = new HashMap();
        map.put("warehouseId", id);
        if (StringUtils.isNotBlank(condition)) {
            map.put("condition", condition);
        }
        return wsBillMapper.getBillByWarehouse(map);
    }

    /**
     * 根据warehouse查询出库单详单
     */
    public List<TWsBill> getBillDetailByWarehouse(String id, String warehouseId) {
        TWsBill bill = new TWsBill();
        bill.setId(id);
        bill.setWarehouseId(warehouseId);
        return wsBillMapper.findDetailByBillIdAndWarehouse(bill);

    }

    @Override
    public int update(TWsBillDetail tWsBillDetail) {
        return tWsBillDetailMapper.updateByPrimaryKeySelective(tWsBillDetail);
    }

    @Override
    public void changebillstatus(String id) {
        List<TWsBillDetail> tWsBillDetails = tWsBillDetailMapper.selectBillDetailByBillId(id);
        boolean flag = false;
        if (tWsBillDetails != null) {
            for (TWsBillDetail billDetail : tWsBillDetails) {
                if (StringUtils.isBlank(billDetail.getExpressCompany())) {
                    flag = true;
                }
            }
        }
        if (flag) {
            tWsBillMapper.updateBillStatus("3001", id);
        } else {
            wsBillMapper.updateBillStatus("3000", id);
        }
    }

    @Override
    @Transient
    public boolean send(String billId, String[] billDetailIds) {
        boolean flag = false;
        HashMap<String, Object> map = new ManagedMap<>();
        map.put("list", Arrays.asList(billDetailIds));

        //根据子订单数量是否唯一来判断是主订单还是子订单
        int countBillDetailByBillId = tWsBillDetailMapper.countBillDetailByBillId(billId);
        if (countBillDetailByBillId == 1 && billDetailIds.length == 1)
            flag = sendTid(billId);
        else
            flag = sendSubTid(billId, billDetailIds);
        //判断发货是否成功
        if (flag) {
            logger.info("发货成功.....................................");
            map.put("state", 1);
        } else {
            logger.info("发货失败......................................");
            map.put("state", 2);
        }
        logger.info("更改子订单的发货状态.............................");
        tWsBillDetailMapper.changeSendState(map);

        return flag;
    }

    @Override
    public List<String> findPermissionByUserId(String userId) {
        return userMapper.findPermissionByUserId(userId);
    }


    private boolean sendSubTid(String billId, String[] billDetailIds) {
        //得到tid
        TWsBill tWsBill = tWsBillMapper.findTWsBillById(billId);
        Long tid = Long.parseLong(tWsBill.getShopNum());
        HashMap<String, String> hashMap = new HashMap<>();
        //用tWsBillDetailMapper查询出对应的list查询出对应的list<TWsBillDetail>
        List<TWsBillDetail> tWsBillDetails = tWsBillDetailMapper.selectBillDetailByBillDetailId(Arrays.asList(billDetailIds));
        for (TWsBillDetail twsBilldetail : tWsBillDetails) {
            //todo
//            if (StringUtils.isBlank(twsBilldetail.getOid()))
//                throw new RuntimeException("此订单中没有子订单的订单，请添加.....");
            //得到物流单号和公司编码
            String expressNum = twsBilldetail.getExpressNum();
            String expressCompany = twsBilldetail.getExpressCompany();
            String expressCode = getExpressCodeByExpressCompany(expressCompany);
            //如果没有物流单号的话直接返回
            if (StringUtils.isBlank(expressCode)) {
                return false;
            }
            //拼接物流单号和公司编码作为HashMap的Key
            String expressMessage = expressNum + ";" + expressCode;
            //如果已经存在key 就 把oid 拼接到value后面
            if (hashMap.containsKey(expressMessage)) {
                hashMap.put(expressMessage, hashMap.get(expressMessage) + "," + twsBilldetail.getOid());
            } else {
                hashMap.put(expressMessage, twsBilldetail.getOid());
            }
        }
        Boolean send = false;
        //循环发货
        logger.info("物流发货.................................");
        for (Map.Entry<String, String> entry : hashMap.entrySet()) {
            String key = entry.getKey();
            String exNum = key.substring(0, key.indexOf(";"));
            String exCode = key.substring(key.indexOf(";") + 1);
            send = TbaoUtils.sendLogistics(entry.getValue(), tid, exNum, exCode).getIsSuccess();
            logger.info("tid:" + tid + "。。。。。subTid:" + entry.getValue() + "。。。。。outSid:" + exNum + "。。。。。exCode:" + exCode);
        }
        logger.info("发货完毕..................................");
        return send;
    }

    /*
     *
     * 根据主订单的订单id来进行发货的方法
     * */
    private boolean sendTid(String billId) {
        //调用主订单接口
        TWsBill tWsBill = tWsBillMapper.findTWsBillById(billId);
        //TODO 可能会包空指针和数据转换异常
        Long tid = Long.parseLong(tWsBill.getShopNum());
        String expressNum = null;
        String expressCode = null;
        String expressCompany = null;

        /*
        查询子订单，看是否存在express_num,如果不存在就说明express_num在父订单中
        */
        TWsBillDetail tWsBillDetail = tWsBillDetailMapper.findTwsBillDetailByBillId(billId);
        expressNum = tWsBillDetail.getExpressNum();
        expressCompany = tWsBillDetail.getExpressCompany();
        expressCode = getExpressCodeByExpressCompany(expressCompany);

        //如果没有物流单号的话直接返回
        if (StringUtils.isBlank(expressCode))
            return false;

        //如果为空就调用本来的方法
        if (StringUtils.isBlank(expressNum)) {
            expressNum = tWsBill.getExpressNum();
            expressCompany = tWsBill.getExpressCompany();
            expressCode = getExpressCodeByExpressCompany(expressCompany);
        }

        //如果主订单中没有物流信息就说明物流信息在子订单中，则查询子订单，到子订单中获取物流信息*//*
//        if (StringUtils.isNotBlank(tWsBill.getExpressNum())) {
//            expressNum = tWsBill.getExpressNum();
//            expressCompany = tWsBill.getExpressCompany();
//            expressCode = getExpressCodeByExpressCompany(expressCompany);
//        } else {
//            TWsBillDetail tWsBillDetail = tWsBillDetailMapper.findTwsBillDetailByBillId(billId);
//            expressNum = tWsBillDetail.getExpressNum();
//            expressCompany = tWsBillDetail.getExpressCompany();
//            expressCode = getExpressCodeByExpressCompany(expressCompany);
//        }

        Boolean send = TbaoUtils.sendLogistics(null, tid, expressNum, expressCode).getIsSuccess();
        logger.info("物流发货.......................");
        logger.info("tid:" + tid + "。。。。。outSid:" + expressNum + "。。。。。exCode:" + expressCode);
        logger.info("发货完毕........................");
        return send;
    }

    //根据快递公司名称查询快递公司的编码
    private String getExpressCodeByExpressCompany(String expressCompany) {
        logger.info("根据快递公司查询编码...............................");
        String expressCode = null;
        TlogisticsCompany tlogisticsCompany = tlogisticsCompanyMapper.findByCompany(expressCompany);
        if (tlogisticsCompany != null) {
            expressCode = tlogisticsCompany.getCpCode();
        } else {
            logger.info("查不到物流公司的编号................................");
        }
        return expressCode;
    }

}
