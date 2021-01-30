package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.serviceclasses.ExpertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/expertPage")
public class ExpertController {
    @Autowired
    private ExpertService expertService;
    @GetMapping
    public String getConfirmNewExpertPage(Model model) {
     Expert expert= expertService.getExpertById(8);
        model.addAttribute("expert",expert);

        return "expert";
    }
}
