package com.abcnews.daoimpl;

import com.abcnews.dao.CategoryDAO;
import com.abcnews.entity.Category;
import com.abcnews.utils.XJdbc;
import com.abcnews.utils.XQuery; // <--- Cần thêm import XQuery

import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {
    private static final String SQL_INSERT = 
        "INSERT INTO Categories(id, name) VALUES(?,?)";
        
    private static final String SQL_UPDATE = 
        "UPDATE Categories SET name=? WHERE id=?";
        
    private static final String SQL_DELETE = 
        "DELETE FROM Categories WHERE id=?";
        
    private static final String SQL_FIND_BY_ID = 
        "SELECT * FROM Categories WHERE id=?";
        
    private static final String SQL_FIND_ALL = 
        "SELECT * FROM Categories";

    @Override
    public void insert(Category c) {
        XJdbc.executeUpdate(SQL_INSERT, c.getId(), c.getName());
    }

    @Override
    public void update(Category c) {
        XJdbc.executeUpdate(SQL_UPDATE, c.getName(), c.getId());
    }

    @Override
    public void delete(String id) {
        XJdbc.executeUpdate(SQL_DELETE, id);
    }


    @Override
    public Category findById(String id) {
        return XQuery.getSingleBean(Category.class, SQL_FIND_BY_ID, id);
    }

    @Override
    public List<Category> findAll() {
        return XQuery.getBeanList(Category.class, SQL_FIND_ALL);
    }
}