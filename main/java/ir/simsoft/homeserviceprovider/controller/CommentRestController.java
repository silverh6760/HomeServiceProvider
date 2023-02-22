package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.repository.entity.Bill;
import ir.simsoft.homeserviceprovider.repository.entity.Comments;
import ir.simsoft.homeserviceprovider.serviceclasses.BillService;
import ir.simsoft.homeserviceprovider.serviceclasses.CommentsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/comment")
public class CommentRestController {
    private CommentsService commentsService;
    private BillService billService;
    @Autowired
    public CommentRestController(CommentsService commentsService, BillService billService) {
        this.commentsService = commentsService;
        this.billService=billService;
    }

    @PostMapping("/insertComment/{id}")
    public ResponseEntity insertComment(@RequestBody Comments comments, @PathVariable("id")int billId){
        Bill billById = billService.getBillById(billId);
        List<Comments> allComments = commentsService.getAllComments();
       for(Comments element:allComments){
           if(element.getOrder().getId()==billById.getOrders().getId()){
               return ResponseEntity.badRequest().body("You already submitted comment for this expert!");
           }

        }
        comments.setUser(billById.getOrders().getCustomer());
        comments.setExpert(billById.getExpert());
        comments.setOrder(billById.getOrders());
        commentsService.saveComment(comments);
        return ResponseEntity.ok("The comment is submitted successfully!");

    }
}
