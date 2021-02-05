package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.Services;
import ir.simsoft.homeserviceprovider.repository.entity.SubServices;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Predicate;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Repository
public interface SubServicesDao extends CrudRepository<SubServices,Integer>, JpaSpecificationExecutor<SubServices> {
    @Query("select subs from SubServices subs where subs.services.name=:category")
    List<SubServices> getSubServices(@Param("category") String category);

    @Query("select subs from SubServices subs where subs.services.id=:id")
    List<SubServices> getSubServicesBySerId(@Param("id") int id);

//    @Query("select subs from SubServices subs where subs.name=:name ")
    SubServices findByName( String name);

    static Specification<SubServices> findBy(SubServices subServices) {
        return (Specification<SubServices>) (root, criteriaQuery, criteriaBuilder) -> {

            CriteriaQuery<SubServices> query = criteriaBuilder.createQuery(SubServices.class);
            List<Predicate> conditions = new ArrayList<>();


            if (Objects.nonNull(subServices.getName())) {
                conditions.add(criteriaBuilder.like(root.get("name"), "%" + subServices.getName() + "%"));
            }
            if (Objects.nonNull(subServices.getBasePrice())) {
                conditions.add(criteriaBuilder.equal(root.get("basePrice"),subServices.getBasePrice()));
            }
            if (Objects.nonNull(subServices.getDescription())) {
                conditions.add(criteriaBuilder.like(root.get("description"), "%" + subServices.getDescription() + "%"));
            }
            if (!subServices.getServices().getName().equals("")) {
                Join<Expert, Services> subServiceJoin = root.join("services", JoinType.INNER);
                conditions.add(criteriaBuilder.like(subServiceJoin.get("name"), "%" + subServices.getServices().getName() + "%"));
            }
//            if (Objects.nonNull(subServices.getServices().getName())) {
//                conditions.add(criteriaBuilder.like(root.get("services.getName()"), "%" + subServices.getServices().getName() + "%"));
//            }

            CriteriaQuery<SubServices> subServicesCriteriaQuery = query.select(root)
                    .where(conditions.toArray(new Predicate[]{}));
            return subServicesCriteriaQuery.getRestriction();
        };
    }

    @Query("select subs from SubServices subs where subs.services.id=:id")
    List<SubServices> findAllByService(@Param("id") int id);




}
