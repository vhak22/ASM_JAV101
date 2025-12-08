package com.abcnews.daoimpl;

import com.abcnews.dao.NewsDAO;
import com.abcnews.entity.News;
import com.abcnews.utils.XJdbc;
import com.abcnews.utils.XQuery; // Import XQuery

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NewsDAOImpl implements NewsDAO {
    private static final String SQL_INSERT = 
        "INSERT INTO News(Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) "
        + "VALUES (?, ?, ?, ?, GETDATE(), ?, ?, ?, ?)";
        
    private static final String SQL_UPDATE = 
        "UPDATE News SET Title=?, Content=?, Image=?, ViewCount=?, CategoryId=?, Home=? WHERE Id=?";
        
    private static final String SQL_DELETE = 
        "DELETE FROM News WHERE Id=?";
        
    private static final String SQL_FIND_BY_ID = 
        "SELECT * FROM News WHERE Id=?";
        
    private static final String SQL_FIND_ALL = 
        "SELECT * FROM News ORDER BY PostedDate DESC";
        
    private static final String SQL_FIND_BY_CATEGORY = 
        "SELECT * FROM News WHERE CategoryId=? ORDER BY PostedDate DESC";
        
    private static final String SQL_FIND_HOME_NEWS = 
        "SELECT * FROM News WHERE Home=1 ORDER BY PostedDate DESC";
        
    private static final String SQL_FIND_RELATED_NEWS = 
        "SELECT TOP 5 * FROM News WHERE CategoryId=? AND Id <> ? ORDER BY PostedDate DESC";
        
    private static final String SQL_FIND_HOTTEST_NEWS = 
        "SELECT TOP 5 * FROM News ORDER BY ViewCount DESC";
        
    private static final String SQL_FIND_BY_REPORTER = 
        "SELECT * FROM News WHERE Author=? ORDER BY PostedDate DESC";
    
    private static final String SQL_FIND_NEWS_NEW = 
        "SELECT TOP 5 * FROM News ORDER BY PostedDate DESC;";
    
    private static final String SQL_FIND_LATEST_POST_VIEWS = 
        "SELECT TOP 1 ViewCount FROM News WHERE Author = ? ORDER BY PostedDate DESC";
            
    private static final String SQL_SUM_VIEWS_BY_AUTHOR = 
        "SELECT SUM(ViewCount) FROM News WHERE Author = ?";
    
    private static final String SQL_COUNT_POSTS_BY_AUTHOR = 
        "SELECT COUNT(Id) FROM News WHERE Author = ?";
        

    @Override
    public void insert(News n) {
        XJdbc.executeUpdate(SQL_INSERT,
                n.getId(),
                n.getTitle(),
                n.getContent(),
                n.getImage(),
                n.getAuthor(),
                n.getViewCount(),
                n.getCategoryId(),
                n.isHome() ? 1 : 0
        );
    }

    @Override
    public void update(News n) {
        XJdbc.executeUpdate(SQL_UPDATE,
                n.getTitle(),
                n.getContent(),
                n.getImage(),
                n.getViewCount(),
                n.getCategoryId(),
                n.isHome() ? 1 : 0,
                n.getId()
        );
    }

    @Override
    public void delete(String id) {
        XJdbc.executeUpdate(SQL_DELETE, id);
    }
    
    @Override
    public News findById(String id) {
        return XQuery.getSingleBean(News.class, SQL_FIND_BY_ID, id);
    }

    @Override
    public List<News> findAll() {
        return XQuery.getBeanList(News.class, SQL_FIND_ALL);
    }

    @Override
    public List<News> findByCategory(String categoryId) {
        return XQuery.getBeanList(News.class, SQL_FIND_BY_CATEGORY, categoryId);
    }

    @Override
    public List<News> findHomeNews() {
        return XQuery.getBeanList(News.class, SQL_FIND_HOME_NEWS);
    }

    @Override
    public List<News> findRelatedNews(String categoryId, String currentNewsId) {
        return XQuery.getBeanList(News.class, SQL_FIND_RELATED_NEWS, categoryId, currentNewsId);
    }

    @Override
    public List<News> findHottestNews() {
        return XQuery.getBeanList(News.class, SQL_FIND_HOTTEST_NEWS);
    }

    @Override
    public List<News> findByReporter(String authorId) {
        return XQuery.getBeanList(News.class, SQL_FIND_BY_REPORTER, authorId);
    }

	@Override
	public List<News> findNewNews() {
		return XQuery.getBeanList(News.class, SQL_FIND_NEWS_NEW);
	}

	@Override
	public int countPostsByAuthor(String authorId) {
		Integer count = XJdbc.getValue(SQL_COUNT_POSTS_BY_AUTHOR, authorId);
		return count != null ? count : 0;
	}

	@Override
	public int sumViewsByAuthor(String authorId) {
		Integer sum = XJdbc.getValue(SQL_SUM_VIEWS_BY_AUTHOR, authorId);
		return sum != null ? sum : 0;
	}

	@Override
	public int findLatestPostViews(String authorId) {
		Integer viewCount = XJdbc.getValue(SQL_FIND_LATEST_POST_VIEWS, authorId);
		return viewCount != null ? viewCount : 0;
	}
}