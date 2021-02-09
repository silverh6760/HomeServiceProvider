package ir.simsoft.homeserviceprovider.serviceclasses;

import ir.simsoft.homeserviceprovider.repository.dao.OfferDao;
import ir.simsoft.homeserviceprovider.repository.entity.Offer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OfferService {
    private OfferDao offerDao;
    @Autowired
    public OfferService(OfferDao offerDao) {
        this.offerDao = offerDao;
    }

    public List<Offer> getAllOffersByOrderId(int id) {
       return offerDao.getAllOffersByOrderId(id);
    }

    public Offer getOfferById(int id) {
        Optional<Offer> byId = offerDao.findById(id);
        if(byId.isPresent()){
            return byId.get();}
        else
            throw new NullPointerException("the offer is null");
    }

    public void saveOffer(Offer offer) {
        offerDao.save(offer);
    }

    public Offer getOfferByUniqueExpertOrder(Integer expertId, Integer orderId) {
        return offerDao.getOfferByExpertIdOrderId(expertId,orderId);
    }
}
