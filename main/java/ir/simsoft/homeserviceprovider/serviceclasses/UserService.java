package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.exceptions.BusinessException;
import ir.simsoft.homeserviceprovider.repository.dao.UserDao;
import ir.simsoft.homeserviceprovider.repository.entity.ConfirmationToken;
import ir.simsoft.homeserviceprovider.repository.entity.User;
import ir.simsoft.homeserviceprovider.repository.enums.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class UserService implements UserDetailsService {
    private UserDao userDao;
    public PasswordEncoder passwordEncoder;
    private ConfirmationTokenService confirmationTokenService;
    private EmailSenderService emailSenderService;

    @Autowired
    public UserService(UserDao userDao, PasswordEncoder passwordEncoder,
                       ConfirmationTokenService confirmationTokenService, EmailSenderService emailSenderService) {
        this.userDao = userDao;
        this.passwordEncoder = passwordEncoder;
        this.confirmationTokenService = confirmationTokenService;
        this.emailSenderService = emailSenderService;
    }
    //private Map<String, User> roles = new HashMap<>();

    public User registerUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userDao.save(user);

    }

    public List<User> getUsers() {
        List<User> all = (List<User>) userDao.findAll();
        return all;
    }
    public User getUserByEmail(String email){
       return userDao.findByEmail(email);
    }

    public void confirmUser(ConfirmationToken confirmationToken) {

        User user = confirmationToken.getUser();
        user.setEnabled(true);
        userDao.save(user);
        confirmationTokenService.deleteConfirmationToken(confirmationToken.getId());
    }

    public void sendConfirmationMail(String userMail, String token) {

        final SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setTo(userMail);
        mailMessage.setSubject("Mail Confirmation Link!");
        mailMessage.setFrom("<MAIL>");
        mailMessage.setText(
                "Thank you for registering. Please click on the below link to activate " +
                        "your account." + "http://localhost:8080/user/confirm?token="
                        + token);

        emailSenderService.sendEmail(mailMessage);
    }

    public Optional<User> checkUserEmail(User user) {
        Optional<User> userByEmail = userDao.findUserByEmail(user.getEmail());
        return userByEmail;
    }

    public boolean checkPassword(User user) {
        if (Objects.nonNull(user.getPassword())) {
            String regex1 = "^(.{0,7}|[^0-9]*|[^A-Z]*|[^a-z]*|[a-zA-Z0-9]*)$";
            String regex2 = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";
            if (user.getPassword().matches(regex2)) {
                return true;
            }
            return false;
        } else
            throw new NullPointerException(BusinessException.nullPointerForPass);
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<User> userByEmail = userDao.findUserByEmail(email);
        if (!userByEmail.isPresent())
            throw new UsernameNotFoundException("not found");
        if(userByEmail.get().getEnabled()==false){
            throw new UsernameNotFoundException("You are not confirmed yet!");
        }
        User user = userByEmail.get();
        Set<GrantedAuthority> authorities = new HashSet<>();
        authorities.add(new SimpleGrantedAuthority(user.getUserRole().toString()));
        return new org.springframework.security.core.userdetails.User(user.getEmail(), user.getPassword(), authorities);
    }


    public List<User> getExperts(UserRole expert) {
        return userDao.findAllByUserRole(expert);
    }

    public void updateUser(int id, User user) {
//        Optional<User> byId = userDao.findById(id);
//
//        if(byId.isPresent()){
//            byId.get().setConfirmationState(user.getConfirmationState());
//            userDao.save(byId.get());
//        }

    }

    public Optional<User> getUserById(int id) {
        Optional<User> byId = userDao.findById(id);
        return byId;
    }

    public void deleteAllExpert() {
        userDao.deleteAllExperts(UserRole.EXPERT);
    }

    public void deleteUserById(int id) {
        userDao.deleteById(id);
    }
}
