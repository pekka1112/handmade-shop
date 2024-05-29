package com.ltw.controller.client;

import com.ltw.bean.CategoryBean;
import com.ltw.bean.CategoryTypeBean;
import com.ltw.bean.CustomizeBean;
import com.ltw.bean.ProductBean;
import com.ltw.dao.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

@WebServlet(value = {"/search"})
public class SearchController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final CategoryTypeDAO categoryTypeDAO = new CategoryTypeDAO();
    private final ProductDAO productDAO = new ProductDAO();

    private final SearchService searchService = new SearchService();
    private final ImageDAO imageDAO = new ImageDAO();

    @Override
    // 5. doGet(request, response)
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 5.1 getKeyWordFromRequest()
        String key = req.getParameter("key");
        // 5.2 isValidKey()
        if (!isValidKey(key)) {
            // 5.3 Error Keyword
            req.setAttribute("error", "Từ khóa tìm kiếm không hợp lệ.");
            req.getRequestDispatcher("/shop.jsp").forward(req, resp);
            return;
        }

        String page = req.getParameter("page");
        String sort = req.getParameter("sort");
        String range = req.getParameter("range");
        int totalPages = getTotalPages();
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        // Sử dụng cho navigation bên trái
        List<CategoryBean> categories = categoryDAO.findAllCategories();
        Map<Integer, List<CategoryTypeBean>> categoryTypeMap = new HashMap<>();
        // Sử dụng cho phần nội dung (Tên type và danh sách sản phẩm)
        // Phân tích range và lấy ra mảng giá trị
        double[] rangeLimit = getLimitRange(range);

        // 6. getProductByKeyAndLimit(key)
        List<ProductBean> products = searchService.getProductByKeyAndLimit(key, rangeLimit, sort, getStartLimit(Integer.parseInt(page)), 2);

        // Đưa phân loại sản phẩm tương ứng với categoryId vào map (navigation bên trái)
        for (CategoryBean category : categories) {
            List<CategoryTypeBean> categoryTypes = categoryTypeDAO.findCategoryTypeByCategoryId(category.getId());
            categoryTypeMap.put(category.getId(), categoryTypes);
        }
        // 5.1 getKeyWordFromRequest()
        req.setAttribute("key", key);

        req.setAttribute("customizeInfo", customizeInfo);
        req.setAttribute("serverPage", Integer.valueOf(page));
        req.setAttribute("serverTotalPages", totalPages);
        req.setAttribute("sort", sort);
        req.setAttribute("range", range);
        req.setAttribute("categories", categories);
        req.setAttribute("categoryTypeMap", categoryTypeMap);

        // 8.1 processNullResultList()
        req.setAttribute("products", products);
        if (products.isEmpty()) {
            // 8.2 showNullResult()
            req.setAttribute("error", "Không tìm thấy sản phẩm nào với từ khóa tìm kiếm của bạn.");
        }
        // 10. Rediirect To HomePage
        req.getRequestDispatcher("/search.jsp").forward(req, resp);
    }

    private double[] getLimitRange(String range) {
        if (!range.equals("none")) {
            double[] rangeLimit = new double[2];
            switch (range) {
                case "0-to-499":
                    rangeLimit[0] = 0;
                    rangeLimit[1] = 499000.0;
                    break;
                case "500-to-2999":
                    rangeLimit[0] = 500000.0;
                    rangeLimit[1] = 2999000.0;
                    break;
                case "3000-to-9999":
                    rangeLimit[0] = 3000000.0;
                    rangeLimit[1] = 9999000.0;
                    break;
                case "up-to-10000":
                    rangeLimit[0] = 10000000.0;
                    rangeLimit[1] = 10000000000.0;
                    break;
            }
            return rangeLimit;
        } else {
            return null;
        }
    }

    // Pagination
    private int getTotalPages() {
        int totalItems = productDAO.getTotalItems();
        return (int) Math.ceil((double) totalItems / 2);
    }

    // Pagination
    private int getStartLimit(int page) {
        return 2 * (page - 1);
    }

    private boolean isValidKey(String key) {
        // Kiểm tra độ dài từ khóa (ví dụ: từ 1 đến 50 ký tự)
        if (key.length() > 50) {
            return false;
        }
        return true;
    }
}
