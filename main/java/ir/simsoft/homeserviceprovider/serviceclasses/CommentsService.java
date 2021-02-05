package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.repository.dao.CommentsDao;
import ir.simsoft.homeserviceprovider.repository.entity.Comments;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
