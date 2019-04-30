package com.kzq.advance.domain;

public class JobState {
    private Integer id;

    private String jobName;

    private String jobClass;

    private String jobGroup;

    private Integer jobState;

    private String cronExpression;

    private String cronExplain;

    @Override
    public String toString() {
        return "JobState{" +
                "id=" + id +
                ", jobName='" + jobName + '\'' +
                ", jobClass='" + jobClass + '\'' +
                ", jobGroup='" + jobGroup + '\'' +
                ", jobState=" + jobState +
                ", cronExpression='" + cronExpression + '\'' +
                ", cronExplain='" + cronExplain + '\'' +
                '}';
    }

    public JobState() {
        super();
    }

    public JobState(String jobClass, String jobGroup, String cronExpression) {
        this.jobClass = jobClass;
        this.jobGroup = jobGroup;
        this.cronExpression = cronExpression;
    }

    public Integer getId() {
        return id;
    }

    public JobState setId(Integer id) {
        this.id = id;
        return this;
    }

    public String getJobName() {
        return jobName;
    }

    public JobState setJobName(String jobName) {
        this.jobName = jobName == null ? null : jobName.trim();
        return this;
    }

    public String getJobClass() {
        return jobClass;
    }

    public JobState setJobClass(String jobClass) {
        this.jobClass = jobClass == null ? null : jobClass.trim();
        return this;
    }

    public String getJobGroup() {
        return jobGroup;
    }

    public JobState setJobGroup(String jobGroup) {
        this.jobGroup = jobGroup == null ? null : jobGroup.trim();
        return this;
    }

    public Integer getJobState() {
        return jobState;
    }

    public JobState setJobState(Integer jobState) {
        this.jobState = jobState;
        return this;
    }

    public String getCronExpression() {
        return cronExpression;
    }

    public JobState setCronExpression(String cronExpression) {
        this.cronExpression = cronExpression == null ? null : cronExpression.trim();
        return this;
    }

    public String getCronExplain() {
        return cronExplain;
    }

    public JobState setCronExplain(String cronExplain) {
        this.cronExplain = cronExplain == null ? null : cronExplain.trim();
        return this;
    }
}