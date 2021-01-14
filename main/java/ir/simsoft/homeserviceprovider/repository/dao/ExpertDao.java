package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.SubServices;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


@Repository
public interface ExpertDao extends CrudRepository<Expert, Integer>, JpaSpecificationExecutor<Expert> {


    static Specification<Expert> findBy(Expert expert) {
        return (Specification<Expert>) (root, criteriaQuery, criteriaBuilder) -> {

            CriteriaQuery<Expert> query = criteriaBuilder.createQuery(Expert.class);
            List<Predicate> conditions = new ArrayList<>();

            if (!expert.getSubServicesList().get(0).getName().equals("")) {
                Join<Expert, SubServices> expertService = root.join("subServicesList", JoinType.INNER);
                conditions.add(criteriaBuilder.like(expertService.get("name"), "%" + expert.getSubServicesList().get(0).getName() + "%"));
            }
            if (Objects.nonNull(expert.getName())) {
                conditions.add(criteriaBuilder.like(root.get("name"), "%" + expert.getName() + "%"));
            }
            if (Objects.nonNull(expert.getFamily())) {
                conditions.add(criteriaBuilder.like(root.get("family"), "%" + expert.getFamily() + "%"));
            }
            if (Objects.nonNull(expert.getEmail())) {
                conditions.add(criteriaBuilder.like(root.get("email"), "%" + expert.getEmail() + "%"));
            }
            if (expert.getScore()>0) {
                conditions.add(criteriaBuilder.equal(root.get("score"), expert.getScore()));
            }
            if (Objects.nonNull(expert.getConfirmationState())) {
                conditions.add(criteriaBuilder.equal(root.get("confirmationState"), expert.getConfirmationState()));
            }
            CriteriaQuery<Expert> expertCriteriaQuery = query.select(root)
                    .where(conditions.toArray(new Predicate[]{}));
            return expertCriteriaQuery.getRestriction();
        };
    }

    Expert findByEmail(String email);
}
