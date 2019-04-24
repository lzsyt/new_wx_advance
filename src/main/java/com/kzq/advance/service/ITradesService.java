package com.kzq.advance.service;


import com.kzq.advance.domain.*;
import com.taobao.api.domain.Item;
import com.taobao.api.domain.Order;
import com.taobao.api.response.TradeFullinfoGetResponse;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zmn
 * @since 2018-08-16
 */
public interface ITradesService {
    public TtradesOrder formOrder(Order t);
    public void addWsbill(String param);
    //插入商品链接
    public void addGoodLink(Item item);

   //插入sku属性
    public void addGoodSku(TGoodsSku sku);
    //更新sku属性
    public void updateGoodSku(TGoodsSku sku);
    //更新链接
    public void updateLink(Item item);
    //根据id查询link
    public TGoodsLink findLinkById(Long numIid);
    //根据id查询sku
    public TGoodsSku findSkuById(Long skuId);
    //获取没有主图的链接
    public List<TGoodsLink> selectByPic();
    //获取所有sessionKey
    public List<TShop> selectAllShop();
    //获取店铺的sessionKey
    public TShop selectSessionKey(Integer id);
    //分割型号的字符串
    public Map<String,String> getProperty(String PropertyAlias);
    //获取一个订单的详情
    public TradeFullinfoGetResponse getOrder(String tid,String shopId);
    //获取一个订单的备注
    public String getMemo(String tid, String shopId);

    /**
     * 查询一个店铺的信息
     * @param shop
     * @return
     */
    public TShop selectShop(TShop shop);

    /**
     * 只更新不删除
     * @param item
     */
    public void updateLinkNotDele(Item item);

    /**
     *根据订单号查询订单信息
     */
    public Trades findTrade(Long tid);
    /**
     *  根据店铺名所有查询链接numiid
     */
    public List<TGoodsLink> selectByShop(String nick);

}
