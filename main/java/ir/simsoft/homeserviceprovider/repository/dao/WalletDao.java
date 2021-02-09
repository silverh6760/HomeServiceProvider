package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.Wallet;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WalletDao extends CrudRepository<Wallet,Integer> {

    Wallet findByExpert(Expert expert);

}
