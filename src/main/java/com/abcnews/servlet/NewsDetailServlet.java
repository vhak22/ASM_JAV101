package com.abcnews.servlet;

import com.abcnews.dao.NewsDAO;
import com.abcnews.daoimpl.NewsDAOImpl;
import com.abcnews.entity.News;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/detail")
public class NewsDetailServlet extends HttpServlet {

    private NewsDAO newsDAO = new NewsDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getParameter("id");

        if (id != null) {
            News n = newsDAO.findById(id);
            n.setViewCount(n.getViewCount() + 1);
            newsDAO.update(n);
            req.setAttribute("news", n);
            req.setAttribute("relatedNews", newsDAO.findRelatedNews(n.getCategoryId(), id));
            req.setAttribute("a", "- Bảng tin chi tiết");
        }
        
        req.getRequestDispatcher("/views/detail/detail.jsp").forward(req, resp);
    }
}
