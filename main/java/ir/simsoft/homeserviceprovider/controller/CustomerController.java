package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.repository.entity.*;
import ir.simsoft.homeserviceprovider.repository.enums.OrderState;
import ir.simsoft.homeserviceprovider.serviceclasses.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping("/customer")
public class CustomerController {
    private SubServicesService subServicesService;
    private OrdersService ordersService;
    private UserService userService;
    private OfferService offerService;
    private BillService billService;

    @Autowired
    public CustomerController(SubServicesService subServicesService,
                              OrdersService ordersService,
                              UserService userService,
                              OfferService offerService,
                              BillService billService) {
        this.subServicesService = subServicesService;
        this.ordersService = ordersService;
        this.userService = userService;
        this.offerService = offerService;
        this.billService=billService;
    }



    @GetMapping()
    public String getCustomerPageForBooking(Model model){
        SubServices subServiceByID=new SubServices();

        Orders orders =new Orders();
        model.addAttribute("orders",orders);
        model.addAttribute("subServiceByID",subServiceByID);
        return "customer";
    }
//    @GetMapping("/customer/{email}")
//    @ResponseBody
//    public String getCustomerByEmail(){
//        return "customer";
//    }
    @PostMapping("/order")
    public String bookAnOrderByCustomer(@ModelAttribute("orders") Orders orders,
                                        @RequestParam("userDate") String userDate, Model model,
                                        RedirectAttributes redirectAttributes) throws ParseException {
        SubServices subServiceByID = subServicesService.findSubServiceByID(orders.getSubServices().getId());

        User userByEmail = userService.getUserByEmail(orders.getCustomer().getEmail());
        if(orders.getAddress().equals("") ||  orders.getAddress().equals(null)){
            redirectAttributes.addFlashAttribute("message", "The Address is Null!");
            return "redirect:/customer";
        }
        if(Objects.isNull(orders.getCustomer())){
            redirectAttributes.addFlashAttribute("message", "The Customer is Null!");
            return "redirect:/customer";
        }

        if(orders.getProposedPrice()<0 || orders.getProposedPrice().equals(null)){
            redirectAttributes.addFlashAttribute("message", "Your Proposed Price is Negative!");
            return "redirect:/customer";
        }
        if(Objects.isNull(orders.getSubServices())){
            redirectAttributes.addFlashAttribute("message", "Your Sub Service is Null");
            return "redirect:/customer";
        }
//       if(orders.getTaskDescription().equals(null)){
//
//       }
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        orders.setDueDate(format.parse(userDate));
        Date date=new Date();
        if(orders.getDueDate().compareTo(date)<0){
            redirectAttributes.addFlashAttribute("message", "Your Submission Date occurs before Today");
            return "redirect:/customer";
        }
        orders.setOrderState(OrderState.WAITING_FOR_EXPERTS_OFFER);
        orders.setSubServices(subServiceByID);
        orders.setCustomer(userByEmail);

        Orders orders1 = ordersService.saveOrders(orders);
        redirectAttributes.addFlashAttribute("message", "Your order with "+orders1.getId()+" is submitted");
        return "redirect:/customer";
    }

    @GetMapping("/orderByCustomerEmailForExpertSelection/{email}")
    @ResponseBody
    public List<Orders> getCustomerOrders(@PathVariable("email") String email){
        List<Orders> ordersList=ordersService.getAllOrdersByCustomerEmailForExpertSelection(email);
        return ordersList;
    }
    @GetMapping("/allOrdersByCustomerEmail/{email}")
    @ResponseBody
    public List<Orders> allOrdersByCustomerEmail(@PathVariable("email") String email){
        List<Orders> ordersList=ordersService.getAllOrdersByCustomerEmail(email);
        return ordersList;
    }
    @GetMapping("/{subServiceId}")
    public String getCustomerPageForBooking(@PathVariable("subServiceId")int id,Model model){
        SubServices subServiceByID = subServicesService.findSubServiceByID(id);
        model.addAttribute("subServiceByID",subServiceByID);
        Orders orders =new Orders();
        model.addAttribute("orders",orders);
        return "customer";
    }

    @GetMapping("/orderOffer/{orderId}")
    @ResponseBody
    public List<Offer> getAllOffersByOrderId(@PathVariable("orderId") int id){
       return offerService.getAllOffersByOrderId(id);
    }
    @PutMapping("/order/{offerId}")
    @ResponseBody
    public ResponseEntity selectExpertFromOffers(@PathVariable("offerId") int id){
        Offer offer =offerService.getOfferById(id);
        if( offer.getOrders().getOrderState().equals(OrderState.WAITING_FOR_EXPERT_TO_COME)){
            return ResponseEntity.badRequest().body("The Expert is Already Chosen!");
        }
        offer.getOrders().setOrderState(OrderState.WAITING_FOR_EXPERT_TO_COME);
        offerService.saveOffer(offer);
       if(Objects.nonNull(offer)){
           return ResponseEntity.ok("the expert is chosen successfully ");
       }else{
           return ResponseEntity.badRequest().body("Null");
       }
    }

    @GetMapping("/customerBillPage")
    public String getCustomerBillPage(){
        return "customerBillPage";
    }
    @GetMapping("/customerPaymentPage/{billId}")
    public String getCustomerPaymentPage(@PathVariable("billId") int billId ,Model model){
        Bill billById = billService.getBillById(billId);
        model.addAttribute("bill",billById);
        return "customerPaymentPage";
    }
    @GetMapping("/expirePaymentPage")
    public String getExpirePage(){
        return "expirePaymentPage";
    }

}
