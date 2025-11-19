package com.vinhkhanh.dao.impl;

import java.util.List;

import com.vinhkhanh.dao.UserDAO;
import com.vinhkhanh.entity.Users;
import com.vinhkhanh.utils.XJdbc;
import com.vinhkhanh.utils.XQuery;    

public class UserDAOImpl implements UserDAO{
    private final String insertSql = "INSERT INTO dbo.Users (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role, CreatedAt) VALUES (?,?,?,?,?,?,?,?,?)";
    private final String updateSql = "UPDATE dbo.Users SET Password = ?, Fullname = ?, Birthday = ?, Gender = ?, Mobile = ?, Email = ?, Role = ? WHERE Id = ?";        
    private final String deleteByIdSql = "DELETE FROM dbo.Users WHERE Id = ?";
    private final String findAllSql = "SELECT * FROM dbo.Users";
    private final String findByIdSql = findAllSql + " WHERE Id = ?";
    
    @Override
    public Users create(Users entity) {
        Object[] values = {
                entity.getId(),
                entity.getPassword(),
                entity.getFullname(),
                entity.getBirthday(),
                entity.getGender(),
                entity.getMobile(),
                entity.getEmail(),
                entity.getRole(),
                entity.getCreatedAt()
        };
        XJdbc.executeUpdate(insertSql, values);
        return entity;
    }

    @Override
    public void update(Users entity) {
        Object[] values = {
                entity.getPassword(),
                entity.getFullname(),
                entity.getBirthday(),
                entity.getGender(),
                entity.getMobile(),
                entity.getEmail(),
                entity.getRole(),
                entity.getId()
        };
        XJdbc.executeUpdate(updateSql, values);
    }

    @Override
    public void deleteById(String id) {
         XJdbc.executeUpdate(deleteByIdSql, id);        
    }

    @Override
    public List<Users> findAll() {
        return XQuery.getBeanList(Users.class, findAllSql);
    }

    @Override
    public Users findById(String id) {
        return XQuery.getSingleBean(Users.class, findByIdSql, id);
    }

    
}
