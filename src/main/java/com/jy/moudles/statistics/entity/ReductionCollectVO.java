package com.jy.moudles.statistics.entity;

/**
 * Created by wb on 2017/11/1.
 */
public class ReductionCollectVO {

    private String orgName;

    private int count;

    private String suffix;

    /**
     * 识别结果--0未知，1确认作弊，2非作弊
     */
    private int recognitionResult;

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getSuffix() {
        return suffix;
    }

    public void setSuffix(String suffix) {
        this.suffix = suffix;
    }

    public int getRecognitionResult() {
        return recognitionResult;
    }

    public void setRecognitionResult(int recognitionResult) {
        this.recognitionResult = recognitionResult;
    }
}
