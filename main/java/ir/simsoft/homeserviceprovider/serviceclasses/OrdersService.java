package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.repository.dao.ExpertDao;
import ir.simsoft.homeserviceprovider.repository.dao.OrdersDao;
import ir.simsoft.homeserviceprovider.repository.dto.OrdersInfoDto;
import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.Offer;
import ir.simsoft.homeserviceprovider.repository.entity.Orders;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.jaxb.SpringDataJaxb;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class OrdersService {
    private OrdersDao ordersDao;
    @Autowired
    public OrdersService(OrdersDao ordersDao) {
        this.ordersDao = ordersDao;
    }

    public Orders saveOrders(Orders orders){
       return ordersDao.save(orders);
    }

    public List<Orders> getAllOrdersByCustomerEmail(String email) {
        return ordersDao.getAllOrdersByCustomerEmail(email);
    }
    public List<Orders> getAllOrdersByCustomerEmailForExpertSelection(String email) {
        return ordersDao.getAllOrdersByCustomerEmailForExpertSelection(email);
    }

    public List<Orders> getAllOrderBySubService(int id) {
        return ordersDao.getAllOrderBySubService(id);
    }
    public List<Orders> getAllOrderComeHomeBySubService(int id){
        return ordersDao.getAllOrderComeHomeBySubService(id);
    }

    public Orders getOrderById(int id) {
        Optional<Orders> byId = ordersDao.findById(id);
        if(byId.isPresent()){
            return byId.get();
        }else
            throw new NullPointerException("order is null");
    }
    public List<Orders> allOrdersByCustomerEmail(String email){
        return ordersDao.allOrdersByCustomerEmail(email);
    }

    public List<Orders> findBySpecifiedField(Orders orders) {
       return ordersDao.findAll(OrdersDao.findBy(orders));
    }

    public List<OrdersInfoDto> allOrdersInfoDto(){
        return ordersDao.allOrdersInfoDto();
    }
    public List<OrdersInfoDto> allOrdersByStartDateEndDate(Date startDate,Date endDate){
        return ordersDao.findAllOrdersInfoDtoByStartEndDate(startDate,endDate);
    }
}
