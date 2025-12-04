package com.abcnews.dao;

import java.util.List;

import com.abcnews.entity.Newsletter;

public interface NewsletterDAO extends CrudDAO<Newsletter, String> {
    boolean exists(String email);
}
