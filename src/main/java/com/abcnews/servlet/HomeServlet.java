package com.abcnews.servlet;

import com.abcnews.dao.NewsDAO;
import com.abcnews.daoimpl.NewsDAOImpl;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private NewsDAO newsDAO = new NewsDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("list", newsDAO.findAll());
        req.setAttribute("homeNews", newsDAO.findHomeNews());
        req.setAttribute("top5view", newsDAO.findHottestNews());
        req.getRequestDispatcher("/views/home/index.jsp").forward(req, resp);
    }
}
