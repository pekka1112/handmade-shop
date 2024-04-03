package com.ltw.controller.admin.account;

import com.ltw.bean.UserBean;
import com.ltw.dao.UserDAO;
import com.ltw.util.BlankInputUtil;
import com.ltw.util.EncryptPasswordUtil;
import com.ltw.util.NumberValidateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/admin/account-management/adding")
public class AccountAddingController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/adding-account.jsp").forward(req, resp);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String password = req.getParameter("password");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String roleId = req.getParameter("roleId");
        String email = req.getParameter("email");
        String addressLine = req.getParameter("addressLine");
        String addressWard = req.getParameter("addressWard");
        String addressDistrict = req.getParameter("addressDistrict");
        String addressProvince = req.getParameter("addressProvince");
        String status = req.getParameter("status");

        String success = "success";
        String[] inputsForm = new String[] {email, password, firstName, lastName, roleId, status, addressLine, addressWard, addressDistrict, addressProvince};
        ArrayList<String> errors = new ArrayList<>();
        // Biến bắt lỗi
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

        // Nếu không lỗi thì lưu vào database
        if (isValid) {
            // Đổi String về số
            int roleIdInt = NumberValidateUtil.toInt(roleId);
            int statusInt = NumberValidateUtil.toInt(status);

            // Set thuộc tính vào bean
            UserBean userBean = new UserBean();
            userBean.setEmail(email);
            userBean.setPassword(EncryptPasswordUtil.encryptPassword(password));
            userBean.setFirstName(firstName);
            userBean.setLastName(lastName);
            userBean.setRoleId(roleIdInt);
            userBean.setStatus(statusInt);
            userBean.setAddressLine(addressLine);
            userBean.setAddressWard(addressWard);
            userBean.setAddressDistrict(addressDistrict);
            userBean.setAddressProvince(addressProvince);

            userDAO.createAccount(userBean);
            resp.sendRedirect(req.getContextPath() + "/admin/account-management/adding?success=" + success);
        } else {
            req.getRequestDispatcher("/adding-account.jsp").forward(req, resp);
        }
    }
}
