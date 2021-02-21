package ir.simsoft.homeserviceprovider.repository.dto;

import ir.simsoft.homeserviceprovider.repository.entity.Expert;

import java.util.Date;

public class BillInfoDto {
    private Date startDate;
    private Date endDate;
    private Expert expert;
    private Long numberOfRequest;

    public BillInfoDto(Expert expert, Long numberOfRequest) {
        this.expert = expert;
        this.numberOfRequest = numberOfRequest;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Expert getExpert() {
        return expert;
    }

    public void setExpert(Expert expert) {
        this.expert = expert;
    }

    public Long getNumberOfRequest() {
        return numberOfRequest;
    }

    public void setNumberOfRequest(Long numberOfRequest) {
        this.numberOfRequest = numberOfRequest;
    }
}
