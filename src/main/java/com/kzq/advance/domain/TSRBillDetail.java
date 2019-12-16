package com.kzq.advance.domain;

import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class TSRBillDetail {
    private String id;

    private Date dateCreated;

    private String goodsId;

    private String goodsName;

    private BigDecimal goodsCount;

    private BigDecimal goodsMoney;

    private BigDecimal goodsPrice;

    private BigDecimal inventoryMoney;

    private BigDecimal inventoryPrice;

    private BigDecimal rejectionGoodsCount;

    private BigDecimal rejectionGoodsPrice;

    private BigDecimal rejectionSaleMoney;

    private Integer showOrder;

    private String srbillId;

    private String wsbilldetailId;

    private String snNote;

    private String dataOrg;

    private String companyId;

    private String warehouseId;

    private String exchangeReturn;

    private String status;

    private String detection;

    private String cpCode;

    private String cpCodeName;

    private String expressNum;

    private List<MultipartFile> images;

    private List<MultipartFile> vdos;

    public String getCpCode() {
        return cpCode;
    }

    public void setCpCode(String cpCode) {
        this.cpCode = cpCode;
    }

    public String getCpCodeName() {
        return cpCodeName;
    }

    public void setCpCodeName(String cpCodeName) {
        this.cpCodeName = cpCodeName;
    }

    public String getExpressNum() {
        return expressNum;
    }

    public void setExpressNum(String expressNum) {
        this.expressNum = expressNum;
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

    public String getDetection() {
        return detection;
    }

    public void setDetection(String detection) {
        this.detection = detection;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getExchangeReturn() {
        return exchangeReturn;
    }

    public void setExchangeReturn(String exchangeReturn) {
        this.exchangeReturn = exchangeReturn;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
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

    public BigDecimal getInventoryMoney() {
        return inventoryMoney;
    }

    public void setInventoryMoney(BigDecimal inventoryMoney) {
        this.inventoryMoney = inventoryMoney;
    }

    public BigDecimal getInventoryPrice() {
        return inventoryPrice;
    }

    public void setInventoryPrice(BigDecimal inventoryPrice) {
        this.inventoryPrice = inventoryPrice;
    }

    public BigDecimal getRejectionGoodsCount() {
        return rejectionGoodsCount;
    }

    public void setRejectionGoodsCount(BigDecimal rejectionGoodsCount) {
        this.rejectionGoodsCount = rejectionGoodsCount;
    }

    public BigDecimal getRejectionGoodsPrice() {
        return rejectionGoodsPrice;
    }

    public void setRejectionGoodsPrice(BigDecimal rejectionGoodsPrice) {
        this.rejectionGoodsPrice = rejectionGoodsPrice;
    }

    public BigDecimal getRejectionSaleMoney() {
        return rejectionSaleMoney;
    }

    public void setRejectionSaleMoney(BigDecimal rejectionSaleMoney) {
        this.rejectionSaleMoney = rejectionSaleMoney;
    }

    public Integer getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(Integer showOrder) {
        this.showOrder = showOrder;
    }

    public String getSrbillId() {
        return srbillId;
    }

    public void setSrbillId(String srbillId) {
        this.srbillId = srbillId == null ? null : srbillId.trim();
    }

    public String getWsbilldetailId() {
        return wsbilldetailId;
    }

    public void setWsbilldetailId(String wsbilldetailId) {
        this.wsbilldetailId = wsbilldetailId == null ? null : wsbilldetailId.trim();
    }

    public String getSnNote() {
        return snNote;
    }

    public void setSnNote(String snNote) {
        this.snNote = snNote == null ? null : snNote.trim();
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

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId == null ? null : warehouseId.trim();
    }
}