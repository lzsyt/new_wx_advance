package com.kzq.advance.domain;

import java.math.BigDecimal;
import java.util.Date;

public class TPwBillDetail {
    private String id;

    private Date dateCreated;

    private String goodsId;

    private BigDecimal goodsCount;

    private BigDecimal goodsMoney;

    private BigDecimal goodsPrice;

    private String pwbillId;

    private Integer showOrder;

    private String dataOrg;

    private String memo;

    private String companyId;

    private String pobilldetailId;

    private String goodName;

    public String getGoodName() {
        return goodName;
    }

    public void setGoodName(String goodName) {
        this.goodName = goodName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(String goodsId) {
        this.goodsId = goodsId == null ? null : goodsId.trim();
    }

    public BigDecimal getGoodsCount() {
        return goodsCount;
    }

    public void setGoodsCount(BigDecimal goodsCount) {
        this.goodsCount = goodsCount;
    }

    public BigDecimal getGoodsMoney() {
        return goodsMoney;
    }

    public void setGoodsMoney(BigDecimal goodsMoney) {
        this.goodsMoney = goodsMoney;
    }

    public BigDecimal getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(BigDecimal goodsPrice) {
        this.goodsPrice = goodsPrice;
    }

    public String getPwbillId() {
        return pwbillId;
    }

    public void setPwbillId(String pwbillId) {
        this.pwbillId = pwbillId == null ? null : pwbillId.trim();
    }

    public Integer getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(Integer showOrder) {
        this.showOrder = showOrder;
    }

    public String getDataOrg() {
        return dataOrg;
    }

    public void setDataOrg(String dataOrg) {
        this.dataOrg = dataOrg == null ? null : dataOrg.trim();
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo == null ? null : memo.trim();
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId == null ? null : companyId.trim();
    }

    public String getPobilldetailId() {
        return pobilldetailId;
    }

    public void setPobilldetailId(String pobilldetailId) {
        this.pobilldetailId = pobilldetailId == null ? null : pobilldetailId.trim();
    }
}