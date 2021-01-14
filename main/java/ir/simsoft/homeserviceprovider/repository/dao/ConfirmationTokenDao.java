package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.entity.ConfirmationToken;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ConfirmationTokenDao extends CrudRepository<ConfirmationToken,Integer> {
    Optional<ConfirmationToken> findConfirmationTokenByConfirmationToken(String token);
}
