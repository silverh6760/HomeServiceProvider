package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.entity.Offer;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OfferDao extends CrudRepository<Offer,Integer> {

    @Query("select offers from Offer offers where offers.orders.id=:orderId")
    List<Offer> getAllOffersByOrderId(@Param("orderId") int id);

    @Query("select offers from Offer offers where offers.orders.id=:orderId and offers.expert.id=:expertId")
    Offer getOfferByExpertIdOrderId(@Param("expertId") Integer id,@Param("orderId") Integer id1);
}
