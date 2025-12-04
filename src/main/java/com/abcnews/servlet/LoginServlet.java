package com.abcnews.servlet;

import com.abcnews.dao.UserDAO;
import com.abcnews.daoimpl.UserDAOImpl;
import com.abcnews.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String id = req.getParameter("id");
        String password = req.getParameter("password");

        User u = userDAO.login(id, password);

        // Sai tài khoản
        if (u == null) {
            req.setAttribute("error", "Sai tài khoản hoặc mật khẩu");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        session.setAttribute("user", u);

        // ADMIN = true
        if (u.isRole()) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
        // REPORTER = false
        else {
            resp.sendRedirect(req.getContextPath() + "/reporter/dashboard");
        }
    }
}
