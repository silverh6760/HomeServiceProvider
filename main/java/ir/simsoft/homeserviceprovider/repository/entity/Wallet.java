package ir.simsoft.homeserviceprovider.repository.entity;

import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.util.Date;

@Entity
public class Wallet {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Date lastCharge;
    private Long balance;
    @OneToOne
    private Expert expert;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getLastCharge() {
        return lastCharge;
    }

    public void setLastCharge(Date lastCharge) {
        this.lastCharge = lastCharge;
    }

    public Long getBalance() {
        return balance;
    }

    public void setBalance(Long balance) {
        this.balance = balance;
    }

    public Expert getExpert() {
        return expert;
    }

    public void setExpert(Expert expert) {
        this.expert = expert;
    }
}
