package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.repository.dto.BillInfoDto;
import ir.simsoft.homeserviceprovider.repository.entity.Bill;
import ir.simsoft.homeserviceprovider.repository.entity.Wallet;
import ir.simsoft.homeserviceprovider.repository.enums.PaymentStatus;
import ir.simsoft.homeserviceprovider.serviceclasses.BillService;
import ir.simsoft.homeserviceprovider.serviceclasses.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/bill")
public class BillRestController {
    private BillService billService;
    private WalletService walletService;
    @Autowired
    public BillRestController(BillService billService,WalletService walletService) {
        this.billService = billService;
        this.walletService=walletService;
    }

    @GetMapping("/getAllCustomerBill/{email}")
    public List<Bill> getAllBills(@PathVariable("email")String email){
        return billService.getAllUnPaidCustomerBills(email);
    }
    @GetMapping("/getAllExpertBill/{expertID}")
    public List<Bill> getAllBills(@PathVariable("expertID")int id){
        return billService.getAllUnExpertBills(id);
    }
    @GetMapping("/getAllUserBill/{userID}")
    public List<Bill> getAllUserBills(@PathVariable("userID")int id){
        return billService.getAllUserBills(id);
    }
    @GetMapping("/checkCustomerBill/{email}")
    public Boolean checkCustomerBill(@PathVariable("email")String email){
        List<Bill> allUnPaidCustomerBills = billService.getAllUnPaidCustomerBills(email);
        if(allUnPaidCustomerBills.isEmpty()){
            return false;
        }
        return true;
    }
    @PostMapping("/payBill/{billId}")
    public ResponseEntity payBillByCustomer(@PathVariable("billId")int billId,@RequestParam("amount")long amount){
        Bill billById = billService.getBillById(billId);
        if(Objects.isNull(billById)){
            return ResponseEntity.badRequest().body("There is No Bill with ID "+billId);
        }
        Wallet walletByExpert = walletService.getWalletByExpert(billById.getExpert());
        Date date=new Date();
        if(Objects.nonNull(walletByExpert)){
            walletByExpert.setBalance((long) (billById.getAmount()*0.7));
            walletByExpert.setLastCharge(date);
            walletService.saveWallet(walletByExpert);
            billById.setPaymentStatus(PaymentStatus.PAID);
            billService.saveBill(billById);
            return ResponseEntity.ok("The Customer Bill is Paid Successfully");
        }
            Wallet wallet=new Wallet();
            wallet.setExpert(billById.getExpert());
            wallet.setBalance((long) (billById.getAmount()*0.7));
            wallet.setLastCharge(date);
            walletService.saveWallet(wallet);
            billById.setPaymentStatus(PaymentStatus.PAID);
            billService.saveBill(billById);
            return ResponseEntity.ok("The Customer Bill is Paid Successfully");
    }

    @PostMapping("/reportExpertOrdersDone")
    public List<BillInfoDto> findAllBillDtoByStartEndDate(@RequestBody BillInfoDto billInfoDto){
        if(billInfoDto.getStartDate()==null && billInfoDto.getEndDate()==null){
            return billService.findAllBillInfoDto();
        }
        return billService.findAllBillDtoByStartEndDate(billInfoDto.getStartDate(), billInfoDto.getEndDate());
    }

}
