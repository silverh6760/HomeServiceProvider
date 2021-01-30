package ir.simsoft.homeserviceprovider.repository.entity;

import ir.simsoft.homeserviceprovider.repository.enums.OrderState;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.util.Date;
@Entity
public class Orders {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @CreationTimestamp
    private Date orderDate;
    private Date dueDate;
    private String taskDescription;
    private String address;
    private Long proposedPrice;
    @Enumerated(value = EnumType.STRING)
    private OrderState orderState;
    @ManyToOne
    private Customer customer;
    @ManyToOne
    private SubServices subServices;

}
