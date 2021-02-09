package ir.simsoft.homeserviceprovider.controller;

import ir.simsoft.homeserviceprovider.repository.entity.Bill;
import ir.simsoft.homeserviceprovider.repository.entity.Comments;
import ir.simsoft.homeserviceprovider.serviceclasses.BillService;
import ir.simsoft.homeserviceprovider.serviceclasses.CommentsService;
import ir.simsoft.homeserviceprovider.serviceclasses.ExpertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.xml.stream.events.Comment;
import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/comment")
public class CommentsRestController {
    private CommentsService commentsService;
    private BillService billService;
    private ExpertService expertService;
    @Autowired
    public CommentsRestController(CommentsService commentsService,
                                  BillService billService,
                                  ExpertService expertService) {
        this.commentsService = commentsService;
        this.billService=billService;
        this.expertService=expertService;
    }
    @GetMapping("/getAllComments")
    public List<Comments> getAllComments(){
        return commentsService.getAllComments();
    }
    @PostMapping("/insertComment/{id}")
    public ResponseEntity insertComment(@RequestBody Comments comments,@PathVariable("id") int billId){
        Bill billById = billService.getBillById(billId);
        Comments commentsByOrder = commentsService.getCommentsByOrder(billById.getOrders());
        if(Objects.nonNull(commentsByOrder)){
            return ResponseEntity.badRequest().body("You already made comment for this order!");
        }
        if(Objects.isNull(billById)){
            return ResponseEntity.badRequest().body("The Bill is Null!");
        }
        if(Objects.isNull(comments)){
            return ResponseEntity.badRequest().body("The Comment is Null!");
        }
        if(comments.getScore()==0 || comments.getScore()<0){
            return ResponseEntity.badRequest().body("Put a correct score in the comment box!");
        }
        if(comments.getScore()>10){
            return ResponseEntity.badRequest().body("the score should be greater than 0 and less equal to 10!");
        }
        comments.setExpert(billById.getExpert());
        comments.setOrder(billById.getOrders());
        comments.setUser(billById.getOrders().getCustomer());
        int newScore=(comments.getScore()+billById.getExpert().getScore())/2;
        billById.getExpert().setScore(newScore);
        expertService.saveExpert(billById.getExpert());
        commentsService.saveComment(comments);
        return ResponseEntity.ok("The Comment is saved successfully");
    }


}
