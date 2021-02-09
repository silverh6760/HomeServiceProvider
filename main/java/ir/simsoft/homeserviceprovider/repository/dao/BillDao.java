package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.entity.Bill;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BillDao extends CrudRepository<Bill,Integer> {
    @Query("select bills from Bill bills where bills.orders.customer.email=:email and" +
            " bills.paymentStatus=\'Not_YET_PAID\'")
    List<Bill> findAllCustomerBill(@Param("email") String email);

    @Query("select bills from Bill bills where bills.expert.id=:id")
    List<Bill> findAllExpertBillById(@Param("id") int id);

    @Query("select bills from Bill bills where bills.orders.customer.id=:id")
    List<Bill> findAllUserBillById(int id);
}
