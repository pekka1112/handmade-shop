package com.ltw.dao;

import com.ltw.bean.CategoryBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    public List<CategoryBean> findAllCategories() {
        String sql = "SELECT id, name FROM categories";
        List<CategoryBean> result = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                CategoryBean categoryBean = new CategoryBean();
                categoryBean.setId(resultSet.getInt("id"));
                categoryBean.setName(resultSet.getString("name"));

                result.add(categoryBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return result;
    }
}