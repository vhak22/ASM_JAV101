package com.abcnews.dao;

import com.abcnews.entity.User;

public interface UserDAO extends CrudDAO<User, String> {
    User login(String username, String password);
    boolean exists(String id);
}