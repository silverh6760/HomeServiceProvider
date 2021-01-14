package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.repository.dao.ConfirmationTokenDao;
import ir.simsoft.homeserviceprovider.repository.entity.ConfirmationToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ConfirmationTokenService {
    private ConfirmationTokenDao confirmationTokenDao;
    @Autowired
    public ConfirmationTokenService(ConfirmationTokenDao confirmationTokenDao) {
        this.confirmationTokenDao = confirmationTokenDao;
    }

    public void saveConfirmationToken(ConfirmationToken confirmationToken){
        confirmationTokenDao.save(confirmationToken);
    }

    public void deleteConfirmationToken(Integer id){

        confirmationTokenDao.deleteById(id);
    }
    public Optional<ConfirmationToken> findConfirmationTokenByToken(String token){
        Optional<ConfirmationToken> confirmationTokenByToken = confirmationTokenDao.findConfirmationTokenByConfirmationToken(token);
        return confirmationTokenByToken;
    }

}
