package com.ltw.controller.client;

import com.ltw.bean.ProductBean;
import com.ltw.dao.ProductDAO;

import java.util.List;

public class SearchService {
    private final ProductDAO productDAO = new ProductDAO();

    // 6.1 findByKeyAndLimit(key, range, sort, start, offset)
    public List<ProductBean> getProductByKeyAndLimit(String key, double[] range, String sort, int start, int offset) {
        return productDAO.findByKeyAndLimit(key, range, sort, start, offset);
    }

}
