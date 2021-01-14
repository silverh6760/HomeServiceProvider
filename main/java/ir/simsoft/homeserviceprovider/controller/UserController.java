package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.repository.entity.ConfirmationToken;
import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.User;
import ir.simsoft.homeserviceprovider.repository.enums.ConfirmationState;
import ir.simsoft.homeserviceprovider.repository.enums.UserRole;
import ir.simsoft.homeserviceprovider.serviceclasses.ConfirmationTokenService;
import ir.simsoft.homeserviceprovider.serviceclasses.ExpertService;
import ir.simsoft.homeserviceprovider.serviceclasses.FileUploadUtil;
import ir.simsoft.homeserviceprovider.serviceclasses.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping({"/user","/"})
public class UserController {
    private UserService userService;
    private ConfirmationTokenService confirmationTokenService;
    private FileUploadUtil fileUploadUtil;
    private ExpertService expertService;

    @Autowired
    public UserController(UserService userService, ConfirmationTokenService confirmationTokenService,
                          FileUploadUtil fileUploadUtil, ExpertService expertService) {
        this.userService = userService;
        this.confirmationTokenService = confirmationTokenService;
        this.fileUploadUtil = fileUploadUtil;
        this.expertService = expertService;
    }


    @GetMapping
    public String hello(){
        return "welcome";
    }
    @GetMapping("/allUsers")
    @ResponseBody
    public List<User> getUsers(){
        List<User> users = userService.getUsers();
        return users;
    }


    @PostMapping("/checkEmail")
    @ResponseBody
    public Boolean checkEmail(@RequestBody User user){
        if(userService.checkUserEmail(user).isPresent()){
            return false;
        }
        else
            return true;
    }
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
        List<String> userRoleList = Arrays.asList("EXPERT", "CUSTOMER");
        model.addAttribute("userRoleList", userRoleList);
        return "register";
    }

    @PostMapping("/register")
    public ModelAndView registerUser(@ModelAttribute("user") User user,@RequestParam("image") MultipartFile multipartFile) throws IOException {
        // studentList.add(student);
        String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());
        if(user.getUserRole().equals(UserRole.EXPERT)){
            Expert expert=new Expert();
            expert.setConfirmationState(ConfirmationState.WAITING_TO_BE_CONFIRMED);
            expert.setUserRole(user.getUserRole());
            expert.setPassword(user.getPassword());
            expert.setName(user.getName());
            expert.setFamily(user.getFamily());
            expert.setEmail(user.getEmail());
            expert.setPhoto(fileName);
            Expert savedExpert=expertService.registerExpert(expert);
            String uploadDir = "user-photos/" + savedExpert.getId();
            fileUploadUtil.saveFile(uploadDir, fileName, multipartFile);
            ConfirmationToken confirmationToken = new ConfirmationToken(expert);
            confirmationTokenService.saveConfirmationToken(confirmationToken);
            userService.sendConfirmationMail(user.getEmail(), confirmationToken.getConfirmationToken());
        }else{
            User savedUser = userService.registerUser(user);
            ConfirmationToken confirmationToken = new ConfirmationToken(user);
            confirmationTokenService.saveConfirmationToken(confirmationToken);
            userService.sendConfirmationMail(user.getEmail(), confirmationToken.getConfirmationToken());
        }
//        User savedUser = userService.registerUser(user);
//        String uploadDir = "user-photos/" + savedUser.getId();
//        fileUploadUtil.saveFile(uploadDir, fileName, multipartFile);
//

        ModelAndView modelAndView = new ModelAndView("welcome", "user", user);
        return modelAndView;
    }
    /*****************************************/
//    @GetMapping("/sign-in")
//    String signIn() {
//
//        return "sign-in.html";
//    }
//
//    @GetMapping("/sign-up")
//    String signUp() {
//
//        return "sign-up.html";
//    }
//
//    @PostMapping("/sign-up")
//    String signUp(User user) {
//
//        userService.registerUser(user);
//        ConfirmationToken confirmationToken=new ConfirmationToken(user);
//        userService.sendConfirmationMail(user.getEmail(),confirmationToken.getConfirmationToken());
//
//        return "redirect:/sign-in.html";
//    }

    @GetMapping("/confirm")
    String confirmMail(@RequestParam("token") String confirmationToken) {

        Optional<ConfirmationToken> optionalConfirmationToken =
                confirmationTokenService.findConfirmationTokenByToken(confirmationToken);
        if(optionalConfirmationToken.isPresent()){
            userService.confirmUser(optionalConfirmationToken.get());
            return "welcome";
        }else{
            return "tokenError";
        }
        //optionalConfirmationToken.ifPresent(userService::confirmUser);


    }

}
