package com.abcnews.daoimpl;

import com.abcnews.dao.NewsletterDAO;
import com.abcnews.entity.Newsletter;
import com.abcnews.utils.XJdbc;
import com.abcnews.utils.XQuery;

import java.util.List;

public class NewsletterDAOImpl implements NewsletterDAO {

    private static final String SQL_INSERT = 
        "INSERT INTO Newsletters(email, enabled) VALUES(?,?)";
        
    private static final String SQL_DELETE = 
        "DELETE FROM Newsletters WHERE email=?";
        
    private static final String SQL_FIND_ALL = 
        "SELECT * FROM Newsletters";
        
    private static final String SQL_EXISTS = 
        "SELECT email FROM Newsletters WHERE email=?";
        
    private static final String SQL_UPDATE = 
        "UPDATE Newsletters SET enabled=? WHERE email=?";

    @Override
    public void insert(Newsletter n) {
        XJdbc.executeUpdate(SQL_INSERT, n.getEmail(), n.isEnabled());
    }

    @Override
    public void delete(String email) {
        XJdbc.executeUpdate(SQL_DELETE, email);
    }
    
    @Override
	public void update(Newsletter entity) {
		XJdbc.executeUpdate(SQL_UPDATE, entity.isEnabled(), entity.getEmail());
	}

    @Override
    public List<Newsletter> findAll() {
        return XQuery.getBeanList(Newsletter.class, SQL_FIND_ALL);
    }

    @Override
    public boolean exists(String email) {
        return XJdbc.getValue(SQL_EXISTS, email) != null;
    }

	@Override
	public Newsletter findById(String key) {
        String sql = "SELECT * FROM Newsletters WHERE email=?";
        return XQuery.getSingleBean(Newsletter.class, sql, key);
	}
}