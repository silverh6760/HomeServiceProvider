package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.exceptions.BusinessException;
import ir.simsoft.homeserviceprovider.repository.dao.ExpertDao;
import ir.simsoft.homeserviceprovider.repository.dao.SubServicesDao;
import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.SubServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class SubServicesService {
    private SubServicesDao subServicesDao;
    @Autowired
    public SubServicesService(SubServicesDao subServicesDao) {
        this.subServicesDao = subServicesDao;
    }
    @Transactional
    public List<SubServices> getSubServices(String category) {
        return subServicesDao.getSubServices(category);
    }

    public SubServices insertSubService(SubServices subServices) {
        return subServicesDao.save(subServices);
    }

    public List<SubServices> getAllSubServices() {
        return  (List<SubServices>) subServicesDao.findAll();
    }

    public SubServices FindSubServiceByName(String name) {
        SubServices subServicesByName = subServicesDao.findByName(name);
        return subServicesByName;
    }
    public SubServices updateSubService(SubServices subServices){
        Optional<SubServices> byId = subServicesDao.findById(subServices.getId());
        if(byId.isPresent()){
            return subServicesDao.save(byId.get());
        }else
            throw new NullPointerException(BusinessException.nullPointerForSubService);
    }

    public List<SubServices> findBySpecifiedField(SubServices subServices) {
        List<SubServices> subServicesList = subServicesDao.findAll(SubServicesDao.findBy(subServices));
        return subServicesList;
    }
}
