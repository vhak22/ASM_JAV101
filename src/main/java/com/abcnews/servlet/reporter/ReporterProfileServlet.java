package com.abcnews.servlet.reporter;

import com.abcnews.dao.UserDAO;
import com.abcnews.daoimpl.UserDAOImpl;
import com.abcnews.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/reporter/profile")
public class ReporterProfileServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/reporter/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        user.setFullname(username);
        user.setPassword(password);

        userDAO.update(user);

        // Cập nhật lại session
        session.setAttribute("user", user);

        resp.sendRedirect("profile");
    }
}
