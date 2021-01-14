package ir.simsoft.homeserviceprovider.repository.entity;

import ir.simsoft.homeserviceprovider.repository.enums.ConfirmationState;
import ir.simsoft.homeserviceprovider.repository.enums.UserRole;

import javax.persistence.*;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class User {
    @Id @GeneratedValue(strategy = GenerationType.TABLE)
    private Integer id;
    private String name;
    private String family;
    private String email;
    private String password;
    @Enumerated(EnumType.STRING)
    private UserRole userRole;
    private Boolean enabled=false;
//    @Enumerated(EnumType.STRING)
//    private ConfirmationState confirmationState;

//    public ConfirmationState getConfirmationState() {
//        return confirmationState;
//    }
//
//    public void setConfirmationState(ConfirmationState confirmationState) {
//        this.confirmationState = confirmationState;
//    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }
//
//    public String getPhoto() {
//        return photo;
//    }
//
//    public void setPhoto(String photo) {
//        this.photo = photo;
//    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFamily() {
        return family;
    }

    public void setFamily(String family) {
        this.family = family;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserRole getUserRole() {
        return userRole;
    }

    public void setUserRole(UserRole userRole) {
        this.userRole = userRole;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }
//    @Transient
//    public String getPhotoImagePath() {
//        if (photo == null || id == null) return null;
//
//        return "/user-photos/" + id + "/" + photo;
//    }

    @Override
    public String toString() {

        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", family='" + family + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", userRole=" + userRole +
                ", enabled=" + enabled +
                '}';
    }
}
