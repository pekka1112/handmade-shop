package com.ltw.controller.client.cart;

import com.ltw.bean.Cart;
import com.ltw.bean.Item;
import com.ltw.bean.ProductBean;
import com.ltw.dao.ProductDAO;
import com.ltw.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/cart-adding")
public class CartAddingController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. Lấy productId từ request
            String productIdStr = req.getParameter("productId");
            if (productIdStr == null || productIdStr.isEmpty()) {
                throw new IllegalArgumentException("Mã sản phẩm không hợp lệ");
            }

            int productId;
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Mã sản phẩm phải là một số nguyên hợp lệ", e);
            }

            // 2. Tìm sản phẩm từ id nhận được
            ProductBean product = productDAO.findProductById(productId);
            if (product == null) {
                throw new IllegalArgumentException("Sản phẩm không tồn tại");
            }

            // 3. Tạo mới một đối tượng thể hiện của giỏ hàng
            Cart cart = null;

            // 4. Lấy ra session hiện tại chứa các sản phẩm của giỏ hàng
            Object o = SessionUtil.getInstance().getValue(req, "cart");

            // 5. Kiểm tra nếu session giỏ hàng đã tồn tại thì lấy ra session đã tồn tại
            if (o != null) {
                cart = (Cart) o;
            } else {
                cart = new Cart();
            }

            // 6. Tạo mới thể hiện của sản phẩm
            Item item = new Item();
            item.setProduct(product);

            // 7. Thêm sản phẩm vào giỏ hàng
            cart.addItem(item);

            // 8. Gán lại session Cart mới đã được thêm sản phẩm
            SessionUtil.getInstance().putValue(req, "cart", cart);

            // 9. Chuyển hướng tới trang shop với thông báo thành công
            resp.sendRedirect(req.getContextPath() + "/shop?success=s");
        } catch (IllegalArgumentException e) {
            // 10. Chuyển hướng tới trang lỗi với thông báo lỗi
            resp.sendRedirect(req.getContextPath() + "/shop?error=" + e.getMessage());
        } catch (Exception e) {
            // 11. Xử lý các lỗi không mong muốn khác và chuyển hướng tới trang lỗi tổng quát
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/shop?error=Đã có lỗi xảy ra, vui lòng thử lại sau.");
        }
    }
}
