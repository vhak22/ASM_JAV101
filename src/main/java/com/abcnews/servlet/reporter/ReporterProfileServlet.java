package com.abcnews.servlet.reporter;

import com.abcnews.dao.UserDAO;
import com.abcnews.daoimpl.UserDAOImpl;
import com.abcnews.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet({"/reporter/user","/reporter/user/edit"})
public class ReporterProfileServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	String uri = req.getRequestURI();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        if (uri.endsWith("/edit")) {
            String id = req.getParameter("id");
            req.setAttribute("add", "add");
            req.setAttribute("action", "update");
            req.setAttribute("user", userDAO.findById(id));
            req.setAttribute("title", "Reporter - Edit Profile");
            req.getRequestDispatcher("/views/pv/user-form.jsp").forward(req, resp);
            return;
        }
        req.setAttribute("title", "Reporter - Profile");
        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/pv/user.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        String roleParam = req.getParameter("role");
        String genderParam = req.getParameter("gender");
        
        // Lấy dữ liệu form
        String id = req.getParameter("id");
        String fullname = req.getParameter("fullname");
        String password = req.getParameter("password");
        String birthday = req.getParameter("birthday");
        boolean gender = Boolean.parseBoolean(genderParam);
        String mobile = req.getParameter("mobile");
        String email = req.getParameter("email");
        boolean role = Boolean.parseBoolean(roleParam);

        User u = new User(id, password, fullname, birthday, gender, mobile, email, role);

        // XỬ LÝ UPDATE USER
        if ("update".equals(action)) {
            userDAO.update(u);
            HttpSession session = req.getSession();
            session.setAttribute("user", u);
        }

        
        resp.sendRedirect(req.getContextPath() + "/reporter/user");
    }
}
