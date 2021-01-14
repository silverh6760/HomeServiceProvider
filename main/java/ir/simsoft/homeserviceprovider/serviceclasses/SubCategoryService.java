package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.repository.dao.SubCategoryDao;
import ir.simsoft.homeserviceprovider.repository.entity.SubCategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
