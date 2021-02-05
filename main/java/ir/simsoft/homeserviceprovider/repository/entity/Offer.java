package ir.simsoft.homeserviceprovider.repository.entity;

import javax.persistence.*;
import java.sql.Time;
import java.time.Duration;
import java.time.LocalTime;
import java.util.Date;
@Entity
public class Offer {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Long proposedPrice;
    private Integer durationOfWork;
    private LocalTime startHour;
    @ManyToOne
    Expert expert;
    @ManyToOne(cascade = CascadeType.PERSIST)
    Orders orders;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Long getProposedPrice() {
        return proposedPrice;
    }

    public void setProposedPrice(Long proposedPrice) {
        this.proposedPrice = proposedPrice;
    }

    public Integer getDurationOfWork() {
        return durationOfWork;
    }

    public void setDurationOfWork(Integer durationOfWork) {
        this.durationOfWork = durationOfWork;
    }

    public LocalTime getStartHour() {
        return startHour;
    }

    public void setStartHour(LocalTime startHour) {
        this.startHour = startHour;
    }

    public Expert getExpert() {
        return expert;
    }

    public void setExpert(Expert expert) {
        this.expert = expert;
    }

    public Orders getOrders() {
        return orders;
    }

    public void setOrders(Orders orders) {
        this.orders = orders;
    }

    @Override
    public String toString() {
        return "Offer{" +
                "id=" + id +
                ", proposedPrice=" + proposedPrice +
                ", durationOfWork=" + durationOfWork +
                ", startHour=" + startHour +
                ", expert=" + expert +
                ", orders=" + orders +
                '}';
    }
}
