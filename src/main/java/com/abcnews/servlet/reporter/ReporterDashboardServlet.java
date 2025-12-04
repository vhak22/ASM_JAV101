package com.abcnews.servlet.reporter;

import com.abcnews.dao.NewsDAO;
import com.abcnews.daoimpl.NewsDAOImpl;
import com.abcnews.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/reporter/dashboard")
public class ReporterDashboardServlet extends HttpServlet {

    private NewsDAO newsDAO = new NewsDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // Chưa login → về login
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Nếu là ADMIN → thấy toàn bộ bài viết
        if (user.isRole()) {   // true = admin
            req.setAttribute("myNews", newsDAO.findAll());
        } 
        else {
            // Reporter chỉ thấy bài của họ
            req.setAttribute("myNews", newsDAO.findByReporter(user.getId()));
        }

        req.getRequestDispatcher("/views/reporter/dashboard.jsp").forward(req, resp);
    }
}
