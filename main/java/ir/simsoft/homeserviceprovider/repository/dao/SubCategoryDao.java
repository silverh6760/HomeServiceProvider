package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.entity.SubCategory;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Repository
public interface SubCategoryDao extends CrudRepository<SubCategory,Integer> {

    @Query("select subCat from SubCategory subCat where subCat.category.id=:id")
    List<SubCategory> findAllByCategory(@Param("id") int id);
}
