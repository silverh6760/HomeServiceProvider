package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.dto.BillInfoDto;
import ir.simsoft.homeserviceprovider.repository.entity.Bill;
import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
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

    @Query("select new ir.simsoft.homeserviceprovider.repository.dto.BillInfoDto(bills.expert ,count(bills)) from Bill bills" +
            " where bills.issueDate>=:startDate and bills.issueDate<=:endDate group by bills.expert")
    List<BillInfoDto> findAllBillDtoByStartEndDate(@Param("startDate") Date startDate,@Param("endDate") Date endDate);

    @Query("select new ir.simsoft.homeserviceprovider.repository.dto.BillInfoDto(bills.expert ,count(bills)) from Bill bills group by bills.expert")
    List<BillInfoDto> findAllBillDto();

    List<Bill> findByExpert(Expert expert);
}
