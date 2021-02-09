package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.Orders;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Repository
public interface OrdersDao extends CrudRepository<Orders,Integer>, JpaSpecificationExecutor<Orders> {

    static Specification<Orders> findBy(Orders orders) {
        return (Specification<Orders>) (root, criteriaQuery, criteriaBuilder) -> {

            CriteriaQuery<Orders> query = criteriaBuilder.createQuery(Orders.class);
            List<Predicate> conditions = new ArrayList<>();

            if (!orders.getSubServices().getName().equals("")) {
                //Join<Orders, SubServices> subServicesJoin = root.join("subServices", JoinType.INNER);
                conditions.add(criteriaBuilder.like(root.get("subServices").get("name"), "%" + orders.getSubServices().getName() + "%"));
            }
            if (!orders.getSubServices().getServices().getName().equals("")) {
//                Join<Orders, SubServices> subServicesJoin = root.join("subServices", JoinType.INNER);
//                Join<Orders, Services> servicesJoin=root.join("services",JoinType.INNER);
                conditions.add(criteriaBuilder.like(root.get("subServices").get("services").get("name"), "%" + orders.getSubServices().getServices().getName() + "%"));
            }
            if (Objects.nonNull(orders.getOrderState())) {
                conditions.add(criteriaBuilder.equal(root.get("orderState"), orders.getOrderState()));
            }
            if (Objects.nonNull(orders.getDueDate())) {
                conditions.add(criteriaBuilder.equal(root.get("dueDate"), orders.getDueDate()));
            }
            if (Objects.nonNull(orders.getOrderDate())) {
                conditions.add(criteriaBuilder.equal(root.get("orderDate"),  orders.getOrderDate()));
            }
            CriteriaQuery<Orders> expertCriteriaQuery = query.select(root)
                    .where(conditions.toArray(new Predicate[]{}));
            return expertCriteriaQuery.getRestriction();
        };
    }

    @Query("select orders from Orders orders where orders.customer.email=:email")
    List<Orders> getAllOrdersByCustomerEmail(@Param("email") String email);

    @Query("select orders from Orders orders where orders.subServices.id=:id")
    List<Orders> getAllOrderBySubService(@Param("id") int id);

    @Query("select orders from Orders orders where orders.subServices.id=:id and" +
            " orders.orderState=\'WAITING_FOR_EXPERT_TO_COME\' ")
    List<Orders> getAllOrderComeHomeBySubService(@Param("id") int id);

    @Query("select orders from Orders orders where orders.customer.email=:email and " +
            "orders.orderState=\'WAITING_FOR_EXPERT_SELECTION\'")
    List<Orders> getAllOrdersByCustomerEmailForExpertSelection(@Param("email") String email);

    @Query("select orders from Orders orders where orders.customer.email=:email")
    List<Orders> allOrdersByCustomerEmail(@Param("email") String email);

}
