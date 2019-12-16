package com.kzq.advance.domain;

import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class TSRBill {
    private String id;

    private Integer billStatus;
    //业务日期
    private Date bizdt;

    private String bizUserId;

    private String bizUserName;

    private String customerId;

    private Date dateCreated;

    private String inputUserId;
    //本单据销售商品的库存价值
    private BigDecimal inventoryMoney;

    private BigDecimal profit;

    private String ref;

    private BigDecimal rejectionSaleMoney;

    private String warehouseId;

    private String warehouseName;

    private String wsBillId;

    private Integer paymentType;

    private String dataOrg;

    private String companyId;

    private String reason;
//维修、退货
    private Byte maintainSale;

    private String imagePath;

    private String tid;

    private String cpCode;

    private String cpCodeName;

    private String expressNum;

    private String search;
//备注：手写的商品详情
    private String memo;
//type=1，表示退货模块
    private Integer type;

    private String customerName;

    private String buyerNick;

    private List<TSRBillDetail> tsrBillDetail;

    private List<MultipartFile> images;

    private List<MultipartFile> vdos;

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }
    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
    public List<MultipartFile> getImages() {
        return images;
    }

    public void setImages(List<MultipartFile> images) {
        this.images = images;
    }

    public List<MultipartFile> getVdos() {
        return vdos;
    }

    public void setVdos(List<MultipartFile> vdos) {
        this.vdos = vdos;
    }

    public List<TSRBillDetail> getTsrBillDetail() {
        return tsrBillDetail;
    }

    public void setTsrBillDetail(List<TSRBillDetail> tsrBillDetail) {
        this.tsrBillDetail = tsrBillDetail;
    }

    public String getBuyerNick() {
        return buyerNick;
    }

    public void setBuyerNick(String buyerNick) {
        this.buyerNick = buyerNick;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCpCodeName() {
        return cpCodeName;
    }

    public void setCpCodeName(String cpCodeName) {
        this.cpCodeName = cpCodeName;
    }

    public Integer getBillStatus() {
        return billStatus;
    }

    public void setBillStatus(Integer billStatus) {
        this.billStatus = billStatus;
    }

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }

    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    public String getCpCode() {
        return cpCode;
    }

    public void setCpCode(String cpCode) {
        this.cpCode = cpCode;
    }

    public String getExpressNum() {
        return expressNum;
    }

    public void setExpressNum(String expressNum) {
        this.expressNum = expressNum;
    }

    public String getBizUserName() {
        return bizUserName;
    }

    public void setBizUserName(String bizUserName) {
        this.bizUserName = bizUserName;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Date getBizdt() {
        return bizdt;
    }

    public void setBizdt(Date bizdt) {
        this.bizdt = bizdt;
    }

    public String getBizUserId() {
        return bizUserId;
    }

    public void setBizUserId(String bizUserId) {
        this.bizUserId = bizUserId == null ? null : bizUserId.trim();
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId == null ? null : customerId.trim();
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getInputUserId() {
        return inputUserId;
    }

    public void setInputUserId(String inputUserId) {
        this.inputUserId = inputUserId == null ? null : inputUserId.trim();
    }

    public BigDecimal getInventoryMoney() {
        return inventoryMoney;
    }

    public void setInventoryMoney(BigDecimal inventoryMoney) {
        this.inventoryMoney = inventoryMoney;
    }

    public BigDecimal getProfit() {
        return profit;
    }

    public void setProfit(BigDecimal profit) {
        this.profit = profit;
    }

    public String getRef() {
        return ref;
    }

    public void setRef(String ref) {
        this.ref = ref == null ? null : ref.trim();
    }

    public BigDecimal getRejectionSaleMoney() {
        return rejectionSaleMoney;
    }

    public void setRejectionSaleMoney(BigDecimal rejectionSaleMoney) {
        this.rejectionSaleMoney = rejectionSaleMoney;
    }

    public String getWarehouseId() {
        return warehouseId;
    }

    public TSRBill setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId == null ? null : warehouseId.trim();
        return this;
    }

    public String getWsBillId() {
        return wsBillId;
    }

    public void setWsBillId(String wsBillId) {
        this.wsBillId = wsBillId == null ? null : wsBillId.trim();
    }

    public Integer getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(Integer paymentType) {
        this.paymentType = paymentType;
    }

    public String getDataOrg() {
        return dataOrg;
    }

    public void setDataOrg(String dataOrg) {
        this.dataOrg = dataOrg == null ? null : dataOrg.trim();
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId == null ? null : companyId.trim();
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason == null ? null : reason.trim();
    }

    public Byte getMaintainSale() {
        return maintainSale;
    }

    public void setMaintainSale(Byte maintainSale) {
        this.maintainSale = maintainSale;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath == null ? null : imagePath.trim();
    }
}