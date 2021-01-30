package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.repository.dao.SubCategoryDao;
import ir.simsoft.homeserviceprovider.repository.entity.Services;
import ir.simsoft.homeserviceprovider.repository.entity.SubCategory;
import ir.simsoft.homeserviceprovider.repository.entity.SubServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SubCategoryService {
    private SubCategoryDao subCategoryDao;
    @Autowired
    public SubCategoryService(SubCategoryDao subCategoryDao) {
        this.subCategoryDao = subCategoryDao;
    }

    public void insertSubCategory(SubCategory subCategory) {
        subCategoryDao.save(subCategory);
    }

    public List<SubCategory> findAllByCategory(Services serviceById) {
       return subCategoryDao.findAllByCategory(serviceById.getId());
    }

    public void deleteSubCategoryByID(int id) {
        subCategoryDao.deleteById(id);
    }
}
