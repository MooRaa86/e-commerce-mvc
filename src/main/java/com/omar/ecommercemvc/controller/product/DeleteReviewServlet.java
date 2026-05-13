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

@WebServlet("/delete-review")
public class DeleteReviewServlet extends HttpServlet {

    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");

        String reviewIdParam = request.getParameter("id");

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

        if (!review.getUserId().equals(user.getId()) && !"ADMIN".equals(user.getRole())) {
            response.sendError(403, "You can only delete your own reviews");
            return;
        }

        Long productId = review.getProductId();
        reviewService.deleteReview(reviewId);

        response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
    }
}
