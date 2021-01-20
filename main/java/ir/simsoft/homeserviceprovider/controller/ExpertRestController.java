package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.exceptions.BusinessException;
import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.SubServices;
import ir.simsoft.homeserviceprovider.repository.entity.User;
import ir.simsoft.homeserviceprovider.repository.enums.ConfirmationState;
import ir.simsoft.homeserviceprovider.repository.enums.UserRole;
import ir.simsoft.homeserviceprovider.serviceclasses.ExpertService;
import ir.simsoft.homeserviceprovider.serviceclasses.SubServicesService;
import ir.simsoft.homeserviceprovider.serviceclasses.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping({"/expert"})
public class ExpertRestController {

    private ExpertService expertService;
    private UserService userService;
    private SubServicesService subServicesService;
@Autowired
    public ExpertRestController(ExpertService expertService, UserService userService, SubServicesService subServicesService) {
        this.expertService = expertService;
        this.userService = userService;
        this.subServicesService = subServicesService;
    }

    @GetMapping
    public String hello(){
        return "admin";
    }

    /*******Rest Methods**************/
    @GetMapping("/allExperts")
    @ResponseBody
    public List<User> getUsers(){
        List<User> users = userService.getExperts(UserRole.EXPERT);
        return users;
    }

    @GetMapping("/{id}")
    @ResponseBody
    public User getUserById(@PathVariable("id") int id){
        Optional<User> user =userService.getUserById(id);
        return user.get();
    }
    @PostMapping("/newExpert")
    @ResponseBody
    public ResponseEntity saveExpert(@RequestBody Expert expert){
        expert.setEnabled(true);
        Expert expert1 = expertService.registerExpert(expert);
        return ResponseEntity.ok("New Expert with ID " + expert1.getId() + " is added!");

    }

    @PutMapping(path = "/{id}")
    @ResponseBody
    public ResponseEntity updateUser(@PathVariable("id") int id) {
        Expert expertById = expertService.getExpertById(id);
        expertById.setConfirmationState(ConfirmationState.CONFIRMED);
        expertService.saveExpert(expertById);
        return ResponseEntity.ok("Expert with id= "+ id + " is updated.");
    }

    @DeleteMapping
    @ResponseBody
    public ResponseEntity deleteAll(){
        userService.deleteAllExpert();
        return ResponseEntity.ok("All Experts are deleted!");
    }
    @DeleteMapping(path = "/{id}")
    @ResponseBody
    public ResponseEntity deleteUserById(@PathVariable("id")int id){
        userService.deleteUserById(id);
        return ResponseEntity.ok("Expert with id= "+ id + " is deleted.");
    }

    @PostMapping(path = "assignService/{id}")
    public ResponseEntity assignServiceToExpert(@PathVariable("id")int id
            ,@RequestParam(value = "subServiceName") String subServiceName){

        SubServices subServices = subServicesService.FindSubServiceByName(subServiceName);
        System.out.println(subServices);
        if(subServices==null){
           throw new NullPointerException(BusinessException.nullPointerForSubService);
       }
       else {
           Expert expertById = expertService.getExpertById(id);
           if(expertById==null)
               throw new NullPointerException(BusinessException.nullPointerForExpert);
           else{
               for(SubServices element:expertById.getSubServicesList()){
                   if(element.equals(subServices)){
                       return ResponseEntity.badRequest().body("The Service of "+subServiceName+" already exists!!");
                   }
               }
               expertById.getSubServicesList().add(subServices);
//               subServices.getExpertList().add(expertById);
//               subServicesService.updateSubService(subServices);
               expertService.updateExpert(expertById);
               return ResponseEntity.ok("The Service of "+subServiceName+" is Successfully Assigned");
           }
       }
    }

    @PostMapping("/search")
    @ResponseBody
    public List<Expert> searchBySpecifiedField(@RequestBody Expert expert) {
        System.out.println(expert);
        return expertService.findBySpecifiedField(expert);
    }

}
