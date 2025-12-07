package com.abcnews.servlet.admin;

import com.abcnews.dao.NewsDAO;
import com.abcnews.dao.UserDAO;
import com.abcnews.dao.CategoryDAO;
import com.abcnews.daoimpl.NewsDAOImpl;
import com.abcnews.daoimpl.UserDAOImpl;
import com.abcnews.daoimpl.CategoryDAOImpl;
import com.abcnews.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private NewsDAO newsDAO = new NewsDAOImpl();
    private UserDAO userDAO = new UserDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // kiểm tra login
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User u = (User) session.getAttribute("user");
        
        // kiểm tra quyền admin (role = true)
        if (!u.isRole()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        
        req.setAttribute("newsCount", newsDAO.findAll().size());
        req.setAttribute("userCount", userDAO.findAll().size());
        req.setAttribute("categoryCount", categoryDAO.findAll().size());
        req.setAttribute("list", newsDAO.findAll());
        req.setAttribute("user", u);
        
        req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);
    }
}
