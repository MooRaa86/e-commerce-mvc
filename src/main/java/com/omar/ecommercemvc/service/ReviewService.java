package com.omar.ecommercemvc.service;

import com.omar.ecommercemvc.dao.ReviewDAO;
import com.omar.ecommercemvc.model.Review;
import com.omar.ecommercemvc.util.CacheConstants;

import java.util.List;

public class ReviewService {

    private final ReviewDAO reviewDAO = new ReviewDAO();
    private final CacheService cacheService = new CacheService();

    public List<Review> getReviewsByProduct(Long productId) {
        String cacheKey = CacheConstants.REVIEWS_CACHE_PREFIX + productId;
        List<Review> cached = cacheService.getList(cacheKey, Review.class);

        if (cached != null) {
            return cached;
        }

        List<Review> reviews = reviewDAO.findByProductId(productId);
        cacheService.set(cacheKey, reviews);
        return reviews;
    }

    public Review getReviewById(Long id) {
        String cacheKey = CacheConstants.REVIEW_CACHE_PREFIX + id;
        Review cached = cacheService.get(cacheKey, Review.class);

        if (cached != null) {
            return cached;
        }

        Review review = reviewDAO.findById(id);
        if (review != null) {
            cacheService.set(cacheKey, review);
        }
        return review;
    }

    public boolean addReview(Review review) {
        if (review.getRating() < 1 || review.getRating() > 5) {
            return false;
        }

        reviewDAO.save(review);
        cacheService.delete(CacheConstants.REVIEWS_CACHE_PREFIX + review.getProductId());
        return true;
    }

    public boolean updateReview(Review review) {
        if (review.getRating() < 1 || review.getRating() > 5) {
            return false;
        }

        boolean updated = reviewDAO.update(review);
        if (updated) {
            cacheService.delete(CacheConstants.REVIEW_CACHE_PREFIX + review.getId());
            cacheService.delete(CacheConstants.REVIEWS_CACHE_PREFIX + review.getProductId());
        }
        return updated;
    }

    public boolean deleteReview(Long id) {
        Review review = reviewDAO.findById(id);
        boolean deleted = reviewDAO.deleteById(id);

        if (deleted) {
            cacheService.delete(CacheConstants.REVIEW_CACHE_PREFIX + id);
            if (review != null) {
                cacheService.delete(CacheConstants.REVIEWS_CACHE_PREFIX + review.getProductId());
            }
        }
        return deleted;
    }
}
