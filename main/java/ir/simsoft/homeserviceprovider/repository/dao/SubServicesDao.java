package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.entity.SubServices;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Repository
public interface SubServicesDao extends CrudRepository<SubServices,Integer> {
    @Query("select subs from SubServices subs where subs.services.name=:category")
    List<SubServices> getSubServices(@Param("category") String category);

//    @Query("select subs from SubServices subs where subs.name=:name ")
    SubServices findByName( String name);
}
