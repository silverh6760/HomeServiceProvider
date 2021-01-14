package ir.simsoft.homeserviceprovider.repository.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import ir.simsoft.homeserviceprovider.repository.enums.ConfirmationState;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Expert extends User {
    private String photo;
    @Enumerated(EnumType.STRING)
    private ConfirmationState confirmationState;

    @ManyToMany(cascade = CascadeType.MERGE)
    private List<SubServices> subServicesList=new ArrayList<>();

    private int score;

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }


    public ConfirmationState getConfirmationState() {
        return confirmationState;
    }

    public List<SubServices> getSubServicesList() {
        return subServicesList;
    }

    public void setSubServicesList(List<SubServices> subServicesList) {
        this.subServicesList = subServicesList;
    }

    public void setConfirmationState(ConfirmationState confirmationState) {
        this.confirmationState = confirmationState;
    }
    @Transient
    public String getPhotoImagePath() {
        if (photo == null || super.getId() == null) return null;

        return "/user-photos/" + super.getId() + "/" + photo;
    }

    @Override
    public String toString() {
        return "Expert{" +
                "photo='" + photo + '\'' +
                ", confirmationState=" + confirmationState +
                ", subServicesList=" + subServicesList +
                ", score=" + score +
                "} " + super.toString();
    }
}
