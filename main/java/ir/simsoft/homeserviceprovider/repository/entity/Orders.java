package ir.simsoft.homeserviceprovider.repository.entity;

import ir.simsoft.homeserviceprovider.repository.enums.OrderState;
import org.hibernate.annotations.CreationTimestamp;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.util.Date;
@Entity
public class Orders {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @CreationTimestamp
    private Date orderDate;
    @Temporal(value = TemporalType.DATE)
    private Date dueDate;
    private String taskDescription;
    private String address;
    private Long proposedPrice;
    @Enumerated(value = EnumType.STRING)
    private OrderState orderState;
    @ManyToOne
    private User customer;
    @ManyToOne
    private SubServices subServices;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getTaskDescription() {
        return taskDescription;
    }

    public void setTaskDescription(String taskDescription) {
        this.taskDescription = taskDescription;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Long getProposedPrice() {
        return proposedPrice;
    }

    public void setProposedPrice(Long proposedPrice) {
        this.proposedPrice = proposedPrice;
    }

    public OrderState getOrderState() {
        return orderState;
    }

    public void setOrderState(OrderState orderState) {
        this.orderState = orderState;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public SubServices getSubServices() {
        return subServices;
    }

    public void setSubServices(SubServices subServices) {
        this.subServices = subServices;
    }

    @Override
    public String toString() {
        return "Orders{" +
                "id=" + id +
                ", orderDate=" + orderDate +
                ", dueDate=" + dueDate +
                ", taskDescription='" + taskDescription + '\'' +
                ", address='" + address + '\'' +
                ", proposedPrice=" + proposedPrice +
                ", orderState=" + orderState +
                ", customer=" + customer +
                ", subServices=" + subServices +
                '}';
    }
}
