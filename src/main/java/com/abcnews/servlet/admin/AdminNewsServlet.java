package com.abcnews.servlet.admin;

import com.abcnews.dao.NewsDAO;
import com.abcnews.dao.CategoryDAO;
import com.abcnews.daoimpl.NewsDAOImpl;
import com.abcnews.daoimpl.CategoryDAOImpl;
import com.abcnews.entity.News;
import com.abcnews.entity.User;
import com.abcnews.entity.Category;


import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/news")
public class AdminNewsServlet extends HttpServlet {

    private NewsDAO newsDAO = new NewsDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        List<Category> categories = categoryDAO.findAll();
       
        if ("add".equals(action)) {
            String id = req.getParameter("id");
            req.setAttribute("news", newsDAO.findById(id));
            req.setAttribute("aws", categories);
            req.getRequestDispatcher("/views/admin/news-form.jsp").forward(req, resp);
            return;
        }
        
        if ("edit".equals(action)) {
            String id = req.getParameter("id");
            req.setAttribute("news", newsDAO.findById(id));
            req.setAttribute("aws", categories);
            req.getRequestDispatcher("/views/admin/news-form.jsp").forward(req, resp);
            return;
        }

        if ("delete".equals(action)) {
            String id = req.getParameter("id");
            newsDAO.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/news");
            return;
        }

        // LIST PAGE
        req.setAttribute("list", newsDAO.findAll());
        req.setAttribute("categories", categories);
        
        
        req.getRequestDispatcher("/views/admin/news.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	req.setCharacterEncoding("UTF-8");
    	String cat = req.getParameter("categoryId");
    	if (cat == null) {
    	    resp.sendRedirect(req.getContextPath() + "/admin/news?action=add&error=missingCategory");
    	    return;
    	}
        String categoryId = req.getParameter("categoryId");


        String homeParam = req.getParameter("highlight");
        boolean isHome = Boolean.parseBoolean(homeParam);
        String id = req.getParameter("id");
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String image = req.getParameter("image");

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        News n = new News();
        n.setTitle(title);
        n.setContent(content);
        n.setImage(image);
        n.setCategoryId(categoryId);
        n.setPostedDate(java.sql.Date.valueOf(LocalDate.now()));
        n.setViewCount(0);
        n.setHome(isHome);
        n.setAuthor(user.getId());  // QUAN TRỌNG

        if (id == null || id.trim().isEmpty()) {
            // Tạo ID mới
            int nextId = newsDAO.findAll().size() + 1;
            n.setId("N" + nextId);

            newsDAO.insert(n);
        } else {
            n.setId(id);
            newsDAO.update(n);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/news");
    }
}
