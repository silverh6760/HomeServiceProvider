package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.repository.entity.Category;
import ir.simsoft.homeserviceprovider.repository.entity.Services;
import ir.simsoft.homeserviceprovider.repository.entity.SubCategory;
import ir.simsoft.homeserviceprovider.repository.entity.SubServices;
import ir.simsoft.homeserviceprovider.serviceclasses.CategoryService;
import ir.simsoft.homeserviceprovider.serviceclasses.ServicesService;
import ir.simsoft.homeserviceprovider.serviceclasses.SubCategoryService;
import ir.simsoft.homeserviceprovider.serviceclasses.SubServicesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/ServiceManagement")
public class ServicesRestController {
    private ServicesService servicesService;
    private CategoryService categoryService;
    private SubCategoryService subCategoryService;
    private SubServicesService subServicesService;
    @Autowired
    public ServicesRestController(ServicesService servicesService, CategoryService categoryService,
                                  SubCategoryService subCategoryService, SubServicesService subServicesService) {
        this.servicesService = servicesService;
        this.categoryService = categoryService;
        this.subCategoryService = subCategoryService;
        this.subServicesService = subServicesService;
    }

    @GetMapping("/allServices")
    @ResponseBody
    public List<Services> getAllServices(){
        List<Services> servicesList=servicesService.getAllServices();
        return servicesList;
    }
    @GetMapping("/allSubServices")
    public List<SubServices> getAllSubServices(){
        List<SubServices> subServicesList=subServicesService.getAllSubServices();
        return subServicesList;

    }

    @PostMapping("/newService")
    public ResponseEntity insertService(@RequestBody Services services){
        Category category=new Category();
        category.setName(services.getName());
        services.setCategory(category);
        categoryService.insertCategory(category);
        Services newService=servicesService.insertService(services);

        return ResponseEntity.ok("new Service with "+newService.getName()+" is added");
    }
    @GetMapping("/allSubServices/{category}")
    public List<SubServices> getSubServices(@PathVariable("category") String category){
        List<SubServices> subServices=subServicesService.getSubServices(category);
        return subServices;
    }

    @PostMapping("/newSubService/{category}")
    public ResponseEntity insertSubServices(@RequestBody SubServices subServices,@PathVariable String category){
        SubCategory subCategory=new SubCategory();
        subCategory.setName(subServices.getName());
        subServices.setSubCategory(subCategory);
        Services services=servicesService.getServiceByName(category);
        subServices.setServices(services);
        subCategory.setCategory(services.getCategory());
        subCategoryService.insertSubCategory(subCategory);
        SubServices newSubServices=subServicesService.insertSubService(subServices);
        return ResponseEntity.ok("new Service with "+newSubServices.getName()+" is added");
    }
//    @PostMapping("/newCategory")
//    public Category insertCategory(@RequestBody Category category){
//        Category newCategory = categoryService.insertCategory(category);
//        return newCategory;
//    }


}
