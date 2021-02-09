package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.Orders;
import ir.simsoft.homeserviceprovider.serviceclasses.OrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/orders")
public class OrdersRestController {
    private OrdersService ordersService;
    @Autowired
    public OrdersRestController(OrdersService ordersService) {
        this.ordersService = ordersService;
    }

    @PostMapping("/search")
    public List<Orders> searchBySpecifiedField(@RequestBody Orders orders) {
        return ordersService.findBySpecifiedField(orders);
    }
}
