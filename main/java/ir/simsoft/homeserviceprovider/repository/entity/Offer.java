package ir.simsoft.homeserviceprovider.repository.entity;

import javax.persistence.ManyToOne;
import java.sql.Time;
import java.time.Duration;
import java.util.Date;

public class Offer {
    private Integer id;
    private Long proposedPrice;
    private Duration durationOfWork;
    private Time startHour;
    @ManyToOne
    Expert expert;
    @ManyToOne
    Orders orders;
}
