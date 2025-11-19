package com.vinhkhanh.dao.impl;

import java.util.List;

import com.vinhkhanh.dao.CategoriesDAO;
import com.vinhkhanh.entity.Categories;
import com.vinhkhanh.utils.XJdbc;
import com.vinhkhanh.utils.XQuery;

public class CategoriesDAOImpl implements CategoriesDAO {
    
    private final String insertSql = "INSERT INTO dbo.Categories (Id, Name) VALUES (?,?)";
    private final String updateSql = "UPDATE dbo.Categories SET Name = ? WHERE Id = ?";
    private final String deleteByIdSql = "DELETE FROM dbo.Categories WHERE Id = ?";
    private final String findAllSql = "SELECT * FROM dbo.Categories";
    private final String findByIdSql = findAllSql + " WHERE Id = ?";
    
    @Override
    public Categories create(Categories entity) {
        Object[] values = {
                entity.getId(),
                entity.getName(),
                
        };
        XJdbc.executeUpdate(insertSql, values);
        return entity;
    }

    @Override
    public void update(Categories entity) {
        Object[] values = {
                entity.getId(),
                entity.getName(),
        };
        XJdbc.executeUpdate(updateSql, values);
    }

    @Override
    public void deleteById(String id) {
         XJdbc.executeUpdate(deleteByIdSql, id);
    }

    @Override
    public List<Categories> findAll() {    
        return XQuery.getBeanList(Categories.class, findAllSql);
    }

    @Override
    public Categories findById(String id) {
        return XQuery.getSingleBean(Categories.class, findByIdSql, id);
    }

}
