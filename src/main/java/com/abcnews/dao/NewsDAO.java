package com.abcnews.dao;

import java.util.List;
import com.abcnews.entity.News;

public interface NewsDAO extends CrudDAO<News, String> {
    List<News> findByCategory(String categoryId);
    List<News> findHomeNews();
    List<News> findByReporter(String authorId);
    List<News> findRelatedNews(String categoryId, String currentNewsId);
    List<News> findHottestNews();
    List<News> findNewNews();
    int countPostsByAuthor(String authorId);
    int sumViewsByAuthor(String authorId);
    int findLatestPostViews(String authorId);
}
