package ir.simsoft.homeserviceprovider.repository.dto;

import ir.simsoft.homeserviceprovider.repository.entity.User;

import java.util.Date;

public class OrdersInfoDto {
    private Date startDate;
    private Date endDate;
    private User customer;
    private Long numberOfOrders;

    public OrdersInfoDto(User customer, Long numberOfOrders) {
        this.customer = customer;
        this.numberOfOrders = numberOfOrders;
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

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public Long getNumberOfOrders() {
        return numberOfOrders;
    }

    public void setNumberOfOrders(Long numberOfOrders) {
        this.numberOfOrders = numberOfOrders;
    }
}
