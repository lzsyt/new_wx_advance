package com.kzq.advance.domain;

public class TSRBillFile {
    private Long id;

    private String srdetailId;

    private String fileName;

    private Integer fileType;

    private String filePath;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSrdetailId() {
        return srdetailId;
    }

    public void setSrdetailId(String srdetailId) {
        this.srdetailId = srdetailId == null ? null : srdetailId.trim();
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName == null ? null : fileName.trim();
    }

    public Integer getFileType() {
        return fileType;
    }

    public void setFileType(Integer fileType) {
        this.fileType = fileType;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath == null ? null : filePath.trim();
    }
}