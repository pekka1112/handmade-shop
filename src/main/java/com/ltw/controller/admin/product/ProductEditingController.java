package com.ltw.controller.admin.product;

import com.ltw.bean.ProductBean;
import com.ltw.dao.ProductDAO;
import com.ltw.util.BlankInputUtil;
import com.ltw.util.NumberValidateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(value = {"/admin/product-management/editing"})
public class ProductEditingController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        ProductBean productBean = productDAO.findProductById(id);
        req.setAttribute("productBean", productBean);
        req.getRequestDispatcher("/editing-product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        // Lấy id kiểu int ra để lưu vào database
        // Sử dụng vòng lặp để set lỗi để trống theo index,
        // tuy nhiên cần phải giữ đúng thứ tự của input theo form và theo database (Vì sử dụng vòng lặp theo i để set lỗi)
        int id = Integer.parseInt(idStr);
        String name = req.getParameter("name");//Ép về kiếutring
        String description = req.getParameter("description");//Ép về kiếutring
        String categoryTypeId = req.getParameter("categoryTypeId");//Ép về kiếutring
        String originalPrice = req.getParameter("originalPrice");//Ép về kiếutring
        String discountPrice = req.getParameter("discountPrice");//Ép về kiếutring
        String discountPercent = req.getParameter("discountPercent");//Ép về kiếutring
        String quantity = req.getParameter("quantity");//Ép về kiếutring
        String size = req.getParameter("size");//Ép về kiếutring
        String otherSpec = req.getParameter("otherSpec");//Ép về kiếutring
        String status = req.getParameter("status");//Ép về kiếutring
        String keyword = req.getParameter("keyword");//Ép về kiếutring

        // Các biến lưu giữ lỗi về giá trị
        String oPrErr = "e", dPrErr = "e", dPeErr = "e";

        // Biến thông báo thành công lỗi
        String success = "success";

        // Đặt các thuộc tính đúng thứ tự theo sắp xếp
        String[] inputsForm = new String[]{name, description, categoryTypeId, originalPrice, discountPrice, discountPercent, quantity, size, otherSpec, status, keyword};
        // Mảng chưas lỗi
        ArrayList<String> errors = new ArrayList<>();

        // Biến bắt lỗi của hệ thống
        boolean isValid = true;

        for (String string : inputsForm) {
            if (BlankInputUtil.isBlank(string)) {
                errors.add("e");
                if (isValid) {
                    isValid = false;
                }
            } else {
                errors.add(null);
            }
        }
        req.setAttribute("errors", errors);

        // Kiểm tra các lỗi nhập liệu khác
        // Lỗi nhập liệu cho giá và phần trăm (Là phần số)
        if (!NumberValidateUtil.isNumeric(originalPrice)) {
            if (isValid) {
                isValid = false;
            }
            req.setAttribute("oPrErr", oPrErr);
        }
        if (!NumberValidateUtil.isNumeric(discountPrice)) {
            if (isValid) {
                isValid = false;
            }
            req.setAttribute("dPrErr", dPrErr);
        }
        if (!NumberValidateUtil.isNumeric(discountPercent)) {
            if (isValid) {
                isValid = false;
            }
            req.setAttribute("dPeErr", dPeErr);
        }

        // Nếu không lỗi thì lưu vào database
        if (isValid) {
            // Đổi String về số
            int categoryTypeIdInt = NumberValidateUtil.toInt(categoryTypeId);// Đổi String về số cho loại
            int quantityInt = NumberValidateUtil.toInt(quantity);// Đổi String về số cho số lượng
            int statusInt = NumberValidateUtil.toInt(status);// Đổi String về số cho trạng thái
            double originalPriceDouble = NumberValidateUtil.toDouble(originalPrice);// Đổi String về số cho giá gốc
            double discountPriceDouble = NumberValidateUtil.toDouble(discountPrice);// Đổi String về số cho giá giảm
            double discountPercentDouble = NumberValidateUtil.toDouble(discountPercent);// Đổi String về số cho giá hiện tại

            // Set thuộc tính vào Productbean
            ProductBean productBean = new ProductBean();
            productBean.setId(id);//cho id
            productBean.setName(name);//cho tên
            productBean.setDescription(description);//cho mổ tả
            productBean.setCategoryTypeId(categoryTypeIdInt);//cho loại
            productBean.setOriginalPrice(originalPriceDouble);//cho giá gốc
            productBean.setDiscountPrice(discountPriceDouble);//cho giá giảm
            productBean.setDiscountPercent(discountPercentDouble);//cho giá hiện tại
            productBean.setQuantity(quantityInt);//cho số lượng
            productBean.setSize(size);//cho size
            productBean.setOtherSpec(otherSpec);//order
            productBean.setStatus(statusInt);//cho trạng thái
            productBean.setKeyword(keyword);//cho mã

            productDAO.updateProduct(productBean);
            resp.sendRedirect(req.getContextPath() + "/admin/product-management/editing?id=" + productBean.getId() + "&success=" + success);
        } else {
            ProductBean productBean = productDAO.findProductById(id);
            req.setAttribute("productBean", productBean);
            req.getRequestDispatcher("/editing-product.jsp").forward(req, resp);
        }
    }
}
