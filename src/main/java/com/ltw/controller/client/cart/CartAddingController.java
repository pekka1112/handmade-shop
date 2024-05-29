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
        // Đăng nhập mới cho phép thêm vào cart (Đã có trong filter)
        String productId = req.getParameter("productId");
        // 3 requestBy: Từ shop, từ product-detail và từ search

        // Tìm sản phẩm từ id nhận được
        ProductBean product = productDAO.findProductById(Integer.parseInt(productId));

        // Tạo mới một đối tượng thể hiện của giỏ hàng
        Cart cart = null;

        // Lấy ra session hiện tại chứa các sản phẩm của giỏ hàng
        Object o = SessionUtil.getInstance().getValue(req, "cart");

        /*
        Hệ thống kiểm tra nếu sesion giỏ hàng đã tồn tại thì lấy ra session đã tồn tại
        Ngược lại nếu chưa có sản phẩm trong giỏ hàng thì sẽ tạo mới một sesion giỏ hàng
         */
        if (o != null) {
            cart = (Cart) o;
        } else {
            cart = new Cart();
        }

        /*
        Tạo mới thể hiện của sản phẩm
        Sau đó gán thuộc tính tương ứng của sản phẩm mà người dùng vừa chọn
        Bước cuối là thêm sản phẩm vào giỏ hàng đã được xử lý ở phía trên
         */
        Item item = new Item();
        item.setProduct(product);

        cart.addItem(item);
        // Gán lại session Cart mới đã được thêm sản phẩm
        SessionUtil.getInstance().putValue(req, "cart", cart);

        resp.sendRedirect(req.getContextPath() + "/shop?success=s");
    }
}
