package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.repository.dao.ServicesDao;
import ir.simsoft.homeserviceprovider.repository.entity.Services;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ServicesService {
    private ServicesDao servicesDao;
    @Autowired
    public ServicesService(ServicesDao servicesDao) {
        this.servicesDao = servicesDao;
    }

    public List<Services> getAllServices() {
        List<Services> all = (List<Services>) servicesDao.findAll();
        return all;
    }

    public Services insertService(Services services) {
      return servicesDao.save(services);
    }

    public Services getServiceByName(String category) {
        return servicesDao.findByName(category).get();
    }

    public Services getServiceById(int id) {
        return servicesDao.findById(id).get();
    }

    public void deleteServiceByID(int id) {
        servicesDao.deleteById(id);
    }
}
