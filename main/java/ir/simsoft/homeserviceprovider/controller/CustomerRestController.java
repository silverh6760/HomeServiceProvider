package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.repository.entity.Offer;
import ir.simsoft.homeserviceprovider.repository.entity.Orders;
import ir.simsoft.homeserviceprovider.repository.enums.OrderState;
import ir.simsoft.homeserviceprovider.serviceclasses.OfferService;
import ir.simsoft.homeserviceprovider.serviceclasses.OrdersService;
import ir.simsoft.homeserviceprovider.serviceclasses.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/customerPage")
public class CustomerRestController {
    private OrdersService ordersService;
    private OfferService offerService;
    private UserService userService;
    @Autowired
    public CustomerRestController(OrdersService ordersService, OfferService offerService, UserService userService) {
        this.ordersService = ordersService;
        this.offerService = offerService;
        this.userService = userService;
    }

    @GetMapping("/orderByCustomerEmailForExpertSelection/{email}")
    public List<Orders> getCustomerOrders(@PathVariable("email") String email){
        List<Orders> ordersList=ordersService.getAllOrdersByCustomerEmailForExpertSelection(email);
        return ordersList;
    }
    @GetMapping("/allOrdersByCustomerEmail/{email}")
    public List<Orders> allOrdersByCustomerEmail(@PathVariable("email") String email){
        List<Orders> ordersList=ordersService.getAllOrdersByCustomerEmail(email);
        return ordersList;
    }

    @GetMapping("/orderOffer/{orderId}")
    public List<Offer> getAllOffersByOrderId(@PathVariable("orderId") int id){
        return offerService.getAllOffersByOrderId(id);
    }
    @PutMapping("/order/{offerId}")
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
}
