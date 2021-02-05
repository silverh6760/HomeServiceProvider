package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.entity.Orders;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrdersDao extends CrudRepository<Orders,Integer> {

    @Query("select orders from Orders orders where orders.customer.email=:email")
    List<Orders> getAllOrdersByCustomerEmail(@Param("email") String email);

    @Query("select orders from Orders orders where orders.subServices.id=:id and" +
            " orders.orderState=\'WAITING_FOR_EXPERTS_OFFER\' ")
    List<Orders> getAllOrderBySubService(@Param("id") int id);

    @Query("select orders from Orders orders where orders.customer.email=:email and " +
            "orders.orderState=\'WAITING_FOR_EXPERT_SELECTION\'")
    List<Orders> getAllOrdersByCustomerEmailForExpertSelection(@Param("email") String email);

    @Query("select orders from Orders orders where orders.customer.email=:email")
    List<Orders> allOrdersByCustomerEmail(@Param("email") String email);

}
