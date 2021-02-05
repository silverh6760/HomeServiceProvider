package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.entity.User;
import ir.simsoft.homeserviceprovider.repository.enums.UserRole;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserDao extends CrudRepository<User,Integer> {

    Optional<User> findUserByEmail(String email);
    List<User> findAllByUserRole(UserRole userRole);

    @Transactional
    @Modifying
    @Query(value="DELETE FROM User user WHERE user.userRole=:userRole")
    void deleteAllExperts(@Param("userRole")UserRole userRole);

    User findByEmail(String email);
}
