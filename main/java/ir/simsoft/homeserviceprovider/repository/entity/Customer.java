package ir.simsoft.homeserviceprovider.repository.entity;

import javax.persistence.Entity;

@Entity
public class Customer extends User {
    private String phoneNumber;

    @Override
    public String toString() {
        return "Customer{} " + super.toString();
    }
}
