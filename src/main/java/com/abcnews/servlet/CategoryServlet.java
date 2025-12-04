package com.abcnews.servlet;

import com.abcnews.dao.CategoryDAO;
import com.abcnews.dao.NewsDAO;
import com.abcnews.daoimpl.CategoryDAOImpl;
import com.abcnews.daoimpl.NewsDAOImpl;
import com.abcnews.entity.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {

    private NewsDAO newsDAO = new NewsDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String cid = req.getParameter("id");
        Category category = categoryDAO.findById(cid);
        String name = "- " + category.getName();
        
        
        if (cid != null) {
            req.setAttribute("category", categoryDAO.findById(cid));
            req.setAttribute("newsList", newsDAO.findByCategory(cid));
            req.setAttribute("top5view", newsDAO.findHottestNews());
            req.setAttribute("a", name);
        }

        req.getRequestDispatcher("/views/category/categoryList.jsp").forward(req, resp);
    }
}
