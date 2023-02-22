package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.repository.entity.*;
import ir.simsoft.homeserviceprovider.repository.enums.ConfirmationState;
import ir.simsoft.homeserviceprovider.repository.enums.UserRole;
import ir.simsoft.homeserviceprovider.serviceclasses.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.*;

//http://localhost:8080/
@Controller
@RequestMapping({"/user","/"})
public class UserController {
    private UserService userService;
    private ConfirmationTokenService confirmationTokenService;
    private FileUploadUtil fileUploadUtil;
    private ExpertService expertService;
    private SubServicesService subServicesService;
    private OrdersService ordersService;

    @Autowired
    public UserController(UserService userService, ConfirmationTokenService confirmationTokenService,
                          FileUploadUtil fileUploadUtil, ExpertService expertService,
                          SubServicesService subServicesService, OrdersService ordersService) {
        this.userService = userService;
        this.confirmationTokenService = confirmationTokenService;
        this.fileUploadUtil = fileUploadUtil;
        this.expertService = expertService;
        this.subServicesService=subServicesService;
        this.ordersService=ordersService;
    }


    @GetMapping
    public String hello(){
        return "home";
    }

    @GetMapping("/allUsers")
    @ResponseBody
    public List<User> getUsers(){
        List<User> users = userService.getUsers();
        return users;
    }
/***********Login*****************/
    @GetMapping("/loginPage")
    public String getLoginPage(Model model){
        return "loginPage";
    }
    @GetMapping("/loginError")
    public String getLoginErrorPage(Model model){
        model.addAttribute("login_error", "username or password incorrect!");
        return "loginPage";
    }
    //@PostMapping()

    /*************For Book an Order****************/

    @GetMapping("/subService/{id}")
    public String getSubServicePage(@PathVariable("id") int id, Model model){
        SubServices subServiceByID = subServicesService.findSubServiceByID(id);
        model.addAttribute("subServiceByID",subServiceByID);
//        Orders orders =new Orders();
//        model.addAttribute(orders);
        return "subService";
    }

//    @GetMapping("/customer/orders/{email}")
//    @ResponseBody
//    public List<Orders> getCustomerOrders(@PathVariable("email") String email){
//        List<Orders> ordersList=ordersService.getAllOrdersByCustomerEmailForExpertSelection(email);
//        return ordersList;
//    }

    @PreAuthorize("permitAll()")
    @PostMapping("/checkEmail")
    @ResponseBody
    public Boolean checkEmail(@RequestBody User user){
        if(userService.checkUserEmail(user).isPresent()){
            return false;
        }
        else
            return true;
    }
    @PreAuthorize("permitAll()")
    @PostMapping("/checkPassword")
    @ResponseBody
    public Boolean checkPassword(@RequestBody User user){
        if(userService.checkPassword(user)==true){
            System.out.println("Hello");
            return true;
        }
        else
            return false;
    }

    @PostMapping("/checkFileSize")
    @ResponseBody
    public Boolean checkImageSize(@RequestParam("multipartFile") MultipartFile multipartFile){

        if(multipartFile.getSize()>512000){
            return false;
        }
        else
            return true;
    }

    @PostMapping
    @ResponseBody
    public ResponseEntity saveAdmin(@RequestBody User user){
        if(!userService.checkUserEmail(user).isPresent()) {
            if (userService.checkPassword(user) == true) {
                userService.registerUser(user);
                return ResponseEntity.ok("New Admin with " + user.getEmail() + " is added!");
            } else {
                return ResponseEntity.badRequest().body("the pass word is wrong!");
            }
        }else{
            return ResponseEntity.badRequest().body("the email is already exist!!!");
        }
    }

    @GetMapping("/register")
    public String getRegistrationPage(Model model){
        User user =new User();
        model.addAttribute("user",user);
        List<String> userRoleList = Arrays.asList("--","CUSTOMER","EXPERT","ADMIN");
        String photoSizeMessage="";
//        String photoFormatMessage="The file's format is wrong!";
        model.addAttribute("photoSizeMessage",photoSizeMessage);
//        model.addAttribute("photoFormatMessage",photoFormatMessage);
        model.addAttribute("userRoleList", userRoleList);
        return "register";
    }

    @PostMapping("/search")
    @ResponseBody
    public List<User> searchBySpecifiedField(@RequestBody User user) {
        return expertService.findBySpecifiedField(user);
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") User user , Model model,
                               @RequestParam("image") MultipartFile multipartFile ,
                               RedirectAttributes redirectAttributes) throws IOException {

        try {
            if(user.getName().length()>10 || user.getFamily().length()>20){
                redirectAttributes.addFlashAttribute("message2", "Text Limit Size Exceeds!");
                return "redirect:register";
            }
            if(userService.checkUserEmail(user).isPresent()){
                redirectAttributes.addFlashAttribute("message", "The Email Already Exists!");
                return "redirect:register";
            }
            if(userService.checkPassword(user)==false){
                redirectAttributes.addFlashAttribute("message", "The Password Format is wrong!");
                return "redirect:register";
            }

            if(user.getName().length()>10 || user.getFamily().length()>20){
                redirectAttributes.addFlashAttribute("message2", "Text Limit Size Exceeds!");
                return "redirect:register";
            }



            String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());

            if (user.getUserRole().equals(UserRole.EXPERT)) {
                if (multipartFile.isEmpty()) {
                    redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
                    return "redirect:register";
                }
                else if(multipartFile.getSize() > 512000){
                    redirectAttributes.addFlashAttribute("message", "Please select a file with size of 500 kB or less");
                    return "redirect:register";
                }
                else if(!StringUtils.cleanPath(multipartFile.getOriginalFilename()).endsWith(".jpg")){
                    redirectAttributes.addFlashAttribute("message", "The format is wrong!!");
                    return "redirect:register";
                }
                Expert expert = new Expert();
                expert.setConfirmationState(ConfirmationState.WAITING_TO_BE_CONFIRMED);
                expert.setUserRole(user.getUserRole());
                expert.setPassword(user.getPassword());
                expert.setName(user.getName());
                expert.setFamily(user.getFamily());
                expert.setEmail(user.getEmail());
                expert.setPhoto(fileName);
                Expert savedExpert = expertService.registerExpert(expert);
                String uploadDir = "user-photos/" + savedExpert.getId();
                fileUploadUtil.saveFile(uploadDir, fileName, multipartFile);
                ConfirmationToken confirmationToken = new ConfirmationToken(expert);
                confirmationTokenService.saveConfirmationToken(confirmationToken);
                userService.sendConfirmationMail(user.getEmail(), confirmationToken.getConfirmationToken());

//            }else if(user.getUserRole().equals(UserRole.CUSTOMER)){
//
//
            }
            else {
                User savedUser = userService.registerUser(user);
                ConfirmationToken confirmationToken = new ConfirmationToken(user);
                confirmationTokenService.saveConfirmationToken(confirmationToken);
                userService.sendConfirmationMail(user.getEmail(), confirmationToken.getConfirmationToken());
            }

        } catch (Exception m) {
            System.out.println("hshhshhshh");
            System.out.println(m.getMessage());
        }
        model.addAttribute(user);
        //ModelAndView modelAndView = new ModelAndView("welcome", "user", user);
        return "welcome";

    }
    @GetMapping("/uploadStatus")
    public String uploadStatus() {
        return "uploadStatus";
    }
    /*****************************************/

    @GetMapping("/confirm")
    String confirmMail(@RequestParam("token") String confirmationToken,Model model) {

        Optional<ConfirmationToken> optionalConfirmationToken =
                confirmationTokenService.findConfirmationTokenByToken(confirmationToken);

        if(optionalConfirmationToken.isPresent()){
            userService.confirmUser(optionalConfirmationToken.get());
            if(optionalConfirmationToken.get().getUser().getUserRole().equals(UserRole.EXPERT)){
                model.addAttribute("expert",optionalConfirmationToken.get().getUser());
                return "expertConfirm";
            }
            else {
                model.addAttribute("customer",optionalConfirmationToken.get().getUser());
                return "customerConfirm";
            }
        }else{
            return "tokenError";
        }


    }

}
