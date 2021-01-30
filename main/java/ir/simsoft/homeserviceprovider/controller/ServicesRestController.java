package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.exceptions.BusinessException;
import ir.simsoft.homeserviceprovider.repository.entity.*;
import ir.simsoft.homeserviceprovider.serviceclasses.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.awt.print.Book;
import java.awt.print.Pageable;
import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/ServiceManagement")
public class ServicesRestController {
    private ServicesService servicesService;
    private CategoryService categoryService;
    private SubCategoryService subCategoryService;
    private SubServicesService subServicesService;
    private ExpertService expertService;
    @Autowired
    public ServicesRestController(ServicesService servicesService, CategoryService categoryService,
                                  SubCategoryService subCategoryService,
                                  SubServicesService subServicesService, ExpertService expertService) {
        this.servicesService = servicesService;
        this.categoryService = categoryService;
        this.subCategoryService = subCategoryService;
        this.subServicesService = subServicesService;
        this.expertService = expertService;
    }

    @GetMapping("/allServices")
    @ResponseBody
    public List<Services> getAllServices(){
        List<Services> servicesList=servicesService.getAllServices();
        return servicesList;
    }


    @PutMapping("/updateService/{id}")
    public ResponseEntity updateService(@PathVariable("id")int id,@RequestBody Services services){
        if(services.getName()!=null){
            if(services.getName().length()<30){
                if(!services.getName().equals(" ")){
                    Services servicesInDB=servicesService.getServiceById(id);
                    if(servicesInDB!=null){
                        servicesInDB.setName(services.getName());
                        servicesInDB.getCategory().setName(services.getName());
                        servicesService.insertService(servicesInDB);
                        return ResponseEntity.ok("new Service with "+servicesInDB.getId()+" is updated");
                    }
                    else {
                        throw new NullPointerException(BusinessException.nullPointerForService);
                    }
                }
                else{
                    throw new NullPointerException(BusinessException.nullPointerForService);
                }
            }
            else{
                return ResponseEntity.badRequest().body("The Text Size Limit Exceeds!");
            }
        }else{
            throw new NullPointerException(BusinessException.nullPointerForService);
        }
    }

    @PostMapping("/newService")
    public ResponseEntity insertService(@RequestBody Services services){
        if(services.getName()!=null){
            if(services.getName().length()<30){
                if(!services.getName().equals(" ")){
                    List<Services> allServices = servicesService.getAllServices();
                    for(Services element:allServices){
                        if(element.getName().equals(services.getName())){
                            return  ResponseEntity.badRequest().body("The Service is Repetitive!");
                        }
                    }
                    Category category=new Category();
                    category.setName(services.getName());
                    services.setCategory(category);
                    categoryService.insertCategory(category);
                    Services newService=servicesService.insertService(services);

                    return ResponseEntity.ok("new Service with "+newService.getId()+" is added");
                }
                else{
                    throw new NullPointerException(BusinessException.nullPointerForService);
                }
            }
            else{
                return ResponseEntity.badRequest().body("The Text Size Limit Exceeds!");
            }
        }else{
            throw new NullPointerException(BusinessException.nullPointerForService);
        }

    }

    @DeleteMapping("/deleteService/{id}")
    public ResponseEntity deleteServiceById(@PathVariable("id")int id){
        Services serviceById = servicesService.getServiceById(id);
        if(serviceById!=null){
            List<SubServices> subServicesList=subServicesService.findAllByService(serviceById);
            List<SubCategory> subCategoryList=subCategoryService.findAllByCategory(serviceById);
            if(subServicesList.isEmpty() && subCategoryList.isEmpty()){
                servicesService.deleteServiceByID(id);
                categoryService.deleteCategoryByID(id);
                return ResponseEntity.ok("Service is Deleted Successfully.");
            }else {
                return ResponseEntity.badRequest().body("You should first delete the SubServices");
            }
        }
        else
            throw new NullPointerException(BusinessException.nullPointerForService);
    }

    @GetMapping("/allSubServices/{category}")
    public List<SubServices> getSubServices(@PathVariable("category") String category){
        List<SubServices> subServices=subServicesService.getSubServices(category);
        return subServices;
    }

    @GetMapping("/allSubServices")
    public List<SubServices> getAllSubServices(){
        List<SubServices> subServicesList=subServicesService.getAllSubServices();
        return subServicesList;

    }

    @PostMapping("/newSubService/{category}")
    public ResponseEntity insertSubServices(@RequestBody SubServices subServices,@PathVariable String category){
        if(subServices.getName()!=null ){
            if(subServices.getName().length()<30){
                if(!subServices.getName().equals(" ")){
                    if( subServices.getBasePrice()>0) {
                        List<SubServices> allSubServices = subServicesService.getAllSubServices();
                        for(SubServices element:allSubServices){
                            if(element.getName().equals(subServices.getName())){
                                return ResponseEntity.badRequest().body("The Sub Service is Repetitive!");
                            }
                        }
                        SubCategory subCategory = new SubCategory();
                        subCategory.setName(subServices.getName());
                        subServices.setSubCategory(subCategory);
                        Services services = servicesService.getServiceByName(category);
                        subServices.setServices(services);
                        subCategory.setCategory(services.getCategory());
                        subCategoryService.insertSubCategory(subCategory);
                        SubServices newSubServices = subServicesService.insertSubService(subServices);
                        return ResponseEntity.ok("New Sub Service with ID " + newSubServices.getId() + " is added");
                    }
                    else {
                        return ResponseEntity.badRequest().body("The price amount is negative!");
                    }
                }
                else{
                    throw new NullPointerException(BusinessException.nullPointerForService);
                }
            }
            else{
                return ResponseEntity.badRequest().body("The Text Size Limit Exceeds!");
            }
        }else{
            throw new NullPointerException(BusinessException.nullPointerForService);
        }
    }

    @PostMapping("/search")
    @ResponseBody
    public List<SubServices> searchBySpecifiedField(@RequestBody SubServices subServices) {
        //subServices.setBasePrice(Long.parseLong(subServices.getBasePrice());
        System.out.println(subServices);
        return subServicesService.findBySpecifiedField(subServices);
    }
    @DeleteMapping("/deleteSubService/{id}")
    public ResponseEntity deleteSubServiceById(@PathVariable("id")int id){
        SubServices subServiceByID = subServicesService.findSubServiceByID(id);
        if(Objects.nonNull(subServiceByID)){
           List<Expert> expertList=expertService.findAllExpertsBySubService(subServiceByID.getId());
           if(expertList.isEmpty()){
               subServicesService.deleteSubServiceByID(id);
               subCategoryService.deleteSubCategoryByID(id);
               return ResponseEntity.ok("Sub Service with ID "+id+" is Deleted Successfully");
           }
           else{
               return ResponseEntity.badRequest().body("You Should First Delete The Experts Involved with it!");
           }
        }
        else {
            throw new NullPointerException(BusinessException.nullPointerForSubService);
        }
    }

    @PutMapping("/updateSubService/{id}")
    public ResponseEntity updateSubService(@PathVariable("id")int id,@RequestBody SubServices subServices){
        System.out.println(subServices);
        if(subServices.getName()!=null){
            if(subServices.getName().length()<30) {
                if (!subServices.getName().equals(" ")) {
                    if( subServices.getBasePrice()>0) {
                        SubServices subServiceByID = subServicesService.findSubServiceByID(id);
                        if (subServiceByID != null) {
                            subServiceByID.setName(subServices.getName());
                            subServiceByID.getSubCategory().setName(subServices.getName());
                            subServiceByID.setBasePrice(subServices.getBasePrice());
                            subServiceByID.setDescription(subServices.getDescription());
                            subServicesService.insertSubService(subServiceByID);
                            return ResponseEntity.ok("SubService with " + subServiceByID.getId() + " is updated");
                        } else {
                            throw new NullPointerException(BusinessException.nullPointerForService);
                        }
                    }
                    else{
                        return ResponseEntity.badRequest().body("The price amount is negative!");
                    }
                } else {
                    throw new NullPointerException(BusinessException.nullPointerForService);
                }
            }
            else{
                return ResponseEntity.badRequest().body("The Text Size Limit Exceeds!");
            }
        }else{
            throw new NullPointerException(BusinessException.nullPointerForService);
        }
    }

//    @GetMapping(path = "deleteSubService")
//    @ResponseBody
//    public List<Expert> getExperts(){
//        SubServices subServiceByID = subServicesService.findSubServiceByID(1);
//        System.out.println(subServiceByID);
//        if(subServiceByID!=null){
//            List<Expert> expertList=expertService.findAllExpertsBySubService(subServiceByID);
//            return expertList;
//        }
//        else
//            throw new NullPointerException(BusinessException.nullPointerForSubService);
//
//    }

}
