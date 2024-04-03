package com.ltw.controller.client;

import com.ltw.bean.CustomizeBean;
import com.ltw.bean.ProductImageBean;
import com.ltw.bean.ProductBean;
import com.ltw.dao.CustomizeDAO;
import com.ltw.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/product-detail"})
public class ProductDetailController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();
    private final ProductDAO productDetailDAO = new ProductDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        int productId = Integer.parseInt(req.getParameter("id"));

        ProductBean productDetailBean = productDetailDAO.findProductById(productId);
        List<ProductImageBean> productImageBeans = productDetailDAO.findImagesByProductId(productId);

        req.setAttribute("customizeInfo", customizeInfo);
        req.setAttribute("productDetail", productDetailBean);
        req.setAttribute("imageList", productImageBeans);

        req.getRequestDispatcher("/product-detail.jsp").forward(req, resp);
    }
}
