package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping({"/admin"})
public class AdminController {

    @GetMapping
    public String getAdminPage(Model model) {
        Expert expert = new Expert();
        model.addAttribute(expert);
        return "admin";
    }

    @GetMapping("/manageExpert/confirmNewExpert")
    public String getConfirmNewExpertPage() {
        return "confirmNewExpert";
    }
    @GetMapping("/manageExpert")
    public String getManageExpertPage() {
        return "manageExpert";
    }

    @GetMapping("/manageService")
    public String getManageServicePage() {
        return "manageService";
    }

    @GetMapping("/manageExpert/expertSearch")
    public String getExpertSearchPage() {
        return "expertSearch";
    }
    @GetMapping("/manageExpert/expertAssignment")
    public String getExpertAssignmentPage() {
        return "expertAssignAdmin";
    }

    @GetMapping("/userSearch")
    public String getUserSearchPage() {
        return "userSearch";
    }

    @GetMapping("/ordersSearch")
    public String getOrdersSearchPage() {
        return "ordersSearch";
    }


    @GetMapping("/report")
    public String getReportPage(){return "report";}
    @GetMapping("/report/expertReport")
    public String getExpertReportPage(){return "expertReport";}
    @GetMapping("/report/userReport")
    public String getUserReportPage(){return "userReport";}

}
