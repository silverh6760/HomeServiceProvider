package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.Offer;
import ir.simsoft.homeserviceprovider.repository.entity.Orders;
import ir.simsoft.homeserviceprovider.repository.enums.OrderState;
import ir.simsoft.homeserviceprovider.serviceclasses.ExpertService;
import ir.simsoft.homeserviceprovider.serviceclasses.OfferService;
import ir.simsoft.homeserviceprovider.serviceclasses.OrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalTime;
import java.util.Objects;

@Controller
public class ExpertController {

    private ExpertService expertService;
    private OrdersService ordersService;
    private OfferService offerService;

    @Autowired
    public ExpertController(ExpertService expertService, OrdersService ordersService,
                            OfferService offerService) {
        this.expertService = expertService;
        this.ordersService = ordersService;
        this.offerService = offerService;
    }

    @GetMapping("/expertPage")
    public String getExpertHomePage() {
        return "expertHomePage";
    }

    @GetMapping("/expertPage/seeOrders")
    public String seeOrdersPage(Model model) {
        Offer offer = new Offer();
        model.addAttribute("offer", offer);
        return "expertOrderPage";
    }

    @GetMapping("/expertPage/terminationAnnouncement")
    public String getTerminationPage() {

        return "terminationAnnouncement";
    }

    @GetMapping("/expertPage/assignSubService")
    public String getConfirmNewExpertPage(Model model) {
        Expert expert = expertService.getExpertById(8);
        model.addAttribute("expert", expert);
        return "expert";
    }
    @GetMapping("/expertPage/seeDoneOrders")
    public String getDoneOrdersPage(){
        return "expertDoneOrders";
    }

    @PostMapping("/expertPage/seeOrders")
    public String makeOfferForOrder(@ModelAttribute("offer") Offer offer,
                                    @RequestParam("time") String time, RedirectAttributes redirectAttributes) {
        Expert expertByEmail = expertService.getExpertByEmail(offer.getExpert().getEmail());
        Orders orders = ordersService.getOrderById(offer.getOrders().getId());
        Offer offerByUniqueExpertOrder = offerService.getOfferByUniqueExpertOrder(expertByEmail.getId(), orders.getId());
        if(Objects.nonNull(offerByUniqueExpertOrder)){
            redirectAttributes.addFlashAttribute("message", "You already made offer for this Order");
            return "redirect:/expertPage/seeOrders";
        }
//        Offer offerInDB = offerService.getOfferByUniqueOrderExpert(expertByEmail.getId(),orders.getId());
//        if(Objects.nonNull(offerInDB)){
//            redirectAttributes.addFlashAttribute("message", "The Offer is repetitive for this order!you " +
//                    "should delete the offer first!");
//            return "redirect:/expertPage/seeOrders";
//        }
        offer.setStartHour(LocalTime.parse(time));
        if (Objects.isNull(offer)) {
            redirectAttributes.addFlashAttribute("message", "The Offer is Null");
            return "redirect:/expertPage/seeOrders";
        }
        if (offer.getDurationOfWork() < 30) {
            redirectAttributes.addFlashAttribute("message", "The Duration Of Work " +
                    "should be at least 30 minutes!");
            return "redirect:/expertPage/seeOrders";
        }
        if (offer.getProposedPrice() < orders.getSubServices().getBasePrice()) {
            redirectAttributes.addFlashAttribute("message", "The Offer Price is less than Base Price");
            return "redirect:/expertPage/seeOrders";
        }
//        if (offer.getStartHour().getHour() > 20 || offer.getStartHour().getHour() < 8) {
//            redirectAttributes.addFlashAttribute("message", "The Time is not Correct");
//            return "redirect:/expertPage/seeOrders";
//        }
        orders.setOrderState(OrderState.WAITING_FOR_EXPERT_SELECTION);
        offer.setOrders(orders);
        offer.setExpert(expertByEmail);
        ordersService.saveOrders(orders);
        offerService.saveOffer(offer);
        redirectAttributes.addFlashAttribute("message", "The Offer is Submitted Successfully!");
        return "redirect:/expertPage/seeOrders";
    }




}
