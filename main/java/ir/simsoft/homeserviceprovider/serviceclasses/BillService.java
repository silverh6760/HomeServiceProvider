package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.repository.dao.BillDao;
import ir.simsoft.homeserviceprovider.repository.dto.BillInfoDto;
import ir.simsoft.homeserviceprovider.repository.entity.Bill;
import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class BillService {
    private BillDao billDao;
    @Autowired
    public BillService(BillDao billDao) {
        this.billDao = billDao;
    }
    public void saveBill(Bill bill){
        billDao.save(bill);
    }
    public List<Bill> getAllUnPaidCustomerBills(String email){
        return billDao.findAllCustomerBill(email);
    }
    public Bill getBillById(int id){
        Optional<Bill> byId = billDao.findById(id);
        if(byId.isPresent()){
            return byId.get();
        }else{
            throw new NullPointerException("Bill Not Found");
        }
    }

    public List<Bill> getAllUnExpertBills(int id) {
        return billDao.findAllExpertBillById(id);
    }

    public List<Bill> getAllUserBills(int id) {
        return billDao.findAllUserBillById(id);
    }


    public List<BillInfoDto> findAllBillDtoByStartEndDate(Date startDate,Date endDate){
        return billDao.findAllBillDtoByStartEndDate(startDate,endDate);
    }
    public List<BillInfoDto> findAllBillInfoDto(){
        return billDao.findAllBillDto();
    }

    public List<Bill> getBillsByExpert(Expert expertByEmail) {
        return billDao.findByExpert(expertByEmail);
    }
}
