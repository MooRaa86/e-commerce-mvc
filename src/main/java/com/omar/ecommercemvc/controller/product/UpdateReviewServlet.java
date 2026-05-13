package com.omar.ecommercemvc.controller.product;

import com.omar.ecommercemvc.model.Review;
import com.omar.ecommercemvc.model.User;
import com.omar.ecommercemvc.service.ReviewService;
import com.omar.ecommercemvc.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/update-review")
public class UpdateReviewServlet extends HttpServlet {

    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");

        String reviewIdParam = request.getParameter("id");
        String productIdParam = request.getParameter("productId");

        if (!ValidationUtil.isValidLong(reviewIdParam)) {
            response.sendError(400, "Invalid review ID");
            return;
        }

        Long reviewId = Long.parseLong(reviewIdParam);
        Review review = reviewService.getReviewById(reviewId);

        if (review == null) {
            response.sendError(404, "Review not found");
            return;
        }

        if (!review.getUserId().equals(user.getId())) {
            response.sendError(403, "You can only update your own reviews");
            return;
        }

        request.setAttribute("review", review);
        request.setAttribute("productId", productIdParam);
        request.getRequestDispatcher("/views/product/update-review.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");

        String reviewIdParam = request.getParameter("reviewId");
        String productIdParam = request.getParameter("productId");
        String ratingParam = request.getParameter("rating");
        String comment = request.getParameter("comment");

        List<String> validationErrors = ValidationUtil.validateReview(ratingParam, productIdParam);

        if (!validationErrors.isEmpty()) {
            Long productId = ValidationUtil.isValidLong(productIdParam) ? Long.parseLong(productIdParam) : null;
            if (productId != null) {
                response.sendRedirect(request.getContextPath() + "/product?id=" + productId + "&error=" + validationErrors.get(0));
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            return;
        }

        if (!ValidationUtil.isValidLong(reviewIdParam)) {
            response.sendError(400, "Invalid review ID");
            return;
        }

        Long reviewId = Long.parseLong(reviewIdParam);
        Long productId = Long.parseLong(productIdParam);
        int rating = Integer.parseInt(ratingParam);

        Review existingReview = reviewService.getReviewById(reviewId);
        if (existingReview == null) {
            response.sendError(404, "Review not found");
            return;
        }

        if (!existingReview.getUserId().equals(user.getId())) {
            response.sendError(403, "You can only update your own reviews");
            return;
        }

        Review review = new Review();
        review.setId(reviewId);
        review.setUserId(user.getId());
        review.setProductId(productId);
        review.setRating(rating);
        review.setComment(comment != null ? comment.trim() : "");

        reviewService.updateReview(review);

        response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
    }
}
