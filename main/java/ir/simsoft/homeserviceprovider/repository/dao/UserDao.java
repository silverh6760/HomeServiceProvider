package ir.simsoft.homeserviceprovider.repository.dao;


import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.User;
import ir.simsoft.homeserviceprovider.repository.enums.UserRole;
import org.hibernate.criterion.CriteriaQuery;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Repository
public interface UserDao extends CrudRepository<User,Integer> , JpaSpecificationExecutor<User> {

    static Specification<User> findBy(User user){
        return (Specification<User>)(root, criteriaQuery, criteriaBuilder) -> {
            javax.persistence.criteria.CriteriaQuery<User> query = criteriaBuilder.createQuery(User.class);
            List<Predicate> conditions = new ArrayList<>();
            if (Objects.nonNull(user.getName())) {
                conditions.add(criteriaBuilder.like(root.get("name"), "%" + user.getName() + "%"));
            }
            if (Objects.nonNull(user.getFamily())) {
                conditions.add(criteriaBuilder.like(root.get("family"), "%" + user.getFamily() + "%"));
            }
            if (Objects.nonNull(user.getEmail())) {
                conditions.add(criteriaBuilder.like(root.get("email"), "%" + user.getEmail() + "%"));
            }

            conditions.add(criteriaBuilder.equal(root.get("enabled"),true));
            javax.persistence.criteria.CriteriaQuery<User> userCriteriaQuery = query.select(root)
                    .where(conditions.toArray(new Predicate[]{}));
            return userCriteriaQuery.getRestriction();

        };
    }

    Optional<User> findUserByEmail(String email);
    List<User> findAllByUserRole(UserRole userRole);

    @Transactional
    @Modifying
    @Query(value="DELETE FROM User user WHERE user.userRole=:userRole")
    void deleteAllExperts(@Param("userRole")UserRole userRole);

    User findByEmail(String email);


}
