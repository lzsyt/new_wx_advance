package com.kzq.advance.domain;

import java.math.BigDecimal;

public class TFinanceInputDetail {
    private Long id;

    private Long financeId;

    private Integer shop;

    private BigDecimal withdrawMoney;

    private BigDecimal withdrawTotal;

    private BigDecimal payMoney;

    private BigDecimal payTotal;

    private BigDecimal expendMoney;

    private BigDecimal expendTotal;

    private BigDecimal sumTotal;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getFinanceId() {
        return financeId;
    }

    public void setFinanceId(Long financeId) {
        this.financeId = financeId;
    }

    public Integer getShop() {
        return shop;
    }

    public void setShop(Integer shop) {
        this.shop = shop;
    }

    public BigDecimal getWithdrawMoney() {
        return withdrawMoney;
    }

    public void setWithdrawMoney(BigDecimal withdrawMoney) {
        this.withdrawMoney = withdrawMoney;
    }

    public BigDecimal getWithdrawTotal() {
        return withdrawTotal;
    }

    public void setWithdrawTotal(BigDecimal withdrawTotal) {
        this.withdrawTotal = withdrawTotal;
    }

    public BigDecimal getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(BigDecimal payMoney) {
        this.payMoney = payMoney;
    }

    public BigDecimal getPayTotal() {
        return payTotal;
    }

    public void setPayTotal(BigDecimal payTotal) {
        this.payTotal = payTotal;
    }

    public BigDecimal getExpendMoney() {
        return expendMoney;
    }

    public void setExpendMoney(BigDecimal expendMoney) {
        this.expendMoney = expendMoney;
    }

    public BigDecimal getExpendTotal() {
        return expendTotal;
    }

    public void setExpendTotal(BigDecimal expendTotal) {
        this.expendTotal = expendTotal;
    }

    public BigDecimal getSumTotal() {
        return sumTotal;
    }

    public void setSumTotal(BigDecimal sumTotal) {
        this.sumTotal = sumTotal;
    }
}