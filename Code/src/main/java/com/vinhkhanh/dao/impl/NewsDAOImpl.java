package com.vinhkhanh.dao.impl;

import java.util.List;

import com.vinhkhanh.dao.NewsDAO;
import com.vinhkhanh.entity.News;
import com.vinhkhanh.utils.XJdbc;
import com.vinhkhanh.utils.XQuery;

public class NewsDAOImpl implements NewsDAO {
    private final String insertSql = "INSERT INTO dbo.News (Id, Title, Content, CreatedAt, AuthorId) VALUES (?,?,?,?,?)";
    private final String updateSql = "UPDATE dbo.News SET Title = ?, Content = ?, CreatedAt = ?, AuthorId = ? WHERE Id = ?";
    private final String deleteByIdSql = "DELETE FROM dbo.News WHERE Id = ?";   
    private final String findAllSql = "SELECT * FROM dbo.News";
    private final String findByIdSql = findAllSql + " WHERE Id = ?";    

    @Override
    public News create(News entity) {
        Object [] values = {
                entity.getId(),
                entity.getTitle(),  
                entity.getContent(),
                entity.getCreatedAt(),
                entity.getAuthorId()
        };
        XJdbc.executeUpdate(insertSql, values);
        return entity;
    }

    @Override
    public void update(News entity) {
        Object[] values = {
                entity.getTitle(),
                entity.getContent(),
                entity.getCreatedAt(),
                entity.getAuthorId(),
                entity.getId()
        };
        XJdbc.executeUpdate(updateSql, values);
    }

    @Override
    public void deleteById(String id) {
        XJdbc.executeUpdate(deleteByIdSql, id);
    }

    @Override
    public List<News> findAll() {
        return XQuery.getBeanList(News.class, findAllSql);
    }

    @Override
    public News findById(String id) {
        return XQuery.getSingleBean(News.class, findByIdSql, id);
    }


}
