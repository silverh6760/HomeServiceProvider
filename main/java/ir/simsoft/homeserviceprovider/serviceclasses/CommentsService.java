package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.repository.dao.CommentsDao;
import ir.simsoft.homeserviceprovider.repository.entity.Comments;
import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.Orders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentsService {
    private CommentsDao commentsDao;
    @Autowired
    public CommentsService(CommentsDao commentsDao) {
        this.commentsDao = commentsDao;
    }
    public void saveComment(Comments comments){
        commentsDao.save(comments);
    }

    public List<Comments> getAllComments() {
       return (List<Comments>) commentsDao.findAll();
    }
    public Comments getCommentsByOrder(Orders orders){
       return commentsDao.findCommentsByOrder(orders);
    }

    public List<Comments> getCommentsByExpert(Expert expertByEmail) {
        return commentsDao.findCommentsByExpert(expertByEmail);
    }
}
