package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.repository.dao.WalletDao;
import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.Wallet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WalletService {
    private WalletDao walletDao;
    @Autowired
    public WalletService(WalletDao walletDao) {
        this.walletDao = walletDao;
    }
    public void saveWallet(Wallet wallet){
        walletDao.save(wallet);
    }
    public Wallet getWalletByExpert(Expert expert){
        return walletDao.findByExpert(expert);
    }
}
