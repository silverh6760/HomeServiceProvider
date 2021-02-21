package ir.simsoft.homeserviceprovider.repository.dao;

import ir.simsoft.homeserviceprovider.repository.entity.Comments;
import ir.simsoft.homeserviceprovider.repository.entity.Expert;
import ir.simsoft.homeserviceprovider.repository.entity.Orders;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentsDao extends CrudRepository<Comments,Integer> {
    Comments findCommentsByOrder(Orders orders);
    List<Comments> findCommentsByExpert(Expert expert);
}
