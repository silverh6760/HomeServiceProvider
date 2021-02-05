package ir.simsoft.homeserviceprovider.repository.entity;

import javax.persistence.*;

@Entity
public class Comments {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private int score;
    private String description;
    @ManyToOne
    private Expert expert;
    @ManyToOne
    private User user;
    @ManyToOne
    private Orders order;

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Expert getExpert() {
        return expert;
    }

    public void setExpert(Expert expert) {
        this.expert = expert;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Orders getOrder() {
        return order;
    }

    public void setOrder(Orders order) {
        this.order = order;
    }
}
