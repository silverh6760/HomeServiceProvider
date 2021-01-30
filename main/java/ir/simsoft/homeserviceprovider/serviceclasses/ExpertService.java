package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.repository.dao.ExpertDao;
import ir.simsoft.homeserviceprovider.repository.dao.UserDao;
import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.SubServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ExpertService extends UserService{
    private ExpertDao expertDao;
    @Autowired
    public ExpertService(ExpertDao expertDao,UserDao userDao, PasswordEncoder passwordEncoder,
                         ConfirmationTokenService confirmationTokenService,
                         EmailSenderService emailSenderService) {
        super(userDao, passwordEncoder, confirmationTokenService, emailSenderService);
        this.expertDao = expertDao;
    }

    public Expert registerExpert(Expert expert){
        expert.setPassword(passwordEncoder.encode(expert.getPassword()));
    return expertDao.save(expert);
}


    public Expert getExpertById(int i) {
        Optional<Expert> byId = expertDao.findById(i);
        return byId.get();
    }

    public Expert getExpertByEmail(String  email) {
        Expert byEmail = expertDao.findByEmail(email);
        return byEmail;
    }
    public List<Expert> findBySpecifiedField(Expert expert) {
        List<Expert> experts = expertDao.findAll(ExpertDao.findBy(expert));
        return experts;
    }
    public List<Expert> findAllExperts(){
        return expertDao.findAllExperts();
    }

    public void updateExpert(Expert expertById) {
        Optional<Expert> byId = expertDao.findById(expertById.getId());
        //byId.get().getSubServicesList()
        if(byId.isPresent()){
            expertDao.save(byId.get());
        }
    }

    public void saveExpert(Expert expertById) {
        expertDao.save(expertById);
    }

    public List<Expert> findAllExpertsBySubService(int id) {
        return expertDao.findAllExpertsBySubService(id);
    }
}
