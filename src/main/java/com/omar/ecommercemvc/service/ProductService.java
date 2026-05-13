package com.omar.ecommercemvc.service;

import com.omar.ecommercemvc.dao.ProductDAO;
import com.omar.ecommercemvc.model.Product;
import com.omar.ecommercemvc.util.CacheConstants;

import java.util.List;

public class ProductService {

    private final ProductDAO productDAO = new ProductDAO();
    private final CacheService cacheService = new CacheService();

    public List<Product> getAllProducts() {
        List<Product> cached = cacheService.getList(CacheConstants.PRODUCTS_CACHE_KEY, Product.class);

        if (cached != null) {
            return cached;
        }
        List<Product> products = productDAO.findAll();
        cacheService.set(CacheConstants.PRODUCTS_CACHE_KEY, products);
        return products;
    }

    public Product getProductById(Long id) {
        Product cached = cacheService.get(CacheConstants.PRODUCT_CACHE_PREFIX + id, Product.class);
        if (cached != null) {
            return cached;
        }
        Product product = productDAO.findById(id);
        if (product != null) {
            cacheService.set(CacheConstants.PRODUCT_CACHE_PREFIX + id, product);
        }
        return product;
    }

    public boolean addProduct(Product product) {
        productDAO.save(product);
        cacheService.delete(CacheConstants.PRODUCTS_CACHE_KEY);
        return true;
    }

    public boolean updateProduct(Product product) {
        boolean updated = productDAO.update(product);

        if (updated) {
            cacheService.delete(CacheConstants.PRODUCT_CACHE_PREFIX + product.getId());
            cacheService.delete(CacheConstants.PRODUCTS_CACHE_KEY);
        }

        return updated;
    }

    public boolean deleteProduct(Long id) {
        boolean deleted = productDAO.deleteById(id);

        if (deleted) {
            cacheService.delete(CacheConstants.PRODUCT_CACHE_PREFIX + id);
            cacheService.delete(CacheConstants.PRODUCTS_CACHE_KEY);
        }

        return deleted;
    }
}
