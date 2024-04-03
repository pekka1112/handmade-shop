package com.ltw.dao;

import com.ltw.bean.UserBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    public List<UserBean> findAllAccounts() {
        String sql = "SELECT id, firstName, lastName, roleId, " +
                "email, addressLine, addressWard, addressDistrict, status, " +
                "createdDate, modifiedDate " +
                "FROM users";

        List<UserBean> accountList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                UserBean userBean = new UserBean();
                userBean.setId(resultSet.getInt("id"));
                userBean.setFirstName(resultSet.getString("firstName"));
                userBean.setLastName(resultSet.getString("lastName"));
                userBean.setRoleId(resultSet.getInt("roleId"));
                userBean.setEmail(resultSet.getString("email"));
                userBean.setAddressLine(resultSet.getString("addressLine"));
                userBean.setAddressWard(resultSet.getString("addressWard"));
                userBean.setAddressDistrict(resultSet.getString("addressDistrict"));
                userBean.setStatus(resultSet.getInt("status"));
                userBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
                userBean.setModifiedDate(resultSet.getTimestamp("modifiedDate"));

                accountList.add(userBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return accountList;
    }

    public void createAccount(UserBean userBean) {
        String sql = "INSERT INTO users (password, firstName, lastName, roleId, " +
                "email, addressLine, addressWard, addressDistrict, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, userBean.getPassword(), userBean.getFirstName(),
                    userBean.getLastName(), userBean.getRoleId(), userBean.getEmail(), userBean.getAddressLine(),
                    userBean.getAddressWard(), userBean.getAddressDistrict(), userBean.getStatus());
            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }

    public int deleteAccount(int id) {
        int affectRows;
        String sql = "DELETE FROM users WHERE id = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, id);
            affectRows = preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
                return -1;
            } catch (SQLException ex) {
                ex.printStackTrace();
                return -1;
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
        return affectRows;
    }
  
    // Tìm danh sách người dùng theo email
    public int findIdByEmail(String email) {
        int id = -1;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id FROM users ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, email);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                id = resultSet.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return id;
    }

    public UserBean findUserById(int id) {
        UserBean userBean = new UserBean();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, email, roleId, firstName, lastName, addressLine, addressWard, addressDistrict, addressProvince, createdDate " )
                .append("FROM users ")
                .append("WHERE id = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                userBean.setId(resultSet.getInt("id"));
                userBean.setEmail(resultSet.getString("email"));
                userBean.setRoleId(resultSet.getInt("roleId"));
                userBean.setFirstName(resultSet.getString("firstName"));
                userBean.setLastName(resultSet.getString("lastName"));
                userBean.setAddressLine(resultSet.getString("addressLine"));
                userBean.setAddressWard(resultSet.getString("addressWard"));
                userBean.setAddressDistrict(resultSet.getString("addressDistrict"));
                userBean.setAddressProvince(resultSet.getString("addressProvince"));
                userBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return userBean;
    }

    // Kiểm tra xem tài khoản đã được active chưa
    public boolean isActiveAccount(String email) {
        int status = -1;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT status FROM users ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());

            // Set the email parameter
            SetParameterUtil.setParameter(preparedStatement, email);

            // Execute the query
            resultSet = preparedStatement.executeQuery();

            // Check if the result set has a row
            if (resultSet.next()) {
                status = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            // Handle the exception (log it or throw a custom exception)
            e.printStackTrace(); // Example, you should handle this appropriately in your application
        } finally {
            // Close resources in the finally block
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        // Check if the status indicates email verification (you can adjust this condition)
        return status == 1;
    }

    // Tạo tài khoản mới (Thông qua đăng ký của client)
    // Role mặc định của client là 1 và status là 2 (Chưa active)
    public int createInRegister(UserBean user) {
        int id = -1;
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO users ")
                .append("(email, password, roleId, status, verifiedCode)")
                .append(" VALUES ")
                .append("(?, ?, 1, 2, ?)");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);

            SetParameterUtil.setParameter(preparedStatement, user.getEmail(), user.getPassword(), user.getVerifiedCode());

            preparedStatement.executeUpdate();
            resultSet = preparedStatement.getGeneratedKeys();

            if (resultSet.next()) {
                id = resultSet.getInt(1);
            }
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
                e.printStackTrace();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return id;
    }

    // Lấy lên email dựa vào verifiedCode (Để kiểm tra tính hợp lệ của code)
    public String checkVerifiedCode(String verifiedCode) {
        String email = "";
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT email FROM users ")
                .append("WHERE verifiedCode = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, verifiedCode);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                email = resultSet.getString("email");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return email;
    }

    // Set code bằng chuỗi rỗng (Sau khi đã xác thực thành công)
    public void setEmptyCode(String email) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE users ")
                .append("SET verifiedCode = '' ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());
            SetParameterUtil.setParameter(preparedStatement, email);

            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }

    // Lưu verifiedCode vào tài khoản có email tương ứng
    public void saveNewCodeByEmail(String email, String verifiedCode) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE users ")
                .append("SET verifiedCode = ? ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, verifiedCode, email);
            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }

    // Cập nhật lại thông tin tài khoản
    public void updateAccount(UserBean user) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE users ")
                .append("SET firstName = ?, lastName = ?, addressLine = ?, ")
                .append("addressWard = ?, addressDistrict = ?, addressProvince = ? ")
                .append("WHERE id = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
      
        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());
            SetParameterUtil.setParameter(preparedStatement, user.getFirstName(), user.getLastName(),
                                            user.getAddressLine(), user.getAddressWard(), user.getAddressDistrict(),
                                            user.getAddressProvince(), user.getId());
            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }

    // Lưu mật khẩu mới cho tài khoản
    public void saveRenewPasswordByEmail(String email, String password) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE users ")
                .append("SET password = ? ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, password, email);
            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }

    // Kiểm tra xem tài khoản và mật khẩu có hợp lệ không
    public String getHashedPasswordByEmail(String email) {
        String hashedPassword = "";
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT password FROM users ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, email);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                hashedPassword = resultSet.getString("password");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return hashedPassword;
    }

    // Lấy lên id đã active theo email
    public int findActiveAccountByEmail(String email) {
        int id = -1;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id FROM users ")
                .append("WHERE email = ? AND status = 1");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, email);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                id = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return id;
    }

    // Lấy lên thông tin của User và gán vào UserBean
    public UserBean findUserByEmail(String email) {
        UserBean userBean = null;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, email, roleId, firstName, lastName, addressLine, addressWard, addressDistrict, addressProvince, createdDate ")
                .append("FROM users ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());
            SetParameterUtil.setParameter(preparedStatement, email);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                userBean = new UserBean();
                userBean.setId(resultSet.getInt("id"));
                userBean.setEmail(resultSet.getString("email"));
                userBean.setRoleId(resultSet.getInt("roleId"));
                userBean.setFirstName(resultSet.getString("firstName"));
                userBean.setLastName(resultSet.getString("lastName"));
                userBean.setAddressLine(resultSet.getString("addressLine"));
                userBean.setAddressWard(resultSet.getString("addressWard"));
                userBean.setAddressDistrict(resultSet.getString("addressDistrict"));
                userBean.setAddressProvince(resultSet.getString("addressProvince"));
                userBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return userBean;
    }

    // Active tài khoản
    public void activeAccount(String email) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE users ")
                .append("SET status = 1 ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, email);

            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
                e.printStackTrace();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
    }

    // Lưu key đối chiếu vào database
    public void saveKeyByEmail(String email, String key) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE users ")
                .append("SET changePwHash = ? ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, key, email);
            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }

    // Kiểm tra key
    public boolean isCorrectKey(String email, String key) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT changePwHash FROM users ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());

            // Set the email parameter
            SetParameterUtil.setParameter(preparedStatement, email);

            // Execute the query
            resultSet = preparedStatement.executeQuery();

            // Check if the result set has a row
            if (resultSet.next()) {
                String keyInDB = resultSet.getString("changePwHash");
                return (keyInDB != null && !keyInDB.isEmpty());
            }
        } catch (SQLException e) {
            // Handle the exception (log it or throw a custom exception)
            e.printStackTrace(); // Example, you should handle this appropriately in your application
        } finally {
            // Close resources in the finally block
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return false;
    }

    // Set empty cho key
    public void setEmptyKey(String email) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE users ")
                .append("SET changePwHash = '' ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, email);

            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }

    // Cập nhật lại thông tin tài khoản
    public void updateAccountForAdmin(UserBean user) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE users ")
                .append("SET roleId = ?, status = ? ")
                .append("WHERE id = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());
            SetParameterUtil.setParameter(preparedStatement, user.getRoleId(), user.getStatus(), user.getId());
            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }
}